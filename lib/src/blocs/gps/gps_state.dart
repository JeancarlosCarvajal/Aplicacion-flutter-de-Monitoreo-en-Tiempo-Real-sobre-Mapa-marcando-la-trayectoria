part of 'gps_bloc.dart';




class GpsState extends Equatable {

  final bool isGpsEnable;

  final bool isGpsPermissionGranted;


  const GpsState({
    required this.isGpsEnable, 
    required this.isGpsPermissionGranted
  });
  
  // Equatable Agrega esta lista para verificar si algun estado se mantiene y no hacer retrabajos
  @override
  List<Object> get props => [ isGpsEnable, isGpsPermissionGranted ];


  // cuando se serializa la clase en un string por ejemplo al imprimirla en print(state)
  @override
  String toString() => '{ isGpsEnable: $isGpsEnable, isGpsPermissionGranted: $isGpsPermissionGranted }';
} 
