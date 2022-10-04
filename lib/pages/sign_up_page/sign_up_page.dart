import 'package:exercise/models/response_models/domain_list_response.dart';
import 'package:exercise/pages/sign_up_page/sign_up_page_controller.dart';
import 'package:exercise/widgets/animated_background.dart';
import 'package:exercise/widgets/blurred_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedBackground(
          child: Stack(
            children: [
              Obx(() {
                if (controller.domains.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                              "assets/icons/mail.png",
                              height: 80,
                            ),
                          ),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 24),
                          BlurredArea(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Obx(
                                () => DropdownButton(
                                    isExpanded: true,
                                    hint: const Text(
                                      "Domain",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    underline: const SizedBox(),
                                    value: controller.domain.value?.id,
                                    items: controller.domains
                                        .map((element) => DropdownMenuItem(
                                            value: element.id,
                                            child: Text(element.domain!)))
                                        .toList(),
                                    onChanged: (selectedId) {
                                      Domain selectedDomain = controller.domains
                                          .firstWhere((element) =>
                                              element.id == selectedId);
                                      controller.setDomain(selectedDomain);
                                    }),
                              ),
                            ),
                          ),
                          Obx(() {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.topCenter,
                              height: controller.domain.value == null ? 0 : 220,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children: <Widget>[
                                  const SizedBox(height: 16),
                                  BlurredArea(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Obx(() => TextField(
                                          controller:
                                              controller.emailTextController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Username",
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "@${controller.domain.value?.domain ?? ''}",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                _toolTip(
                                                    controller.emailError.value),
                                              ],
                                            ),
                                          ),
                                        )),
                                  )),
                                  const SizedBox(height: 16),
                                  BlurredArea(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Obx(() => TextFormField(
                                          controller:
                                              controller.passwordTextController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            suffixIcon: _toolTip(
                                                controller.passwordError.value),
                                          ),
                                          obscureText: true,
                                        )),
                                  )),
                                  const SizedBox(height: 40),
                                  GestureDetector(
                                    onTap: () {
                                      controller.signUp();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff3d80fd),
                                              Color(0xff3648ef)
                                            ],
                                          )),
                                      child: const Center(
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Positioned(
                top: 40,
                left: 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BlurredArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _toolTip(var value) {
    return value.isEmpty
        ? const SizedBox()
        : Tooltip(
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8)),
            message: value,
            child: const Icon(
              Icons.info_outline,
              color: Colors.red,
            ),
          );
  }
}
