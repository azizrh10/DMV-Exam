// import 'package:flutter/material.dart';
// import 'package:rate_my_app/rate_my_app.dart';

// class AppRating {
//   rateApp(BuildContext context) {
//     RateMyApp rateMyApp = RateMyApp(
//       preferencesPrefix: "rateMyApp_",
//       minDays: 0,
//       minLaunches: 1,
//       remindDays: 0,
//       remindLaunches: 1,
//       googlePlayIdentifier: 'com.androiddev.perfectionfinder',
//     );

//     rateMyApp.init().then((value) => {
//           if (rateMyApp.shouldOpenDialog)
//             {
//               rateMyApp.showRateDialog(
//                 context,
//                 title: 'Enjoy our App',
//                 message:
//                     'if you like our app, please rate on Google Play Store',
//                 rateButton: 'Rate Now',
//                 noButton: 'Cancel',
//                 laterButton: 'May be Later',
//                 listener: (button) {
//                   switch (button) {
//                     case RateMyAppDialogButton.rate:
//                       print('Rate App');
//                       break;
//                     case RateMyAppDialogButton.no:
//                       print('No');
//                       break;
//                     case RateMyAppDialogButton.later:
//                       print('Later');
//                       break;
//                   }
//                   return true;
//                 },
//                 dialogStyle: const DialogStyle(),
//                 onDismissed: () =>
//                     rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
//               )
//             }
//         });
//   }
// }

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as FlutterRatingBar;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

class AppRating {
  rateApp(BuildContext context) {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: "rateMyApp_",
      minDays: 0,
      minLaunches: 1,
      remindDays: 0,
      remindLaunches: 1,
      googlePlayIdentifier: 'com.example.nurbs_driving_test',
      // googlePlayIdentifier: 'com.androiddev.perfectionfinder',
    );

    rateMyApp.init().then((value) => {
          if (rateMyApp.shouldOpenDialog)
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final themeSate =
                      Provider.of<ThemeSetting>(context).currentTheme;
                  var isLight = themeSate.brightness == Brightness.light;

                  double rating = 0;
                  return AlertDialog(
                    title: poppinsTxt(
                        txt: 'Rate our App', txtWeight: FontWeight.w500),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: FlutterRatingBar.RatingBar(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              ratingWidget: RatingWidget(
                                full: const Icon(Icons.star, color: greenShade),
                                half: const Icon(Icons.star_half,
                                    color: greenShade),
                                empty: const Icon(Icons.star_border,
                                    color: greenShade),
                              ),
                              onRatingUpdate: (newRating) {
                                rating = newRating;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade400),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: poppinsTxt(
                                txt: 'Cancel',
                                clr: isLight ? Colors.black45 : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: greenDark),
                              onPressed: () async {
                                if (rating >= 4) {
                                  // Redirect to Play Store
                                  rateMyApp.launchStore();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Thank You for rating!',
                                    backgroundColor: greenDark,
                                    textColor: Colors.white,
                                  );
                                }
                                Navigator.pop(context);
                              },
                              child: poppinsTxt(
                                  txt: 'Rate Now',
                                  clr: Colors.white,
                                  txtWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            }
        });
  }
}
