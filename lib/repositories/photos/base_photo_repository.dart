import 'package:flutter_unsplash_app/models/models.dart';
import 'package:flutter_unsplash_app/repositories/base_repository.dart';

abstract class BasePhotoRepository extends BaseRepository {
  Future<List<Photo>> searchPhotos({required String query, int page});
}
