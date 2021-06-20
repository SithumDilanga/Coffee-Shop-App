import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/models/SnackProduct.dart';
import 'package:coffee_shop_app/models/TodaySpecialsPoroduct.dart';
import 'package:coffee_shop_app/models/cart_user.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:coffee_shop_app/models/dessertProduct.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/user.dart';

class DataBaseService {

  // userid of the user
  final String uid;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  DataBaseService({this.uid});

  int currentCartUsersCount;

  // users collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // coffee collection reference
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffee'); //products

  // snacks collection reference
  final CollectionReference snacksCollection = FirebaseFirestore.instance.collection('snacks');

  // dessert collection reference
  final CollectionReference dessertsCollection = FirebaseFirestore.instance.collection('desserts');

  // today specials collection reference
  final CollectionReference todaySpecialsCollection = FirebaseFirestore.instance.collection('todaySpecials');

  // current cart users count
  final CollectionReference currentCartUsersCountRef = FirebaseFirestore.instance.collection('currentCartUsersCount');

  // current cart users
  final CollectionReference currentCartUsersRef = FirebaseFirestore.instance.collection('currentCartUsers');


  // creating new document for a new user and updating existing userdata
  Future updateUserData(String name, String email, String password, bool isCartUser) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'isCartUser': isCartUser
    });
  }

  // ------------ coffee products -------------

  // creating new document for coffee products and updating existing products
  Future setCoffeeProducts(String category, String name, int price, String desc, String imgUrl) async {

    print(category);

    return await coffeeCollection.doc(uid).set({
      'category': category,
      'name': name,
      'price': price,
      'desc': desc,
      'imgUrl': imgUrl,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // coffe product list from snapshot
  List<CoffeeProduct> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CoffeeProduct(
        category: doc.data()['category'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        desc: doc.data()['desc'] ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
      );
    }).toList();
  }

  // get coffee products stream
  Stream<List<CoffeeProduct>> get coffeProducts {
    return coffeeCollection.snapshots().map(_productListFromSnapshot);
  }

  // ------------ End coffee products -------------


  // ------------ Snack products -------------

  Future setSnackProducts(String category, String name, int price, String desc, String imgUrl) async {

    print(category);

    return await snacksCollection.doc(uid).set({
      'category': category,
      'name': name,
      'price': price,
      'desc': desc,
      'imgUrl': imgUrl,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // product list from snapshot
  List<SnackProduct> _snacktListFromSnapshot(QuerySnapshot snapshot) {
    
    return snapshot.docs.map((doc) {
      print('snap ' + doc.data().toString());
      return SnackProduct(
        category: doc.data()['category'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        desc: doc.data()['desc'] ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
      );
    }).toList();
  }

  // get products stream
  Stream<List<SnackProduct>> get snackProducts {
    return snacksCollection.snapshots().map(_snacktListFromSnapshot);
  }

  // ------------ End Snack products -------------


  // ------------ Dessert products -------------

    Future setDessertProducts(String category, String name, int price, String desc, String imgUrl) async {

    print(category);

    return await dessertsCollection.doc(uid).set({
      'category': category,
      'name': name,
      'price': price,
      'desc': desc,
      'imgUrl': imgUrl,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // product list from snapshot
  List<DessertProduct> _dessertListFromSnapshot(QuerySnapshot snapshot) {
    
    return snapshot.docs.map((doc) {
      print('snap ' + doc.data().toString());
      return DessertProduct(
        category: doc.data()['category'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        desc: doc.data()['desc'] ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
      );
    }).toList();
  }

  // get products stream
  Stream<List<DessertProduct>> get dessertProducts {
    return dessertsCollection.snapshots().map(_dessertListFromSnapshot);
  }

  // ------------ End Dessert products -------------

  // ------------ Today Specials products -------------

  Future setTodaySpecialsProducts(String category, String name, int price, String desc, String imgUrl) async {

    print(category);

    return await todaySpecialsCollection.doc(uid).set({
      'category': category,
      'name': name,
      'price': price,
      'desc': desc,
      'imgUrl': imgUrl,
      'timeStamp': FieldValue.serverTimestamp(),
    });

  }

  // product list from snapshot
  List<TodaySpecialstProduct> _todaySpecialsListFromSnapshot(QuerySnapshot snapshot) {
    
    return snapshot.docs.map((doc) {
      print('snap ' + doc.data().toString());
      return TodaySpecialstProduct(
        category: doc.data()['category'] ?? '',
        name: doc.data()['name'] ?? '',
        price: doc.data()['price'] ?? '',
        desc: doc.data()['desc'] ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
      );
    }).toList();
  }

  // get products stream
  Stream<List<TodaySpecialstProduct>> get todaySpecialsProducts {
    return todaySpecialsCollection.snapshots().map(_todaySpecialsListFromSnapshot);
  }

  // deleting product
  Future removeTodaySpecialProduct(String name) async {

    todaySpecialsCollection
      .where('name', isEqualTo: name)
      .get().then((value) {
        value.docs.forEach((element) {
          todaySpecialsCollection.doc(element.id).delete().then((val) {
            print('deleted ' + element.id);
          });
        });
      });

  }

  // ------------ End Today Specials products -------------


  // ------------ Delete Products ----------------

  Future removeProduct(String category, String productName) async {

    switch(category) {
      case 'Coffee' : {
        deleteItem(coffeeCollection, productName);
        break;
      }
      case 'Snacks' : {
        deleteItem(snacksCollection, productName);
        break;
      }
      case 'Desserts' : {
        deleteItem(dessertsCollection, productName);
        break;
      } 
    }
    
  }

  // helper fucntion for removeProduct
  deleteItem(final collection, String productName) {
    collection
      .where('name', isEqualTo: productName)
      .get().then((value) {
        value.docs.forEach((element) {
          collection.doc(element.id).delete().then((val) {
            print('deleted ' + element.id);
          });
        });
      });
  }

  // ------------ End Delete Products ----------------


  // ------------- User related functions -------------

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
  // Future currentCartUser() async {
  //   return await currentCartUsersCountRef.doc('ux126').update({'count': FieldValue.increment(1)});
  // }

  // getting currentCartUsers count from the database 
  Future<int> getCurrentCartUserCount() async {

    await currentCartUsersCountRef.doc('ux126').get().then((value) {
      // count = value.data()['count'];
      currentCartUsersCount = value.data()['count'];
      print('count value ' + currentCartUsersCount.toString());
    });

    return currentCartUsersCount;
  }

  // set whether the user is currently cartUser or not
  Future setIsCartUser(String userId, bool isCartUser) async {
     FirebaseFirestore.instance.collection('users').doc(userId).update({'isCartUser': isCartUser});
  }

  // add current user as a cart user to the database
  Future setCurrentCartUser(String name, List<Item> items, int total,) async {

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
      // 'isItemOnTheWay': isItemOnTheWay
    });

  }

  Future getCurrentCartUsersItems(List<String> cartUserids) async {

    // cart items according to each user
    var items = []; 

    for(String uid in cartUserids) {

      // each user's cart items
      var itemsData = [];

      await FirebaseFirestore.instance.collection('currentCartUsers').doc(uid).collection('items').get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        itemsData.add(doc);
        print(itemsData);
        print('bla bla ' + uid.toString());
      })
    });

    items.add(itemsData);

    }

    // await FirebaseFirestore.instance.collection('currentCartUsers').doc(cartUserids[0]).collection('items').get().then((QuerySnapshot querySnapshot) => {
    //   querySnapshot.docs.forEach((doc) {
    //     cartUsersData.add(doc);
    //     print(cartUsersData);
    //     // return itemName = doc['itemName'];
    //   })
    // }); 
    return items;
  }

  // deleting cart user
  Future removeCurrentCartUsersItem(String cartUserid) async {

      // deleting items subcollecion
      await currentCartUsersRef.doc(cartUserid).collection('items').get().then((value) {
        value.docs.forEach((element) {
          currentCartUsersRef.doc(cartUserid).collection('items').doc(element.id).delete();
        });
      });

      // deleting the relevant doc of currentCartUsers collection 
      await currentCartUsersRef.doc(cartUserid).delete();


  }


  // cart users list from snapshot
  List<CartUser> _cartUsersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CartUser(
        name: doc.data()['name'] ?? '',
        uid: doc.data()['uid'] ?? '',
        total: doc.data()['total'] ?? '',
        // isItemOnTheWay: doc.data()['isItemOnTheWay'] ?? ''
      );
    }).toList();
  }

  // get cart users stream
  Stream<List<CartUser>> get cartUsers {
    return currentCartUsersRef.snapshots().map(_cartUsersFromSnapshot);
  }

  // checking isCartUser
  Future<bool> getIsCartUser(String userId) async{

   bool checkValue;

   await usersCollection.doc(userId).get().
      then(
        (value) {
          print('new here ' + value.data()['isCartUser'].toString());

          if(value.data()['isCartUser'] == true) {

            print('new value ' + checkValue.toString());
            return checkValue = true;
            // return true;

          } else {

            print('new value ' + checkValue.toString());
            return checkValue = false;
            // return false;

          }

        } 
      );   

      return checkValue;
  }

}

// ------------- End User related functions -------------