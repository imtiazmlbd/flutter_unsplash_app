import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash_app/models/models.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;

  const PhotoCard({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
        image: DecorationImage(
          image: CachedNetworkImageProvider(photo.url),
          fit: BoxFit.cover,
        ),
      ),
    );
    ;
  }
}
