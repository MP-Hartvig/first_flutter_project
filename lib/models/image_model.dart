import 'dart:typed_data';

class ImageModel {
  final Uint8List image;
  final String description;
  final String fileType;
  final String fileName;

  ImageModel({
    required this.image,
    required this.description,
    required this.fileType,
    required this.fileName,
  });
}
