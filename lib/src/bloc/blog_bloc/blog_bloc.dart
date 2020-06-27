import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app_bloc/src/models/post.dart';
import 'package:blog_app_bloc/src/repository/blog_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository _blogRepository;
  StreamSubscription _blogSubscription;

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
    } else if (event is AddPost) {
      yield* _mapAddPostToState(event);
    } else if (event is BlogUpdated) {
      yield* _mapBlogUpdatedToState(event);
    }
  }

  Stream<BlogState> _mapLoadBlogToState() async* {
    yield BlogLoading();
    _blogSubscription?.cancel();
    try {
      _blogSubscription = _blogRepository.getPosts().listen(
        (posts) => add(BlogUpdated(posts))
      );
    } catch (_) {
      yield BlogNoLoaded();
    }
  }

  Stream<BlogState> _mapAddPostToState(AddPost event) async* {
    await _blogRepository.putPost(event.image, event.description);
  }

  Stream<BlogState> _mapBlogUpdatedToState(BlogUpdated event) async* {
    yield BlogLoaded(event.posts);
  }

  @override
  Future<void> close() {
    _blogSubscription?.cancel();
    return super.close();
  }
}
