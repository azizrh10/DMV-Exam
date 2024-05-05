import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/signs%20lists/warning_signs_list.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class WarningSignsScreen extends StatefulWidget {
  const WarningSignsScreen({super.key});

  @override
  State<WarningSignsScreen> createState() => _WarningSignsScreenState();
}

class _WarningSignsScreenState extends State<WarningSignsScreen> {
  final WarningSignsRepository _warningSignsRepository =
      WarningSignsRepository();

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    // Access the warningList from the repository
    final warningList = _warningSignsRepository.getWarningList();
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
                  txt: 'Warning Signs',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: warningList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = warningList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          color: isLight ? Colors.transparent : blueShade,
                          width: double.infinity,
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: dmSansTxt(
                                        txt: '${item['text']}',
                                        txtSize: 16.5,
                                        txtWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(item['image'],
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
