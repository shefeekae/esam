import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class FirePanelsDropdownButton extends StatelessWidget {
  FirePanelsDropdownButton({
    required this.onChanged,
    super.key,
  });

  final UserDataSingleton userData = UserDataSingleton();

  String? selectedFirePanelValue;
  void Function(Map<String, dynamic>?) onChanged;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices()
          .getQueryOptions(query: AssetSchema.getAssetList, variables: {
        "filter": {
          "domain": userData.domain,
          // "offset": 1,
          "order": "asc",
          "type": ["FACP"],
          "sortField": "displayName",
          // "pageSize": 1000,
          "fields": [
            "displayName",
            "type",
            "identifier",
            "domain",
            "location",
            "points"
          ]
        }
      }),
      builder: (result, {fetchMore, refetch}) {
        // if (result.isLoading) {
        //   return const SizedBox();
        // }

        if (result.hasException) {
          return TextButton(
            onPressed: () {
              refetch!();
            },
            child: const Text("Something went wrong, Retry"),
          );
        }

        List panels = result.data?['getAssetList']?['assets'] ?? [];

        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 70.w,
            height: 30.sp,
            margin: EdgeInsets.only(right: 5.sp),
            decoration: BoxDecoration(
              color: Brightness.dark == Theme.of(context).brightness
                  ? Colors.black26
                  : kWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: StatefulBuilder(
              builder: (context, setState) => DropdownButton(
                value: selectedFirePanelValue,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text("Select"),
                items: [
                  DropdownMenuItem(
                    value: null,
                    onTap: () {
                      onChanged(null);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.sp),
                      child: const Text(
                        "All Panels",
                      ),
                    ),
                  ),
                  ...List.generate(panels.length, (index) {
                    var map = panels[index];

                    String title = map['displayName'] ?? "N/A";

                    String identifier = map['identifier'] ?? "";
                    String type = map['type'] ?? "";
                    String domain = map['domain'] ?? "";

                    Map<String, dynamic> data = {
                      "type": type,
                      "data": {
                        "domain": domain,
                        "identifier": identifier,
                        "displayName": title,
                      }
                    };

                    return DropdownMenuItem(
                      value: identifier,
                      onTap: () {
                        onChanged(data);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.sp),
                        child: Text(
                          title,
                        ),
                      ),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(
                    () {
                      selectedFirePanelValue = value;
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
