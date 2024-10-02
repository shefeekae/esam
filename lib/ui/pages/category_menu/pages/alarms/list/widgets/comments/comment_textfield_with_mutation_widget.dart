import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../../shared/widgets/textfield/comment_textfield.dart';

class CommentTextfieldWithMutationWidget extends StatelessWidget {
  const CommentTextfieldWithMutationWidget({
    super.key,
    required this.eventId,
    required this.onCompleted,
  });

  final String eventId;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    return MutationWidget(
      options: GrapghQlClientServices().getMutateOptions(
        document: AlarmsSchema.addComment,
        context: context,
        showErrorMessage: false,
        onCompleted: (data) {
          if (data != null) {
            buildSnackBar(
              context: context,
              value: "Comment added..",
            );
            onCompleted();
          } else {
            buildSnackBar(
              context: context,
              value: "Comment adding failed. Please try again later",
            );
          }
        },
      ),
      builder: (runMutation, result) {
        if (result?.isLoading ?? false) {
          return Row(
            children: [
              const Text("Comment Addding.."),
              SizedBox(
                width: 3.sp,
              ),
              const Center(child: CircularProgressIndicator.adaptive()),
            ],
          );
        }

        return CommentTextfield(
          sendButtonIsLoading: result?.isLoading ?? false,
          sendButtonTap: (comment) {
            runMutation({
              "payload": {
                "eventId": eventId,
                "type": "manual",
                "comment": comment,
                "commentTime": DateTime.now().millisecondsSinceEpoch,
                "assetCopyRequired": false
              }
            });
          },
        );
      },
    );
  }
}
