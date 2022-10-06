import 'dart:io';

import 'package:estate_portal/pages/complaintsPage.dart';
import 'package:estate_portal/pages/signup_page.dart';
import 'package:estate_portal/screens/main_screen.dart';
import 'package:estate_portal/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class ButtonsInfo {
  String title;
  IconData icon;
  Function onTap;

  ButtonsInfo({required this.title, required this.icon, required this.onTap});
}

int _currentIndex = 0;

List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(
      title: 'Dashboard',
      icon: Icons.home,
      onTap: () => {
            // (BuildContext context) => SignUpPage(),
            // Navigator.push(
            //               context, MaterialPageRoute(builder: (context) => MainPage()));
          }),
  ButtonsInfo(title: 'Notifications', icon: Icons.notifications, onTap: () {}),
  ButtonsInfo(title: 'Payment', icon: Icons.sell, onTap: () {}),
  ButtonsInfo(
      title: 'Complaints',
      icon: Icons.mark_email_read,
      onTap: () {
        (BuildContext context) => complaintPage();
      }),
  ButtonsInfo(title: 'Security', icon: Icons.verified_user, onTap: () {}),
  ButtonsInfo(
      title: 'Neighbours',
      icon: Icons.supervised_user_circle_rounded,
      onTap: () {}),
  ButtonsInfo(title: 'Settings', icon: Icons.settings, onTap: () {}),
  ButtonsInfo(
      title: 'Change password', icon: Icons.password_outlined, onTap: () {}),
  ButtonsInfo(
      title: 'Logout', icon: Icons.arrow_back_ios_new_sharp, onTap: () {}),
];

class _DrawerPageState extends State<DrawerPage> {
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
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Constants.blueLight,
        child: ListView(
          children: <Widget>[
            // title: Padding(

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 37.0,
                    backgroundColor: Color.fromARGB(255, 4, 76, 134),
                    child: image != null
                        ? Image.file(
                            image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.white,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Occupant name',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Dashbaord',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Notification',
                    icon: Icons.notifications,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Complaint',
                    icon: Icons.mark_email_read,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Payment',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Security',
                    icon: Icons.verified_user,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Neighbours',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 7),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Change password',
                    icon: Icons.password_outlined,
                    onClicked: () => selectedItem(context, 8),
                  ),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.arrow_back_ios_new_sharp,
                    onClicked: () => FirebaseAuth.instance.signOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(text, style: TextStyle(color: color)),
          hoverColor: hoverColor,
          onTap: onClicked,
        ),
        Divider(
          color: Colors.white,
          thickness: 0.2,
        )
      ],
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => complaintPage(),
        ));
    }
  }
}
