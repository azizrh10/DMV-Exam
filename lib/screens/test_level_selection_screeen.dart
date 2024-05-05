import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/quiz_screen.dart';
import 'package:nurbs_driving_test/widgets/custom_btn.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class TestLevelSelectionScreen extends StatefulWidget {
  const TestLevelSelectionScreen({super.key});

  @override
  State<TestLevelSelectionScreen> createState() =>
      _TestLevelSelectionScreenState();
}

class _TestLevelSelectionScreenState extends State<TestLevelSelectionScreen> {
  List testLevel = [
    "Short Quiz (10 mcq's)",
    "Average Quiz (30 mcq's)",
    "Long Quiz (100 mcq's)",
  ];

  int selectedLevelIndex = -1;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeState.brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: customBtn(
          context: context,
          contTxt: "Let's start now!",
          txtClr: Colors.white,
          contRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          conPress: () {
            if (selectedLevelIndex < 0) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please select quiz level',
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 1200),
                margin: EdgeInsets.only(bottom: 60.0),
              ));
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QuizScreen(quizLevel: selectedLevelIndex),
                ),
              );
            }
          },
          contClr: greenDark),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              poppinsTxt(
                txt: "Select your Quiz length",
                txtSize: 25,
                txtWeight: FontWeight.w400,
              ),
              const SizedBox(height: 50),
              ListView.builder(
                shrinkWrap: true,
                itemCount: testLevel.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    height: 70,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        backgroundColor: i == selectedLevelIndex
                            ? isLight
                                ? greenDark
                                : blueShade
                            : Colors.white,
                        foregroundColor: isLight ? greenDark : Colors.white,
                        side: BorderSide(
                          color: isLight ? greenDark : blueShade,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedLevelIndex = i;
                          isPressed = true;
                        });
                      },
                      child: dmSansTxt(
                        clr: isLight
                            ? i == selectedLevelIndex
                                ? Colors.white
                                : greenDark
                            : i == selectedLevelIndex
                                ? Colors.white
                                : blueShade,
                        txt: testLevel[i],
                        txtSize: 19.5,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
