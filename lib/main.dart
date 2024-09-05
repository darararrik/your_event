import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yourevent/other/firebase_options.dart';
import 'other/your_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const YourEventApp());
}
