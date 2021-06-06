import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();
  List<String> _picImageNames = [];
  String? mainImageFile;

  @override
  void initState() {
    super.initState();
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
                children: List.generate(
                  snapshot.data!.length,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        mainImageFile = snapshot.data!.elementAt(index).path;
                      });
                    },
                    child: Image.file(
                      snapshot.data!.elementAt(index),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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

  void _takePhoto() async {
    PickedFile? pickFile =
        await ImagePicker().getImage(source: ImageSource.camera);

    // setState가 saveImage 함수 아래에 오면 기다리다가
    // 사진 촬영 화면이 꺼져서 함수의 스택이 종료되버려서 반영이 안된다.
    setState(() {
      mainImageFile = pickFile!.path;
    });

    await GallerySaver.saveImage(pickFile!.path);
    print("사진 촬영이 완료되었고 저장되었습니다.");
  }

  Future getPickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        print("선택된 이미지 경로 : ${_image!.path}");
        _fileNameMemSave(_image!.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _fileNameMemSave(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("이미지 경로 prefs에 저장 : ${value}");
    setState(() {
      _picImageNames = [..._picImageNames, "$value"];
      print(_picImageNames.toString());
    });
    // 이 부분은 실제로는 디비에 저장해야 한다.
    await prefs.setStringList('picked', _picImageNames);
  }

  Future<List<String>> _fileNameMemSelect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 이 부분은 실제로는 디비에서 가져와야 한다.
    return prefs.getStringList("picked")!;
  }

  Future<List<File>> getFileImages() async {
    List<String> imageFileList = await _fileNameMemSelect();
    List<File> files = imageFileList.map((e) => File("$e")).toList();
    print("가져올 이미지들 : ${files}");
    try {
      return files;
    } catch (e) {
      throw "파일 읽기 실패";
    }
  }
}
