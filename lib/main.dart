import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jadwal_shalat_mengajar/model/input_jadwal_kamis.dart';

import 'package:jadwal_shalat_mengajar/admin/home_admin.dart';
import 'package:jadwal_shalat_mengajar/admin/kamis_admin.dart';
import 'package:jadwal_shalat_mengajar/package/selasa.dart';
import 'package:jadwal_shalat_mengajar/admin/senin_admin.dart';
import 'package:jadwal_shalat_mengajar/utils/login_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized;
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.withOpacity(0.8),
        elevation: 0,
      )),
      home: LoginPage(),
    );
  }
}
