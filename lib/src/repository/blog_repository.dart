import 'dart:io';

import 'package:blog_app_bloc/src/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class BlogRepository {
  final databaseReference = Firestore.instance.collection("posts");

  Stream<List<Post>> getPosts() {
    return databaseReference.snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Post.fromSnapshot(doc)).toList();
    });
  }

  Future<void> putPost(File image, String description) async {
    // Save image
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("Post Images");
    var timeKey = DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(image);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = imageUrl.toString();

    // Save post
    var formatDate = DateFormat('MMM d, yyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(timeKey);
    String time = formatTime.format(timeKey);
    databaseReference.document().setData(
      {
        'image': url,
        'description': description,
        'date': date,
        'time': time
      }
    );
  }
}
