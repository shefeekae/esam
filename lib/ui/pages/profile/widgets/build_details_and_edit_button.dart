import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/models/profile_logged_model.dart';
import '../../../../core/schemas/profile_schema.dart';
import '../../../../core/services/graphql_services.dart';
import '../../../shared/functions/converters.dart';
import '../pages/profile_update_screen.dart';

class BuildDetailsAndEditButtonWidget extends StatelessWidget {
  const BuildDetailsAndEditButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: ProfileSchemas.finndLoggedInUser,
        rereadPolicy: true,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return buildLoading(context);
        }

        if (result.hasException) {
          return GraphqlServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        ProfileLoggedModel profileLoggedModel =
            profileLoggedModelFromJson(result.data ?? {});

        var userData = profileLoggedModel.findLoggedInUser?.user?.data;

        String firstName = userData?.firstName ?? "";
        String lastName = userData?.lastName ?? "";
        String contactNumber = userData?.contactNumber ?? "";
        String email = userData?.emailId ?? "";
        String userName = userData?.userName ?? "";

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 40.sp,
              backgroundColor: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  Converter().largeLetterToSmall(userData?.userName ?? ""),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "$firstName $lastName",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                buildIconWithText(
                  contactNumber,
                  Icons.phone_outlined,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                buildIconWithText(
                  email,
                  Icons.email_outlined,
                ),
              ],
            ),
            const Spacer(),
            PermissionChecking(
              featureGroup: "applicationAccess",
              feature: "login",
              permission: "mobile",
              child: IconButton(
                onPressed: () async {
                  bool? isScuccess = await Navigator.of(context)
                      .pushNamed<dynamic>(ProfileUpdateScreen.id, arguments: {
                    "initialPayload":
                        profileLoggedModel.findLoggedInUser?.user?.toJson(),
                    "initialValues": [
                      {
                        "key": "userName",
                        // "identifier": userName,
                        "values": [
                          {
                            "name": userName,
                            "data": userName,
                          },
                        ],
                      },
                      {
                        "key": "userType",
                        "identifier": userData?.typeName ?? "",
                        "values": [
                          {
                            "name": userData?.typeName ?? "",
                            "data": userData?.typeName,
                          },
                        ],
                      },
                      {
                        "key": "role",
                        "identifier": userData?.roleName ?? "",
                        "values": [
                          {
                            "name": userData?.roleName ?? "",
                            "data": userData?.roleName,
                          },
                        ],
                      },
                      {
                        "key": "firstName",
                        "identifier": firstName,
                        "values": [
                          {
                            "name": firstName,
                            "data": firstName,
                          },
                        ],
                      },
                      {
                        "key": "lastName",
                        "identifier": lastName,
                        "values": [
                          {
                            "name": lastName,
                            "data": lastName,
                          },
                        ],
                      },
                      {
                        "key": "contactNumber",
                        "identifier": contactNumber,
                        "values": [
                          {
                            "name": contactNumber,
                            "data": contactNumber,
                          },
                        ],
                      },
                      {
                        "key": "email",
                        "identifier": email,
                        "values": [
                          {
                            "name": email,
                            "data": email,
                          },
                        ],
                      },
                    ],
                  });

                  if (isScuccess ?? false) {
                    refetch!.call();
                  }
                },
                icon: Icon(
                  Icons.edit_outlined,
                  size: 12.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildLoading(BuildContext context) {
    return Skeletonizer(
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 40.sp,
            backgroundColor: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                "",
                // Converter().largeLetterToSmall(userData?.userName ?? ""),
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: kWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Loading Loading",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              buildIconWithText(
                "Loading",
                Icons.phone_outlined,
              ),
              SizedBox(
                height: 5.sp,
              ),
              buildIconWithText(
                "Loading",
                Icons.email_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIconWithText(String label, IconData iconData) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 13.sp,
        ),
        SizedBox(
          width: 5.sp,
        ),
        SizedBox(
          width: 45.w,
          child: Text(
            label,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
