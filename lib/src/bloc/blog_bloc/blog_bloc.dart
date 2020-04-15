import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app_bloc/src/models/post.dart';
import 'package:blog_app_bloc/src/repository/blog_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository _blogRepository;

  BlogBloc({@required BlogRepository blogRepository})
    : assert(blogRepository != null),
    _blogRepository = blogRepository;

  @override
  BlogState get initialState => BlogLoading();

  @override
  Stream<BlogState> mapEventToState(
    BlogEvent event,
  ) async* {
    if (event is LoadBlog) {
      yield* _mapLoadBlogToState();
    }
  }

  Stream<BlogState> _mapLoadBlogToState() async* {
    yield BlogLoading();
    try {
      final List<Post> posts = await _blogRepository.getPosts().first;
      yield BlogLoaded(posts);
    } catch (_) {
      yield BlogNoLoaded();
    }
  }
}
