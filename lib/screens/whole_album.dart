import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../get_data.dart';

class Album extends StatefulWidget {
  int id;
  Album({this.id});

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  List allPhotos = [];
  List oneAlbumPhotos = [];

  @override
  void initState() {
    GetData().getData(GetData.urlPhotos).then((value) {
      allPhotos = value;

      int start;
      int end = 50 * widget.id;
      start = end - 50;
      setState(() {
        oneAlbumPhotos = allPhotos.sublist(start, end);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: oneAlbumPhotos.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image(
                    image: NetworkImage(oneAlbumPhotos[index]['url']),
                  ),
                  title: Text(oneAlbumPhotos[index]['title']),
                ),
              );
            }),
      ),
    );
  }
}
