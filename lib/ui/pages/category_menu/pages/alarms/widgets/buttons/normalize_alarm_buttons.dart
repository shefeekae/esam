import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';

import '../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../shared/widgets/buttons/custom_elevated_button.dart';

class NormalizeAlarmButton extends StatelessWidget {
  NormalizeAlarmButton({
    required this.eventId,
    required this.isActive,
    this.padding,
    super.key,
  });

  final String eventId;
  final bool isActive;
  final EdgeInsetsGeometry? padding;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return const SizedBox();
    }

    return MutationWidget(
      options: GrapghQlClientServices().getMutateOptions(
        document: AlarmsSchema.normalizeAlarm,
        context: context,
        onCompleted: (data) {
          if (data != null) {
            buildSnackBar(
                context: context, value: "Alarm normalized successfully");
            Navigator.of(context).pop(true);
          }
        },
      ),
      builder: (runMutation, result) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          isLoading: result?.isLoading ?? false,
          title: "Normalize Alarm",
          onPressed: () async {
            String? message = await showDialog<String?>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Force Normalize Alarm'),
                    content: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                          hintText: "Enter normalize resolve message",
                          border: OutlineInputBorder()),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(messageController.text.trim());
                        },
                        child: const Text(
                          "Save",
                        ),
                      )
                    ],
                  );
                });

            if (message == null || message.isEmpty) {
              return;
            }

            runMutation({
              "data": [
                {
                  "eventId": eventId,
                  "resolveMessage": message,
                }
              ]
            });
          },
        ),
      ),
    );
  }
}
