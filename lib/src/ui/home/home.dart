import 'package:blog_app_bloc/src/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app_bloc/src/repository/blog_repository.dart';
import 'package:blog_app_bloc/src/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final BlogRepository _blogRepository = BlogRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogBloc>(
      create: (context) => BlogBloc(blogRepository: _blogRepository)
                            ..add(LoadBlog()),
      child: Scaffold(
        appBar: AppBar(title: Text("Home"),),
        body: HomePage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addPost'),
          child: Icon(Icons.add),
          tooltip: 'Add post',
        ),
      )
    );
  }
}