import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; 

import 'package:maps_app/src/blocs/blocs.dart';
import 'package:maps_app/src/views/views.dart';
import 'package:maps_app/src/widgets/widgets.dart';

class MapScreen extends StatefulWidget { // lo converti a statufull para poder inicializar la ubicacion del usuario 
   
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() { //se dispara una vez cuando se construye y puedo hacer una limpieza  
    super.initState();

    // acceso al bloc de location, para ver la ubicacion.. startFollowingUser es para verlo en tiempo real
    // esto se ejecuta de primero y renombramos el locationbloc con los datos y ya se pueden usar mas abajo
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser(); 
  }
  @override
  void dispose() {
    // acceso al bloc de location, para ver la ubicacion.. 
    // stopFolloingUser detener el stream de seguimiento dejar de escuchar cuando se cierre esta pantalla 
    locationBloc.stopFolloingUser(); 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(  // JOJOJO se debria tener un mUltiBlocBuilder
        builder: (context, locationState) {
          if( locationState.lastKnowLocation == null ) return const Center(child: Text( 'Esepere por favor...' ));
          // JOJOJO se debria tener un mUltiBlocBuilder 
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              // extraer el polyline de la ruta 
              // crear una copia de las polylines para detener y crear una nueva polylines para la proxima que se active
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              // removerlo si y solo sii.. OJOJO analizar mejor
              if(!mapState.showMyRoute){ // remueve la ruta del Mapa de polylines
              // remuevo las polylines del Map nuevo que cree peeero el original queda intacto
              // esto se hace para no eliminar el original que lo podemos usar nuevamente para activar la vista de la ruta
                polylines.removeWhere((key, value) => key == 'MyRoute');
              }
              return SingleChildScrollView( // hay que definir dimenciones de los hijos sino da error
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnowLocation!, 
                      // polylines: mapState.polylines.values.toSet(), // OJOJOJ el toSet() sirvio para convertir el Map de las polylines en un Set
                      polylines: polylines.values.toSet(), // OJOJOJ el toSet() sirvio para convertir el Map de las polylines en un Set
                    ),

                    // TODO: Botones
                    SearchBar()
                    
                  ],
                ),
              );
            },
          );

          // return GoogleMap(initialCameraPosition: initialCameraPosition); 
          // return Center(
          //   child: Text( 'Latitude: ${state.lastKnowLocation!.latitude}, Longitud: ${state.lastKnowLocation!.longitude}' ),
          // );

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}