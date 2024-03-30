import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/screens/pre_assessment_questions/ListenAndSpell.dart';
import 'package:momento/screens/pre_assessment_questions/dateDropDownData.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

class SelectMonths extends StatefulWidget {
  const SelectMonths({super.key});

  @override
  State<SelectMonths> createState() => _SelectMonthsState();
}


class _SelectMonthsState extends State<SelectMonths> {
  @override
  void initState() {
    super.initState();
    months = MonthDropDownData;
    months.shuffle();
  }
List months = [];
  List<String> selectedMonths = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
        child: Column(
          children: [
            Text("Select the first 3 months of the year!",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Montserrat")),
            SizedBox(
              height: 5.h,
            ),
            Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: months
                  .map((month) => FilterChip(
                        label: Text(month),
                        selected: selectedMonths.contains(month),
                        onSelected: (selected) {
                          setState(() {
                            if (selectedMonths.length < 3 ||
                                selected == false) {
                              selected
                                  ? selectedMonths.add(month)
                                  : selectedMonths.remove(month);
                            }
                          });
                        },
                        selectedColor: brown2,
                        checkmarkColor: Colors.white,
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 5.h,
            ),
            LoginButton(
                onPressed: () {
                  if (selectedMonths.length == 3) {
                    // print(selectedMonths);
                    // print(selectedMonths.contains("January") &&
                    //     selectedMonths.contains("February") &&
                    //     selectedMonths.contains("March"));
                    //     print(selectedMonths.contains("January") );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListenAndSpell(
                          data: {"months": {
                            "selectedMonths": selectedMonths,
                            "isCorrect": selectedMonths
                                .contains("January") &&
                                selectedMonths.contains("February") &&
                                selectedMonths.contains("March")
                          }},
                        ),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please select 3 months"),
                    ));
                  }
                },
                text: "Next"),
          ],
        ),
      ),
    ));
  }
}
