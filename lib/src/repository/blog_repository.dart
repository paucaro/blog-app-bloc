import 'package:blog_app_bloc/src/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogRepository {
  final databaseReference = Firestore.instance;

  Stream<List<Post>> getPosts() {
    return databaseReference.collection("posts").snapshots()
      .map((snapshot) {
        return snapshot.documents.map((doc) => Post.fromSnapshot(doc)).toList();
      });
  }
}