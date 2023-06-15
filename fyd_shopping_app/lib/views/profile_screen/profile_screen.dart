import 'package:fyd_shopping_app/consts/consts.dart';
import 'package:fyd_shopping_app/consts/lists.dart';
import 'package:fyd_shopping_app/controllers/auth_controller.dart';
import 'package:fyd_shopping_app/controllers/profile_controller.dart';
import 'package:fyd_shopping_app/views/auth_screen/login_screen.dart';
import 'package:fyd_shopping_app/views/chat_screen/messaging_screen.dart';
import 'package:fyd_shopping_app/views/orders_screen/orders_screen.dart';
import 'package:fyd_shopping_app/views/profile_screen/components/details_card.dart';
import 'package:fyd_shopping_app/views/profile_screen/components/edit_profile_screen.dart';
import 'package:fyd_shopping_app/views/widgets_common/bg_widget.dart';
import 'package:fyd_shopping_app/views/widgets_common/loading_indicator.dart';
import 'package:fyd_shopping_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      //edit profile button
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.edit, color: whiteColor))
                              .onTap(() {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
                          })),

                      //user details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(imgProfile2,
                                        width: 75, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.network(data['imageUrl'],
                                        width: 75, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                  color: whiteColor,
                                )),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: "logout"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                      ),

                      10.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     detailsCard(
                      //         count: data['cart_count'],
                      //         title: "in your cart",
                      //         width: context.screenWidth / 3.4),
                      //     detailsCard(
                      //         count: data['wishlist_count'],
                      //         title: "in your wishlist",
                      //         width: context.screenWidth / 3.4),
                      //     detailsCard(
                      //         count: data['order_count'],
                      //         title: "your orders",
                      //         width: context.screenWidth / 3.4),
                      //   ],
                      // ),

                      FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else {
                            var countData = snapshot.data;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                    count: countData[0].toString(),
                                    title: "in your cart",
                                    width: context.screenWidth / 3.3),
                                detailsCard(
                                    count: countData[1].toString(),
                                    title: "in your wishlist",
                                    width: context.screenWidth / 3.3),
                                detailsCard(
                                    count: countData[2].toString(),
                                    title: "your orders",
                                    width: context.screenWidth / 3.3),
                              ],
                            );
                          }
                        },
                      ),

                      //buttons section
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profileButtonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const OrderScreen());
                                  break;
                                case 1:
                                  Get.to(() => const WishListScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessagesScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: profileButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(blackColor)
                          .make(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
