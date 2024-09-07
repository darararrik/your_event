import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yourevent/core/firebase_options.dart';
import 'features/your_event_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const YourEventApp());
}
