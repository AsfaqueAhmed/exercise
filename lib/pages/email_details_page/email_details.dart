import 'package:exercise/controller_global/token_controller.dart';
import 'package:exercise/models/response_models/email_list_response.dart';
import 'package:exercise/pages/email_details_page/email_details_controller.dart';
import 'package:exercise/pages/email_list_page/email_list_controller.dart';
import 'package:exercise/pages/sign_in_page/sign_in_page.dart';
import 'package:exercise/widgets/animated_background.dart';
import 'package:exercise/widgets/blurred_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class EmailDetailsScreen extends GetView<EmailDetailsController> {
  static const String routeName = "/email_details";

  const EmailDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              BlurredArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 16, top: 40, bottom: 4),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.emailDetails.value == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    DateTime createdTime = DateTime.parse(
                        controller.emailDetails.value!.createdAt!);
                    return ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      children: [
                        controller.emailDetails.value!.subject == null ||
                                controller.emailDetails.value!.subject!.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: BlurredArea(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Sub: ${controller.emailDetails.value!.subject ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                        BlurredArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xff3d80fd),
                                  radius: 20,
                                  child: Center(
                                    child: Text(
                                      controller.emailDetails.value!.from!.name!
                                          .substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .emailDetails.value!.from!.name!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "${createdTime.day.toString().padLeft(2, "0")}/${createdTime.month.toString().padLeft(2, "0")}/${createdTime.year.toString().substring(2)}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlurredArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _userSection(title: "From", user: [
                                  controller.emailDetails.value!.from!
                                ]),
                                _userSection(
                                    title: "To",
                                    user: controller.emailDetails.value!.to!),
                                _userSection(
                                    title: "Cc",
                                    user: controller.emailDetails.value!.cc!),
                                _userSection(
                                    title: "BCc",
                                    user: controller.emailDetails.value!.bcc!),
                              ],
                            ),
                          ),
                        ),
                        ...(controller.emailDetails.value!.html?.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: BlurredArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Html(data: e),
                                  ),
                                ),
                              ),
                            ) ??
                            [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: BlurredArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(controller.emailDetails.value!.text??''),
                                  ),
                                ),
                              )
                            ]),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _userSection({required String title, required List<SenderReceiver> user}) {
    if (user.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                title,
                style: const TextStyle(color: Colors.black87, fontSize: 13),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: user
                .map((e) => Row(
                      children: [
                        Text(
                          e.name!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                        const Text(" - "),
                        Expanded(
                          flex: 3,
                          child: Text(
                            e.address!,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}
