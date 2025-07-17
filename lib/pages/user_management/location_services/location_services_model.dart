import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'location_services_widget.dart' show LocationServicesWidget;
import 'package:flutter/material.dart';

class LocationServicesModel extends FlutterFlowModel<LocationServicesWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
