import 'package:news/providers/networking/ApiProvider.dart';
import 'dart:async';
import 'package:news/models/comment.dart';

class CommentsRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<Comment>> fetchComments(int id) async {
    List<Comment> comments = [];
    final response = await _provider.get("comments?postId=$id");
    response.forEach((element) => comments.add(Comment.fromJson(element)));
    return comments;
  }
}
