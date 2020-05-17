import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news/models/comment.dart';
import 'package:news/models/post.dart';
import 'package:news/providers/networking/Repsonse.dart';
import 'package:news/repositories/comments_repository.dart';
import 'package:news/repositories/database_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository commentsRepository;
  final DatabaseRepository databaseRepository;

  CommentsBloc(
      {@required this.commentsRepository, @required this.databaseRepository});

  @override
  CommentsState get initialState => CommentsInitial();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is CommentsLoad) {
      yield* _mapCommentsLoadToState(event.post);
    }
  }

  Stream<CommentsState> _mapCommentsLoadToState(Post post) async* {
    try {
      yield CommentsLoading();
      final List<Comment> comments =
          await commentsRepository.fetchComments(post.id);
      comments.forEach((item) => databaseRepository.saveComment(item));
      var savedComments = await databaseRepository.getAllComments();
      savedComments.forEach((item) => print(item));
      yield CommentsSuccess(comments);
    } catch (e) {
      yield CommentsError(Response.error(e.toString()));
      print(e);
    }
  }
}
