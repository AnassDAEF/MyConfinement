import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'My confinement',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Todo List'),
            onTap: () => {Navigator.of(context).pushNamed("/todolist")}
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text('Boussole'),
            onTap: () => {Navigator.of(context).pushNamed("/compass")}
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Maps'),
            onTap: () => {Navigator.of(context).pushNamed("/velomap")}
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Agenda'),
            onTap: () => {Navigator.of(context).pushNamed("/posts")}
          )
        ],
      ),
    );
  }
}

//Navigator.of(context).pop()