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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Infravision: Detecting and Locating Humans using thermal Infrared Images'),
          ),
          Text('''
By:
Jeevan Koiri (076Bei016)
Kailash Pantha (076Bei017)
Ashma Yonghang (076Bei007) 
  ''')
        ],
      ),
    );
  }
}
