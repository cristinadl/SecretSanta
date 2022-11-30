import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const myTitle = 'Flutter Demo';
    return GetMaterialApp(
      title: myTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: myTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Persona {
  String name = "";
  String familia = "";
  String gives = "";
  bool available = true;
  // Creating parent constructor
  Persona(String nombre, String fam){
    familia = fam ;
    name = nombre;
  }
}

class SecretSanta{
  final _availableUsers = <Persona>[];
  final _users = <Persona>[];
  SecretSanta(){
    _users.add(Persona("Ricky", "Ricky"));
    _users.add(Persona("Mayte", "Mayte"));
    _users.add(Persona("Richo", "Richo"));
    _users.add(Persona("Teresita", "Richo"));
    _users.add(Persona("Tofita", "Tofita"));
    _users.add(Persona("Caro", "Tofita"));
    _users.add(Persona("Max", "Tofita"));
    _users.add(Persona("Caty", "Tofita"));
    _users.add(Persona("Césarin", "Tofita"));
    _users.add(Persona("Titi", "Titi"));
    _users.add(Persona("Sebas", "Titi"));
    _users.add(Persona("Maria Andrea", "Titi"));
    _users.add(Persona("Mari José", "Titi"));
    _users.add(Persona("Abuelo", "Abuelo"));

    _availableUsers.add(Persona("Ricky", "Ricky"));
    _availableUsers.add(Persona("Mayte", "Mayte"));
    _availableUsers.add(Persona("Richo", "Richo"));
    _availableUsers.add(Persona("Teresita", "Richo"));
    _availableUsers.add(Persona("Tofita", "Tofita"));
    _availableUsers.add(Persona("Caro", "Tofita"));
    _availableUsers.add(Persona("Max", "Tofita"));
    _availableUsers.add(Persona("Caty", "Tofita"));
    _availableUsers.add(Persona("Césarin", "Tofita"));
    _availableUsers.add(Persona("Titi", "Titi"));
    _availableUsers.add(Persona("Sebas", "Titi"));
    _availableUsers.add(Persona("Maria Andrea", "Titi"));
    _availableUsers.add(Persona("Mari José", "Titi"));
    _availableUsers.add(Persona("Abuelo", "Abuelo"));
  }
  String getSecretSanta(Persona giver){
    final availableUsersEx = <Persona>[];
    for( var i = 0 ; i < _availableUsers.length; i++) {
      if(_availableUsers[i].name != giver.name && _availableUsers[i].familia != giver.familia){
        availableUsersEx.add(_availableUsers[i]);
      }
    }
    giver.gives = (availableUsersEx..shuffle()).first.name;
    _availableUsers.removeWhere((item) => item.name == giver.gives);
    return giver.gives;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = -1;
  String _texto = " ";
  SecretSanta _jugada = SecretSanta();
  String _giver = "Intercambio";
  String _receiver = "Familiar";
  bool show = true;

  void _reset () {
    setState((){
      _giver = "Intercambio";
      _receiver = "Familiar";
      _texto = " ";
      _jugada = SecretSanta();
      _counter = -1;
      show = true;
    });
  }

  void _showGiver(){
    setState((){
      if (show) {
        show = false;
      } else {
        show = true;
      }
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
      if(_counter < _jugada._users.length){
        show = false;
        final giver = _jugada._users[_counter];
        _receiver = _jugada.getSecretSanta(giver);
        _giver = giver.name;
        _texto = "Te tocó: ";
      }else{
        _receiver = "Ya fue TODO";
        _texto = " ";
        _giver = "Grax por participar";
        show = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _giver,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              _texto,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              show ? _receiver : "....",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _reset,
                tooltip: 'Reset',
                child: const Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                onPressed: _showGiver,
                tooltip: 'Show',
                child: const Icon(Icons.remove_red_eye),
              ),
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.navigate_next),
              )
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
