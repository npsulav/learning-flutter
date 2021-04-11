import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// entry for the application
void main() {
  runApp(MyApp());
}

// Mock Data
final url = 'https://jsonplaceholder.typicode.com/users';

// @author npsulav

// this is the model of the data
class User {
  String name, image, post;

  User({this.name, this.image, this.post});

  // factory helps to extend class with easy functions
  // here [fromJson] factory method enables to convert
  // the passed json to [User] object
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        image:
            "https://hackernoon.com/images/avatars/GqcjssqRtrhIrv8IXYk1w1FHUYG3.jpg",
        post: json["email"],
      );
}

List<User> userList = [];

// Datastore sole purpose is to get and populate the data
// in [userList] so the View can consume it
// Datastore may fetch the data from Server, Local Database
// or from Shared Prefs or from all of the above
// changing the datastore shoud not affect View
class DataStore extends ChangeNotifier {

  DataStore() {
    /*User u1 = User(
        name: "John Doe",
        image: "https://hackernoon.com/images/avatars/GqcjssqRtrhIrv8IXYk1w1FHUYG3.jpg",
        post: "Android Developer");
    userList.add(u1);*/

    getData(url).then((value) {
      print("Data Got");
      var user =
          (json.decode(value) as List).map((i) => User.fromJson(i)).toList();
      print(user);
      userList.clear();
      userList.addAll(user);

      // now using change notifier we can listen to changes easily from the UI
      // [notifyListeners] allows to send an event that notifies its consumers
      // about data changes
      notifyListeners();
      print(userList);
    });
  }

  Future<String> getData(url) {
    return http.read(url);
  }
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
  // var ds = new DataStore();

  @override
  Widget build(BuildContext cn) {

    DataStore ds = DataStore();

    return ChangeNotifierProvider(
      create: (BuildContext context) => ds,
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Users Showcase"),
            ),
            body: RefreshIndicator(
              onRefresh: () async{
                ds = new DataStore();
                return;
              },
              child: Consumer<DataStore>(
                builder: (context, _, __) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.network(userList[index].image),
                            title: Text(userList[index].name),
                            subtitle: Text(userList[index].post),
                            trailing: Text(index.toString()));
                      });
                },
              ),
            )),
      ),
    );
  }


}
