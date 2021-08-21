import 'package:flutter/material.dart';
import 'package:manage_my_time/db/shopping_item_database.dart';
import 'package:manage_my_time/models/shopping_item_model.dart';
import 'package:manage_my_time/screens/add_shopping_item_screen.dart';
import 'package:manage_my_time/widgets/no_shopping_item_found.dart';
import 'package:manage_my_time/widgets/shopping_item_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late List<ShoppingItem> items = [];
  late final ShoppingItem? task;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.items = await ShoppingItemDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddShoppingItem(
                        refershTasks: refreshNotes,
                      )));
        },
        backgroundColor: Colors.red,
        splashColor: Colors.red[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 55.0,
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
                'Shopping List',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: items.length == 0 ? 1 : items.length,
            itemBuilder: (context, int index) {
              return items.length == 0
                  ? NoItemFound()
                  : Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        ShoppingItemDatabase.instance.delete(items[index].id!);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            '"${items[index].itemName}" Removed',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                        child: Container(
                          height: 50.0,
                          width: double.infinity - 10.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index].itemName,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          )),
        ],
      ),
    );
  }
}
