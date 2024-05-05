import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';

Widget customBtn({
  Color? contClr,
  required String contTxt,
  double? conHght,
  Color? txtClr,
  required Function() conPress,
  required BuildContext context,
  BorderRadius? contRadius,
}) {
  final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
  var isLight = themeSate.brightness == Brightness.light;
  return InkWell(
    onTap: conPress,
    child: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: conHght ?? 55,
      decoration: BoxDecoration(
        border: Border.all(color: isLight ? greenDark : blueShade),
        borderRadius: contRadius,
        color: isLight ? greenDark : blueShade,
      ),
      child: poppinsTxt(
          txt: contTxt, clr: txtClr, txtSize: 20, txtWeight: FontWeight.w300),
    ),
  );
}

Widget drawerBtn({
  required String contTxt,
  required Function() conPress,
  required BuildContext context,
  required IconData conIcon,
}) {
  final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
  var isLight = themeSate.brightness == Brightness.light;
  return SizedBox(
    width: double.infinity,
    child: TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        side: BorderSide(color: isLight ? greenDark : blueShade),
        foregroundColor: isLight ? greenDark : Colors.white,
      ),
      onPressed: conPress,
      icon: Icon(conIcon),
      label: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: FittedBox(
          child: poppinsTxt(
            txt: contTxt,
            txtSize: 18,
            txtWeight: FontWeight.w300,
          ),
        ),
      ),
    ),
  );
}

Widget homeBtn({
  required bool isColumn,
  required context,
  required String btnTxt,
  required IconData btnIcon,
  required bool isSquare,
  required Function() btnPress,
  double? txtSize,
  double? btnSize,
}) {
  final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
  var isLight = themeSate.brightness == Brightness.light;
  return Container(
    height: isSquare ? 100 : btnSize ?? 55,
    width: double.infinity,
    decoration: BoxDecoration(
        border: Border.all(color: isLight ? greenDark : blueShade),
        borderRadius: BorderRadius.circular(10)),
    child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: isLight ? greenDark : Colors.grey.shade300),
        onPressed: btnPress,
        child: isColumn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    btnIcon,
                    size: 55,
                  ),
                  FittedBox(
                    child: FittedBox(
                      child: poppinsTxt(
                        txt: btnTxt,
                        clr: isLight ? Colors.black : Colors.white,
                        txtSize: 15,
                        txtWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: poppinsTxt(
                      txt: btnTxt,
                      clr: isLight ? Colors.black : Colors.white,
                      txtSize: txtSize ?? 16,
                      txtWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    btnIcon,
                    size: 32,
                  ),
                ],
              )),
  );
}
