import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CorrectAnswerScreen extends StatefulWidget {
  final List quesList;
  final List selectedOptionsList;
  final List optionBool;
  const CorrectAnswerScreen(
      {super.key,
      required this.quesList,
      required this.selectedOptionsList,
      required this.optionBool});

  @override
  State<CorrectAnswerScreen> createState() => _CorrectAnswerScreenState();
}

class _CorrectAnswerScreenState extends State<CorrectAnswerScreen> {
  List compare = [];
  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    bool isImageLoading = false;
    List questionList = widget.quesList;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false; // Prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsTxt(
                  txt: "Answer Sheet",
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: questionList.length,
                    itemBuilder: (context, index) {
                      List<String> options =
                          List.from(questionList[index].options.keys);
                      List answers = widget.selectedOptionsList;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // add the questionWIdget here
                          SizedBox(
                            width: double.infinity,
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${index + 1}. ${questionList[index].title.toString()}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
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
                                                questionList[index].imgUrl,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                                          setState(
                                                            () {
                                                              isImageLoading =
                                                                  true;
                                                            },
                                                          );

                                                          // Load the image again.
                                                          Image.network(
                                                            questionList[index]
                                                                .imgUrl,
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
                                                filterQuality:
                                                    FilterQuality.high,
                                                fit: BoxFit.contain,
                                              );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: options.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              final option = options[i];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: dmSansTxt(
                                  txt: '${i + 1}. $option',
                                  clr: questionList[index].options[option]! ==
                                          false
                                      ? isLight
                                          ? Colors.black54
                                          : Colors.white.withOpacity(0.6)
                                      : greenShade,
                                  txtSize: 17,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Text.rich(
                            TextSpan(
                              style: GoogleFonts.dmSans(fontSize: 16),
                              children: [
                                const TextSpan(text: "Attemped:"),
                                TextSpan(
                                  text: ' ${answers[index]}',
                                  style: TextStyle(
                                    color: widget.optionBool[index] == "Right"
                                        ? greenShade
                                        : Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          const Divider(),
                        ],
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
