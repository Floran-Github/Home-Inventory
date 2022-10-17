import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/widget/nestedappbar.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class BillImageCrop extends StatefulWidget {
  const BillImageCrop({super.key});

  @override
  State<BillImageCrop> createState() => _BillImageCropState();
}

class _BillImageCropState extends State<BillImageCrop> {
  XFile? _pickedFile;
  XFile? _croppedFile;
  String scannedText = "";
  bool textScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(title: "Scan bill"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose from :",
                style: TextStyle(fontSize: 21),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  camerabtn(Icons.photo_camera, "Camera"),
                  const SizedBox(
                    width: 10,
                  ),
                  gallerybtn(Icons.collections, "Gallery")
                ],
              ),
              if (textScanning) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  // function

  Future<void> _uploadImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
    _cropImage();
  }

  Future<void> _uploadImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
    _cropImage();
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile as XFile?;
        });
        getRecognisedText(_croppedFile);
      }
    }
  }

  void getRecognisedText(XFile? image) async {
    final inputImage = InputImage.fromFilePath(image!.path);
    final textDetector = TextRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    textScanning = false;
    print("-----------------");
    print(scannedText);
    print("-----------------");
    setState(() {});
  }
  // widgets

  Expanded camerabtn(IconData icondata, String text) {
    return Expanded(
      child: MaterialButton(
        minWidth: double.infinity,
        color: AppColors.greenShade,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          _uploadImageFromCamera();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icondata,
                size: 44,
                color: AppColors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 24, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded gallerybtn(IconData icondata, String text) {
    return Expanded(
      child: MaterialButton(
        minWidth: double.infinity,
        color: AppColors.greenShade,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          _uploadImageFromGallery();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icondata,
                size: 44,
                color: AppColors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 24, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
