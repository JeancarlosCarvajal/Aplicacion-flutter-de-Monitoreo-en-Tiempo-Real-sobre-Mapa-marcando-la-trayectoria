part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}


class GpsAddPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsAddPermissionEvent({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted
  }); 
}