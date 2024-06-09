import 'package:flutter/material.dart';

class CatDrop extends StatefulWidget {
  const CatDrop({super.key});

  @override
  State<CatDrop> createState() => _CatDropState();
}

class _CatDropState extends State<CatDrop> {
  String category = 'PERSONAL';

  var catvalue = ["PERSONAL", "BUSINESS"];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
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
    );
  }
}
