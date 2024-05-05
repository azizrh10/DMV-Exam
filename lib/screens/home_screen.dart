import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/screens/about_us_screen.dart';
import 'package:nurbs_driving_test/screens/information%20screens/guide_for_vehicle_screen.dart';
import 'package:nurbs_driving_test/screens/information%20screens/instructions_for_driving_screen.dart';
import 'package:nurbs_driving_test/screens/information%20screens/public_road_information_screen.dart';
import 'package:nurbs_driving_test/screens/information%20screens/written_test_guide_screen.dart';
import 'package:nurbs_driving_test/screens/signs%20screens/informatory_signs_screen.dart';
import 'package:nurbs_driving_test/screens/signs%20screens/prohibitory_signs_screen.dart';
import 'package:nurbs_driving_test/screens/signs%20screens/rate_app.dart';
import 'package:nurbs_driving_test/screens/signs%20screens/road_signs_screen.dart';
import 'package:nurbs_driving_test/screens/signs%20screens/warning_signs_screen.dart';
import 'package:nurbs_driving_test/screens/test_level_selection_screeen.dart';
import 'package:nurbs_driving_test/widgets/custom_btn.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changeTheme() {
    final settings = Provider.of<ThemeSetting>(context, listen: false);
    settings.changeTheme();
  }

  List gridList = [];

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;

    // Function to show the exit confirmation dialog
    void showExitDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isLight ? Colors.white : Colors.black,
            title: const Text("Exit Confirmation"),
            content: const Text("Do you really want to exit the app?"),
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
                    "Exit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Perform the exit action here
                    // You can call SystemNavigator.pop() to exit the app
                    Navigator.of(context).pop(); // Close the dialog
                    SystemNavigator.pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    // Share app link
    Future<void> shareAppLink() async {
      // Get the app's package name.
      final String packageName =
          await PackageInfo.fromPlatform().then((info) => info.packageName);

      // Create the Play Store link.
      String playStoreLink =
          'https://play.google.com/store/apps/details?id=$packageName';

      // Share the Play Store link.
      await Share.share(
        'Download our app from the Google Play Store: $playStoreLink',
      );
    }

    final AppRating appRating = AppRating();
//
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false; // Prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isLight ? greenDark : blueShade,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: changeTheme,
              icon: Icon(isLight ? Icons.dark_mode : Icons.light_mode),
            ),
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsTxt(
                    txt: "Menu",
                    txtSize: 30,
                    clr: isLight ? greenDark : Colors.grey.shade200),
                Divider(color: isLight ? greenDark : Colors.white),
                const SizedBox(height: 40),
                drawerBtn(
                    contTxt: "Change theme",
                    conPress: changeTheme,
                    context: context,
                    conIcon: isLight
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                const SizedBox(height: 12),
                drawerBtn(
                    contTxt: "Share our app",
                    conPress: () async {
                      // Share the app's link.
                      Navigator.pop(context);
                      await shareAppLink();
                    },
                    context: context,
                    conIcon: Icons.share_outlined),
                const SizedBox(height: 12),
                drawerBtn(
                    contTxt: "Rate our app",
                    conPress: () {
                      appRating.rateApp(context);
                    },
                    context: context,
                    conIcon: Icons.star_border),
                const SizedBox(height: 12),
                drawerBtn(
                    contTxt: "About us",
                    conPress: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUs(),
                        ),
                      );
                    },
                    context: context,
                    conIcon: Icons.info_outline),
                const SizedBox(height: 12),
                drawerBtn(
                    contTxt: "Exit",
                    conPress: () {
                      Navigator.pop(context);
                      showExitDialog(context);
                    },
                    context: context,
                    conIcon: Icons.exit_to_app_outlined),
              ],
            ),
          ),
        ),
        bottomSheet: customBtn(
            context: context,
            contTxt: "Short Quiz",
            txtClr: Colors.white,
            contRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            conPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TestLevelSelectionScreen(),
                ),
              );
            },
            contClr: greenDark),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FittedBox(
                          child: dmSansTxt(txt: "Welcome to ", txtSize: 19)),
                      FittedBox(
                        child: dmSansTxt(
                            txt: "DMV PREPARATION",
                            txtSize: 21.5,
                            txtWeight: FontWeight.w500,
                            clr: isLight ? greenDark : blueShade),
                      ),
                    ],
                  ),
                  FittedBox(
                    child: dmSansTxt(
                      txt: "Start your DMV preparation journey now!",
                      txtSize: 14,
                      clr: Colors.grey,
                      txtWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: homeBtn(
                          isSquare: true,
                          isColumn: true,
                          context: context,
                          btnTxt: 'Warning signs',
                          btnIcon: Icons.warning_amber,
                          btnPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WarningSignsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: homeBtn(
                          isSquare: true,
                          isColumn: true,
                          context: context,
                          btnTxt: 'Road signs',
                          btnIcon: Icons.drive_eta,
                          btnPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoadSignsScreen(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: homeBtn(
                          isSquare: true,
                          isColumn: true,
                          context: context,
                          btnTxt: 'Informatory signs',
                          btnIcon: Icons.directions_outlined,
                          btnPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const InformatorySignsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: homeBtn(
                          isSquare: true,
                          isColumn: true,
                          context: context,
                          btnTxt: 'Prohibitory signs',
                          btnIcon: Icons.block,
                          btnPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProhibitorySignsScreen(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  homeBtn(
                    isSquare: false,
                    isColumn: false,
                    context: context,
                    btnTxt: 'Instructions for driving',
                    btnIcon: Icons.arrow_right_alt_outlined,
                    btnPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const InstructionsForDrivingScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  homeBtn(
                    isSquare: false,
                    isColumn: false,
                    context: context,
                    btnTxt: 'Public road information',
                    btnIcon: Icons.arrow_right_alt_outlined,
                    btnPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PublicRoadInformationScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  homeBtn(
                    isSquare: false,
                    isColumn: false,
                    context: context,
                    btnTxt: 'Written test guide',
                    btnIcon: Icons.arrow_right_alt_outlined,
                    btnPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WrittenTestGuideScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  homeBtn(
                    isSquare: false,
                    isColumn: false,
                    context: context,
                    btnTxt: 'Guide for vehicle',
                    btnIcon: Icons.arrow_right_alt_outlined,
                    btnPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GuideForVehicleScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
