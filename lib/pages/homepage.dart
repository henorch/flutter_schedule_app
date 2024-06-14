import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/login.dart';
import 'package:world_times/widgets/category.dart';

import '../src/features/presntations/screen/postscreen/postlist.dart';
import '../widgets/bottommodal.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNode = FocusNode();

  String _uid = "";

  @override
  void initState() {
    _uidData();
    super.initState();
  }

  Future<void> _uidData() async {
    String? value = await LocalStorage.getFromSharedPreference('userid');
    setState(() {
      _uid = value ?? "No id yet";
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomSheetModal(focusNode: _focusNode),
        );
      },
    ).whenComplete(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Schedule",
            style: TextStyle(fontFamily: 'PoetsenOne'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  iconSize: 20.0,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await LocalStorage.removeFromSharePreference('userid');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  icon: const Icon(Icons.logout_rounded)),
            )
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "CATEGORIES",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 170.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                const Category(
                    name: "PERSONAL",
                    subname:
                        "Start by planning your personal life, and making value out of it"),
                const Category(
                    name: "BUSINESS",
                    subname:
                        "Business success relies on effective planning, start planning ")
              ],
            ),
          ),
          const SizedBox(
            height: 1.0,
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: const Text(
              "TODAY'S PRIOTITIES",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Postlist(useruid: _uid),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          onPressed: _showBottomSheet,
          child: const Icon(Icons.edit),
        ));
  }
}
