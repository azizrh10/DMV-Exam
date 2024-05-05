import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/information%20lists/wriiten_test_guide_list.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class WrittenTestGuideScreen extends StatefulWidget {
  const WrittenTestGuideScreen({super.key});

  @override
  State<WrittenTestGuideScreen> createState() => _WrittenTestGuideScreenState();
}

class _WrittenTestGuideScreenState extends State<WrittenTestGuideScreen> {
  final WrittenTestGuideRepository _writtenTestGuideRepository =
      WrittenTestGuideRepository();

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    // Access the warningList from the repository
    final writtenTestGuide =
        _writtenTestGuideRepository.getWrittenTestGuideList();
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
                  txt: 'Written test guide',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: writtenTestGuide.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = writtenTestGuide[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.circle,
                              size: 9,
                              color: isLight ? greenDark : blueShade,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: dmSansTxt(
                                txt: '${item['title']}',
                                txtSize: 20,
                                txtWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      dmSansTxt(
                          txt: '${item['text']}',
                          txtSize: 16,
                          txtWeight: FontWeight.w400),
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
