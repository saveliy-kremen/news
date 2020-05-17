part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class CommentsLoad extends CommentsEvent {
  final Post post;

  const CommentsLoad(this.post);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Comments load event';
}
