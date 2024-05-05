import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/information%20lists/guide_for_vehicle_list.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class GuideForVehicleScreen extends StatefulWidget {
  const GuideForVehicleScreen({super.key});

  @override
  State<GuideForVehicleScreen> createState() => _GuideForVehicleScreenState();
}

class _GuideForVehicleScreenState extends State<GuideForVehicleScreen> {
  final GuideForVehicleRepository _guideForVehicleRepository =
      GuideForVehicleRepository();

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    // Access the warningList from the repository
    final guideForVehicleRepository =
        _guideForVehicleRepository.getGuideForVehicleList();
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
                  txt: 'Guide for vehicle',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: guideForVehicleRepository.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = guideForVehicleRepository[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dmSansTxt(
                        txt:
                            'A car is a complex machine that comprises several mechanical and electrical components. However, understanding the basic parts of an automobile is not rocket science. You can go through the car parts list below to improve your car knowledge.',
                        txtSize: 16,
                        txtWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 20),
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
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Icon(
                                      Icons.circle,
                                      size: 9,
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
