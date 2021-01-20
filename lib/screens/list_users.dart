import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:test_godunoff/screens/user_page.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String urlUsers = 'https://jsonplaceholder.typicode.com/users';

  @override
  void initState() {
    _getData(urlUsers);
    super.initState();
  }

  List _users = [];

  Future _getData(String url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      _users = await jsonDecode(data);
    } else {
      print(response.statusCode);
    }

    return _users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getData(urlUsers),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, int index) {
                  // getData();
                  return Card(
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        _users[index]['username'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        _users[index]['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: InkWell(
                        child: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPage(
                                userName: _users[index]['username'],
                                name: _users[index]['name'],
                                email: _users[index]['email'],
                                phone: _users[index]['phone'],
                                website: _users[index]['website'],
                                companyName: _users[index]['company']['name'],
                                companyBs: _users[index]['company']['bs'],
                                companyCatchPhrase: _users[index]['company']
                                    ['catchPhrase'],
                                street: _users[index]['address']['street'],
                                suite: _users[index]['address']['suite'],
                                city: _users[index]['address']['city'],
                                zipcode: _users[index]['address']['zipcode'],
                                userId: _users[index]['id'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
