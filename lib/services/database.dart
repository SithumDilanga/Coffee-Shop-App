import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/models/product.dart';

class DataBaseService {

  // userid of the user
  final String uid;

  DataBaseService({this.uid});

  // users collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // products collection reference
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  // creating new document for a new user and updating existing userdata
  Future updateUserData(String name, String email, String password) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  // creating new document for products and updating existing products
  Future updateProductData(String category, String name, double price, String desc, String imgUrl) async {

    print(category);

    return await productsCollection.doc(uid).set({
      'category': category,
      'name': name,
      'price': price,
      'desc': desc,
      'imgUrl': imgUrl,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // product list from snapshot
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        category: doc.data()['category'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        desc: doc.data()['desc'] ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
      );
    }).toList();
  }

  // get products stream
  Stream<List<Product>> get products {
    return productsCollection.snapshots().map(_productListFromSnapshot);
  }

}