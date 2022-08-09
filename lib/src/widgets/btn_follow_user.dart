import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart'; 

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({Key? key}) : super(key: key);

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
              icon: Icon(state.isFollowingUser ? Icons.directions_run_rounded : Icons.hail_rounded),
              color: state.isFollowingUser ? Color.fromARGB(255, 0, 255, 8) : Colors.white,
              onPressed: () {
                // verifica si el usuario esta siendo seguido para detener el seguimiento
                isFollowingUser
                  ? mapBloc.add(OnStopFollowingUserEvent())
                  : mapBloc.add(OnStartFollowingUserEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
