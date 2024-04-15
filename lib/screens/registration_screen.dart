import 'package:flash_chat/constants.dart';
import 'package:flash_chat/firebase_services/firestore_services.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import '../utils/loading.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password, name;

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextInputDecoration(
                  hintText: 'Enter your email', lableText: "Email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: kTextInputDecoration(
                  hintText: 'Enter your name', lableText: "Name"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: showPassword,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextInputDecoration(
                hintText: 'Enter your password',
                lableText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on password visible state choose the icon
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print(showPassword);
                    showPassword = !showPassword;
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ButtonWidget(
              onPressed: () async {
                try {
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Loading();
                      },
                    );
                  }
                  await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  CloudService.userCollection.add(
                    UserModel.toMap(
                      UserModel(id: "", name: name, email: email),
                    ),
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e);
                }
              },
              text: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
