import 'package:flutter/material.dart';
import 'package:test_godunoff/get_data.dart';
import 'package:test_godunoff/screens/detailed_posts.dart';
import 'package:test_godunoff/screens/whole_album.dart';

class AlbumList extends StatelessWidget {
  AlbumList(
      {Key key,
      @required Future<List> future,
      this.page,
      this.userId,
      this.isPreview,
      this.isLastPage})
      : future = future,
        super(key: key);

  final Future<List> future;

  final Widget page;
  final int userId;
  bool isPreview = false;
  bool isLastPage = false;
  List listOfAlbums = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            listOfAlbums = GetData().subListPost(userId, snapshot.data);

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: isPreview == true ? 3 : listOfAlbums.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.green[50],
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Title: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: '${listOfAlbums[index]['title']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          isLastPage == true
                              ? Container()
                              : FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => page));
                                  },
                                  child: Text(
                                    'Look at list of albums',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Album(
                                            id: listOfAlbums[index]['id'],
                                          )));
                            },
                            child: Text(
                              'See the album',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
