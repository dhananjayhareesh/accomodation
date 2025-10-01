import 'package:accomodation_admin/features/counterUser/allocationModule/screens/allocation_screen.dart';
import 'package:accomodation_admin/features/counterUser/cancellationModule/screens/cancellation_screen.dart';
import 'package:accomodation_admin/features/counterUser/extentionModule/screens/extention_screen.dart';
import 'package:accomodation_admin/features/counterUser/registrationModule/screens/indian_reg.dart';
import 'package:accomodation_admin/features/counterUser/vacationModule/screens/vacation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/png/logo.png"),
          ),
          DrawerListTile(
            title: "Allocation",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.to(const AllocationScreen());
            },
          ),
          DrawerListTile(
            title: "Extention",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Get.to(const ExtensionScreen());
            },
          ),
          DrawerListTile(
            title: "Vacation",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Get.to(const VacationScreen());
            },
          ),
          DrawerListTile(
            title: "Cancellation",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Get.to(const CancellationScreen());
            },
          ),
          DrawerListTile(
            title: "Group Allocation",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Registration - Indians",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Get.to(const IndianRegScreen());
            },
          ),
          DrawerListTile(
            title: "Registration - Foreigners",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Enquires",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Modify",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Guest Diary",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Reports",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
