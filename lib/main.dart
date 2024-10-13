import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yourevent/core/internal/firebase_options.dart';

import 'core/internal/your_event_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(YourEventApp());
}
