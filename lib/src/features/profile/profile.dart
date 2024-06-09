import 'package:flutter/material.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/pages/login.dart';

class Profile extends StatefulWidget {
  final username;
  const Profile({super.key, required this.username});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username = "";
  bool _mode = false;

  Future<void> _getUsername() async {
    String? value = await LocalStorage.getFromSharedPreference('username');
    setState(() {
      _username = value ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(username: _username))),
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () => {
                    print(_mode),
                    setState(() {
                      _mode = !_mode;
                      LocalStorage.saveThemePreference('mode', _mode);
                    })
                  },
              icon: Icon(_mode ? Icons.sunny : Icons.nights_stay_rounded))
        ],
        title: Text("PROFILE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: ColoredBox(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Icon(Icons.person_2),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _username,
              style: TextStyle(
                  fontFamily: 'PoetsenOne',
                  fontSize: 40.0,
                  decoration: TextDecoration.none),
            ),
            Text(
              "SOFTWARE DEVELOPER",
              style: TextStyle(fontSize: 30.0, decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 10.0,
            ),
            AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(seconds: 3),
              curve: Curves.bounceIn,
              height: 50.0,
              width: 300.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.call),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "+2347033407608",
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(seconds: 3),
              curve: Curves.bounceIn,
              height: 50.0,
              width: 300.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.mail),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "henorch01@gmail.com",
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              onPressed: null,
              style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              icon: Icon(Icons.edit),
              label: Text(
                "EDIT PROFILE",
                style: TextStyle(fontSize: 23.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: 150.0,
              color: Colors.grey,
              child: ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text("LOGOUT"),
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())),
              ),
            )
          ],
        ),
      ),
    );
  }
}
