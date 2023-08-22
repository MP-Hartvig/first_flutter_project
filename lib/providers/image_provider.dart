import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageModelProvider extends ChangeNotifier{
  final List<ImageModel> _imageList = [];

  UnmodifiableListView<ImageModel> get imageList => UnmodifiableListView(_imageList);

  void add(ImageModel imgModel) {
    _imageList.add(imgModel);
    notifyListeners();
  }
}