import 'package:flutter/material.dart';
import 'package:secret_santa/page/group_info.dart';
import 'package:secret_santa/Classes/secret_santa.dart';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var existentSecretSantas = <SecretSanta>[];
  int i = 0;
  bool added = false;
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _navigateAndSaveChanges(BuildContext context, int i) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  GroupInfo(group: existentSecretSantas[i])),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    _groupNameController.dispose();
    _budgetController.dispose();
    _typeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                color.AppColor.formPageButton.withOpacity(0.2),
                color.AppColor.formBox.withOpacity(0.8),
              ],
            begin: Alignment.center,
            end: Alignment.bottomLeft
          )
        ),
        padding: const EdgeInsets.only(top: 70, left: 30, right: 20, bottom: 200),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Amigo Secreto",
                    style: TextStyle(
                      fontSize: 28,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: (){
                          _showAddDialog();
                        },
                        tooltip: 'Add new group',
                        backgroundColor: color.AppColor.homePageTitle,
                        child: Icon(Icons.group_add,size: 20,color: color.AppColor.homePageBackground,),
                      ),
                    ),
                  ),
                ],
              ), // Main title
              const SizedBox(height: 30,),
              Row(
                children: [
                  Text(
                    "Tus intercambios: ",
                    style: TextStyle(
                        fontSize: 20,
                        color: color.AppColor.homePageText,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Expanded(child: Container()),
                  /*SizedBox(
                    height: 40,
                    width: 40,
                    child: FittedBox(
                      child: IconButton(
                        onPressed: (){},
                        tooltip: 'Edit groups',
                        icon: Icon(Icons.edit,size: 20,color: color.AppColor.homePageText,),
                      ),
                    ),
                  ),*/
                ],
              ), // Your groups: title
              SizedBox(
                width: MediaQuery.of(context).size.width - 50, // as big as screen
                height: MediaQuery.of(context).size.height - 350,
                child: Column(
                  children: [
                    Expanded(
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              itemCount: existentSecretSantas.length,
                              itemBuilder: (context, i){
                                return InkWell(
                                  onTap: (){_navigateAndSaveChanges(context, i);},
                                  onLongPress: (){_removeSecretSanta(context,existentSecretSantas[i]);},
                                  child: Container(
                                      width: double.maxFinite, // as big as parent
                                      height: 80,
                                      margin: const EdgeInsets.only(bottom:20, top: 15),
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
                                          existentSecretSantas[i].groupName,
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
            ],
          ),
        ),
      )
    );
  }

  _removeSecretSanta(context, SecretSanta grupo) async {
   await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Elimnar grupo...!'),
        content: Text('Esta seguro de eliminar a ${grupo.groupName}?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                existentSecretSantas.remove(grupo);
                Navigator.pop(context);
              });
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }


  _showAddDialog() async {
    SecretSanta newData = SecretSanta(groupName: "");
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Create group'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _groupNameController,
                          decoration: const InputDecoration(
                            labelText: 'Group name',
                            icon: Icon(Icons.group),
                          ),
                        ),
                        TextFormField(
                          controller: _budgetController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Budget',
                            icon: Icon(Icons.monetization_on),
                          ),
                        ),
                        TextFormField(
                          controller:  _typeController,
                          decoration: const InputDecoration(
                            labelText: 'Choose type',
                            icon: Icon(Icons.info),
                          ),
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter YOUR name',
                            icon: Icon(Icons.admin_panel_settings ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 5, left: 40, right: 5),
                          child: const Text(
                            'This is the name that other participants will see.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w200
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      child: const Text("Submit"),
                      onPressed: () {
                       setState(() {
                         newData.groupName = _groupNameController.text;
                         newData.budget = _budgetController.text;
                         newData.type = _typeController.text;
                         newData.addUser(Persona(name: _nameController.text, family: _nameController.text));
                         newData.adminID =  _nameController.text; // TODO (Add device id)
                         existentSecretSantas.insert(0,newData);
                         _groupNameController.clear();
                         _budgetController.clear();
                         _typeController.clear();
                         _nameController.clear();
                         Navigator.pop(context,true);
                       });
                      })
                ],
              );
            }).then((exit) {
              if(exit == null){
                _groupNameController.clear();
                _budgetController.clear();
                _typeController.clear();
                _nameController.clear();
              }
              print(exit);
    });
  }
}

