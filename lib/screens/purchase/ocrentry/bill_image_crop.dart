import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/bloc/transactionBloc.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/response/transactionResponse.dart';
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
  CroppedFile? _croppedFile;
  String scannedText = "";
  bool textScanning = false;
  TransactionBloc? _bloc;
  int? invId;
  Preference prefs = Preference();

  @override
  void initState() {
    _bloc = TransactionBloc();
    getCredits();
    super.initState();
  }

  Future<void> getCredits() async {
    invId = await prefs.getInvid();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String market = arguments['market'];
    return Scaffold(
      appBar: const NestedAppBar(title: "Scan bill"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose from :",
                style: TextStyle(fontSize: 21),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  camerabtn(Icons.photo_camera, "Camera", market),
                  const SizedBox(
                    width: 10,
                  ),
                  gallerybtn(Icons.collections, "Gallery", market)
                ],
              ),
              StreamBuilder<TransactionResponse<OCRCreate>>(
                stream: _bloc?.ocrCreateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data?.status) {
                      case Status.LOADING:
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      case Status.COMPLETED:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, Routes.ocrDetail,
                              arguments: {'ocrData': snapshot.data?.data});
                        });
                        break;
                      case Status.ERROR:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            snapshot.data!.msg,
                            style: const TextStyle(fontSize: 20),
                          )));
                        });
                        break;
                      default:
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                    }
                  }
                  return const SizedBox(
                    height: 0,
                  );
                },
              ),
              if (textScanning) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  // function

  Future<void> _uploadImageFromCamera(String market) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
    _cropImage(market);
  }

  Future<void> _uploadImageFromGallery(String market) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
    _cropImage(market);
  }

  Future<void> _cropImage(String market) async {
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
          _croppedFile = croppedFile;
        });
        XFile? finalpic = XFile(_croppedFile!.path);
        getRecognisedText(finalpic, market);
      }
    }
  }

//   Image grayscale(Image src) {
//   var p = src.getBytes();
//   for (var i = 0, len = p.length; i < len; i += 4) {
//     var l = getLuminanceRgb(p[i], p[i + 1], p[i + 2]);
//     p[i] = l;
//     p[i + 1] = l;
//     p[i + 2] = l;
//   }
//   return src;
// }

  void getRecognisedText(XFile? image, String market) async {
    final inputImage = InputImage.fromFilePath(image!.path);
    final textDetector = TextRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
        print(line.text);
      }
      print("======");
    }
    textScanning = false;
    print("-----------------");
    // print(scannedText);

    print("-----------------");
    setState(() {});
    if (scannedText != null) {
      _bloc?.ocrCreate(scannedText, market, invId!);
    }
  }
  // widgets

  Expanded camerabtn(IconData icondata, String text, String market) {
    return Expanded(
      child: MaterialButton(
        minWidth: double.infinity,
        color: AppColors.greenShade,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          _uploadImageFromCamera(market);
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
                style: const TextStyle(fontSize: 24, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded gallerybtn(IconData icondata, String text, String market) {
    return Expanded(
      child: MaterialButton(
        minWidth: double.infinity,
        color: AppColors.greenShade,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          _uploadImageFromGallery(market);
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
                style: const TextStyle(fontSize: 24, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
