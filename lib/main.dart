import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MyApp(),
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
  File? _image;
  final List<Image> _imageList = <Image> [];

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final tempImg = File(image.path);

    setState(() {
      _image = tempImg;
      _imageList.add(Image.file(tempImg, width: 200, height: 200,));
      _showMyDialog();
    });
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Image information'),
        content: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Work in progress.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
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
              customButton(title: "Pick from gallery", icon: Icons.image_outlined, onClick: getImage),
              const SizedBox(
                height: 40,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int index) {
                  return _imageList[index];
                },
                itemCount: _imageList.length,
              )
            ],
          ),

          // body: Center(
          //   child: Column(children: [
          //     const SizedBox(
          //       height: 40,
          //     ),
          //     customButton(
          //         icon: Icons.image_outlined,
          //         title: "Pick from gallery",
          //         onClick: getImage),
          //     _image != null ? Image.file(_image!, width: 250, height: 250) : const Image( image: AssetImage('images/image3.jpg'), width: 250, height: 250),
          //     const SizedBox(
          //       height: 40,
          //     ),
          // ]),
          // ),
        );
  }
}

// foreach over image list

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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// late List<Image> fileResultList = [
//   const Image(
//     image: AssetImage('images/image2.jpg'),
//     fit: BoxFit.cover,
//   ),
//   const Image(
//     image: AssetImage('images/image3.jpg'),
//     fit: BoxFit.cover,
//   ),
//   const Image(
//     image: AssetImage('images/image4.jpg'),
//     fit: BoxFit.cover,
//   ),
// ];
// late List<File> fileList;

// void _uploadPicture() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();

//   if (result != null) {
//     PlatformFile pFile = result.files.first;
//     File file = File(pFile.path!);
//     fileResultList.add(Image.file(file));
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return GestureDetector(onTap: () {}
// appBar: AppBar(
//   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//   title: Text(widget.title),
// ),
// body: GridView.count(
//   // Create a grid with 2 columns. If you change the scrollDirection to
//   // horizontal, this produces 2 rows.
//   crossAxisCount: 3,
//   children: [...fileResultList.reversed],
// ),
// floatingActionButton: FloatingActionButton(
//   onPressed: _uploadPicture,
//   tooltip: 'Add pictures',
//   child: const Icon(Icons.add),
// ), // This trailing comma makes auto-formatting nicer for build methods.
//         );
//   }
// }

// This is the theme of your application.
//
// TRY THIS: Try running your application with "flutter run". You'll see
// the application has a blue toolbar. Then, without quitting the app,
// try changing the seedColor in the colorScheme below to Colors.green
// and then invoke "hot reload" (save your changes or press the "hot
// reload" button in a Flutter-supported IDE, or press "r" if you used
// the command line to start the app).
//
// Notice that the counter didn't reset back to zero; the application
// state is not lost during the reload. To reset the state, use hot
// restart instead.
//
// This works for code too, not just values: Most code changes can be
// tested with just a hot reload.

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

// This call to setState tells the Flutter framework that something has
// changed in this State, which causes it to rerun the build method below
// so that the display can reflect the updated values. If we changed
// _counter without calling setState(), then the build method would not be
// called again, and so nothing would appear to happen.

// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.

// Column is also a layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).
//
// TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// action in the IDE, or press "p" in the console), to see the
// wireframe for each widget.
