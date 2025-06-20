class Kpi {
  final String id;
  final String name;
  final String frequency;
  final int target;

  Kpi({
    required this.id,
    required this.name,
    required this.frequency,
    required this.target,
  });

  factory Kpi.fromJson(Map<String, dynamic> json) {
    return Kpi(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      frequency: json['frequency'] ?? '',
      target: json['target'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'frequency': frequency, 'target': target};
  }
}
