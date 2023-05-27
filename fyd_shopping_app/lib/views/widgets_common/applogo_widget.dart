// ignore_for_file: unused_import

import 'package:fyd_shopping_app/consts/consts.dart';

Widget applogoWidget() {
  //using velocity x here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(100, 100)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
