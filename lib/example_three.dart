import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_pp/user_model.dart';
import 'package:http/http.dart' as http;

class ExampleThreePage extends StatefulWidget {
  const ExampleThreePage({super.key});

  @override
  State<ExampleThreePage> createState() => _ExampleThreePageState();
}

class _ExampleThreePageState extends State<ExampleThreePage> {
  // List<UserModel> userList = [];
  // Future<List<UserModel>> getUserApi() async {

  //   final response =
  //       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     for (Map i in data) {
  //       userList.add(UserModel.fromJson(i));
  //     }
  //     return userList;
  //   } else {
  //     return userList;
  //   }
  // }
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List) {
          userList = data.map((i) => UserModel.fromJson(i)).toList();
          return userList;
        } else {
          print('Invalid response format');
          return userList;
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return userList;
      }
    } catch (e) {
      print('Error: $e');
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "API Integration 2",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => ExampleThreePage()));
        //       },
        //       icon: Icon(Icons.navigate_next))
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(children: [
                                ReusableCodeRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReusableCodeRow(
                                    title: 'Username',
                                    value: snapshot.data![index].username
                                        .toString()),
                                ReusableCodeRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString()),
                                ReusableCodeRow(
                                    title: 'Address',
                                    value: snapshot.data![index].address.city
                                            .toString() +
                                        snapshot.data![index].address.geo.lat
                                            .toString()),
                                ReusableCodeRow(
                                    title: 'ZipCode',
                                    value: snapshot.data![index].address.zipcode
                                        .toString())
                              ]),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableCodeRow extends StatelessWidget {
  String title, value;
  ReusableCodeRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
