import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Notifications page
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 1'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 2'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
