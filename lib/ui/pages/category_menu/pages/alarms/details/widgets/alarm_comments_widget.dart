import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/models/alarms/alarm_comment_model.dart';
import '../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../../core/services/graphql_services.dart';
import '../../list/widgets/comments/comment_textfield_with_mutation_widget.dart';
import '../../widgets/comments/comment_widget.dart';

class BuildAlarmDetailsComments extends StatelessWidget {
  const BuildAlarmDetailsComments({
    required this.eventId,
    super.key,
  });

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: AlarmsSchema.getComments,
        variables: {
          "identifier": eventId,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        // if (result.isLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator.adaptive(),
        //   );
        // }

        if (result.hasException) {
          return GrapghQlClientServices().handlingGraphqlExceptions(
            result: result,
            context: context,
            refetch: refetch,
          );
        }

        AlarmComments alarmComments = AlarmComments.fromJson(result.data ?? {});

        List<GetComments> comments = alarmComments.getComments ?? [];

        return Skeletonizer(
          enabled: result.isLoading,
          child: Column(
            children: [
              CommentTextfieldWithMutationWidget(
                eventId: eventId,
                onCompleted: () {
                  refetch?.call();
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  itemCount: result.isLoading ? 5 : comments.length,
                  itemBuilder: (context, index) {
                    if (result.isLoading) {
                      return const ListTile(
                        leading: CircleAvatar(),
                        title: Text("Loading........................"),
                      );
                    }

                    GetComments comment = comments[index];

                    return CommentWidget(
                      comment: comment,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

//     return Column(
//       children: [
// BuildTextformField(
//       hintText: "Add Comment",
//       controller: TextEditingController(),
//       // fillColor: f1White,
//     ),
//     SizedBox(
//       height: 10.sp,
//     ),
//     ...List.generate(
//       3,
//       (index) => const BuildCommentWidget(),
//     )
//       ],
//     );
  }
}
