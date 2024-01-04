import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momento/constants.dart';
import 'package:momento/widgets/buttons/loginButton.dart';
import 'package:sizer/sizer.dart';

List colorMap = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
];
List originalColors = [
  Color.fromARGB(255, 1, 53, 96),
  Color.fromARGB(255, 103, 7, 0),
  Color.fromARGB(255, 0, 83, 3),
  Color.fromARGB(255, 142, 128, 0),
];

class PatternMatchGameScreen extends StatefulWidget {
  String level;
  PatternMatchGameScreen({required this.level});

  @override
  State<PatternMatchGameScreen> createState() => _PatternMatchGameScreenState();
}

class _PatternMatchGameScreenState extends State<PatternMatchGameScreen> {
  bool flag = true;
  bool hasStartBeenPressed = false;
  String startButtonText = "Start";
  bool currentlyRunning = false;
  String nextButtonText = "Next";
  Color container1Color = originalColors[0];
  Color container2Color = originalColors[1];
  Color container3Color = originalColors[2];
  Color container4Color = originalColors[3];
  List<int> currentPattern = [];
  List<int> userInputPattern = [];

  int score = 0;
  void showPattern(List<int> pattern) {
    int i = 0;
    int showDelay = widget.level == "Hard" ? 800 : 1500;
    Timer.periodic(Duration(milliseconds: showDelay), (timer) {
      setState(() {
        // print("i: $i");
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            container1Color = originalColors[0];
            container2Color = originalColors[1];
            container3Color = originalColors[2];
            container4Color = originalColors[3];
          });
        });
        if (pattern[i] == 1) {
          container1Color = colorMap[0];
          i++;
        } else if (pattern[i] == 2) {
          container2Color = colorMap[1];
          i++;
        } else if (pattern[i] == 3) {
          container3Color = colorMap[2];
          i++;
        } else if (pattern[i] == 4) {
          container4Color = colorMap[3];
          i++;
        }
      });
      if (i == pattern.length) {
        Future.delayed(Duration(milliseconds: 1000), () {
          resetColors();
        });
        setState(() {
          currentlyRunning = false;
        });
        timer.cancel();
      }
    });
  }

  void openInputWindow() {
    setState(() {
      flag = false;
    });
  }

  void closeInputWindow() {
    setState(() {
      flag = true;
    });
  }

  void incrementScore() {
    setState(() {
      score += 100;
    });
    print("User input pattern: $userInputPattern");
    print("Current pattern: $currentPattern");
  }

  void decrementScore() {
    print("User input pattern: $userInputPattern");
    print("Current pattern: $currentPattern");
  }

  bool compareInputWithPattern(List<int> patternToBeMatched) {
    if (userInputPattern.length != patternToBeMatched.length) {
      return false;
    }
    for (int i = 0; i < patternToBeMatched.length; i++) {
      if (userInputPattern[i] != patternToBeMatched[i]) {
        return false;
      }
    }
    return true;
  }

  void resetColors() {
    setState(() {
      container1Color = originalColors[0];
      container2Color = originalColors[1];
      container3Color = originalColors[2];
      container4Color = originalColors[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dynamic alert = AlertDialog(
          title: Text("Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                dynamic alert2 = AlertDialog(
                  title: const Text(
                    "Score",
                    textAlign: TextAlign.center,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    color: Colors.black,
                  ),
                  contentTextStyle: TextStyle(
                    fontSize: 70.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                  content: SizedBox(
                    height: 30.h,
                    child: Column(
                      children: [
                        Text(
                          score.toString(),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 40.sp,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 40.sp,
                              color: Colors.yellow,
                            ),
                            Icon(
                              Icons.star,
                              size: 40.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 5.h,
                          width: 80.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  setState(() {
                                    score = 0;
                                    hasStartBeenPressed = false;
                                    currentlyRunning = false;
                                    nextButtonText = "Next";
                                    flag = true;
                                  });
                                  Navigator.pop(context);
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.loop,
                                  size: 40.sp,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              IconButton(
                                alignment: Alignment.center,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/home'));
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  size: 40.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert2;
                  },
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                )),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Help');
              },
              icon: Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
            ),
          ],
          elevation: 0,
          leadingWidth: 30.w,
          centerTitle: true,
          title: Text(
            "Pattern Matching",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: brown2,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  dynamic alert = AlertDialog(
                    title: Text("Are you sure you want to exit?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          dynamic alert2 = AlertDialog(
                            title: const Text(
                              "Score",
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.black,
                            ),
                            contentTextStyle: TextStyle(
                              fontSize: 70.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                            ),
                            content: SizedBox(
                              height: 30.h,
                              child: Column(
                                children: [
                                  Text(
                                    score.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 40.sp,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40.sp,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 40.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                    width: 80.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            setState(() {
                                              score = 0;
                                              hasStartBeenPressed = false;
                                              currentlyRunning = false;
                                              nextButtonText = "Next";
                                              flag = true;
                                            });
                                            Navigator.pop(context);
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.loop,
                                            size: 40.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        IconButton(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Navigator.popUntil(context,
                                                ModalRoute.withName('/home'));
                                          },
                                          icon: Icon(
                                            Icons.exit_to_app,
                                            size: 40.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert2;
                            },
                          );
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.level=="Easy"?Colors.green:widget.level=="Medium"?Colors.yellow:Colors.red,
                ),
                child: Center(
                  child: Text(
                    widget.level,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: brown2,
                ),
                child: Center(
                  child: Text(
                    "Score",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: brown2,
                ),
                child: Center(
                  child: Text(
                    score.toString(),
                    style: TextStyle(
                      fontSize: 80.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
              GridView(
                padding: EdgeInsets.all(10.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: container1Color,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: flag == false
                          ? () {
                              print(1);
                              setState(() {
                                container1Color = colorMap[0];
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setState(() {
                                    container1Color = originalColors[0];
                                  });
                                });
                                userInputPattern.add(1);
                              });
                            }
                          : null,
                      child: Text(""),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: container2Color,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: flag == false
                          ? () {
                              print(2);
                              setState(() {
                                container2Color = colorMap[1];
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setState(() {
                                    container2Color = originalColors[1];
                                  });
                                });
                                userInputPattern.add(2);
                              });
                            }
                          : null,
                      child: Text(""),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: container3Color,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: flag == false
                          ? () {
                              print(3);
                              setState(() {
                                container3Color = colorMap[2];
                                Future.delayed(Duration(milliseconds: 100), () {
                                  setState(() {
                                    container3Color = originalColors[2];
                                  });
                                });
                                userInputPattern.add(3);
                              });
                            }
                          : null,
                      child: Text(""),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: container4Color,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: flag == false
                          ? () {
                              print(4);
                              setState(() {
                                container4Color = colorMap[3];
                                Future.delayed(Duration(milliseconds: 100), () {
                                  setState(() {
                                    container4Color = originalColors[3];
                                  });
                                });
                                userInputPattern.add(4);
                              });
                            }
                          : null,
                      child: Text(""),
                    ),
                  ),
                ],
              ),
              hasStartBeenPressed
                  ? SizedBox(
                      height: 1.h,
                    )
                  : SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: currentlyRunning
                            ? () {
                                print("Pattern is running");
                              }
                            : () {
                                setState(() {
                                  hasStartBeenPressed = true;
                                  currentlyRunning = true;
                                  nextButtonText = "Submit";
                                });
                                if (widget.level == 'Easy') {
                                  currentPattern = [1, 2, 3, 4]..shuffle();
                                } else if (widget.level == 'Medium') {
                                  currentPattern = [
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1
                                  ];
                                } else if (widget.level == 'Hard') {
                                  currentPattern = [
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                    Random().nextInt(4) + 1,
                                  ];
                                }
                                showPattern(currentPattern);
                                // List<int> patternToBeMatched = currentPattern;
                                openInputWindow();
                                Future.delayed(Duration(milliseconds: 5000),
                                    () {
                                  setState(() {});
                                });
                              },
                        text: startButtonText,
                      )),
              hasStartBeenPressed
                  ? SizedBox(
                      width: 80.w,
                      child: LoginButton(
                        onPressed: hasStartBeenPressed
                            ? currentlyRunning
                                ? () {
                                    print("Pattern is running");
                                  }
                                : () {
                                    closeInputWindow();
                                    bool ans =
                                        compareInputWithPattern(currentPattern);
                                    if (ans) {
                                      incrementScore();
                                    } else {
                                      decrementScore();
                                    }
                                    currentPattern = [];
                                    userInputPattern = [];
                                    setState(() {
                                      currentlyRunning = false;
                                      nextButtonText = "Next";
                                      hasStartBeenPressed = false;
                                    });
                                  }
                            : () {
                                print("First click start");
                              },
                        text: nextButtonText,
                      ))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}