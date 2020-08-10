import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carpollo/apiSheet.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forumsfdssddsf'),
        backgroundColor: Color(0xffBE6151),
      ),
      body: Forum(),
    );
  }
}

class Forum extends StatefulWidget {
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {

  List posts = [];

  _ForumState() {
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
//        child: new Container(
//          width: double.infinity,
//          child: Post(),
//        ),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCell(Map<String, dynamic>.from(posts[index]));
          },
//          child: RaisedButton(
//            onPressed: () {
//              Navigator.pop(context);
//            },
//            child: ListView.builder(itemBuilder: null)
        ),
        onRefresh: onRefresh
    );
  }

  Future<Null> onRefresh() async {
//    await print('onRefresh');
    Response res = await getPosts();
    print(res.data);
    setState(() {
      posts = res.data;
    });
    return null;
  }

  Future<Response> getPosts() {
    return Api.instance.getPosts();
  }
}


class PostCell extends StatelessWidget {

  Map<String, dynamic> _info;
  String description;
  String departDate;
  String username;
  String title;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  PostCell(this._info) {
    String date = (_info['departTime'] == null) ? "1974-03-20 00:00:00.000" : _info['departTime'];
    departDate = formatter.format(DateTime.parse(date));
    description = "From " + _info['departCity'] + " to " + _info['arrivalCity'];
    if (_info['stops'].length != 0) {
      description += ', stop by ';
      for (var stop in _info['stops']) {
        description += "$stop ,";
      }
    }
    username = _info['username'];
    title = "From " + _info['departCity'] + " to " + _info['arrivalCity'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            print('tap tap tap');
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              ListTile(
                leading: Column(
                  children: <Widget>[
                    Icon(Icons.album),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        username,
                      ),
                    )                  ],
                ),
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Depart at: ' + departDate,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
