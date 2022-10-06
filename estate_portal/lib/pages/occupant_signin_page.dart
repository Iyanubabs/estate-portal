import 'dart:ffi';

import 'package:estate_portal/main.dart';
import 'package:estate_portal/pages/fogotpassword.dart';
import 'package:estate_portal/pages/signup_page.dart';
import 'package:estate_portal/screens/main_screen.dart';
import 'package:estate_portal/services/constants.dart';
import 'package:estate_portal/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(vertical: 70)),
        Text(
          'ESTATE PORTAL',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )
      ],
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
        ));
  }

  Widget _buildForgetPasswordButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 20),
              ),
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  ))
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Constants.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
            onPressed: signIn,

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => MainPage()));

            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Have you not registered? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onClickedSignUp,
              text: 'Sign Up',
              style: TextStyle(
                color: Constants.mainColor,
                fontSize: MediaQuery.of(context).size.height / 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 50,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  _buildUsernameRow(),
                  _buildPasswordRow(),
                  SizedBox(height: 10),
                  _buildForgetPasswordButton(),
                  SizedBox(height: 20),
                  _buildLoginButton(),
                ],
              ),
            ),
          )
        ],
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.darkBlue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
            ],
          )),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
