// ignore_for_file: public_member_api_docs, sort_constructors_first
class MachinesHoursModel {
  String label;
  double previousMonthValue;
  double currentMonthValue;
  MachinesHoursModel({
    required this.label,
    required this.previousMonthValue,
    required this.currentMonthValue,
  });
}

List<MachinesHoursModel> machinesHoursList = [
  MachinesHoursModel(
    label: "Periodic Fuel Used",
    previousMonthValue: 40000,
    currentMonthValue: 30000,
  ),
  MachinesHoursModel(
    label: "Daily Fuel Used",
    previousMonthValue: 2500,
    currentMonthValue: 5000,
  ),
];
