import 'package:flutter/material.dart';
import 'package:manage_my_time/db/shopping_item_database.dart';
import 'package:manage_my_time/models/shopping_item_model.dart';
import 'package:manage_my_time/screens/home_screen.dart';
import 'package:manage_my_time/screens/shopping_cart_screen.dart';

class AddShoppingItem extends StatefulWidget {
  const AddShoppingItem({Key? key}) : super(key: key);

  @override
  _AddShoppingItemState createState() => _AddShoppingItemState();
}

class _AddShoppingItemState extends State<AddShoppingItem> {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red[900],
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => ShoppingCartScreen()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded), color: Colors.white,),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
                color: Colors.red[900]),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
              child: Text(
                'Add New Item',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Item Name',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                TextField(
                  maxLength: 50,
                  controller: itemName,
                  onSubmitted: (value) {
                    itemName.text = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        var item = ShoppingItem(itemName: itemName.text, itemPrice: 0);
                        ShoppingItemDatabase.instance.create(item);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ShoppingCartScreen()));
                      },
                      child: Container(
                        height: 50.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.green),
                        child: Center(
                          child: Text(
                            'Add Item',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ShoppingCartScreen()));
                      },
                      child: Container(
                        height: 50.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.red),
                        child: Center(
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
