import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/src/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
   
  const GpsAccessScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) { 
              // print(state); 
              return !state.isGpsEnabled
                ? const _EnableGpsMessage()
                : const _AccessButton();
            },
          )
         
          // _AccessButton(),
         
          // _EnableGpsMessage(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text( 'Es necesario el acceso al GPS' ),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: (){
            // acceder al bloc para preguntar sobre el acceso
            final gpsBloc = BlocProvider.of<GpsBloc>(context); // una forma 
            // final gpsBloc = context.read<GpsBloc>(); // otra forma de hacerlo

            // accedemos a la funcion que pregunta el acceso
            gpsBloc.askGpsAccess();

          },
          child: const Text( 'Solicitar Acceso', style: TextStyle(color: Colors.white) ), 
        )
      ],
    );
  }
}



class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe de habilitar el GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}