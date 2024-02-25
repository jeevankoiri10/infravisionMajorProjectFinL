// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infravision/views/details_page.dart';
import '../models/firestore_model.dart';

class FirestorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: ConvexAppBar(
      //   backgroundColor: Colors.lightBlueAccent,
      //   style: TabStyle.flip,
      //   items: [
      //     TabItem(icon: Icons.home, title: 'Home'),
      //     TabItem(icon: Icons.notes, title: 'Abouts'),
      //   ],
      //   onTap: (int i) => print('click index=$i'),
      // ),
      // appBar: AppBar(
      //   title: Text('Infravision'),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('database').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Location> locations = [];
          snapshot.data!.docs.forEach((doc) {
            locations.add(Location(
              doc['name'],
              List<String>.from(doc['listOfImages']),
            ));
          });

          return Column(
            children: [
              Image.asset("assets/chitwan.jpg"),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(location: locations[index])));
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(locations[index].name),
                          // subtitle: Text(
                          //     'Number of Images: ${locations[index].listOfImages.length}'
                          //     ),
                          // Add onTap functionality to navigate to a detail page if needed
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
