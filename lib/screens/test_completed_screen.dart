import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/result_screen.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class TestCompletedScreen extends StatelessWidget {
  final int result;
  final Function onPressed;
  final int questionLength;
  final List questionList;
  final List selectedOptionsList;
  final List optionBool;
  const TestCompletedScreen({
    super.key,
    required this.result,
    required this.onPressed,
    required this.questionLength,
    required this.questionList,
    required this.selectedOptionsList,
    required this.optionBool,
  });

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
            title: const Text("Back to home"),
            content: const Text("Do you really want to skip the results?"),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: isLight ? Colors.black : Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 15),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    "No",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Perform the exit action here
                    // You can call SystemNavigator.pop() to exit the app
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          score: result,
                          onpressed: onPressed,
                          quesLength: questionLength,
                          quesList: questionList,
                          selectedOptionsList: selectedOptionsList,
                          optionBool: optionBool,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }

//
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false; // Prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showExitDialog(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsTxt(
                  txt: "Short Quiz",
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                ),
                const SizedBox(height: 30),
                dmSansTxt(
                    txt: "Congratulations on completing the quiz! 🎉",
                    txtSize: 20),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(quizComplete),
                  ),
                ),
                const SizedBox(height: 10),
                dmSansTxt(txt: "Thank you for participating!", txtSize: 20),
                const SizedBox(height: 10),
                Row(
                  children: [
                    dmSansTxt(txt: "Let's ", txtSize: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              score: result,
                              onpressed: onPressed,
                              quesLength: questionLength,
                              quesList: questionList,
                              selectedOptionsList: selectedOptionsList,
                              optionBool: optionBool,
                            ),
                          ),
                        );
                      },
                      child: dmSansTxt(
                        txt: "Review our result",
                        txtSize: 20,
                        clr: isLight ? greenShade : Colors.blue,
                        clrDecor: isLight ? greenShade : Colors.blue,
                        txtDecor: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
