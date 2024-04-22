class Parameter {
  Parameter(this.name, this.maxmin, this.max, this.min);

  final String name;
  final String maxmin;
  final int max;
  final int min;

  Parameter.fromJson(Map<String, dynamic> json)
      : name = json['n'],
        maxmin = json['mm'],
        max = json['max'],
        min = json['min'];

  Map<String, dynamic> toJson() {
    return {
      'n': name,
      'mm': maxmin,
      'max': max,
      'min': min,
    };
  }
}
