import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/bloc/all_products_bloc/bloc/all_products_bloc.dart';
import 'package:shopping_app/consts/consts.dart';
import 'package:shopping_app/providers/user_provider.dart';
import 'package:shopping_app/screens/splashScreen/splashScreen.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context)=>UserProvider(),)],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsBloc()..add(AllProductsInitialEvent()),
      child: GetMaterialApp(
        title: appname,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: darkFontGrey,
            ),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
            fontFamily: regular),
        home: SplashScreen(),
      ),
    );
  }
}
