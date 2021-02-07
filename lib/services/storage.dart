import 'dart:io';
import 'dart:math';
import 'package:coffee_shop_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {

  String imageLink;
  String imageFileName;

  DataBaseService database = DataBaseService();

  Future<String> uploadProductImage(File imageFile) async {

    // make random image name
    int randomNumber = Random().nextInt(1000000);
    imageFileName = 'productImage$randomNumber.jpg';

    Reference photosRef = FirebaseStorage.instance.ref().child('photos').child(imageFileName);

    // TODO: check what happens with whenComplete's callback function
    photosRef.putFile(imageFile).whenComplete((() {})).then((storageTask) async {
      imageLink = await storageTask.ref.getDownloadURL(); 
      print(imageLink);
    });

  }

}