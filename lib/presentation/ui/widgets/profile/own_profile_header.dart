import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_flare/presentation/state_holders/user_controller.dart';
import 'package:share_flare/presentation/ui/screens/follower_screen.dart';
import 'package:share_flare/presentation/ui/utilities/auth_constant.dart';
import 'package:share_flare/presentation/ui/utilities/colors.dart';
import 'package:share_flare/presentation/ui/utilities/theme/theme.dart';
import 'package:share_flare/presentation/ui/widgets/round_divider.dart';

class OwnProfileHeaderWidget extends StatefulWidget {
  OwnProfileHeaderWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.profilePhoto,
    required this.follower,
    required this.following,
  });

  String firstName;
  String lastName;
  String userName;
  String profilePhoto;
  int following;
  int follower;

  @override
  State<OwnProfileHeaderWidget> createState() => _OwnProfileHeaderWidgetState();
}

class _OwnProfileHeaderWidgetState extends State<OwnProfileHeaderWidget> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    final dark = SFAppTheme.isDarkMode(context);
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: dark ? const Color(0xFF1D2939) : SFColors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.profilePhoto),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.firstName} ${widget.lastName}',
                      style: TextStyle(
                        color: dark ? SFColors.white : const Color(0xFF1D2939),
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: dark ? SFColors.white : const Color(0xFF1D2939),
                        letterSpacing: 0.4,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "23",
                              style: TextStyle(
                                color: dark
                                    ? SFColors.white
                                    : const Color(0xFF1D2939),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Postsss",
                              style: TextStyle(
                                color: dark
                                    ? SFColors.white
                                    : const Color(0xFF1D2939),
                                fontSize: 10,
                                letterSpacing: 0.4,
                              ),
                            )
                          ],
                        ),
                        const RoundDivider(),
                        Row(
                          children: [
                            Text(
                              widget.following.toString(),
                              style: TextStyle(
                                color: dark
                                    ? SFColors.white
                                    : const Color(0xFF1D2939),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                              onTap: () async {
                                List<String> userIds = userProfileController
                                    .fetchUserModel.following!
                                    .cast<String>()
                                    .toList();
                                await followUserController
                                    .getUsersByIds(userIds);
                                Get.to(() => const FollowerScreen(
                                      isFollowerTab: false,
                                    ));
                              },
                              child: Text(
                                "Following",
                                style: TextStyle(
                                  color: dark
                                      ? SFColors.white
                                      : const Color(0xFF1D2939),
                                  letterSpacing: 0.4,
                                  fontSize: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                        const RoundDivider(),
                        GestureDetector(
                          onTap: () async {
                            List<String> userIds = userProfileController
                                .userData['follower']
                                .cast<String>()
                                .toList();
                            print('Follower List is :::::: $userIds');
                            print('Follower List is ::::::');
                            await followUserController.getUsersByIds(userIds);
                            Get.to(() => const FollowerScreen(
                                  isFollowerTab: false,
                                ));
                          },
                          child: Row(
                            children: [
                              Text(
                                widget.follower.toString(),
                                style: TextStyle(
                                  color: dark
                                      ? SFColors.white
                                      : const Color(0xFF1D2939),
                                  letterSpacing: 0.4,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "Follower",
                                style: TextStyle(
                                  color: dark
                                      ? SFColors.white
                                      : const Color(0xFF1D2939),
                                  letterSpacing: 0.4,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
