import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/file_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/required_text.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_listtile.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:app_filter_form/core/services/file_services.dart';

class SwitchBreakDownStatusScreen extends StatefulWidget {
  const SwitchBreakDownStatusScreen(
      {super.key,
      required this.type,
      required this.identifier,
      required this.underMaintenance});

  final String type;
  final String identifier;
  final bool underMaintenance;

  @override
  State<SwitchBreakDownStatusScreen> createState() =>
      _SwitchBreakDownStatusScreenState();
}

class _SwitchBreakDownStatusScreenState
    extends State<SwitchBreakDownStatusScreen> {
  TextEditingController breakdownNotesController = TextEditingController();
  // TextEditingController serviceRunHoursController = TextEditingController();
  // TextEditingController serviceOdometerController = TextEditingController();

  final GlobalKey<FormState> _breakdownFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _serviceRunHoursFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _serviceOdometerFormKey = GlobalKey<FormState>();

  UserDataSingleton userData = UserDataSingleton();

  late int breakDownDateTimeMilliSecondsEpoch;

  late int serviceStartDateMilliSecondsEpoch;
  late int serviceEndDateMilliSecondsEpoch;

  ValueNotifier<String> breakdownTimeNotifier =
      ValueNotifier<String>(DateFormat("dd MMM yy").add_jm().format(
            DateTime.now(),
          ));
  ValueNotifier<String> serviceTimeStartNotifier =
      ValueNotifier<String>(DateFormat("dd MMM yy").add_jm().format(
            DateTime.now(),
          ));
  ValueNotifier<String> serviceTimeEndNotifier =
      ValueNotifier<String>(DateFormat("dd MMM yy").add_jm().format(
            DateTime.now(),
          ));

  ValueNotifier<File?> filesNotifier = ValueNotifier<File?>(null);

  @override
  void initState() {
    breakDownDateTimeMilliSecondsEpoch = DateTime.now().millisecondsSinceEpoch;
    serviceStartDateMilliSecondsEpoch = DateTime.now().millisecondsSinceEpoch;
    serviceEndDateMilliSecondsEpoch = DateTime.now().millisecondsSinceEpoch;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Switch Breakdown Status",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequiredTextWidget(
                title: widget.underMaintenance
                    ? "Service Start Date"
                    : "BreakDown Time",
              ),
              SizedBox(
                height: 5.sp,
              ),
              Visibility(
                visible: !widget.underMaintenance,
                child: ValueListenableBuilder(
                    valueListenable: breakdownTimeNotifier,
                    builder: (context, value, child) {
                      return ContainerWithListTile(
                        title: value,
                        trailing: const Icon(Icons.calendar_month),
                        onTap: () async {
                          DateTime dateAndTime =
                              await showDateTimePicker(context: context);

                          breakDownDateTimeMilliSecondsEpoch =
                              dateAndTime.millisecondsSinceEpoch;

                          breakdownTimeNotifier.value = DateFormat("dd MMM yyy")
                              .add_jm()
                              .format(dateAndTime);

                          // breakdownTimeNotifier.notifyListeners();
                        },
                      );
                    }),
              ),
              Visibility(
                visible: widget.underMaintenance,
                child: ValueListenableBuilder(
                    valueListenable: serviceTimeStartNotifier,
                    builder: (context, value, child) {
                      return ContainerWithListTile(
                        title: value,
                        trailing: const Icon(Icons.calendar_month),
                        onTap: () async {
                          DateTime dateAndTime =
                              await showDateTimePicker(context: context);

                          serviceStartDateMilliSecondsEpoch =
                              dateAndTime.millisecondsSinceEpoch;

                          serviceTimeStartNotifier.value =
                              DateFormat("dd MMM yyy")
                                  .add_jm()
                                  .format(dateAndTime);

                          // serviceTimeStartNotifier.notifyListeners();
                        },
                      );
                    }),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Visibility(
                visible: widget.underMaintenance,
                child: const RequiredTextWidget(
                  title: "Service End Date",
                ),
              ),
              Visibility(
                visible: widget.underMaintenance,
                child: SizedBox(
                  height: 5.sp,
                ),
              ),
              Visibility(
                visible: widget.underMaintenance,
                child: ValueListenableBuilder(
                    valueListenable: serviceTimeEndNotifier,
                    builder: (context, value, child) {
                      return ContainerWithListTile(
                        title: value,
                        trailing: const Icon(Icons.calendar_month),
                        onTap: () async {
                          DateTime dateAndTime =
                              await showDateTimePicker(context: context);

                          serviceEndDateMilliSecondsEpoch =
                              dateAndTime.millisecondsSinceEpoch;

                          serviceTimeEndNotifier.value =
                              DateFormat("dd MMM yyy")
                                  .add_jm()
                                  .format(dateAndTime);

                          // serviceTimeEndNotifier.notifyListeners();
                        },
                      );
                    }),
              ),
              // Visibility(
              //   visible: widget.underMaintenance,
              //   child: SizedBox(
              //     height: 10.sp,
              //   ),
              // ),
              //==================================================================
              // // Visibility(
              // //   visible: widget.underMaintenance,
              // //   child: const RequiredTextWidget(
              // //     title: "Service Run Hours",
              // //   ),
              // // ),
              // // Visibility(
              // //   visible: widget.underMaintenance,
              // //   child: SizedBox(
              // //     height: 5.sp,
              // //   ),
              // // ),
              // // Visibility(
              // //   visible: widget.underMaintenance,
              // //   child: Form(
              // //     key: _serviceRunHoursFormKey,
              // //     child: TextFormField(
              // //       keyboardType: TextInputType.number,
              // //       validator: (value) {
              // //         if (value == null || value.isEmpty) {
              // //           return "Please enter the Service Run Hours";
              // //         } else {
              // //           return null;
              // //         }
              // //       },
              // //       maxLines: 1,
              // //       controller: serviceRunHoursController,
              // //       decoration: InputDecoration(
              // //         // fillColor: kWhite,
              // //         filled: true,

              // //         focusedErrorBorder: OutlineInputBorder(
              // //           borderRadius: BorderRadius.circular(5),
              // //           borderSide: const BorderSide(color: Colors.red),
              // //         ),

              // //         errorBorder: OutlineInputBorder(
              // //           borderRadius: BorderRadius.circular(5),
              // //           borderSide: const BorderSide(color: Colors.red),
              // //         ),
              // //         hintText: "Service Run Hours",
              // //         border: OutlineInputBorder(
              // //           borderRadius: BorderRadius.circular(5),
              // //           borderSide: BorderSide.none,
              // //         ),
              // //       ),
              // //     ),
              // //   ),
              // // ),
              // //==================================================================
              // Visibility(
              //   visible: widget.underMaintenance,
              //   child: SizedBox(
              //     height: 10.sp,
              //   ),
              // ),
              // //==================================================================
              // Visibility(
              //   visible: widget.underMaintenance,
              //   child: Visibility(
              //     visible: widget.underMaintenance,
              //     child: const RequiredTextWidget(
              //       title: "Service Odometer",
              //     ),
              //   ),
              // ),
              // Visibility(
              //   visible: widget.underMaintenance,
              //   child: SizedBox(
              //     height: 5.sp,
              //   ),
              // ),
              // Visibility(
              //   visible: widget.underMaintenance,
              //   child: Form(
              //     key: _serviceOdometerFormKey,
              //     child: TextFormField(
              //       keyboardType: TextInputType.number,
              //       validator: (value) {
              //         if (value == null || value.isEmpty) {
              //           return "Please enter the Service Run Hours";
              //         } else {
              //           return null;
              //         }
              //       },
              //       maxLines: 1,
              //       controller: serviceOdometerController,
              //       decoration: InputDecoration(
              //         // fillColor: kWhite,
              //         filled: true,

              //         focusedErrorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //           borderSide: const BorderSide(color: Colors.red),
              //         ),

              //         errorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //           borderSide: const BorderSide(color: Colors.red),
              //         ),
              //         hintText: "Service Odometer",
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //           borderSide: BorderSide.none,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              //==================================================================
              Visibility(
                visible: widget.underMaintenance,
                child: SizedBox(
                  height: 10.sp,
                ),
              ),
              const RequiredTextWidget(
                title: "Notes",
              ),
              SizedBox(
                height: 5.sp,
              ),
              Form(
                key: _breakdownFormKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the breakdown notes";
                    } else {
                      return null;
                    }
                  },
                  maxLines: 4,
                  controller: breakdownNotesController,
                  decoration: InputDecoration(
                    // fillColor: kWhite,
                    filled: true,

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    hintText: "Enter Breakdown Notes",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              const RequiredTextWidget(
                title: "Files",
                required: false,
              ),
              SizedBox(
                height: 5.sp,
              ),
              ValueListenableBuilder(
                  valueListenable: filesNotifier,
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () async {
                        File? file =
                            await AttachmentServices().pickImage(context);

                        if (file != null) {
                          filesNotifier.value = file;
                        }

                        // ImagePicker picker = ImagePicker();

                        // try {
                        //   // XFile? xFile = await picker.pickImage(
                        //   //   source: ImageSource.gallery,
                        //   // );

                        //   // if (xFile == null) {
                        //   //   return;
                        //   // }
                        //   // value = File(xFile.path);
                        // } catch (e) {
                        //   print(e);
                        //   // TODO
                        // }

                        // filesNotifier.notifyListeners();
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeServices().getBgColor(context),
                              borderRadius: BorderRadius.circular(3.sp),
                              image: value == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(
                                        value,
                                      ),
                                    ),
                            ),
                            height: 100.sp,
                            child: Center(
                              child: value != null
                                  ? null
                                  : const Text("Choose File"),
                            ),
                          ),
                          Visibility(
                            visible: value != null,
                            child: Positioned(
                                right: 5.sp,
                                child: IconButton(
                                    onPressed: () {
                                      filesNotifier.value = null;
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))),
                          )
                        ],
                      ),
                    );
                  }),
              const Spacer(),
              MutationWidget(
                options: GrapghQlClientServices().getMutateOptions(
                  document: AssetSchema.markUnderMaintenanceMutation,
                  context: context,
                  onCompleted: (data) {
                    if (data == null) {
                      return;
                    }

                    print(data);

                    if (filesNotifier.value != null) {
                      String identifier =
                          data['markUnderMaintenance']['data']['identifier'];

                      int? startTime =
                          data['markUnderMaintenance']?['data']?['startTime'];

                      if (startTime == null) {
                        return;
                      }

                      FileServices().attachBreakDownStatusFiles(
                        attachedFile: filesNotifier.value!,
                        context: context,
                        identifier: identifier,
                        dateTimeEpoch: startTime,
                      );
                    }

                    Navigator.of(context).pop(true);
                  },
                ),
                builder: (runMutation, result) => CustomElevatedButton(
                  isLoading: result?.isLoading ?? false,
                  title: "Save",
                  onPressed: () {
                    breakdownStatusOnPressed(
                        runMutation: runMutation,
                        underMaintenance: widget.underMaintenance);
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  breakdownStatusOnPressed(
      {required Function(Map<String, dynamic>, {Object? optimisticResult})
          runMutation,
      required bool underMaintenance}) {
    if (!underMaintenance) {
      if (_breakdownFormKey.currentState!.validate()) {
        runMutation({
          "data": {
            "asset": {
              "type": widget.type,
              "data": {
                "domain": userData.domain,
                "identifier": widget.identifier,
              }
            },
            "breakdownTime": breakDownDateTimeMilliSecondsEpoch,
            "notes": breakdownNotesController.text.trim(),
            "requestType": "CREATED",
            "emailNotification": false
          }
        });
      }
    } else {
      if (
          // _serviceOdometerFormKey.currentState!.validate() ||
          //   _serviceRunHoursFormKey.currentState!.validate() ||
          _breakdownFormKey.currentState!.validate()) {
        runMutation({
          "data": {
            "asset": {
              "type": widget.type,
              "data": {
                "domain": userData.domain,
                "identifier": widget.identifier,
              }
            },
            "jobStartTime": serviceStartDateMilliSecondsEpoch,
            "jobEndTime": serviceEndDateMilliSecondsEpoch,
            "notes": breakdownNotesController.text.trim(),
            // "runhours": int.parse(
            //   serviceRunHoursController.text.trim(),
            // ),
            
            // "odometer": int.parse(
            //   serviceOdometerController.text.trim(),
            // ),
            
            // "assignee": 1252,
            
            // "teamMembers": [1248],
            "requestType": "COMPLETED",
            "emailNotification": false
          }
        });
      }
    }
  }

  Future showDateTimePicker({
    required BuildContext context,
  }) async {
    DateTime? breakDownDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 365 * 100,
        ),
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 100000),
      ),
    );

    if (breakDownDateTime != null) {
      // String breakDownDate =
      //     DateFormat("dd MMM yyyy").format(breakDownDateTime);

      // ignore: use_build_context_synchronously
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(breakDownDateTime),
      );

      if (selectedTime != null) {
        DateTime dateAndTime = DateTime(
            breakDownDateTime.year,
            breakDownDateTime.month,
            breakDownDateTime.day,
            selectedTime.hour,
            selectedTime.minute);

        return dateAndTime;
      }

      // ignore: use_build_context_synchronously
      // final localization = MaterialLocalizations.of(context);
      // final formattedTime = localization.formatTimeOfDay(selectedTime!);
    }

    return DateTime.now();
  }
}
