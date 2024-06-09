import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownItem = '1';

  var Status = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownItem,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: Status.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownItem = newValue!;
        });
      },
    );
  }
}
