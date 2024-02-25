// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:infravision/models/firestore_model.dart';

@immutable
class DetailsPage extends StatefulWidget {
  Location location;
  DetailsPage({Key? key, required this.location}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool showListView = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //delay the appearance of the list by 5 second.
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        showListView = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('${widget.location.name}'),
              // Text(
              //   'Number of Images: ${widget.location.listOfImages.length}',

              //   textScaleFactor: 0.5,
              //   textAlign: TextAlign.left,
              // ),
            ],
          ),
        ),
        body: Column(
          children: [
            // VideoPlayerPage(),
            showListView
                ? Expanded(
                    child: ListView.builder(
                      itemCount: widget.location.listOfImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            widget.location.listOfImages[index],
                            fit: BoxFit.cover,
                          ),
                        );

                        // ListTile(
                        //   title: Text(widget.location.listOfImages[index]),
                        //   leading: Icon(Icons.image),
                        // );
                      },
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
