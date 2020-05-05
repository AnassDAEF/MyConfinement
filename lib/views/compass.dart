import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math';

import 'package:my_confinement/widgets/menu.dart'; 


class Compass extends StatefulWidget {//since the direction keeps changing, so should the angle and the compass pointer, thus we use STFUL widget
  @override
  _CompassState createState() => new _CompassState();
}

class _CompassState extends State<Compass> {
  double _direction;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompassRed(direction: _direction);
  }
}

class CompassRed extends StatelessWidget { 
  const CompassRed({
    Key key,
    @required double direction,
  }) : _direction = direction, super(key: key);

  final double _direction;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Menu(),
      appBar: new AppBar(
        title: const Text('Compass'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Transform.rotate( // to get the angle deviation
          angle: ((_direction ?? 0) * (pi / 180) * -1),
          child: Image.asset('assets/compass.png')
        ),
      ),
    );
  }
}