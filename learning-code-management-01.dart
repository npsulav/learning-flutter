import 'package:flutter/material.dart';

// @author npsulav

// this is the model of the data
class User {
  String name, image, post;
  User({this.name, this.image, this.post});
}

List<User> userList = [];

// Datastore sole purpose is to get and populate the data
// in [userList] so the View can consume it
// Datastore may fetch the data from Server, Local Database
// or from Shared Prefs or from all of the above
// changing the datastore shoud not affect View 
class Datastore {
  Datastore() {
    User u1 = User(
        name: "John Doe",
        image: "https://hackernoon.com/images/avatars/GqcjssqRtrhIrv8IXYk1w1FHUYG3.jpg",
        post: "Android Developer");
    userList.add(u1);
    User u2 = User(
        name: "Jane Doe",
        image: "https://hackernoon.com/images/avatars/GqcjssqRtrhIrv8IXYk1w1FHUYG3.jpg",
        post: "IOS Developer");
    userList.add(u2);
    User u3 = User(
        name: "Johan Doe",
        image: "https://hackernoon.com/images/avatars/GqcjssqRtrhIrv8IXYk1w1FHUYG3.jpg",
        post: "Web Developer");
    userList.add(u3);
  }
}


// entry for the application
void main() {
  runApp(MyApp());
}





// View
// View doesnot where the data is from coming
// its sole purpose here is just to consume the [userList] 
// and it doesnot care anything else
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  // calling the datastore so that it can populate the [userList]
  var ds = new Datastore();

  @override
  Widget build(BuildContext cn) {
    return MaterialApp(
      home: Scaffold(
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(userList[index].image),
                  title: Text(userList[index].name),
                  subtitle: Text(userList[index].post),
                  trailing: Text(index.toString())
                );
              })),
    );
  }
}
