import 'package:flutter/material.dart';

class PhotoDetails extends StatelessWidget {
  final int id;
  final String title;
  final String url;

  const PhotoDetails(
      {super.key, required this.id, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Photo Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Center(child: AspectRatio(aspectRatio: 600/600, child: Image.network(url))),
              const SizedBox(height: 20),
              Text(
                "title :$title",
                style: const TextStyle(fontSize: 20),
              ),
              Center(child: Text("Id : $id", style: const TextStyle(fontSize: 20),))
            ],
          ),
        ),
      ),
    );
  }
}
