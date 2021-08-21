import 'package:flutter/material.dart';
import 'package:manage_my_time/provider/theme_provider.dart';
import 'package:manage_my_time/screens/add_task_screen.dart';
import 'package:manage_my_time/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  _updatetask() {

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            routes: {
              '/home': (context) => HomeScreen(),
              // '/add_task_screen': (context) => AddTaskScreen(updateTasks: (){},),
            },
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
        });
  }
}
