import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fyd_shopping_app/models/category_model.dart';

class ProductController extends GetxController {
  var subcat = [];

  getSubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }
}
