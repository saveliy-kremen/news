part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {
  @override
  List<Object> get props => [];
}

class PostsSuccess extends PostsState {
  final List<Post> posts;

  const PostsSuccess([this.posts = const []]);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'PostsLoadSuccess { posts: $posts }';
}

class PostsError extends PostsState {
  final Response error;

  const PostsError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => error.toString();
}
