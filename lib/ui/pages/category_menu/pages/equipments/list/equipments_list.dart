import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/assets/assets_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/paginated_gridview_builder.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/search/equipments_search_delegate.dart';
import 'package:nectar_assets/ui/shared/widgets/map/google_map_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/model/user_data_model.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../shared/widgets/sheets/custom_draggable_sheet.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'widgets/equipments_status_cards.dart';

class EquipmentsListScreen extends StatefulWidget {
  const EquipmentsListScreen({super.key});

  static const String id = '/equipments/list';

  @override
  State<EquipmentsListScreen> createState() => _EquipmentsListScreenState();
}

class _EquipmentsListScreenState extends State<EquipmentsListScreen> {
  final UserDataSingleton userData = UserDataSingleton();

  late PayloadManagementBloc payloadManagementBloc;
  late FilterSelectionBloc filterSelectionBloc;
  late FilterAppliedBloc filterAppliedBloc;

  late PagingController<int, Assets> pagingController;

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    pagingController = PagingController(firstPageKey: 1);

    payloadManagementBloc.state.payload = {};

    super.initState();
  }

  @override
  void dispose() {
    payloadManagementBloc.state.payload = {};

    filterAppliedBloc.state.filterAppliedCount = 0;
    filterSelectionBloc.state.filterLabelsMap[FilterType.assets] = [];

    super.dispose();
  }

  int assetLength = 0;

  final bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: "assetManagement",
      feature: "assetList",
      permission: "list");

  List<Map> filterValues = [];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    filterValues = args?['filterValues'] ?? [];

    Map<String, dynamic> payload = {};

    for (var element in filterValues) {
      payload[element['filterKey']] = element['identifier'];
    }

    payloadManagementBloc.state.payload = payload;
    filterAppliedBloc.state.filterAppliedCount = filterValues.length;

    return Scaffold(
      appBar: buildAppbar(context),
      body: PermissionChecking(
        featureGroup: "assetManagement",
        feature: "assetList",
        permission: "list",
        showNoAccessWidget: true,
        child: buildGridView(
          ScrollController(),
        ),
        // Stack(
        //   children: [
        //     buildGoogleMap(),
        //     buildDraggableScrollSheet(),
        //   ],
        // ),
      ),
    );
  }

  BlocBuilder<PayloadManagementBloc, PayloadManagementState> buildGoogleMap() {
    return BlocBuilder<PayloadManagementBloc, PayloadManagementState>(
      builder: (context, state) {
        Map<String, dynamic> mapPayload = {
          "clients": userData.domain,
          // "offset": -1,
          // "pageSize": 10,
          "order": "asc",
          "sortField": "displayName"
        };

        mapPayload.addAll(state.payload);

        return QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: AssetSchema.getAssetList,
            variables: {
              "filter": mapPayload,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return buildGoogleMapLoading();
            }

            // var result = snapshot.data!;

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            var listAssets = AssetsListModel.fromJson(result.data ?? {});

            List<Assets> assets = listAssets.getAssetList?.assets ?? [];

            assetLength = assets.length;

            return GoogleMapWidget(
              markers: AssetsServices().convertToMarkerData(
                context: context,
                assets: assets,
              ),
            );
          },
        );
      },
    );
  }

  // ==================================================================================
  Widget buildDraggableScrollSheet() {
    return CustomDraggableScroallableSheet(
      builder: (context, controller) => buildGridView(controller),
    );
  }

  // ==============================================================================
  buildGridView(ScrollController controller) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        pagingController.refresh();
      },
      child: PaginatedEquipmentListBuilder(
        // assets: assets,
        pagingController: pagingController,
        controller: controller,
        payloadManagementBloc: payloadManagementBloc,
      ),
    );
  }

  AbsorbPointer buildGoogleMapLoading() {
    return const AbsorbPointer(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(25.2048, 55.2708),
                zoom: 3.0,
              ),
              // markers: {},
              // onMapCreated: _onMapCreated,
            ),
          ),
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("Equipment"),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.sp),
        child: EquipmentsStatusCard(
          onChanged: (initialValue) {
            if (!filterValues
                .any((element) => element['key'] == "communicationStatus")) {
              filterValues.add(initialValue);
            }

            pagingController.refresh();
          },
        ),
      ),
      actions: [
        Visibility(
          visible: hasPermission,
          child: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: AssetSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ),
        Visibility(
          visible: hasPermission,
          child: FilterButtonWidget(
            onPressed: () {
              FilterWidgetHelpers().filterBottomSheet(
                context: context,
                filterType: FilterType.assets,
                isMobile: true,
                initialValues: filterValues,
                saveButtonTap: (value) {
                  pagingController.refresh();
                },
              );
            },
            // icon: const Icon(Icons.filter_alt_outlined),
          ),
        ),
      ],
    );
  }
}
