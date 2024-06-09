import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:world_times/firebase/firebase_auth.dart';
import 'package:world_times/firebase/firebase_storage.dart';
import 'package:world_times/pages/Login.dart';
// import 'package:world_times/pages/login.dart';
import 'package:world_times/widgets/button.dart';
import 'package:world_times/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isSignUp = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseStorageServices firestoreserv = FirebaseStorageServices();

  // final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "REGISTER",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 45.0,
                    fontFamily: 'PoetsenOne'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFieldWdget(
                placeholder: "enter username",
                subject: "username",
                isObscure: false,
                sideIcon: const Icon(Icons.person_2_outlined),
                fieldController: usernameController,
              ),
              TextFieldWdget(
                placeholder: "enter email",
                subject: "email",
                isObscure: false,
                sideIcon: const Icon(Icons.email),
                fieldController: nameController,
              ),
              const SizedBox(height: 10.0),
              TextFieldWdget(
                placeholder: "enter password",
                subject: "password",
                sideIcon: const Icon(Icons.lock),
                fieldController: passwordController,
                isObscure: false,
              ),
              const SizedBox(height: 15.0),
              _isSignUp
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : MyButton(
                      text: "SIGN UP",
                      backgroundColor: Colors.blue,
                      handlePress: () {
                        _signUp();
                      },
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already register click to",
                    style: TextStyle(
                        fontSize: 23.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'PoetsenOne'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()))
                    },
                    child: const Text(
                      'LOGIN HERE',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                          fontFamily: 'PoetsenOne'),
                    ),
                  )
                ],
              ),
            ]),
      ),
    ));
  }

  void _signUp() async {
    // String username = usernameController.text;

    setState(() {
      _isSignUp = true;
    });

    String username = usernameController.text;
    String email = nameController.text;
    String password = passwordController.text;

    try {
      User? user = await _auth.signupWithEmailAndPassword(email, password);

      setState(() {
        _isSignUp = false;
      });
      if (user != null) {
        firestoreserv.registerUser(user.uid, username, email);
        _showSimpleModalDialog(
            context, "Congratulation", "You have successfully register");
      }
    } catch (e) {
      await _showSimpleModalDialog(context, "error!", e.toString());
    }
    setState(() {
      _isSignUp = false;
    });
  }
}

_showSimpleModalDialog(context, String header, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(header,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoetsenOne',
                        fontSize: 40,
                      )),
                  Center(
                    child: Text(message,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            wordSpacing: 1)),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
