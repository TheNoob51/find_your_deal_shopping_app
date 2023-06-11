import 'package:fyd_shopping_app/consts/consts.dart';
import 'package:fyd_shopping_app/consts/lists.dart';
import 'package:fyd_shopping_app/controllers/product_controller.dart';
import 'package:fyd_shopping_app/views/category_screen/category_details.dart';
import 'package:fyd_shopping_app/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(categoryImages[index],
                      height: 150, width: 200, fit: BoxFit.cover),
                  10.heightBox,
                  categoryList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowMd
                  .make()
                  .onTap(() {
                controller.getSubcategories(categoryList[index]);
                Get.to(() => CategoryDetails(title: categoryList[index]));
              });
            }),
      ),
    ));
  }
}
