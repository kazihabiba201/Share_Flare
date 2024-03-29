import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_flare/presentation/ui/utilities/auth_constant.dart';
import 'package:share_flare/presentation/ui/utilities/colors.dart';
import 'package:share_flare/presentation/ui/utilities/theme/theme.dart';
import 'package:share_flare/presentation/ui/widgets/follower_list/follower_tab.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({
    super.key,
    required this.isFollowerTab,
  });

  final bool isFollowerTab;
  //final List followerList;
  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      followUserController.userList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = SFAppTheme.isDarkMode(context);
    return Obx(() {
      return Visibility(
        visible: !followUserController.isDataLoading,
        replacement: const Center(
          child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                  // color: Colors.red,
                  ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
        child: Scaffold(
          backgroundColor: dark ? SFColors.darkBackgroundColor : SFColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
                backgroundColor:
                    dark ? const Color(0xFF1D2939) : SFColors.white,
                title: Text(
                  'My Follower',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: dark ? SFColors.white : const Color(0xFF1D2939),
                  ),
                ),
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: dark ? SFColors.white : const Color(0xFF1D2939),
                  ),
                )),
          ),
          body: DefaultTabController(
            initialIndex: widget.isFollowerTab ? 1 : 0,
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [],
                    ),
                  ),
                ];
              },
              body: FollowerTabBar(
                followingList: followUserController.userList,
                followerList: followUserController.userList,
              ),
            ),
          ),
        ),
      );
    });
  }
}
