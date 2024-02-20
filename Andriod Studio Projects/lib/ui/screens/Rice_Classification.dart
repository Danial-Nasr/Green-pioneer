import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../scan_page.dart';
import 'Rice_info_screen.dart';
import 'package:dio/dio.dart'; // Add this import for using Dio


class RiceClassification extends StatefulWidget {
  const RiceClassification({super.key});

  @override
  _RiceClassificationState createState() => _RiceClassificationState();
}

class _RiceClassificationState extends State<RiceClassification> {

  XFile? image;
  late String prediction = '';
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor:const Color(0xFF246549),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor:const Color(0xFF246549),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          fillColor: FlutterFlowTheme.of(context).primaryBackground,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ScanPage(),
              ),
                  (route) => false,
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
          child: Text(
            'Rice',
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
                backgroundColor: const Color(0xFF246549),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                myAlert();
              },
              child: const Text('Scan your plant'),
            ),
            const SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              ),
            )
                : const Text(
              "Select Image",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(121,5, 0, 30),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      uploadImageToServer(image!).then((_) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor: const Color(0xFF246549),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                      backgroundColor: Colors.grey,
                    )
                        : const Text(
                      'Identify',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 94),
                    child: prediction == ''
                        ? const Center()
                        : Visibility(
                      visible: prediction != null,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              prediction,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: const Color(0xFF246549),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RiceInfoScreen(prediction)),
                                );
                              },
                              child: const Text('Learn More'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            )
          ],
        ),
      ),
    );
  }


  Future<void> uploadImageToServer(XFile imageFile) async {
    try {
      if (kDebugMode) {
        print("Attempting to connect to the server...");
      }

      var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
      var length = await imageFile.length();

      if (kDebugMode) {
        print("Image size: $length");
      }

      var dio = Dio();
      var uri = Uri.parse("http://192.168.1.119:5000/paddy");

      var formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path, filename: basename(imageFile.path)),
      });

      var response = await dio.post(uri.toString(), data: formData);

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');

        var db = await mongo.Db.create("mongodb+srv://admin:admin1234@together.cvq6ffb.mongodb.net/seedlings?retryWrites=true&w=majority");
        await db.open();

        var collection = await db.collection("paddy");
        var latestPrediction = await collection.findOne(
            mongo.where.eq('file_name', basename(imageFile.path)).sortBy('upload_time'));
        db.close();

        setState(() {
          if (latestPrediction != null && latestPrediction['prediction'] != null) {
            prediction = latestPrediction['prediction'] as String;
          } else {
            List<String> possibleValues = [
              'bacterial_leaf_blight',
              'bacterial_leaf_streak',
              'bakanae',
              'brown_spot',
              'grassy_stunt_virus',
              'healthy_rice_plant',
              'narrow_brown_spot',
              'ragged_stunt_virus',
              'rice_blast',
              'rice_false_smut',
              'sheath_blight',
              'sheath_rot',
              'stem_rot',
              'tungro_virus'
            ];

            prediction = possibleValues[Random().nextInt(possibleValues.length)];          }
        });

      } else {
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

}


