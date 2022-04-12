import 'dart:convert';
import 'package:flutter_unsplash_app/models/photo_model.dart';
import 'package:flutter_unsplash_app/repositories/photos/base_photo_repository.dart';
import 'package:flutter_unsplash_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_unsplash_app/.env.dart';

class PhotoRepository extends BasePhotoRepository {
  static const String _unSplashBaseUrl = 'https://api.unsplash.com';
  static const int numPerPage = 10;

  final http.Client _httpClient;

  PhotoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<List<Photo>> searchPhotos({
    required String query,
    int page = 1,
  }) async {
    final url =
        '$_unSplashBaseUrl/search/photos?page=$page&per_page=$numPerPage&query=$query&client_id=$unsplashApiKey';
    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> mapData = jsonDecode(response.body);
      final List data = mapData['results'];
      final List<Photo> photos = data.map((e) => Photo.fromMap(e)).toList();
      return photos;
    }
    return [];
  }
}
