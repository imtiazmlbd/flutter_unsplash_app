import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unsplash_app/models/failure_model.dart';
import 'package:flutter_unsplash_app/models/photo_model.dart';
import 'package:flutter_unsplash_app/repositories/photos/photo_repository.dart';
import 'package:meta/meta.dart';

part 'photos_event.dart';

part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoRepository _photoRepository;

  PhotosBloc({required PhotoRepository photoRepository})
      : _photoRepository = photoRepository,
        super(PhotosState.initial()) {
    on<PhotosEvent>((event, emit) {
      //mapEventToState(event);
      if (event is PhotosSearchPhotos) {
        _mapSearchPhotos(event);
      }
    });
  }

  @override
  Future<void> close() {
    _photoRepository.dispose();
    return super.close();
  }

  /*Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    if (event is PhotosSearchPhotos) {
      yield* _mapSearchPhotos(event);
    }
  }*/

  Stream<PhotosState> _mapSearchPhotos(PhotosSearchPhotos event) async* {
    yield state.copyWith(query: event.query, status: PhotoStatus.loading);
    try {
      final photos = await _photoRepository.searchPhotos(query: event.query);
      yield state.copyWith(photos: photos, status: PhotoStatus.success);
    } on Exception catch (err) {
      print(err);
      yield state.copyWith(
          failure: const Failure(message: 'Something went wrong!'),
          status: PhotoStatus.error);
    }
  }
}
