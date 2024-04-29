import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revier_pode/widgets/main_screen.dart';


void main() {
  runApp(const ProviderScope(
    child:  MaterialApp(home: MainScreen()),
  ),
  );
}

