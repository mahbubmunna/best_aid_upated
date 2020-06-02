import 'package:bestaid/config/helper.dart';
import 'package:bestaid/src/models/post.dart';
import 'package:bestaid/src/models/route_argument.dart';
import 'package:bestaid/src/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  var _allPosts;

  @override
  void initState() {
    _allPosts = PostRepository.getPost();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text('Back'),
        elevation: 0,

      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 16,
              color: Theme.of(context).primaryColor,
              shape: StadiumBorder(),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('/PostProblem');
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'POST YOUR PROBLEM',
                    textScaleFactor: 1.2,
                  )),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: RaisedButton(
                  color: Colors.white,
                  textColor: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'NEWS FEED',
                          textScaleFactor: 1.2,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Transform.rotate(
                            angle: 90 * math.pi / 180,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).accentColor,
                            )),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: FutureBuilder(
                future: _allPosts,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data.error != null && snapshot.data.error.length > 0){
                      buildErrorWidget(snapshot.data.error);
                    }
                    return _postListWidget(snapshot.data.posts);
                  } else if (snapshot.hasError) {
                    return buildErrorWidget(snapshot.error);
                  } else {
                    return buildLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _postListWidget(List<Post> posts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        Post post = posts[index];
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('EEEE').format(post.time),
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      Text(DateFormat('d MMM yyyy').format(post.time)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat('h:mm a').format(post.time),
                        textScaleFactor: 1.5,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            post.body, maxLines: 4, overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          height: 25,
                          width: 100,
                          child: MaterialButton(
                            shape: StadiumBorder(),
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            onPressed: () {Navigator.of(context).pushNamed('/PostDetails', arguments: RouteArgument(param: post));},
                            child: Text(
                              'Read More',
                              textScaleFactor: .8,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}



