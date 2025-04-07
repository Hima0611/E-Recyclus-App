import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_recycle_app/domain/app_routes.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Recycle App',
      theme: ThemeData( // ✅ Move fontFamily here
        fontFamily: 'avenir',
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash_page,
      routes: AppRoutes.getRoutes(),
    );
  }
}