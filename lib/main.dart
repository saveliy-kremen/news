import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/comments/comments_bloc.dart';
import 'package:news/blocs/posts/posts_bloc.dart';
import 'package:news/repositories/comments_repository.dart';
import 'package:news/repositories/database_repository.dart';
import 'package:news/repositories/posts_repository.dart';
import 'package:news/screens/posts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PostsBloc>(create: (context) {
        return PostsBloc(
            postsRepository: PostsRepository(),
            databaseRepository: DatabaseRepository());
      }),
      BlocProvider<CommentsBloc>(create: (context) {
        return CommentsBloc(
            commentsRepository: CommentsRepository(),
            databaseRepository: DatabaseRepository());
      }),
    ], child: MaterialApp(title: 'News', home: Posts()));
  }
}
