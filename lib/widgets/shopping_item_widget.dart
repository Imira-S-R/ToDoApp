import 'package:flutter/material.dart';
import 'package:manage_my_time/db/shopping_item_database.dart';
import 'package:manage_my_time/models/shopping_item_model.dart';


class ShoppingItemWidget extends StatefulWidget {
  const ShoppingItemWidget({Key? key}) : super(key: key);

  @override
  _ShoppingItemWidgetState createState() => _ShoppingItemWidgetState();
}

class _ShoppingItemWidgetState extends State<ShoppingItemWidget> {
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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, int index) {
        return Dismissible(
          key: UniqueKey(),
            onDismissed: (direction) {
              ShoppingItemDatabase.instance.delete(items[index].id!);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  '${items[index].itemName} Removed',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                color: Colors.white,
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
                          color: Colors.black,
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
    );
  }
}
