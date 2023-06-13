// ignore_for_file: unused_import

import 'package:fyd_shopping_app/consts/lists.dart';
import 'package:fyd_shopping_app/controllers/auth_controller.dart';
import 'package:fyd_shopping_app/views/widgets_common/applogo_widget.dart';
import 'package:fyd_shopping_app/views/widgets_common/custom_textfield.dart';
import 'package:fyd_shopping_app/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../home_screen/home.dart';
import '../widgets_common/bg_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join The $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(children: [
                customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false),
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    hint: passwordHint,
                    title: retypePassword,
                    controller: passwordRetypeController,
                    isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                //2.heightBox,
                //ourButton().box.width(context.screenWidth - 50).make(),
                Row(children: [
                  Checkbox(
                    checkColor: redColor,
                    value: isCheck,
                    onChanged: (newvalue) {
                      setState(() {
                        isCheck = newvalue;
                      });
                    },
                  ),
                  10.widthBox,
                  Expanded(
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the Terms & conditions ",
                            style: TextStyle(fontFamily: bold, color: fontGrey))
                      ]),
                    ),
                  )
                ]),

                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () async {
                          if (isCheck != false) {
                            controller.isLoading(true);
                            try {
                              await controller
                                  .signupMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                return controller.StorageUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        }).animatedBox.width(context.screenWidth - 50).make(),

                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Already Have a Account?",
                      style: TextStyle(fontFamily: bold, color: fontGrey)),
                  TextSpan(
                      text: "LOGIN",
                      style: TextStyle(fontFamily: bold, color: redColor))
                ])).onTap(() {
                  Get.back();
                }),
              ])
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
