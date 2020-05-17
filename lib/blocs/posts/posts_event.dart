part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class PostsLoad extends PostsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Posts load event';
}
