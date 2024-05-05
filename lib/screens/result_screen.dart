import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/correct_answer_screen.dart';
import 'package:nurbs_driving_test/screens/test_level_selection_screeen.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final Function onpressed;
  final int quesLength;
  final List quesList;
  final List selectedOptionsList;
  final List optionBool;

  const ResultScreen({
    super.key,
    required this.score,
    required this.onpressed,
    required this.quesLength,
    required this.quesList,
    required this.selectedOptionsList,
    required this.optionBool,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final double percentage = (widget.score / widget.quesLength) * 100;
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(),
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
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isLight
                      ? greenShade.withOpacity(0.1)
                      : blueShade.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: MediaQuery.sizeOf(context).height / 2.6,
                width: double.infinity,
                child: Column(
                  children: [
                    dmSansTxt(
                        txt: "Results",
                        txtSize: 24,
                        txtWeight: FontWeight.w500),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dmSansTxt(
                          txt: "Total:",
                          txtSize: 20,
                        ),
                        dmSansTxt(
                          txt: widget.quesLength.toString(),
                          txtSize: 20,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dmSansTxt(
                          txt: "Correct:",
                          txtSize: 20,
                        ),
                        dmSansTxt(
                          txt: widget.score.toString(),
                          txtSize: 20,
                          clr: greenShade,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dmSansTxt(
                          txt: "False:",
                          txtSize: 20,
                        ),
                        dmSansTxt(
                          txt: "${widget.quesLength - widget.score}",
                          txtSize: 20,
                          clr: Colors.red,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                          child: Text.rich(
                        TextSpan(
                          style: GoogleFonts.dmSans(fontSize: 16),
                          children: [
                            TextSpan(
                              text: percentage > 50
                                  ? "Great! Keep up the progressive work and feel free to "
                                  : "Not bad! Keep up the progressive work and feel free to ",
                            ),
                            TextSpan(
                                text: "retake the quiz",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TestLevelSelectionScreen(),
                                        ),
                                      ),
                                style: TextStyle(
                                  color: isLight ? greenDark : blueShade,
                                  decoration: TextDecoration.underline,
                                )),
                            const TextSpan(
                                text: " to further enhance your knowledge."),
                          ],
                        ),
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: isLight
                                          ? Colors.grey.shade400
                                          : Colors.white),
                                  foregroundColor:
                                      isLight ? greenDark : Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CorrectAnswerScreen(
                                      quesList: widget.quesList,
                                      selectedOptionsList:
                                          widget.selectedOptionsList,
                                      optionBool: widget.optionBool,
                                    ),
                                  ),
                                );
                              },
                              child: dmSansTxt(txt: "Correct Answer"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      isLight ? greenDark : blueShade),
                              child: dmSansTxt(txt: "Done"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
