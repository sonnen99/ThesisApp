
class RadarParameter {
  RadarParameter(this.date, this.values);

  final String date;
  final List<Object> values;

  RadarParameter.fromJson(Map<String, dynamic> json)
      : date = json['d'],
        values = json['v'];

  Map<String, dynamic> toJson() {
    return {
      'd': date,
      'v': values,
    };
  }
}
