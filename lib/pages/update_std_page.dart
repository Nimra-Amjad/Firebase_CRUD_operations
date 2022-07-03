// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;

  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formkey = GlobalKey<FormState>();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> updateuser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print('User Updated'))
        .catchError((error) => print('failed to update user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Form(
          key: _formkey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                            labelText: 'Name:',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        autofocus: false,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                            labelText: 'Email:',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          } else if (!value.contains('@')) {
                            return 'Please enter valid value';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: password,
                        autofocus: false,
                        onChanged: (value) => password = value,
                        decoration: InputDecoration(
                            labelText: 'Password:',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                updateuser(widget.id, name, email, password);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            )),
                        ElevatedButton(
                          onPressed: () => {},
                          child: Text(
                            'Reset',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          )),
    );
  }
}
