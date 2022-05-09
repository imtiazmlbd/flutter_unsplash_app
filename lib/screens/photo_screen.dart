import 'package:flutter/material.dart';
import 'package:flutter_unsplash_app/models/models.dart';
import 'package:flutter_unsplash_app/repositories/photos/photo_repository.dart';
import 'package:flutter_unsplash_app/widget/photo_card.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  String _query = 'Programming';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Photos'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  setState(() => _query = val.trim());
                }
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: PhotoRepository().searchPhotos(query: _query),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      final List<Photo> photos = snapshot.data as List<Photo>;
                      print(photos);
                      return GridView.builder(
                        padding: const EdgeInsets.all(20.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final photo = photos[index];
                          return PhotoCard(
                            photos: photos,
                            index: index,
                            photo: photo,
                          );
                        },
                        itemCount: photos.length,
                      );
                    }
                    return Container();
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
