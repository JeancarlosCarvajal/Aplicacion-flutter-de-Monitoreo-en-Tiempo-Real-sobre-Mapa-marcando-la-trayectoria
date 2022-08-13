part of 'search_bloc.dart';

class SearchState extends Equatable {

  // indiador si quiere que despliegue el marcador manual
  final bool displayManualMarker;
  // almacenar los lugares de las busquedas
  final List<Feature> places;
  // Almacena el historial de busqueda 
  final List<Feature> searchHistory;

  const SearchState({
    this.displayManualMarker = false, // valor por defecto false
    this.places = const [], // al crear el SearchState nunca se va tener un valor, se recomienda siempre inicializarlo con una constante en el constructor
    this.searchHistory = const []
  });

  SearchState copyWidth({
    bool? displayManualMarker,
    List<Feature>? places,
    List<Feature>? searchHistory
  }) 
  => SearchState(
    displayManualMarker: displayManualMarker ?? this.displayManualMarker,
    places: places ?? this.places,
    searchHistory: searchHistory ?? this.searchHistory
  );
  
  @override
  List<Object> get props => [ displayManualMarker, places, searchHistory ];
} 
