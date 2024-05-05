import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/models/db_connect.dart';
import 'package:nurbs_driving_test/models/question_model.dart';
import 'package:nurbs_driving_test/screens/test_completed_screen.dart';
import 'package:nurbs_driving_test/widgets/custom_btn.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quizLevel});
  final int quizLevel;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedOptionIndex = -1; // Initialize with -1 to indicate no selection.
  bool selectedOption = false;
  bool isOptionSelected = false;
  bool isImageLoading = true;

  var db = DBconnect();

  late Future _questions;
  bool networkError = false;
  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  List<Question> extractedData = [];

  @override
  void initState() {
    _questions = getData();

    // Shuffle the data only once when it's fetched
    _questions.then((data) {
      setState(() {
        extractedData = List.from(data);
        extractedData.shuffle();
      });
    });

    super.initState();
  }

  // create an index to loop through _questions
  int index = 0;
// create a score variable
  int score = 0;
  List questionList = [];
  List selectedOptionsList = [];
  List optionBool = [];
  // create a boolean value to check if the user has clicked
  bool isPressed = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      // this is the block where the questions end.
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TestCompletedScreen(
              result: score, // total points the user got
              questionLength: questionLength, // out of how many questions
              questionList: questionList,
              selectedOptionsList: selectedOptionsList,
              optionBool: optionBool,
              onPressed: startOver,
            ),
          ));
    } else {
      setState(() {
        index++; // when the index will change to 1. rebuild the app.
        isPressed = false;
        selectedOptionIndex = -1;
        isImageLoading = true;
      });
    }
  }

  // create a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeState.brightness == Brightness.light;

    // Function to show the exit confirmation dialog
    void showExitDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isLight ? Colors.white : Colors.black,
            title: const Text("Exit Confirmation"),
            content: const Text("Do you really want to skip the quiz?"),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  "No",
                  style: TextStyle(
                    color: isLight ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 15),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Perform the exit action here
                    // You can call SystemNavigator.pop() to exit the app
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

//

    // use the FutureBuilder Widget
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false; // Prevent the default back navigation
      },
      child: Material(
        child: FutureBuilder(
          future: _questions as Future<List<Question>>,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        errorImg,
                        fit: BoxFit.cover,
                      ),
                      dmSansTxt(txt: "No internet connection found!")
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                var limit = widget.quizLevel == 0
                    ? extractedData.sublist(0, 10)
                    : widget.quizLevel == 1
                        ? extractedData.sublist(0, 30)
                        : widget.quizLevel == 2
                            ? extractedData.sublist(0, 100)
                            : extractedData;
                questionList = limit;
                List<String> options = List.from(limit[index].options.keys);

                return Scaffold(
                  appBar: AppBar(),
                  body: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            poppinsTxt(
                              txt: "Short Quiz:",
                              txtSize: 25,
                              txtWeight: FontWeight.w500,
                            ),
                            poppinsTxt(
                              txt: "${index + 1}/${limit.length}",
                              txtSize: 22,
                              txtWeight: FontWeight.w400,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // add the questionWIdget here
                        SizedBox(
                          width: double.infinity,
                          height: 120,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "${index + 1}. ${limit[index].title.toString()}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: FutureBuilder(
                                    future: Future.delayed(
                                            const Duration(seconds: 2))
                                        .then((value) {
                                      setState(() {
                                        isImageLoading = false;
                                      });
                                    }),
                                    builder: (context, snapshot) {
                                      return isImageLoading == true
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey.shade400,
                                              highlightColor:
                                                  Colors.grey.shade200,
                                              enabled: isImageLoading,
                                              child: const Icon(
                                                Icons.image,
                                                size: 80,
                                              ),
                                            )
                                          : Image.network(
                                              limit[index].imgUrl,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.restart_alt,
                                                        size: 50,
                                                        color: isLight
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        // Reload the image.
                                                        setState(() {
                                                          isImageLoading = true;
                                                        });

                                                        // Load the image again.
                                                        Image.network(
                                                          limit[index].imgUrl,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return const Text(
                                                                "again");
                                                          },
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          fit: BoxFit.contain,
                                                        );
                                                      },
                                                    ),
                                                    const Text(
                                                      "Network Error",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                );
                                              },
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.contain,
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25.0),

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, i) {
                            final option = options[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              height: 70,
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: i == selectedOptionIndex
                                      ? isLight
                                          ? greenDark
                                          : blueShade
                                      : Colors.white,
                                  foregroundColor:
                                      isLight ? greenDark : Colors.white,
                                  side: BorderSide(
                                    color: isLight ? greenDark : blueShade,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedOption =
                                        limit[index].options[option]!;
                                    selectedOptionIndex = i;
                                    isPressed = true;
                                    selectedOptionsList.add(option);
                                  });
                                },
                                child: dmSansTxt(
                                  clr: isLight
                                      ? i == selectedOptionIndex
                                          ? Colors.white
                                          : greenDark
                                      : i == selectedOptionIndex
                                          ? Colors.white
                                          : blueShade,
                                  txt: option,
                                  txtSize: 18,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  bottomSheet: customBtn(
                      context: context,
                      contTxt: "Submit",
                      txtClr: Colors.white,
                      contRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      conPress: () {
                        if (isPressed) {
                          if (selectedOption == true) {
                            score++;
                            selectedOptionsList;
                            nextQuestion(limit.length);
                          } else {
                            selectedOptionsList;
                            nextQuestion(limit.length);
                          }
                          optionBool
                              .add(selectedOption == true ? "Right" : "Wrong");
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Please select any option',
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1200),
                            margin: EdgeInsets.only(bottom: 60.0),
                          ));
                        }
                      },
                      contClr: greenDark),
                );
              }
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: greenDark,
              ));
            }

            return const Center(
              child: Text('No Data'),
            );
          },
        ),
      ),
    );
  }
}
