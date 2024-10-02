import 'package:app_filter_form/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:sizer/sizer.dart';

class ServingSpacesBuilder extends StatelessWidget {
  const ServingSpacesBuilder({required this.assetEntity, super.key});

  final Map<String, dynamic> assetEntity;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices()
          .getQueryOptions(query: AssetSchema.listServingSpaces, variables: {
        "asset": assetEntity,
      }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return BuildShimmerLoadingWidget(
            height: 50.sp,
          );
        }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        List list = result.data?['listServingSpaces'] ?? [];

        if (list.isEmpty) {
          return const Center(
            child: Text("No Data to show"),
          );
        }

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            refetch?.call();
          },
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            itemBuilder: (context, index) {
              var map = list[index];

              var siteData = map['site']?['data'];
              var spaceData = map['space']?['data'];

              String? siteName = siteData['displayName'] ?? siteData['name'];
              String? spaceName = spaceData['displayName'] ?? spaceData['name'];

              return BgContainer(
                child: ListTile(
                  title: Text("$spaceName ($siteName)"),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 8.sp,
              );
            },
            itemCount: list.length,
          ),
        );
      },
    );
  }
}
