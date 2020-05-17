import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news/models/post.dart';
import 'package:news/providers/networking/Repsonse.dart';
import 'package:news/repositories/database_repository.dart';
import 'package:news/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;
  final DatabaseRepository databaseRepository;

  PostsBloc(
      {@required this.postsRepository, @required this.databaseRepository});

  @override
  PostsState get initialState => PostsInitial();

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is PostsLoad) {
      yield* _mapPostsLoadToState();
    }
  }

  Stream<PostsState> _mapPostsLoadToState() async* {
    try {
      yield PostsLoading();
      final List<Post> posts = await postsRepository.fetchPosts();
      posts.forEach((item) => databaseRepository.savePost(item));
      var savedPosts = await databaseRepository.getAllPosts();
      savedPosts.forEach((item) => print(item));
      yield PostsSuccess(posts);
    } catch (e) {
      yield PostsError(Response.error(e.toString()));
      print(e);
    }
  }
}
