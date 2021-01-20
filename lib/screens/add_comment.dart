import 'package:flutter/material.dart';
import 'package:test_godunoff/comment_model.dart';
import 'package:http/http.dart' as http;

class AddComment extends StatefulWidget {
  final int id;

  AddComment({this.id});

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  CommentModel _comment;

  Future<CommentModel> createComment(
      String userName, String userEmail, String userComment, int id) async {
    final String apiUrl = 'https://jsonplaceholder.typicode.com/comments';
    final response = await http.post(apiUrl, body: {
      "postId": id,
      "name": userName.toString(),
      "email": userEmail.toString(),
      "body": userComment.toString()
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return commentModelFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email address'),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
                child: Text('Send'),
                onPressed: () async {
                  final String userName = nameController.text;
                  final String userEmail = emailController.text;
                  final String userComment = commentController.text;

                  final CommentModel comment = await createComment(
                      userName, userEmail, userComment, widget.id);

                  FocusScope.of(context).unfocus();
                }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
