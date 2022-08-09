import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart'; 

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapBloc mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.red, 
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>( // aqui estoy escuchando el MapBloc
          builder: (context, state) {
            final isFollowingUser = state.isFollowingUser;
            return IconButton(
              icon: Icon(state.showMyRoute ? Icons.more_horiz_rounded : Icons.more_horiz_rounded),
              color: state.showMyRoute ? Color.fromARGB(255, 0, 255, 8) : Colors.white,
              onPressed: () {
                // modifica al valor contrario si esta mostrando la linea en el mapa ahora no la muestra
                mapBloc.add(OnToggleUserRoute());
              },
            );
          },
        ),
      ),
    );
  }
}
