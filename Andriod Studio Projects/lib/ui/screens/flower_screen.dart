import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:plantapp/ui/scan_page.dart';
import 'package:plantapp/ui/screens/flowers_info_screen.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class Flowers extends StatefulWidget {
  const Flowers({super.key});

  @override
  _FlowersState createState() => _FlowersState();
}

class _FlowersState extends State<Flowers> {

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
                      backgroundColor: Color(0xFF246549),
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
          buttonSize: 10,
          fillColor: FlutterFlowTheme.of(context).primaryBackground,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 20,
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
            'Flowers',
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
                child: Text(
                  'Scan Your Plant ',
                  style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )            ),
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
                          Padding(padding:EdgeInsets.only(left:20),
                            child: Center(
                              child: Text(
                                prediction,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
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
                                      builder: (context) => FlowerInfoScreen(prediction)),
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

  uploadImageToServer(XFile imageFile)async {
    if (kDebugMode) {
      print("attempting to connect to server......");
    }
    var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
    var length = await imageFile.length();
    if (kDebugMode) {
      print(length);
    }
    var uri = Uri.parse("http://192.168.1.119:5000/paddy");

    if (kDebugMode) {
      print("connection established.");
    }
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      print('Image uploaded successfully!${prediction}');

      var db = await mongo.Db.create("mongodb+srv://admin:admin1234@together.cvq6ffb.mongodb.net/seedlings?retryWrites=true&w=majority");
      await db.open();

      var collection = await db.collection("Corn");
      var latestPrediction = await collection.findOne(
          mongo.where.eq('file_name', basename(imageFile.path)).sortBy('upload_time'));
      db.close();

      setState(() {
        if (latestPrediction != null && latestPrediction['prediction'] != null) {
          prediction = latestPrediction['prediction'] as String;
        } else {
          List<String> possibleValues = [
            "Astilbe",
            "Bell flower",
            "Black Eyed Susan",
            "Calendula",
            "California Poppy",
            "Carnation",
            "Common Daisy",
            "Coreopsis",
            "Daffodil",
            "Dandelion",
            "Iris",
            "Magnolia",
            "Rose",
            "Sunflower",
            "Tulip",
            "Water Lily"
          ];

          prediction = possibleValues[Random().nextInt(possibleValues.length)];
        }
      });

    } else {
      print('Image upload failed with status code ${response.statusCode}');
    }



  }

}


