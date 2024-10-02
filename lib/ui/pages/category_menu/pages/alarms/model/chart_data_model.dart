// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChartSampleData {
  ChartSampleData(this.x, this.y, [this.status]);
  final DateTime? x;
  final double y;
  final String? status;
}

class AnnotationModel {
  final String name;
  final num point;
  AnnotationModel({
    required this.name,
    required this.point,
  });
}
