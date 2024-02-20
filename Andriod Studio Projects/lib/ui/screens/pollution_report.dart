import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantapp/const/constant.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;


class pollutionReport extends StatefulWidget {
  const pollutionReport({super.key});

  @override
  _pollutionReportState createState() => _pollutionReportState();
}

class _pollutionReportState extends State<pollutionReport> {
  XFile? image;
  bool IsSent = false;
  late String prediction = '';
  late double latitude=0;
  late double longitude=0;

  final ImagePicker picker = ImagePicker();

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
                      backgroundColor:Color(0xFF246549),
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
                      backgroundColor:Color(0xFF246549),
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor:Color(0xFF246549),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
          child: Text(
            'Pollution Report',
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Container(
                height: 280,
                width: 400,
                child: Card(
                  color: Color(4283996538),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 90.0),
                        child: Text(
                          'Take an action, Save the Planet',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      // Select Image Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 40),
                          backgroundColor:Color(0xFF246549),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          myAlert();
                        },
                        child: const Text(
                          'Select pollution image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            //if image not null show the image & if image null show text
            image != null
                ? Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              ),
            )
                : const Text(""),
            // Submit Report Button
            Center(
              child: SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor:Color(0xFF246549),
                    ),
                    onPressed: image != null ?  () {
                      uploadImageToServer(image!);
                      if (IsSent) {
                        Fluttertoast.showToast(
                            msg: "Submitted Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                            FlutterFlowTheme
                                .of(context)
                                .primaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } : null,
                    // Disable the button if image is null
                    // Set onPressed to null when image is null
                    child: const Text(
                      "Submit Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),

                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical:10), // Add margin for spacing
                padding: EdgeInsets.all(16), // Add padding to the container
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Customize the background color
                  borderRadius: BorderRadius.circular(12), // Customize the border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Add a subtle shadow
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Prediction: $prediction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Latitude: $latitude',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Longitude: $longitude',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                  ],
                ),
              ),
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
    // var uri = Uri.parse("http://ec2-3-217-210-251.compute-1.amazonaws.com:9874/flowers");
    var uri = Uri.parse("http://192.168.1.2:5000/report");

    if (kDebugMode) {
      print("connection established.");
    }
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    final response = await request.send();
    if (response.statusCode != 200) {
      // Handle the case where the server responded with an error.
      return;
    }

    final responseBody = await response.stream.bytesToString();

    try {
      final resJson = jsonDecode(responseBody);
      final classLabel = resJson['class_label'] as String?;
      final confidence = resJson['confidence'] as double?;
      var latitude = resJson['latitude'] as double?;
      var longitude = resJson['longitude'] as double?;



      if (classLabel != null && confidence != null && latitude!= null && longitude!=null) {
        setState(() {
          prediction = classLabel;
          latitude = latitude;
          longitude = longitude;

        });

      } else {
        setState(() {
          prediction = "Invalid response format";
        });
      }
    } catch (e) {
      setState(() {
        prediction = "Error parsing response: $e";
      });
    }



  }

}





























