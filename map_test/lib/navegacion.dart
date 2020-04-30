import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            
            /* Pasa a la siguiente pantalla pero deja abierta esta */
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(builder: (context) => SecondRoute()),
            //);

            /* Pasa a la siguiente pantalla y cierra esta esta */
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => SecondRoute()));
    
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Navigator.pop(context); //se devuelve a la pantalla anterior
            exit(0);  //cierra todo
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}