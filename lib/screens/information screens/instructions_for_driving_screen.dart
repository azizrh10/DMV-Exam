import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/information%20lists/instruction_for_drving_list.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class InstructionsForDrivingScreen extends StatefulWidget {
  const InstructionsForDrivingScreen({super.key});

  @override
  State<InstructionsForDrivingScreen> createState() =>
      _InstructionsForDrivingScreenState();
}

class _InstructionsForDrivingScreenState
    extends State<InstructionsForDrivingScreen> {
  final InstructionForDrivingRepository _instructionForDrivingRepository =
      InstructionForDrivingRepository();

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    // Access the warningList from the repository
    final instructionForDrvingList =
        _instructionForDrivingRepository.getInstructionForDrivingList();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: poppinsTxt(
                  txt: 'Instructions for driving',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: instructionForDrvingList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = instructionForDrvingList[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dmSansTxt(
                          txt: '${index + 1}. ${item['title']}',
                          txtSize: 20,
                          txtWeight: FontWeight.w500),
                      const SizedBox(height: 20),
                      // Display subpoints as a sub-list
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: item['subpoints'].length,
                          shrinkWrap: true,
                          itemBuilder: (context, subIndex) {
                            final subpoint = item['subpoints'][subIndex];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Icon(
                                      Icons.circle,
                                      size: 7,
                                      color: isLight ? greenDark : blueShade,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Expanded(
                                    child: dmSansTxt(
                                      txt: subpoint,
                                      txtSize: 16,
                                      txtWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
