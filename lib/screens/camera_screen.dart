import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:flutter_instagram/models/camera_state.dart';
import 'package:flutter_instagram/screens/share_post_screen.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  final CameraState _cameraState = CameraState();

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void dispose() {
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("나머지 : ${(size!.height * 0.15) - (size!.height * 0.13)}");
    double circlePosition = ((size!.height * 0.15) - (size!.height * 0.13)) / 2;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Consumer<CameraState>(
          builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  width: size!.width,
                  height: size!.height * 0.7,
                  color: Colors.black,
                  child: value.isReadyToTakePhoto
                      ? CameraPreview(value.cameraController)
                      : CircularProgressIndicator(),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: Align(
                      child: InkWell(
                        onTap: () {
                          if (value.isReadyToTakePhoto) {
                            _attemptTakePhoto(value, context);
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: size!.height * 0.13,
                              height: size!.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              left: circlePosition,
                              top: circlePosition,
                              child: Container(
                                width: size!.height * 0.11,
                                height: size!.height * 0.11,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 4,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    try {
      XFile pictureTaken = await cameraState.cameraController.takePicture();

      File imageFile = File(pictureTaken.path);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
    } catch (e) {}
  }

// void onTakePictureButtonPressed() {
//   takePicture().then((XFile? file) {
//     if (mounted) {
//       setState(() {
//         imageFile = file;
//         print("사진 잘 찍힘 : ${imageFile!.path}");
//       });
//       if (file != null) showInSnackBar('Picture saved to ${file.path}');
//     }
//   });
// }
//
// Future<XFile?> takePicture() async {
//   final CameraController? cameraController = _controller;
//   if (cameraController == null || !cameraController.value.isInitialized) {
//     showInSnackBar('Error: select a camera first.');
//     return null;
//   }
//
//   if (cameraController.value.isTakingPicture) {
//     // A capture is already pending, do nothing.
//     return null;
//   }
//
//   try {
//     XFile file = await cameraController.takePicture();
//     return file;
//   } on CameraException catch (e) {
//     _showCameraException(e);
//     return null;
//   }
// }
//
// void showInSnackBar(String message) {
//   // ignore: deprecated_member_use
//   _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
// }
//
// void _showCameraException(CameraException e) {
//   logError(e.code, e.description);
//   showInSnackBar('Error: ${e.code}\n${e.description}');
// }
//
// void logError(String code, String? message) {
//   if (message != null) {
//     print('Error: $code\nError Message: $message');
//   } else {
//     print('Error: $code');
//   }
// }
}
