import 'package:flutter/material.dart';
import 'package:test_godunoff/widgets/album.dart';

import '../get_data.dart';

class AllAlbums extends StatefulWidget {
  AllAlbums(this.userId);
  final int userId;

  @override
  _AllAlbumsState createState() => _AllAlbumsState();
}

class _AllAlbumsState extends State<AllAlbums> {
  Future<List> _albums;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _albums = GetData().getData(GetData.urlAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All albums'),
      ),
      body: AlbumList(
        future: _albums,
        userId: widget.userId,
        isLastPage: true,
      ),
    );
  }
}
