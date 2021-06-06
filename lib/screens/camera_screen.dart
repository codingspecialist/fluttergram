import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<String> _picImageNames = [];
  String? mainImageFile;
  bool isCameraState = false;

  @override
  void initState() {
    super.initState();
    initTakePhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            _selectedImage(),
            _pickedOrCameraButton(),
            _pickedImageList()
          ],
        ),
      ),
    );
  }

  Widget _pickedImageList() {
    return Expanded(
      child: FutureBuilder<List<File>>(
          future: getFileImages(),
          builder: (context, snapshot) {
            return Container(
              color: Colors.black,
              padding: EdgeInsets.all(common_xxs_gap),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                children: snapshot.data != null
                    ? List.generate(
                        snapshot.data!.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              mainImageFile =
                                  snapshot.data!.elementAt(index).path;
                            });
                          },
                          child: Image.file(
                            snapshot.data!.elementAt(index),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : [],
              ),
            );
          }),
    );
  }

  Widget _pickedOrCameraButton() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                _takePhoto();
              },
              icon: Icon(Icons.camera_alt_outlined)),
          IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                getPickImage();
              },
              icon: Icon(Icons.picture_in_picture_alt)),
        ],
      ),
    );
  }

  Widget _selectedImage() {
    return Expanded(
      child: Container(
        color: Colors.black,
        width: double.infinity,
        child: mainImageFile != null
            ? Padding(
                padding: const EdgeInsets.all(common_xxs_gap),
                child: Image.file(
                  File(mainImageFile!),
                  fit: BoxFit.cover,
                ),
              )
            : FlutterLogo(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text("새 게시물"),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              "다음",
              style: TextStyle(fontSize: 20),
            )),
      ],
    );
  }

  // GallerySaver.saveImage 함수를 한번 호출함으로써 버그를 잡는다. (최초 사진 저장안되는 버그)
  void initTakePhoto() {
    Uuid uuid = Uuid();
    GallerySaver.saveImage(
        "/data/user/0/com.cos.flutter_instagram/cache/$uuid.jpg");
  }

  void _takePhoto() async {
    PickedFile? pickFile =
        await ImagePicker().getImage(source: ImageSource.camera);

    if (pickFile != null) {
      setState(() {
        mainImageFile = pickFile.path;
      });

      // 갤러리 세이버 최초 사진 저장안되는 버그 잡으려고
      // 함수 스택 종료된 것 때문인가 해서 테스트 해봐도 안됨. 강제로 한번 실행시켜주는 방법밖에 없다. 5시간동안 고생함.
      GallerySaver.saveImage(mainImageFile!, albumName: "Media");
    }
  }

  void getPickImage() async {
    PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      _fileNameMemSave(image.path);
    } else {
      print('No image selected.');
    }
  }

  _fileNameMemSave(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _picImageNames = [..._picImageNames, "$value"];
      print(_picImageNames.toString());
    });
    // 이 부분은 실제로는 디비에 저장해야 한다.
    await prefs.setStringList('pick', _picImageNames);
  }

  Future<List<String>> _fileNameMemSelect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 이 부분은 실제로는 디비에서 가져와야 한다.
    return prefs.getStringList("pick")!;
  }

  Future<List<File>> getFileImages() async {
    List<String> imageFileList = await _fileNameMemSelect();
    List<File> files = imageFileList.map((e) => File("$e")).toList();

    try {
      return files;
    } catch (e) {
      throw "파일 읽기 실패";
    }
  }
}
