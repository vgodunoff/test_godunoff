import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class GetData {
  static const String urlUsers = 'https://jsonplaceholder.typicode.com/users';
  static const String urlPost = 'https://jsonplaceholder.typicode.com/posts';
  static const String urlComments =
      'https://jsonplaceholder.typicode.com/comments';

  static const String urlAlbums = 'https://jsonplaceholder.typicode.com/albums';
  static const String urlPhotos = 'https://jsonplaceholder.typicode.com/photos';

  // List listOfDecodedData = [];

  Future<List> getData(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var arr = await jsonDecode(data) as List;
      return arr;
    } else {
      print(response.statusCode);
    }
  }

  List subListPost(int userId, List snapshot) {
    List list = snapshot;
    int start;
    int end = 10 * userId;
    start = end - 10;
    List tmp = list.sublist(start, end);
    return tmp;
  }
}
