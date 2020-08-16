import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/models/image.dart';
import 'package:gallery_app/showFullScreenImage.dart';
import 'package:gallery_app/utils/DBHelper.dart';
import 'package:gallery_app/utils/utility.dart';
import 'package:gallery_app/widgets/floating_button.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }
  @override
  Widget build(BuildContext context) {
    final mediaquery=MediaQuery.of(context);
    final appbar=AppBar(
      title: Text('My Gallery',style: Theme.of(context).textTheme.title,),
      centerTitle: true,
    );
    final height=mediaquery.size.height-appbar.preferredSize.height-mediaquery.padding.top;
    return Scaffold(
      appBar:appbar,
      body: Stack(
        children:<Widget>[
          Container(
            height:height,
            width: mediaquery.size.width,
            decoration:BoxDecoration(
              image: DecorationImage(
                image:ExactAssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: gridView(),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ActionButton(pickImage: pickImage,),
    );
  }

  Widget gridView() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        children: images.map((photo) {
          return InkWell(
            onTap:()=> showImage(photo),
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Utility.imageFromBase64String(photo.photo_name))),
          );
        }).toList(),
      ),
    );
  }

  void showImage(Photo photo){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>showFullScreenImage(photo: photo)));
  }

  void pickImage(String source) {
    ImagePicker.pickImage(source: (source=='gallery')?ImageSource.gallery:ImageSource.camera).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
      Photo photo = Photo(0, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }

  void refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }


}