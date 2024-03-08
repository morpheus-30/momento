import 'package:flutter/material.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class HourOfDay extends StatefulWidget {
  String hour = "";
  @override
  State<HourOfDay> createState() => _HourOfDayState();
}

class _HourOfDayState extends State<HourOfDay> {
  
  dynamic data = {
    "answer": "",
    "iscorrect": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.w,
              child: Text(
                "What is the current hour of the day?",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            DropDownMenuMy(
              items: List.generate(24, (index) => (index + 1).toString()),
              onChanged: (value) {
                setState(() {
                  // print("hi");
                  widget.hour = value;
                  // print();
                });
              },
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 80.w,
              child: LoginButton(
                  onPressed: () {
                    // print(widget.hour);
                    data["answer"] = widget.hour;
                    if (DateTime.now().hour.toString() == widget.hour) {
                      data["iscorrect"] = true;
                    }
                    Navigator.pop(context, data);
                  },
                  text: "Next"),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownMenuMy extends StatefulWidget {
  List<String> items = [];
  Function? onChanged;
  DropDownMenuMy({required this.items, this.onChanged});

  @override
  State<DropDownMenuMy> createState() => _DropDownMenuMyState();
}

class _DropDownMenuMyState extends State<DropDownMenuMy> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: widget.items
          .map((e) => DropdownMenuEntry<dynamic>(label: e, value: e))
          .toList(),
      onSelected: (val) {
        widget.onChanged!(val);
      },
      hintText: "Select hour",
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
        side: MaterialStateProperty.all(
            BorderSide(color: Colors.black, width: 0.5)),
      ),
      width: 80.w,
    );
  }
}
