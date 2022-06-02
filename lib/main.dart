import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unsplash_app/blocs/photos/photos_bloc.dart';
import 'package:flutter_unsplash_app/repositories/repositories.dart';
import 'package:flutter_unsplash_app/screens/photo_screen.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PhotoRepository(),
      child: BlocProvider(
        create: (context) =>
            PhotosBloc(photoRepository: context.read<PhotoRepository>())
              ..add(PhotosSearchPhotos(query: 'programming')),
        child: MaterialApp(
          title: 'Flutter Photos App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: PhotoScreen(),
        ),
      ),
    );
  }
}
