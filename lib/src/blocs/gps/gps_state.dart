part of 'gps_bloc.dart';




class GpsState extends Equatable {

  final bool isGpsEnabled;

  final bool isGpsPermissionGranted;


  const GpsState({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted
  });

  GpsState copyWidth({
    bool? isGpsEnabled, 
    bool? isGpsPermissionGranted
  }) => GpsState (
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted 
  );
  
  // Equatable Agrega esta lista para verificar si algun estado se mantiene y no hacer retrabajos
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGranted ];


  // cuando se serializa la clase en un string por ejemplo al imprimirla en print(state)
  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
} 
