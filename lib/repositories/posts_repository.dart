import 'package:news/providers/networking/ApiProvider.dart';
import 'package:news/models/post.dart';
import 'dart:async';

class PostsRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<Post>> fetchPosts() async {
    List<Post> posts = [];
    final response = await _provider.get("posts");
    response.forEach((element) => posts.add(Post.fromJson(element)));
    return posts;
  }
}
