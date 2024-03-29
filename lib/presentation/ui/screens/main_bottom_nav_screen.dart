
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_flare/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:share_flare/presentation/state_holders/post_screen_controller.dart';

import 'package:share_flare/presentation/ui/screens/home_page.dart';
import 'package:share_flare/presentation/ui/screens/own_profile_screen.dart';
import 'package:share_flare/presentation/ui/screens/search_screen.dart';
import 'package:share_flare/presentation/ui/utilities/assets_path.dart';
import 'package:share_flare/presentation/ui/utilities/auth_constant.dart';
import 'package:share_flare/presentation/ui/utilities/colors.dart';
import 'package:share_flare/presentation/ui/utilities/theme/theme.dart';
import 'package:share_flare/presentation/ui/utilities/utiles.dart';

import 'post_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  final bool camera;
  const MainBottomNavScreen({Key? key, required this.camera}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  MainBottomNavController mainBottomNavController =
      Get.put(MainBottomNavController());

  Uint8List? _imageList ;
  MainBottomNavController mainBottomNavController =
  Get.put(MainBottomNavController());
  /// int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    SearchScreen(),
    HomePage(),
    OwnProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
  ];


  @override
  Widget build(BuildContext context) {
    final dark = SFAppTheme.isDarkMode(context);
    return GetBuilder<MainBottomNavController>(builder: (controller) {
      return Scaffold(
        body: _pages[controller.currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: dark ? Colors.yellow : SFColors.buttonActiveColor,
          unselectedItemColor: dark ? SFColors.white : SFColors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: controller.currentSelectedIndex,
          onTap: (index) {
            if (index == 2) {
              _showAddOptionsDialog();
            } else {
              controller.changeScreen(index);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "add",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "person",
            ),
          ],
        ),
      );
    });
  }

  void _showAddOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
            alignment: Alignment.center,
            child: Text("Select From"),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  if (widget.camera) {
                    await PostScreenController().pickImageFromCamera();
                  } else {
                    Get.to(() => const PostScreen(camera: false));
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      SFAssetsPath.cameraImagePNG,
                      height: 80,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PostScreen(camera: false));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      SFAssetsPath.galleryImagePNG,
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}