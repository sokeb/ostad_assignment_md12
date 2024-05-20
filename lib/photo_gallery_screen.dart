import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ostad_assignment_md12/photo_details_screen.dart';

class PhotoGalleryApp extends StatefulWidget {
  const PhotoGalleryApp({super.key});

  @override
  State<PhotoGalleryApp> createState() => _PhotoGalleryAppState();
}

class _PhotoGalleryAppState extends State<PhotoGalleryApp> {
  bool _getPhotoListInProgress = false;
  List<Photos> photoList = [];

  @override
  void initState() {
    super.initState();
    _getPhotoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Photo Gallery App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Visibility(
        visible: _getPhotoListInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: photoList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoDetails(
                        id: photoList[index].id,
                        title: photoList[index].title,
                        url: photoList[index].url),
                  ));
            },
            child: ListTile(
              horizontalTitleGap: 20,
              leading: AspectRatio(
                aspectRatio: 150/150,
                child: Image.network(
                  photoList[index].thumbnailUrl
                ),
              ),
              title: Text(
                photoList[index].title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 5),
        ),
      ),
    );
  }

  Future<void> _getPhotoList() async {
    _getPhotoListInProgress = true;
    setState(() {});
    photoList.clear();

    const String productListUrl = "https://jsonplaceholder.typicode.com/photos";
    Uri uri = Uri.parse(productListUrl);

    Response response = await get(uri);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      for (Map<String, dynamic> p in decodedData) {
        Photos photos = Photos(
          p["id"] ?? "",
          p["title"] ?? "",
          p["url"] ?? "",
          p["thumbnailUrl"] ?? "",
        );
        photoList.add(photos);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Get photo list failed!"),
      ));
    }
    _getPhotoListInProgress = false;
    setState(() {});
  }
}

class Photos {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos(this.id, this.title, this.url, this.thumbnailUrl);
}
