import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
