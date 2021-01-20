import 'package:flutter/material.dart';
import 'package:test_godunoff/screens/detailed_posts.dart';
import 'package:test_godunoff/widgets/post.dart';

import '../get_data.dart';

class AllPosts extends StatefulWidget {
  AllPosts(this.userId);
  final int userId;

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  Future<List> _posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _posts = GetData().getData(GetData.urlPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All posts of user'),
      ),
      body: PostList(
        future: _posts,
        userId: widget.userId,
        isLastPage: true,
      ),
    );
  }
}
