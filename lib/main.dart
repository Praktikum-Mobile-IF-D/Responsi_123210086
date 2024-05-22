import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsi/model/bookmarks.dart';
import 'package:responsi/view/login.dart';
import 'package:responsi/view/register.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JobsAdapter());
  await Hive.openBox<Jobs>('bookmarks');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
