import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String image, description, date, time, id;

  const Post(this.image, this.description, this.date, this.time, this.id);

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    return Post(
      snapshot.data['image'],
      snapshot.data['description'],
      snapshot.data['date'],
      snapshot.data['time'],
      snapshot.documentID
    );
  }
}