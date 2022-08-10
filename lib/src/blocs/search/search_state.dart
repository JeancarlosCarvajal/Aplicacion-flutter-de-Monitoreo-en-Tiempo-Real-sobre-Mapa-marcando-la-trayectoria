part of 'search_bloc.dart';

class SearchState extends Equatable {

  // indiador si quiere que despliegue el marcador manual
  final bool displayManualMarker;

  const SearchState({
    this.displayManualMarker = false, // valor por defecto false
  });

  SearchState copyWidth({
    bool? displayManualMarker
  }) 
  => SearchState(
    displayManualMarker: displayManualMarker ?? this.displayManualMarker
  );
  
  @override
  List<Object> get props => [ displayManualMarker ];
} 
