part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class OnActivateManualMarkerEvent extends SearchEvent{}
class OnDeactivateManualMarkerEvent extends SearchEvent{}

// lugares obtenidos de la base de datos API de MapBox
class OnNewPlacesFoundEvent extends SearchEvent{
  final List<Feature> places; 
  const OnNewPlacesFoundEvent(this.places);
}

// AddToHistoryEvent Historial de busquedas por query
class AddToHistoryEvent extends SearchEvent {
  final Feature place;
  const AddToHistoryEvent(this.place);
}