import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/app/modules/main/pages/home/controllers/home_controller.dart';

class CustomDrawer extends GetView<HomeController> {
  final String firstItem;
  final VoidCallback? onScanHistoryTap;
  final VoidCallback? onLogoutTap;

  const CustomDrawer( {
    super.key,
    required this.firstItem,
    this.onScanHistoryTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ikonamoja.png',
                  height: 80,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Menu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ListTile(
            title:  Text(firstItem,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: onScanHistoryTap,
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}
