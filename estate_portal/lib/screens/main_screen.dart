import 'dart:io';

import 'package:estate_portal/main.dart';
import 'package:estate_portal/pages/drawer_page.dart';
import 'package:estate_portal/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser!;

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              color: Colors.blue,
              playSound: true,
            )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new message was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog();
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
          title: Center(
            child: Text(
              'Occupants Dashboard',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ]),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Icon(
                    Icons.home,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    color: Constants.blueLight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.email!,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 500,
                margin: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 30),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Constants.redDark,
                                child: CircleAvatar(
                                  radius: 45,
                                  child: ClipOval(
                                    child: image != null
                                        ? Image.file(
                                            image!,
                                            width: 160,
                                            height: 160,
                                            fit: BoxFit.cover,
                                          )
                                        : CircleAvatar(
                                            radius: 45,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 80,
                              child: RawMaterialButton(
                                elevation: 10,
                                fillColor: Colors.white,
                                child: Icon(Icons.add_a_photo),
                                padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Choose option',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(children: [
                                              InkWell(
                                                onTap: () => pickImage(
                                                    ImageSource.camera),
                                                splashColor:
                                                    Constants.blueLight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.camera,
                                                      color: Colors.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'camera',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => pickImage(
                                                    ImageSource.gallery),
                                                splashColor:
                                                    Constants.blueLight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.image,
                                                      color: Colors.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'gallery',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor:
                                                    Constants.blueLight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'remove',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              )
                                            ]),
                                          ),
                                        );
                                      });
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: () {},
                                child: Text(
                                  'PROFILE',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              '190022',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text(
                              'Gbolahan Ojo',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey,
                      thickness: 0.9,
                    ),
                    Expanded(
                      child: ListView(children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(fontSize: 15),
                            )),
                            DataColumn(
                                label: Text('Gbolahan Ojo',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                'ID number',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )),
                              DataCell(Text('190022',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Street',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(Text('Lane 2',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Phone number',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(Text('+2349087654210',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Entry year',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(Text('2019',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                            ]),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      drawer: DrawerPage(),
    );
  }
}
