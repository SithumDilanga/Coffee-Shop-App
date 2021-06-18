import 'dart:io';
import 'dart:math';
import 'package:coffee_shop_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Storage {

  String imageLink;
  String imageFileName;

  DataBaseService database = DataBaseService();

  Future<String> uploadProductImage(File imageFile, String imageName) async {

    // make random image name
    int randomNumber = Random().nextInt(1000000);
    // imageFileName = 'productImage$randomNumber.jpg';
        imageFileName = '$imageName.jpg';


    Reference photosRef = FirebaseStorage.instance.ref().child('photos').child(imageFileName);

    photosRef.putFile(imageFile).whenComplete((() {
      Fluttertoast.showToast(
        msg: 'Image added!',
        toastLength: Toast.LENGTH_SHORT,
      );
    })).then((storageTask) async {
      imageLink = await storageTask.ref.getDownloadURL(); 
      print(imageLink);
    });

  }

  Future deleteProductImage(String imageName) async {

    final Reference storageRef = FirebaseStorage.instance.ref().child('photos').child(imageName);

    print('storage delete called ' + storageRef.toString());

    try {
      await storageRef.delete();
    } catch(e) {
      print('storage delete Error : ' + e.toString());
      return e.toString();
    }

  }

}