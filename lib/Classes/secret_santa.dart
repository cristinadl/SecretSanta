class Persona {
  String name;
  String family;
  String gives = "";
  bool available = true;
  // Creating parent constructor
  Persona({required this.name,required this.family});
}


class SecretSanta{
  //var id;
  //var groupId;
  String groupName;
  var adminID;
  var participants =  <Persona>[];
  var availableUsers = <Persona>[];
  var users = <Persona>[];
  var type;
  bool shuffled = false;
  var budget;
  //var date;

  SecretSanta({required this.groupName});

  void fillParticipants(List<Persona> data){
    users = List.from(data);
    availableUsers = List.from(data);
  }

  String getSecretSanta(Persona giver){
    final availableUsersEx = <Persona>[];
    for( var i = 0 ; i < availableUsers.length; i++) {
      if(availableUsers[i].name != giver.name && availableUsers[i].family != giver.family){
        availableUsersEx.add(availableUsers[i]);
      }
    }
    giver.gives = (availableUsersEx..shuffle()).first.name;
    availableUsers.removeWhere((item) => item.name == giver.gives);
    return giver.gives;
  }

  void addUser(Persona user){
    users.add(user);
    availableUsers.add(user);
  }

  void instantShuffle(){
    if(!shuffled){
      for( var i = 0; i < users.length; i++){
        Persona giver = users[i];
        final availableUsersEx = <Persona>[];
        for( var j = 0 ; j < availableUsers.length; j++) {
          if(availableUsers[j].name != giver.name && availableUsers[j].family != giver.family){
            availableUsersEx.add(availableUsers[j]);
          }
        }
        giver.gives = (availableUsersEx..shuffle()).first.name;
        availableUsers.removeWhere((item) => item.name == giver.gives);
      }
    }
  }

  String getUsersLength(){
    return users.length.toString();
  }

  String getAvailableUsersLength(){
    return availableUsers.length.toString();
  }

  List getUsers(){
    return users;
  }
}
