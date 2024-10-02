import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/site/find_site_model.dart';
import 'package:nectar_assets/core/schemas/site_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/insights/pages/summary_equipments.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/communities/site/widgets/building_details_card.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/services/assets/assets_services.dart';

class BuildingProfileScreen extends StatelessWidget {
  BuildingProfileScreen({required this.siteEntity, super.key});

  static const String id = "site/profile";

  final Map<String, dynamic> siteEntity;

  final ValueNotifier<String?> nameNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: QueryWidget(
          options: GraphqlServices().getQueryOptions(
            query: SiteSchema.findSite,
            variables: {
              "site": siteEntity,
            },
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return BuildShimmerLoadingWidget(
                padding: 0,
                itemCount: 4,
                borderRadius: 5,
              );
            }

            if (result.hasException) {
              return GraphqlServices().handlingGraphqlExceptions(
                result: result,
                context: context,
                refetch: refetch,
              );
            }

            FindSiteModel findSiteModel =
                FindSiteModel.fromJson(result.data ?? {});

            FindSite? findSite = findSiteModel.findSite;

            Site? site = findSite?.site;

            Data? siteData = site?.data;

            Future.delayed(const Duration(milliseconds: 10), () {
              String displayName = siteData?.displayName ?? "";

              nameNotifier.value =
                  displayName.isEmpty ? siteData?.name ?? "" : displayName;
            });

            List<Contact> fmsContactList = findSite?.fmsContact ?? [];
            List<Contact> bmsContactList = findSite?.bmsContact ?? [];
            List<Contact> associationManagerContactList =
                findSite?.associationManagerContact ?? [];
            List<Contact> securityContactList = findSite?.securityContact ?? [];

            return ListView(
              children: [
                buildingInformation(siteData),
                BgContainer(
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    title: "Building Summary",
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SummaryEquipmentsScreen(
                                identifier: siteData?.identifier ?? "",
                                name: siteData?.displayName ?? "",
                              ),
                            ));
                          },
                          child: const Text(
                            "View All Equipments",
                          ),
                        )
                      ],
                    )),
                buildContactCard(
                  title: "Facility Management Contact",
                  contacts: fmsContactList,
                ),
                buildContactCard(
                  title: "BMS Contact",
                  contacts: bmsContactList,
                ),
                buildContactCard(
                  title: "Association Manager Contact",
                  contacts: associationManagerContactList,
                ),
                buildContactCard(
                  title: "Security Contact",
                  contacts: securityContactList,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  BuildingDetailsCard buildingInformation(
    Data? siteData,
  ) {
    LatLng? latLng = AssetsServices().parseWktPoint(siteData?.location ?? "");

    return BuildingDetailsCard(
      title: "Building - Information",
      list: [
        CardData(
          label: "Built Year",
          value: siteData?.builtYear,
        ),
        CardData(
          label: "Address",
          value: siteData?.address,
        ),
        CardData(
          label: "Location",
          value:
              latLng == null ? null : "${latLng.latitude}, ${latLng.longitude}",
        ),
      ],
    );
  }

  // ===========================================================================

  BuildingDetailsCard buildContactCard({
    required String title,
    required List<Contact> contacts,
  }) {
    // String? name = contact?.name;

    List<List<CardData>> list = contacts.map((e) {
      var list = [
        CardData(
          label: "Name",
          value: e.name,
        ),
        CardData(
          label: "Address",
          value: e.addresses?.map((e) => e.address ?? "").toList().join(", "),
        ),
        CardData(
          label: "Emailt",
          value: e.emails?.map((e) => e.emailId ?? "").toList().join(", "),
        ),
        CardData(
          label: "Contact",
          value: e.phones?.map((e) => e.number ?? "").toList().join(", "),
        ),
      ];

      if (contacts.length != 1 && contacts.indexOf(e) != contacts.length - 1) {
        list.add(CardData(
          showDivider: true,
        ));
      }

      return list;
    }).toList();

    return BuildingDetailsCard(
      title: title,
      list: list.expand((element) => element).toList(),
    );
  }

  // =============================================================================
  // Build AppBar

  AppBar buildAppBar() {
    return AppBar(
      title: ValueListenableBuilder(
          valueListenable: nameNotifier,
          builder: (context, value, _) {
            return Text(value ?? "Building Profile");
          }),
    );
  }
}
