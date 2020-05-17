import 'dart:async';
import 'dart:io';

import 'package:news/models/comment.dart';
import 'package:news/models/post.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final postsTABLE = 'Posts';
final commentsTABLE = 'Comments';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "News.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $postsTABLE ("
        "id INTEGER PRIMARY KEY, "
        "user_id INTEGER, "
        "title TEXT, "
        "body TEXT "
        ")");
    await database.execute("CREATE TABLE $commentsTABLE ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "email TEXT, "
        "body TEXT, "
        "post_id INTEGER "
        ")");
  }

  //Insert or replace posts records
  Future<int> savePost(Post post) async {
    final db = await dbProvider.database;
    var result = db.insert(postsTABLE, post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //Insert or replace comments records
  Future<int> saveComment(Comment comment) async {
    final db = await dbProvider.database;
    var result = db.insert(commentsTABLE, comment.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //Get all posts
  Future<List<Post>> getPosts({List<String> columns}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(postsTABLE, columns: columns);

    List<Post> posts = result.isNotEmpty
        ? result.map((item) => Post.fromJson(item)).toList()
        : [];
    return posts;
  }

  //Get all comments
  Future<List<Comment>> getComments({List<String> columns}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(commentsTABLE, columns: columns);

    List<Comment> comments = result.isNotEmpty
        ? result.map((item) => Comment.fromJson(item)).toList()
        : [];
    return comments;
  }
}
