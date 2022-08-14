import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart';

import 'package:maps_app/src/screens/screens.dart';
import 'package:maps_app/src/services/services.dart';

void main() async {

  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env"); 

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()), 
        BlocProvider(create: (context) => MapBloc( locationBloc: BlocProvider.of<LocationBloc>(context) )),  
        BlocProvider(create: (context) => SearchBloc(trafficService: TrafficService())), 
      ], 
      child: const MapsApp()
    )
  );  

}

class MapsApp extends StatelessWidget {
  const MapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MappsApp',
      // home: LoadingScreen(),
      home: MapScreen(),
      routes: {},
    );
  }
}
