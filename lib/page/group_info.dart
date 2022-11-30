import 'package:flutter/material.dart';
import 'package:secret_santa/Classes/secret_santa.dart';
import 'colors.dart' as color;

class GroupInfo extends StatefulWidget {
  final SecretSanta group;
  const GroupInfo({Key? key, required this.group}) : super(key: key);
  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  List<Persona> dummy = [
    Persona(name: "Ricky", family: "Ricky"),
    Persona(name: "Mayte", family: "Mayte"),
    Persona(name: "Richo", family: "Richo"),
    Persona(name: "Teresita", family: "Richo"),
    Persona(name: "Tofita", family: "Tofita"),
    Persona(name: "Caro", family: "Tofita"),
    Persona(name: "Max", family: "Tofita"),
    Persona(name: "Caty", family: "Tofita"),
    Persona(name: "Césarin", family: "Tofita"),
    Persona(name: "Titi", family: "Titi"),
    Persona(name: "Sebas", family: "Titi"),
    Persona(name: "Maria Andrea", family: "Titi"),
    Persona(name: "Mari José", family: "Titi"),
    Persona(name: "Abuelo", family: "Abuelo"),
  ];
  var i = 0;
  String _groupName = " ";
  String _budget = " ";
  var _participants = <Persona>[];
  final TextEditingController _eventController = TextEditingController();
  //String _code = " ";

  void _shuffle (String users, String available, String code) {
    setState((){
      _groupName = users;
      widget.group.groupName = "nuevo";
      _budget = available;
    });
  }



  @override
  void dispose(){
    _eventController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _groupName = widget.group.groupName;
    _budget = widget.group.getAvailableUsersLength();
    _participants = [...widget.group.users];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  color.AppColor.formBox.withOpacity(0.8),
                  color.AppColor.formPageButton.withOpacity(0.4),
                ],
                begin: Alignment.center,
                end: Alignment.bottomLeft
            )
        ),
        padding: const EdgeInsets.only(top: 70, left: 30, right: 20, bottom: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){Navigator.pop(context, widget.group);},
                      icon: const Icon(size: 20,Icons.arrow_back_ios),
                  ),
                  Expanded(child: Container()),
                  IconButton(alignment:Alignment.centerRight,onPressed: (){}, icon: const Icon(size: 15, Icons.share)),
                  IconButton(alignment:Alignment.centerLeft, onPressed: (){}, icon: const Icon(size: 30,Icons.more_horiz)),
                ],
              ), // Main title
              const SizedBox(height: 30,),
              Text(_groupName),
              Text(_budget),
              const Text("Hola"),
              const Text("Group Code"),
              Row(
                children: [
                  Text(
                    "Participants: ",
                    style: TextStyle(
                        fontSize: 18,
                        color: color.AppColor.homePageTitle,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: FittedBox(
                      child: IconButton(
                        onPressed: (){
                          _showAddDialog();
                        },
                        tooltip: 'Add new group',
                        icon: Icon(Icons.person_add,size: 30,color: color.AppColor.homePageTitle,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80, // as big as screen
                height: MediaQuery.of(context).size.height - 400,
                child: Column(
                  children: [
                    Expanded(
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              itemCount: _participants.length,
                              itemBuilder: (context, i){
                                return InkWell(
                                  onLongPress: (){
                                    setState(() {
                                      _removeUser(context, _participants[i]);
                                    });
                                  },
                                  child: Container(
                                      width: double.maxFinite, // as big as parent
                                      height: 80,
                                      margin: const EdgeInsets.only(bottom:5, top: 5),
                                      //padding: const EdgeInsets.only(bottom:20), // for whats inside
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: color.AppColor.formPageBox,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3,
                                                offset: const Offset(5,5),
                                                color: color.AppColor.homePageButton.withOpacity(0.1)
                                            )
                                          ]
                                      ),
                                      child: Center(
                                        child: Text(
                                          _participants[i].name,
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: color.AppColor.homePageTitle,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      )
                                  ),
                                );
                              }),
                        )
                    )
                  ],
                ),
              ), // List of groups
              TextButton(
                onPressed: () {
                  widget.group.instantShuffle();
                  widget.group.shuffled = true;
                  },
                child: const Text("Shuffle"),
              )
            ],
          ),
        ),
      )
    );
  }

  _removeUser(context, Persona persona) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Elimnar Participante...!'),
        content: Text('Esta seguro de eliminar a ${persona.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                widget.group.users.remove(persona);
                widget.group.participants.remove(persona);
                widget.group.availableUsers.remove(persona);
                _participants = [...widget.group.users];
                Navigator.pop(context);
              });
            },
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("Put name"),
            content: TextField(
                controller:  _eventController
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text("more",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    if(_eventController.text.isEmpty) return;
                    if(_eventController.text.replaceAll(' ', '') == '') return;
                    setState(() {
                      widget.group.users.add(Persona(name: _eventController.text, family: _eventController.text));
                      widget.group.participants.add(Persona(name: _eventController.text, family: _eventController.text));
                      widget.group.availableUsers.add(Persona(name: _eventController.text, family: _eventController.text));
                      _eventController.clear();
                    });

                  }

              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if(_eventController.text.isNotEmpty && _eventController.text.replaceAll(' ', '') != '') {
                      widget.group.users.add(Persona(name: _eventController.text, family: _eventController.text));
                      widget.group.participants.add(Persona(name: _eventController.text, family: _eventController.text));
                      widget.group.availableUsers.add(Persona(name: _eventController.text, family: _eventController.text));
                    }
                    _eventController.clear();
                    _participants = [...widget.group.users];
                    Navigator.pop(context);
                  });
                },
                child: const Text('Done'),
              ),
            ],
          );

        });
  }
}
