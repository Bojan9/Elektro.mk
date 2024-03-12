class ConnectorInfo {
  final String id;
  final String type;
  final String tariff;
  final String power;
  final String condition;

  ConnectorInfo({
    required this.id,
    required this.type,
    required this.tariff,
    required this.power,
    required this.condition,
  });

  factory ConnectorInfo.fromJson(Map<String, dynamic> json) {
    
    return ConnectorInfo(
      id: json['id'],
      type: json['type'],
      tariff: json['tariff'],
      power: json['power'],
      condition: json['condition'],
    );
  }
}