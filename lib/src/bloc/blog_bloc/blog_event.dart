part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class LoadBlog extends BlogEvent {}

class AddPost extends BlogEvent {
  final File image;
  final String description;

  const AddPost(this.image, this.description);

  @override
  List<Object> get props => [image, description];

  @override
  String toString() => 'Adding posts';
}

class BlogUpdated extends BlogEvent {
  final List<Post> posts;

  const BlogUpdated(this.posts);

  @override
  List<Object> get props => [posts];
}