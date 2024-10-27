import 'dart:async';

import 'package:around_the_frog/AppTextStyles.dart';
import 'package:flutter/material.dart';
import 'userTrackingService.dart';

class CounterDisplay extends StatefulWidget {
  @override
  _CounterDisplayState createState() => _CounterDisplayState();
}

class _CounterDisplayState extends State<CounterDisplay> {
  final UserTrackingService trackingService = UserTrackingService();

  @override
  void initState() {
    super.initState();

    trackingService.getUsersID().then((userId) {
      trackingService.handleUsersCounter(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
      stream: trackingService.getOnlineUsersByCountry(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final Map<String, int> onlineUsersByCountry = snapshot.data!;

        return ListView.builder(
          itemCount: onlineUsersByCountry.length - 1,
          itemBuilder: (context, index) {
            final country = onlineUsersByCountry.keys.elementAt(index);
            final onlineCount = onlineUsersByCountry[country];

            return ListTile(
              title: Text('$country  $onlineCount',
                  style: AppTextStyles.statisticsDescriptionText),
            );
          },
        );
      },
    );
  }
}
