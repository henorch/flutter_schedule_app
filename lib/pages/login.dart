import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:world_times/firebase/firebase_auth.dart';
import 'package:world_times/firebase/firebase_post.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/pages/signup.dart';
import 'package:world_times/widgets/button.dart';
import 'package:world_times/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignin = false;
  final FetchPostServices _fetchpost = FetchPostServices();
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "LOGIN",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 45.0,
                fontFamily: 'PoetsenOne'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWdget(
                    fieldController: usernameController,
                    placeholder: "enter username",
                    subject: "username",
                    isObscure: false,
                    sideIcon: const Icon(Icons.person_2_outlined),
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldWdget(
                    fieldController: passwordController,
                    placeholder: "enter password",
                    subject: "password",
                    isObscure: true,
                    sideIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(height: 10.0),
                  _isSignin
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : MyButton(
                          handlePress: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );

                              _login();
                            }
                          },
                          text: "LOGIN",
                          backgroundColor: Colors.blue,
                        ),
                ],
              )),
          const SizedBox(
            height: 20.0,
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
                          builder: (context) => const SignupScreen()))
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'PoetsenOne'),
                ),
              )
            ],
          ),
        ],
      ),
    )));
  }

  void _login() async {
    setState(() {
      _isSignin = true;
    });
    try {
      String username = usernameController.text;
      String password = passwordController.text;

      User? user = await _auth.signinWithEmailAndPassword(username, password);
      if (user != null) {
        username = await _fetchpost.fetchCurrentUser(user);
        setState(() {
          _isSignin = false;
        });
        await LocalStorage.saveToSharedPreference('userid', user.uid);
        await LocalStorage.saveToSharedPreference('username', username);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(username: username)));
      }
    } on Exception catch (e) {
      if (e.toString() == "Exception: invalid-email") {
        await _showSimpleModalDialog(context, "inavlid-email");
      } else if (e.toString() == "Exception: invalid-credential") {
        await _showSimpleModalDialog(context,
            "Either the email or password is inccorect, please check and try again");
      } else if (e.toString() == "Exception: network-request-failed") {
        await _showSimpleModalDialog(
            context, "Please check your internet connection");
      } else {
        await _showSimpleModalDialog(context, "An unexpected issue occured");
      }
      setState(() {
        _isSignin = false;
      });
    } catch (e) {
      print("no error");
    }
  }
}

_showSimpleModalDialog(context, String errormessage) {
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
                  Text("Error!",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoetsenOne',
                        fontSize: 40,
                      )),
                  Center(
                    child: Text(errormessage,
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
