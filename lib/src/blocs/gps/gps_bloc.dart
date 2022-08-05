import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  GpsBloc() : super( const GpsState(isGpsPermissionGranted: false, isGpsEnable: false) ) {

    on<GpsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GpsAddPermissionEvent>((event, emit) => emit(state.copyWidth(
        isGpsEnable: event.isGpsEnable,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      ))
    );
  }
}
