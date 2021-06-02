import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:image_picker/image_picker.dart';

class PhotoView extends StatefulWidget {
  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  final ImagePicker _picker = ImagePicker();
  PickedFile? _image;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(common_xxs_gap),
                child: Container(
                  width: size!.width,
                  height: size!.width,
                  child: FlutterLogo(),
                ),
              ),
              Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.picture_in_picture,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _getImage();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/camera");
                        }),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 11,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemBuilder: (context, index) => FlutterLogo(),
                ),
              ),
            ],
          );
        });
  }

  Future _getImage() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
