// ignore_for_file: deprecated_member_use

import 'package:fyd_shopping_app/consts/consts.dart';

Widget ourButton(
    {onPress, color, textcolor, String? title, required Color textColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: color, padding: const EdgeInsets.all(12)),
    onPressed: onPress,
    child: title!.text.color(textcolor).fontFamily(bold).make(),
  );
}
