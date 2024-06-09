import 'package:flutter/material.dart';

class Prioriries extends StatelessWidget {
  final String? title;
  final String? rating;

  const Prioriries({super.key, this.title, this.rating});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      shadowColor: Colors.green,
      child: Container(
        height: 90.0,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style:
                  const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              child: Text(
                rating!,
                style: const TextStyle(
                    fontSize: 23.0, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
