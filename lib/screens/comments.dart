import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/blocs/comments/comments_bloc.dart';
import 'package:news/models/comment.dart';
import 'package:news/models/post.dart';

class Comments extends StatelessWidget {
  final Post _post;

  Comments(this._post);

  @override
  Widget build(BuildContext context) {
    Completer<Null> completer = new Completer<Null>();
    BlocProvider.of<CommentsBloc>(context).add(CommentsLoad(_post));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Comments',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: RefreshIndicator(
        onRefresh: () {
          completer = new Completer<Null>();
          BlocProvider.of<CommentsBloc>(context).add(CommentsLoad(_post));
          return completer.future;
        },
        child: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is CommentsLoading) {
              return Loading(loadingMessage: "Loading...");
            } else if (state is CommentsSuccess) {
              if (!completer.isCompleted) {
                completer.complete();
              }
              return CommentsList(commentsList: state.comments);
            } else if (state is CommentsError) {
              if (!completer.isCompleted) {
                completer.complete();
              }
              return Error(
                  errorMessage: state.error.message,
                  onRetryPressed: () => BlocProvider.of<CommentsBloc>(context)
                      .add(CommentsLoad(_post)));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<Comment> commentsList;

  const CommentsList({Key key, this.commentsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 1.0,
            ),
            child: Container(
              color: Color(0xFF333333),
              alignment: Alignment.centerLeft,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: Text(
                        commentsList[index].body,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Roboto'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: Text(
                        commentsList[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Roboto'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: Text(
                        commentsList[index].email,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Roboto'),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ]),
            ),
          );
        },
        itemCount: commentsList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
