import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/pages/scheduledetail.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';
import 'package:world_times/widgets/post_edit.dart';

import '../pages/homepage.dart';
import '../src/features/presntations/model/postmodel.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  const CategoryScreen({super.key, required this.title});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(username: ""))),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "${widget.title} SCHEDULE",
          style: TextStyle(fontFamily: 'PoetsenOne'),
        ),
      ),
      body: ListCateg(category: widget.title),
    );
  }
}

class ListCateg extends StatelessWidget {
  final String category;

  const ListCateg({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        if (postProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (postProvider.errorMessage != null) {
          return Center(child: Text("Error: ${postProvider.errorMessage}"));
        } else {
          List<PostModel> posts = postProvider.filterPostsByCategory(category);

          if (posts.isEmpty) {
            return Center(child: Text("No posts available in this category."));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              PostModel post = posts[index];
              return GestureDetector(
                onDoubleTap: () => {
                  _showDetailsDialog(context, post.id, post.category,
                      post.title, post.description)
                },
                child: ListTile(
                  title: Text(
                    post.title,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    post.description,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleDetail(
                              Postid: post.id,
                              owner: post.owner,
                              Posttitle: post.title,
                              category: post.category,
                              description: post.description))),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showDetailsDialog(BuildContext context, String id, String category,
      String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<PostProvider>(builder: (context, postProvider, child) {
          return Dialog(
            insetAnimationDuration: Duration(seconds: 2),
            insetAnimationCurve: Curves.bounceIn,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostEdit(
                                  id: id,
                                  description: description,
                                  category: category,
                                  title: title,
                                  owner: '',
                                ))),
                  },
                  label: Text(
                    "Edit",
                    style: TextStyle(fontSize: 30, fontFamily: 'PoetsenOne'),
                  ),
                  icon: Icon(
                    Icons.edit_note,
                    size: 50,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => {
                    Navigator.pop(context),
                    postProvider.deletePost(id),
                  },
                  label: Text(
                    "Delete",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontFamily: 'PoetsenOne'),
                  ),
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    size: 50,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
