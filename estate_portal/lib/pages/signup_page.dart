import 'package:email_validator/email_validator.dart';
import 'package:estate_portal/main.dart';

import 'package:estate_portal/services/constants.dart';
import 'package:estate_portal/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final roomNoController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget _buildNameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: nameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.verified_user,
              color: Constants.mainColor,
            ),
            labelText: 'Full name'),
      ),
    );
  }

  Widget _buildoccupantIdRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: idController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.verified_user,
              color: Constants.mainColor,
            ),
            labelText: 'occupant ID'),
      ),
    );
  }

  Widget _buildroomNoRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: roomNoController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.verified_user,
              color: Constants.mainColor,
            ),
            labelText: 'Room No'),
      ),
    );
  }

  Widget _buildUsernameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.verified_user,
              color: Constants.mainColor,
            ),
            labelText: 'Username/Email'),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? "Enter a valid email"
            : null,
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Constants.mainColor,
              ),
              labelText: 'Password'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value != null && value.length < 8
              ? "Enter min. of 8 characters"
              : null,
        ));
  }

  Widget _buildSignUpButton() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 10),
            // margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Constants.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              onPressed: signUp,

              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MainPage()));

              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignIn,
                text: 'Sign In',
                style: TextStyle(
                  color: Constants.mainColor,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return SafeArea(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
              key: formKey,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  _buildNameRow(),
                  _buildoccupantIdRow(),
                  _buildroomNoRow(),
                  _buildUsernameRow(),
                  _buildPasswordRow(),
                  _buildSignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Constants.darkBlue,
        body: _buildContainer(),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
