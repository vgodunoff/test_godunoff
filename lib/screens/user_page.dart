import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:test_godunoff/get_data.dart';
import 'package:test_godunoff/screens/all_albums.dart';
import 'package:test_godunoff/screens/all_posts.dart';
import 'package:test_godunoff/widgets/album.dart';
import 'package:test_godunoff/widgets/post.dart';

class UserPage extends StatefulWidget {
  final String userName;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String companyName;
  final String companyBs;
  final String companyCatchPhrase;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final int userId;

  const UserPage({
    Key key,
    this.userName,
    this.name,
    this.email,
    this.phone,
    this.website,
    this.companyName,
    this.companyBs,
    this.companyCatchPhrase,
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.userId,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<List> _posts;
  Future<List> _albums;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _posts = GetData().getData(GetData.urlPost);
    _albums = GetData().getData(GetData.urlAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            UserInfo(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  'Several examples of user\'s posts (first 3 posts)',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
            PostList(
                future: _posts,
                page: AllPosts(widget.userId),
                userId: widget.userId,
                isPreview: true),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  'Several examples of albums (first 3 albums)',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
            AlbumList(
                future: _albums,
                page: AllAlbums(widget.userId),
                userId: widget.userId,
                isPreview: true),
          ],
        ),
      ),
    );
  }

  Container UserInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('name: ${widget.name}'),
          Text('email: ${widget.email}'),
          Text('phone: ${widget.phone}'),
          Text('website: ${widget.website}'),
          Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Wrap(
            children: [
              Text('working (company):'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('name: ${widget.companyName}'),
                    Text('bs: ${widget.companyBs}'),
                    Text(
                      'catchPhrase: "${widget.companyCatchPhrase}"',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('adress:'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('street: ${widget.street}'),
                        Text('suite: ${widget.suite}'),
                        Text('city: ${widget.city}'),
                        Text('zipcode: ${widget.zipcode}'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
