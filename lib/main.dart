import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'models/image_model.dart';
import 'package:first_flutter_project/providers/image_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageModelProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PickImage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImagePickerApp(),
    );
  }
}

class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({super.key});

  @override
  State<ImagePickerApp> createState() => _ImagePickerApp();
}

class _ImagePickerApp extends State<ImagePickerApp> {
  XFile? _file;
  late List<ImageModel> imageList = <ImageModel>[];
  late TextEditingController descriptionController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  late ImageModel imageModel;

  Future getImage() async {
    _file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_file == null) return;

    setState(() {
      _showMyDialog();
    });
  }

  void _showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image information'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.file(File(_file!.path)),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                imageModel = ImageModel(
                    fileName: _file!.name,
                    fileType: _file!.mimeType != null ? _file!.mimeType! : '',
                    description: descriptionController.text,
                    image: File(_file!.path).readAsBytesSync());
                Provider.of<ImageModelProvider>(context, listen: false)
                    .add(imageModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImageModelProvider provider =
        Provider.of<ImageModelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text("Pick an image"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          customButton(
              title: "Pick from gallery",
              icon: Icons.image_outlined,
              onClick: getImage),
          const SizedBox(
            height: 40,
          ),
          DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text("Image"),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text("Description"),
                ),
              ),
            ],
            rows: provider.imageList
                .map(
                  (ImageModel imgModel) => DataRow(cells: [
                    DataCell(OutlinedButton(
                        onPressed: () => {
                              showImageFullscreenWithClose(
                                  image: imgModel.image, context: context)
                            },
                        child: Image.memory(imgModel.image))),
                    DataCell(
                      OutlinedButton(
                        onPressed: () => {
                          showImageDetails(
                              description: imgModel.description,
                              fileName: imgModel.fileName,
                              fileType: imgModel.fileType,
                              context: context)
                        },
                        child: Text(imgModel.description),
                      ),
                    ),
                  ]),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget customButton(
    {required String title,
    required IconData icon,
    required VoidCallback onClick}) {
  return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(children: [Icon(icon), Text(title)]),
      ));
}

void showImageFullscreenWithClose(
    {required Uint8List image, required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Image.memory(image),
        );
      });
}

void showImageDetails(
    {required String description,
    required String fileName,
    required String fileType,
    required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: 250,
          child: Column(
            children: [
              Row(children: [
                Text("Description: $description"),
              ]),
              Row(children: [
                Text("File name: $fileName"),
              ]),
              Row(children: [
                Text("File type: $fileType"),
              ]),
            ],
          ),
        ),
      );
    },
  );
}
