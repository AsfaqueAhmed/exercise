import 'package:exercise/controller_global/token_controller.dart';
import 'package:exercise/models/response_models/email_list_response.dart';
import 'package:exercise/pages/email_details_page/email_details.dart';
import 'package:exercise/pages/email_list_page/email_list_controller.dart';
import 'package:exercise/pages/sign_in_page/sign_in_page.dart';
import 'package:exercise/widgets/animated_background.dart';
import 'package:exercise/widgets/blurred_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class EmailListScreen extends GetView<EmailListController> {
  static const String routeName = "/email_list";

  const EmailListScreen({Key? key}) : super(key: key);

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
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          controller.loadEmails();
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                          onPressed: () async {
                            Dialogs.materialDialog(
                                msg: 'Are you sure, you want to log out?',
                                title: "Log out",
                                color: Colors.white,
                                context: context,
                                actions: [
                                  IconsOutlineButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    text: 'Cancel',
                                    iconData: Icons.cancel_outlined,
                                    textStyle:
                                        const TextStyle(color: Colors.grey),
                                    iconColor: Colors.grey,
                                  ),
                                  IconsButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Get.find<TokenController>()
                                          .removeToken();
                                      Get.offAllNamed(SignInScreen.routeName);
                                    },
                                    text: 'Sign out',
                                    iconData: Icons.power_settings_new,
                                    color: Colors.red,
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                    iconColor: Colors.white,
                                  ),
                                ]);
                          },
                          icon: const Icon(Icons.power_settings_new)),
                    ],
                  ),
                ),
              ),
              Expanded(child: Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.emails.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "No email received",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.loadEmails();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) {
                      Email email = controller.emails[index];
                      DateTime createdTime = DateTime.parse(email.createdAt!);
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(EmailDetailsScreen.routeName,
                              arguments: [email.id]);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            BlurredArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color(0xff3d80fd),
                                          radius: 20,
                                          child: Center(
                                            child: Text(
                                              email.from!.name!.substring(0, 1),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      email.from!.name!,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${createdTime.day.toString().padLeft(2, "0")}/${createdTime.month.toString().padLeft(2, "0")}/${createdTime.year.toString().substring(2)}",
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              email.subject == null ||
                                                      email.subject!.isEmpty
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2),
                                                      child: Text(
                                                        "No subject",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey),
                                                        maxLines: 1,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2),
                                                      child: Text(
                                                        email.subject ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    email.intro == null || email.intro!.isEmpty
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              email.intro!,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff3d3d3d),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                    email.hasAttachments == null ||
                                            !email.hasAttachments!
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              ((email.hasAttachments ?? false)
                                                  ? "📎 Has attachment with email"
                                                  : ""),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xff3d3d3d),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: email.seen == true
                                  ? const SizedBox()
                                  : const CircleAvatar(
                                      radius: 6,
                                      backgroundColor: Colors.green,
                                    ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: controller.emails.length,
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
