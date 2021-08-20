import 'package:flutter/material.dart';
import 'package:manage_my_time/widgets/change_theme_button.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Manage My Tasks',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width - 10.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Version',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  '2.0.0',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 10.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Theme.of(context).accentColor),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 10.0),
                          child: Text(
                            'Created By Imira Randeniya',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 10.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Theme.of(context).accentColor),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 9.0, 10.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Dark Theme',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              ChangeThemeButtonWidget(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
