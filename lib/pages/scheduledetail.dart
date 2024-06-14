import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';
import 'package:world_times/widgets/post_edit.dart';

class ScheduleDetail extends StatefulWidget {
  final String Postid;
  final String Posttitle;
  final String category;
  final String description;
  const ScheduleDetail({
    super.key,
    required this.Postid,
    required this.Posttitle,
    required this.category,
    required this.description,
  });

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
    print(widget.Postid);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2 - 50;
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
      body: Container(
        alignment: Alignment.topLeft,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  widget.Posttitle,
                  style: TextStyle(fontSize: 40.0, fontFamily: 'PoetsenOne'),
                ),
                Divider(
                  height: 20.0,
                ),
                DetailInfo(
                  title: "decription",
                  description: widget.description,
                ),
                Detail2Info(
                  title: "category",
                  sub: widget.category,
                ),
                Divider(
                  height: 20.0,
                ),
                Detail2Info(title: "ranking", sub: "5"),
                Divider(
                  height: 20.0,
                ),
                Detail2Info(title: "status", sub: "pending")
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 3,
            child:
                Consumer<PostProvider>(builder: (context, postProvider, child) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            fixedSize: WidgetStatePropertyAll(Size(width, 50)),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black)),
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostEdit(
                                    id: widget.Postid,
                                    title: widget.Posttitle,
                                    category: widget.category,
                                    description: widget.description))),
                        child: Text("Edit")),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          fixedSize: WidgetStatePropertyAll(Size(width, 50)),
                        ),
                        onPressed: () {
                          postProvider.deletePost(widget.Postid);
                        },
                        child: Text("Delete"))
                  ],
                ),
              );
            }),
          )
        ]),
      ),
    );
  }
}

class Detail2Info extends StatelessWidget {
  final title;
  final sub;

  const Detail2Info({super.key, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10.0),
            child: Text(sub,
                style: TextStyle(
                  fontSize: 20.0,
                )),
          )
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  final title;
  final description;

  const DetailInfo({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(description,
            style: TextStyle(
              fontSize: 25.0,
            ))
      ],
    );
  }
}
