import 'package:flutter/material.dart';
import 'package:manage_my_time/screens/add_shopping_item_screen.dart';
import 'package:manage_my_time/widgets/shopping_item_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddShoppingItem()));
        },
        backgroundColor: Colors.red,
        splashColor: Colors.red[900],
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
            onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
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
              color: Colors.blue[900],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
              child: Text(
                'Shopping Cart',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0),
              ),
            ),
          ),
          Expanded(child: ShoppingItemWidget()),
        ],
      ),
    );
  }
}
