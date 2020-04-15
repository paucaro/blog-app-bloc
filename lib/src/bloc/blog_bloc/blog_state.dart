part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

// Tres estados
// 1. Blog loading -> los posts del blog estan cargando
// 2. Blog loaded -> los posts del blog han cargado
// 3. Blog No loaded -> no se pudo cargar los posts

class BlogLoading extends BlogState {
  @override
  String toString() => 'Blog Loading';
}

class BlogLoaded extends BlogState {
  final List<Post> posts;

  const BlogLoaded([this.posts]);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'Blog loaded';
}

class BlogNoLoaded extends BlogState {
  @override
  String toString() => 'Blog No Loaded';
}
