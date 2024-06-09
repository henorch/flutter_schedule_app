import 'package:flutter/material.dart';
import 'package:world_times/src/features/presntations/model/schedulemodel.dart';

class SchedulContent extends StatelessWidget {
  final ScheduleModel scheduleModel;

  const SchedulContent({
    super.key,
    required this.scheduleModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              DetailInfo(title: "title", description: scheduleModel.postTitle),
              Divider(
                height: 20.0,
              ),
              Detail2Info(
                title: "category",
                sub: scheduleModel.category,
              ),
              Divider(
                height: 20.0,
              ),
              Detail2Info(title: "ranking", sub: "5"),
              Divider(
                height: 20.0,
              ),
              DetailInfo(
                title: "decription",
                description: scheduleModel.description,
              ),
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
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50)),
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        foregroundColor: WidgetStatePropertyAll(Colors.black)),
                    onPressed: null,
                    child: Text("Edit")),
                SizedBox(
                  width: 30.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      fixedSize: WidgetStatePropertyAll(Size(200, 50)),
                    ),
                    onPressed: () {},
                    child: Text("Delete"))
              ],
            ),
          ),
        )
      ]),
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
                fontFamily: 'PoetsenOne'),
          ),
          SizedBox(height: 10.0),
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(10.0),
            child: Text(sub,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'PoetsenOne',
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
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PoetsenOne'),
        ),
        SizedBox(height: 10.0),
        Text(description,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'PoetsenOne',
            ))
      ],
    );
  }
}
