import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_instagram/constants/screen_size.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  @override
  Widget build(BuildContext context) {
    //print("나머지 : ${(size!.height * 0.15) - (size!.height * 0.13)}");
    double circlePosition = ((size!.height * 0.15) - (size!.height * 0.13)) / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<CameraDescription>>(
          future: availableCameras(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Container(
                  width: size!.width,
                  height: size!.height * 0.7,
                  color: Colors.black,
                  child: snapshot.hasData
                      ? _getPreview(snapshot.data!)
                      : CircularProgressIndicator(),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: Align(
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              width: size!.height * 0.13,
                              height: size!.height * 0.13,
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
              ],
            );
          }),
    );
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    return FutureBuilder(
        future: _controller!.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
