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
      mapEventToState(event);
    });
  }

  @override
  Future<void> close() {
    _photoRepository.dispose();
    return super.close();
  }

  Stream<PhotosEvent> mapEventToState(
    PhotosEvent event,
  ) async* {
    if (event is PhotosSearchPhotos) {}
  }

  Stream<PhotosState> _mapPhotosSearchPhotos() async* {}
}
