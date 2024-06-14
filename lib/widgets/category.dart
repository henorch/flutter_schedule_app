import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';
import 'package:world_times/widgets/catgory_screen.dart';

import '../src/features/presntations/model/postmodel.dart';

class Category extends StatefulWidget {
  final String name;
  final String subname;

  const Category({
    super.key,
    required this.name,
    required this.subname,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        List<PostModel> posts =
            postProvider.filterPostsByCategory('${widget.name}');
        int itemLength = posts.length;
        return Column(
          children: [
            SizedBox(
              child: InkWell(
                onTap: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(title: widget.name))),
                },
                child: Card(
                    shadowColor: Colors.grey,
                    child: Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width - 120.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${widget.name} SCHEDULE',
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'PoetsenOne',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.subname,
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            ClipRRect(
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircleAvatar(
                                  child: Text(
                                    itemLength.toString(),
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ])),
              ),
            ),
          ],
        );
      },
    );
  }
}
