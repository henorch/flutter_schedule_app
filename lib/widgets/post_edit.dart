import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/src/features/presntations/model/postmodel.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';
import 'package:world_times/widgets/catgory_screen.dart';
import 'package:world_times/widgets/textfield.dart';

class PostEdit extends StatefulWidget {
  final String title;
  final String category;
  final String id;
  final String description;
  const PostEdit(
      {super.key,
      required this.id,
      required this.title,
      required this.category,
      required this.description});

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CategoryScreen(title: widget.category))),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: EditContent(
        id: widget.id,
        category: widget.category,
        description: widget.description,
        title: widget.title,
      ),
    );
  }
}

class EditContent extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String category;
  const EditContent(
      {super.key,
      required this.id,
      required this.category,
      required this.description,
      required this.title});

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  String category = "PERSONAL";
  var catvalue = ["PERSONAL", "BUSINESS"];
  String rating = "1";
  var Status = ["1", "2", "3", "4", "5"];
  TextEditingController _titlecontoller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text(
                  "Title:",
                  style: TextStyle(fontFamily: 'PoetsenOne', fontSize: 30.0),
                ),
              ),
              TextFieldWdget(
                fieldController: _titlecontoller,
                placeholder: widget.title,
                isObscure: false,
                sideIcon: const Icon(Icons.title),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 10, 0),
                child: Text(
                  "description:",
                  style: TextStyle(fontFamily: 'PoetsenOne', fontSize: 30.0),
                ),
              ),
              TextFormField(
                controller: _descriptioncontroller,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: '${widget.description}',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'category:',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoetsenOne'),
                      ),
                    ),
                    DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: catvalue.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'urgency ranking:',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoetsenOne'),
                      ),
                    ),
                    DropdownButton(
                      value: rating,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: Status.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? urgency) {
                        setState(() {
                          rating = urgency!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: OutlinedButton(
                      onPressed: () => {
                            print({
                              _titlecontoller.text,
                              _descriptioncontroller.text,
                              category,
                              rating
                            }),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(username: ""))),
                            postProvider.updatePost(
                                widget.id,
                                PostModel(
                                  id: widget.id,
                                  category: category,
                                  description: _descriptioncontroller.text,
                                  title: _titlecontoller.text,
                                )),
                          },
                      style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.black),
                          fixedSize: WidgetStatePropertyAll(Size(200.0, 50))),
                      child: Text(
                        "Update",
                        style:
                            TextStyle(fontFamily: 'PoetsenOne', fontSize: 20.0),
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
