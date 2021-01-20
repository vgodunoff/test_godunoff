import 'package:flutter/material.dart';
import 'package:test_godunoff/get_data.dart';
import 'package:test_godunoff/screens/detailed_posts.dart';

class PostList extends StatelessWidget {
  PostList(
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
  List listOfPosts = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            listOfPosts = GetData().subListPost(userId, snapshot.data);

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: isPreview == true ? 3 : listOfPosts.length,
                itemBuilder: (context, index) {
                  String preview1 = listOfPosts[index]['body'];
                  var list1 = preview1.split('\n');
                  List onePost = [];

                  list1.forEach((String element) {
                    onePost
                        .add(element[0].toUpperCase() + element.substring(1));
                  });

                  String theOnlyOnePost = onePost.join(". ");

                  return buildPost(index, list1, context, theOnlyOnePost);
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Container buildPost(int index, List<String> list1, BuildContext context,
      String theOnlyOnePost) {
    return Container(
      color: Colors.orange[50],
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Title: ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                children: [
                  TextSpan(
                      text: '${listOfPosts[index]['title']}',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            RichText(
                text: TextSpan(
                    text: 'Post(First line): ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                  TextSpan(
                      text: '${list1[0]}',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                ])),
            isLastPage == true
                ? Container()
                : FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => page));
                    },
                    child: Text(
                      'Look at all posts of user',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPost(
                              post: theOnlyOnePost,
                              id: listOfPosts[index]['id'],
                            )));
              },
              child: Text(
                'See this post',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
