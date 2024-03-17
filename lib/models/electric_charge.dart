import 'package:elektro/models/connector_info.dart';

class ElectricCharge {
  final String id;
  final String name;
  final String location;
  final List<double> coordinates;
  final String availability;
  final String roadAccess;
  final String paymentType;
  final String paymentAccess;
  final bool isOpen;
  final String parking;
  final String limit;
  final List<String> amenities;
  final int numConnectors;
  final List<ConnectorInfo> connectorInfo;

  ElectricCharge({
    required this.id,
    required this.name,
    required this.location,
    required this.coordinates,
    required this.availability,
    required this.roadAccess,
    required this.paymentType,
    required this.paymentAccess,
    required this.isOpen,
    required this.parking,
    required this.limit,
    required this.amenities,
    required this.numConnectors,
    required this.connectorInfo,
  });

  factory ElectricCharge.fromJson(Map<String, dynamic> json) {
    List<ConnectorInfo> connectorInfo = [];

    if (json['connectorInfo'] != null) {
      connectorInfo = List<ConnectorInfo>.from(json['connectorInfo'].map((x) => ConnectorInfo.fromJson(x)));
    }
    
    return ElectricCharge(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
      availability: json['availability'],
      roadAccess: json['roadAccess'],
      paymentType: json['paymentType'],
      paymentAccess: json['paymentAccess'],
      isOpen: json['isOpen'],
      parking: json['parking'],
      limit: json['limit'],
      amenities: json['amenities'] != null ? List<String>.from(json['amenities'].split(',').map((x) => x.trim())) : [],
      numConnectors: json['numConnectors'],
      connectorInfo: connectorInfo,
    );
  }
}