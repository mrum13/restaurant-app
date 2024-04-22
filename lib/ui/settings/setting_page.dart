import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/shared_prefrences.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifikasi Restaurant",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Setiap pukul 11:00",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
                  var settingsStatus = SharedPreference.favoriteRestaurant.getBool("scheduled_setting");
                  return Switch.adaptive(
                    value: settingsStatus ?? false,
                    activeColor: Colors.green,
                    onChanged: (value) async {
                      SharedPreference.scheduledSetting?.setBool("scheduled_setting", value);
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledRestaurant(value);
                      }
                    },
                  );
                })
              ],
            )
          ],
        ),
      )),
    );
  }
}
