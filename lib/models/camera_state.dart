import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraState extends ChangeNotifier {
  CameraController? _cameraController;
  CameraDescription? _cameraDescription;
  bool _readyTakePhoto = false;

  void dispose() {
    if (_cameraController != null) _cameraController!.dispose();
    _cameraController = null;
    _cameraDescription = null;
    _readyTakePhoto = false;
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      setCameraDescription(cameras.first);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }

    _readyTakePhoto = true;
    notifyListeners(); //
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _cameraController =
        CameraController(_cameraDescription!, ResolutionPreset.medium);
  }

  Future<bool> initialize() async {
    try {
      await _cameraController!.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController get cameraController => _cameraController!;
  CameraDescription get cameraDescription => _cameraDescription!;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}
