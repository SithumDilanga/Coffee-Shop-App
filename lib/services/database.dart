import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/models/cart_user.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBaseService {

  // userid of the user
  final String uid;

  DataBaseService({this.uid});

  int currentCartUsersCount;

  // users collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // products collection reference
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  // current cart users count
  final CollectionReference currentCartUsersCountRef = FirebaseFirestore.instance.collection('currentCartUsersCount');

  // current cart users
  final CollectionReference currentCartUsersRef = FirebaseFirestore.instance.collection('currentCartUsers');


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

  // users list from snapshot
  List<UserData> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        password: doc.data()['password'] ?? '',
      );
    }).toList();
  }

  // get users stream
  Stream<List<UserData>> get users {
    return usersCollection.snapshots().map(_usersListFromSnapshot);
  }

  Future<String> getCurrentUserName(String userId) async{

    String name = '';

    await usersCollection.where(
      FieldPath.documentId,
      isEqualTo: userId
    ).get().then((value) {
      if(value.docs.isNotEmpty) {
        name = value.docs.single.data()['name'];
        print(name);
      }
    }).catchError((e) => 'Error fecthing data $e');

    return name;

    // same thing can be achieved by using below code
    // var user = DataBaseService().usersCollection.doc(auth.currentUser.uid).get();
    // user.then(
    //   (value) {
    //     print('current user name ' + value.data()['name']);
    //   }
    // );    
    
  }

  // keep how many users using cart realtime
  Future currentCartUser() async {
    return await currentCartUsersCountRef.doc('ux126').update({'count': FieldValue.increment(1)});
  }

  // getting currentCartUsers count from the database 
  Future<int> getCurrentCartUserCount() async {

    await currentCartUsersCountRef.doc('ux126').get().then((value) {
      // count = value.data()['count'];
      currentCartUsersCount = value.data()['count'];
      print('count value ' + currentCartUsersCount.toString());
    });

    return currentCartUsersCount;
  }

  // add current user as a cart user to the database
  Future setCurrentCartUser(String name, List<Item> items, double total) async {

    // adding ordered items to the items collection
    for(Item item in items) {

      await FirebaseFirestore.instance.collection('currentCartUsers').doc(uid).collection('items').add({
        'itemName': item.itemName,
        'itemPrice': item.itemPrice,
        'itemAmount': item.amount,
        'tableNo':item.tableNo,
      });

    }

    return await currentCartUsersRef.doc(uid).set({
      'uid': uid,
      'name': name,
      'total': total,
    });

  }

  Future getCurrentCartUsers(String uid) async {

    var itemName = [];
    var cartUsersData = [];

    await FirebaseFirestore.instance.collection('currentCartUsers').doc(uid).collection('items').get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        itemName.add(doc['itemName']);
        cartUsersData.add(doc);
        print(cartUsersData);
        // return itemName = doc['itemName'];
      })
    });

    return cartUsersData;

  }

}