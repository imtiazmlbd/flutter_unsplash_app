import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unsplash_app/blocs/photos/photos_bloc.dart';
import 'package:flutter_unsplash_app/models/models.dart';
import 'package:flutter_unsplash_app/repositories/photos/photo_repository.dart';
import 'package:flutter_unsplash_app/widget/photo_card.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Photos'),
        ),
        body: BlocBuilder<PhotosBloc, PhotosState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          context
                              .read<PhotosBloc>()
                              .add(PhotosSearchPhotos(query: val.trim()));
                        }
                      },
                    ),
                    if (state.status == PhotoStatus.success)
                      Expanded(
                        child: state.photos.isNotEmpty
                            ? GridView.builder(
                                padding: const EdgeInsets.all(20.0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 15.0,
                                  crossAxisSpacing: 15.0,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  final photo = state.photos[index];
                                  return PhotoCard(
                                    photos: state.photos,
                                    index: index,
                                    photo: photo,
                                  );
                                },
                                itemCount: state.photos.length,
                              )
                            : const Center(
                                child: Text('No Results'),
                              ),
                      ),
                  ],
                ),
                if (state.status == PhotoStatus.loading)
                  const CircularProgressIndicator()
              ],
            );
          },
        ),
      ),
    );
  }
}
