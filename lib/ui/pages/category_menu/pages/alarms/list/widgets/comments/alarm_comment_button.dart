import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/alarms/alarm_comment_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../widgets/comments/comment_widget.dart';
import 'comment_textfield_with_mutation_widget.dart';

class AlarmCommentButtonWidget extends StatelessWidget {
  const AlarmCommentButtonWidget({
    required this.eventId,
    super.key,
  });

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          // backgroundColor: f1White,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(7.sp),
            ),
          ),
          builder: (ctx) {
            return SizedBox(
              height: 80.h,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                    query: AlarmsSchema.getComments,
                    variables: {
                      "identifier": eventId,
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return BuildShimmerLoadingWidget(
                        height: 50.sp,
                        padding: 10.sp,
                      );
                    }

                    if (result.hasException) {
                      return GrapghQlClientServices().handlingGraphqlExceptions(
                        result: result,
                        context: context,
                        refetch: refetch,
                      );
                    }

                    AlarmComments alarmComments =
                        AlarmComments.fromJson(result.data ?? {});

                    List<GetComments> comments =
                        alarmComments.getComments ?? [];

                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Comments",
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () async {
                              refetch?.call();
                            },
                            child: ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                GetComments comment = comments[index];

                                return CommentWidget(
                                  comment: comment,
                                );
                              },
                            ),
                          ),
                        ),
                        // buildCommentTextfield(
                        //   ctx,
                        //   refetch: refetch,
                        // ),
                        // SizedBox(
                        //   height: 15.sp,
                        // ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: iconWithText(),
    );
  }

  // =================================================
  // Showing comment Textfiled,

  Padding buildCommentTextfield(
    BuildContext context, {
    required Future<QueryResult<dynamic>?> Function()? refetch,
  }) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: CommentTextfieldWithMutationWidget(
        eventId: eventId,
        onCompleted: () {
          refetch?.call();
        },
      ),
    );
  }

  Container iconWithText() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 13.sp,
              color: Colors.grey,
            ),
            SizedBox(
              width: 2.sp,
            ),
            Text(
              "Comments",
              style: TextStyle(
                fontSize: 8.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
