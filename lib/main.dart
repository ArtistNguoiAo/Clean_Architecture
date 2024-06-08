import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:risky_coin/data/data_source/database_product.dart';
import 'package:risky_coin/data/model/product_model.dart';
import 'package:risky_coin/presentation/route/app_router.dart';
import 'firebase_options.dart';

DatabaseProduct databaseProduct = DatabaseProduct.db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}

