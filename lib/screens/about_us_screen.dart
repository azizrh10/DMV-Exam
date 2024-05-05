import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsTxt(
                  txt: 'About Us',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white,
                ),
                const SizedBox(height: 10),
                dmSansTxt(
                    txt:
                        "Welcome to the Driving Guidance App – your trusted partner in preparing for your DMV tests.",
                    txtSize: 17),
                const SizedBox(height: 5),
                dmSansTxt(
                    txt:
                        "At Driving Guidance App, we understand the importance of obtaining your driver's license and the challenges that come with it. Whether you're a first-time driver or need to renew your license, we're here to make the preparation process easier and more effective.",
                    txtSize: 17),
                const SizedBox(height: 20),
                poppinsTxt(
                  txt: 'Our Mission',
                  txtSize: 23,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white,
                ),
                const SizedBox(height: 10),
                dmSansTxt(
                  txt:
                      "Our mission is to provide comprehensive and user-friendly DMV test preparation that empowers users to pass their exams with confidence. We're dedicated to helping you become a safe and responsible driver.",
                  txtSize: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
