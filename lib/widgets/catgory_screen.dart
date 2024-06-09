import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/pages/scheduledetail.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';

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
                  print("You double tap me"),
                  _showDetailsDialog(context, "Great", "Super natural")
                },
                child: ListTile(
                  title: Text(
                    post.postTitle,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    post.postDescription,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleDetail(
                              Postid: post.postId,
                              Posttitle: post.postTitle,
                              category: post.postCategory,
                              description: post.postDescription))),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showDetailsDialog(BuildContext context, String title, String subtitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
