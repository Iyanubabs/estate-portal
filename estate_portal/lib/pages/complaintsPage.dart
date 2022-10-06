import 'package:estate_portal/services/constants.dart';
import 'package:flutter/material.dart';

class complaintPage extends StatefulWidget {
  complaintPage({Key? key}) : super(key: key);

  @override
  State<complaintPage> createState() => _complaintPageState();
}

class _complaintPageState extends State<complaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(backgroundColor: Constants.mainColor),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  iconSize: 25.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {},
                        decoration: InputDecoration.collapsed(
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(
                              fontSize: 30, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 30.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
