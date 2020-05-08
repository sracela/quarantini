//https://medium.com/flutter-community/flutter-code-organization-revised-b09ad5cef7f6

import 'package:flutter/material.dart';
//import 'routes.dart';
import 'screens/home/home.dart';
import 'theme/style.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return BlocProviderTree(
//      blocProviders: <BlocProvider>[
//        BlocProvider<AuthBloc>(bloc: AuthBloc()),
//        BlocProvider<PrefBloc>(bloc: PrefBloc()),
//      ],
//      child: MaterialApp(
  return MaterialApp(
        title: 'Quarantini',
        theme: appTheme(),
        //initialRoute: '/',
        //routes: routes,
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
//    );
  }

}