import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/pages/scheduledetail.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';

class Postlist extends StatefulWidget {
  final String useruid;
  const Postlist({super.key, required this.useruid});

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  @override
  void initState() {
    print(widget.useruid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false)
          .fetchAllPostByCurrentUser(widget.useruid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, postProvider, child) {
      if (postProvider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (postProvider.errorMessage != null) {
        return Center(
          child: Text(postProvider.errorMessage!),
        );
      } else if (postProvider.postModels.isEmpty) {
        return Center(
          child: Text("The post schedule is currently empty"),
        );
      } else {
        return ListView.builder(
            itemCount: postProvider.postModels.length,
            itemBuilder: (context, index) {
              final post = postProvider.postModels[index];
              return ListTile(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleDetail(
                                Postid: post.postId,
                                Posttitle: post.postTitle,
                                description: post.postDescription,
                                category: post.postCategory,
                              ))),
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(post.postTitle,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Text(
                            "Category: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            post.postCategory,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                      SizedBox(width: 10.0),
                      OutlinedButton.icon(
                          onPressed: () async =>
                              {await postProvider.deletePost(post.postId)},
                          label: Text("Remove"),
                          icon: Icon(Icons.remove_circle_outline)),
                      Divider(
                        height: 10.0,
                      )
                    ],
                  ));
            });
      }
    });
  }
}
