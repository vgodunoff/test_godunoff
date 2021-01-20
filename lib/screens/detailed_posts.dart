import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_godunoff/screens/add_comment.dart';
import 'package:test_godunoff/widgets/post.dart';

import '../get_data.dart';

class DetailPost extends StatefulWidget {
  String post;
  int id;
  DetailPost({this.post, this.id});

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  List listOfComments = [];
  List postComments = [];

  @override
  void initState() {
    GetData().getData(GetData.urlComments).then((value) {
      listOfComments = value;

      int start;
      int end = 5 * widget.id;
      start = end - 5;
      setState(() {
        postComments = listOfComments.sublist(start, end);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments of post'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: postComments.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                        child: ListTile(
                      title: Text(postComments[index]['body']),
                      subtitle: Text(
                          'name: ${postComments[index]['name']}, email:${postComments[index]['email']}'),
                    )),
                  );
                }),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddComment(
                              id: widget.id,
                            )));
              },
              child: Text('Add comment'),
            )
          ],
        ),
      ),
    );
  }
}
