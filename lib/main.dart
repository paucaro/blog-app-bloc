import 'package:blog_app_bloc/src/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app_bloc/src/bloc/simple_delegate_bloc.dart';
import 'package:blog_app_bloc/src/repository/blog_repository.dart';
import 'package:blog_app_bloc/src/ui/home/home.dart';
import 'package:blog_app_bloc/src/ui/photo_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogBloc>(
        create: (context) {
          return BlogBloc(blogRepository: BlogRepository())..add(LoadBlog());
        },
        child: MaterialApp(
          title: "Blog App II",
          theme: ThemeData(
              primarySwatch: Colors.red, accentColor: Colors.redAccent),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => Home(),
            '/addPost': (context) {
              return PhotoUpload(
                onSave: (image, description) {
                  BlocProvider.of<BlogBloc>(context).add(AddPost(image, description));
                },
              );
            }
          },
        ));
  }
}
