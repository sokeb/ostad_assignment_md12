import 'package:flutter/material.dart';
import 'package:ostad_assignment_md12/photo_gallery_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhotoGalleryApp(),
    );
  }
}
