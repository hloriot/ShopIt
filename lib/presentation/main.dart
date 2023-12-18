import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_it/data/manager/permission_manager_impl.dart';
import 'package:shop_it/data/repository/google_auto_complete_city_repository.dart';
import 'package:shop_it/data/repository/yper_shop_repository.dart';
import 'package:shop_it/domain/manager/permission_manager.dart';
import 'package:shop_it/domain/repository/city_repository.dart';
import 'package:shop_it/domain/repository/shop_repository.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PermissionManager>(
          create: (context) => PermissionManagerImpl(),
        ),
        Provider<ShopRepository>(
          create: (context) => YperShopRepository(),
        ),
        Provider<CityRepository>(
          create: (context) => GoogleAutoCompleteCityRepository(),
        ),
      ],
      child: SafeArea(
        child: MaterialApp(
          title: 'shop it',
          themeMode: ThemeMode.system,
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF57c1ca),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
            useMaterial3: true,
          ),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF57c1ca),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.rubikTextTheme(ThemeData.light().textTheme),
            useMaterial3: true,
          ),
          home: const SplashScreenPage(),
        ),
      ),
    );
  }
}
