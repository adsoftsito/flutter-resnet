import 'package:flutter/material.dart';
import 'package:resnet/routes/Routes.dart';
import 'package:resnet/screens/ResnetScreen.dart';
import 'package:resnet/themes/Themes.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Resnet App',
        theme: CustomTheme().baseTheme,


        initialRoute: ResnetScreen.routeName,

        routes: routes,
      );
    });
  }
}
