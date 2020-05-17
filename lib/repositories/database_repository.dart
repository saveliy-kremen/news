import 'package:news/providers/database/database_provider.dart';
import 'package:news/models/comment.dart';
import 'package:news/models/post.dart';

class DatabaseRepository {
  final dbProvider = DatabaseProvider.dbProvider;

  Future getAllPosts() => dbProvider.getPosts();

  Future savePost(Post post) => dbProvider.savePost(post);

  Future getAllComments() => dbProvider.getComments();

  Future saveComment(Comment comment) => dbProvider.saveComment(comment);
}
