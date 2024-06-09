import 'package:flutter/material.dart';
import 'package:world_times/firebase/firebase_storage.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/widgets/button.dart';
import 'package:world_times/widgets/textfield.dart';

class BottomSheetModal extends StatefulWidget {
  final FocusNode focusNode;

  BottomSheetModal({super.key, required this.focusNode});

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  final FirebaseStorageServices _firestore = FirebaseStorageServices();
  final TextEditingController _titlecontoller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  String rating = "1";
  var Status = ["1", "2", "3", "4", "5"];
  String category = "PERSONAL";
  var catvalue = ["PERSONAL", "BUSINESS"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height / 2 + 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create a new Schedule',
                style: TextStyle(
                  fontFamily: 'PoetsenOne',
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          Column(children: [
            TextFieldWdget(
              fieldController: _titlecontoller,
              placeholder: "schedule title",
              subject: "title",
              isObscure: false,
              sideIcon: const Icon(Icons.title),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
              child: TextFormField(
                controller: _descriptioncontroller,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'description',
                  labelText: "description",
                  labelStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoetsenOne'),
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
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
            const SizedBox(
              height: 10.0,
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
            const SizedBox(
              height: 20.0,
            ),
            MyButton(
                handlePress: () async {
                  String? userid =
                      await LocalStorage.getFromSharedPreference('userid');
                  await _firestore.addSchedule(userid, _titlecontoller.text,
                      category, _descriptioncontroller.text, rating);

                  print({
                    userid,
                    _titlecontoller.text,
                    category,
                    _descriptioncontroller.text,
                    2
                  });
                  Navigator.pop(context);
                },
                text: "Create Schedule",
                backgroundColor: Colors.blue)
          ])
        ],
      ),
    );
  }
}
