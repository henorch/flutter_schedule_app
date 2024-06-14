import 'package:flutter/material.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/src/features/presntations/model/schedulemodel.dart';
import 'package:world_times/src/features/presntations/screen/schedule/schedulecontent.dart';

class ScheduleDetail extends StatefulWidget {
  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  String _storedData = "";

  Future<void> _loadData() async {
    String? value = await LocalStorage.getFromSharedPreference('username');
    setState(() {
      _storedData = value ?? 'No data';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(username: _storedData))),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Schedule Detail"),
      ),
      body: SchedulContent(
          scheduleModel: ScheduleModel(
        category: '',
        description: '',
        owner: '',
        id: '',
        title: '',
      )),
    );
  }
}
