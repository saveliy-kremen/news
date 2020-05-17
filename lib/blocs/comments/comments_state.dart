part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsInitial extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsSuccess extends CommentsState {
  final List<Comment> comments;

  const CommentsSuccess([this.comments = const []]);

  @override
  List<Object> get props => [comments];

  @override
  String toString() => 'CommentsLoadSuccess { comments: $comments }';
}

class CommentsError extends CommentsState {
  final Response error;

  const CommentsError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => error.toString();
}
