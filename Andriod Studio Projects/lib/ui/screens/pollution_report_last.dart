import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../scan_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Pollution_Info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pollution Report App',
      home: ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String prediction = "";
  double latitude = 0.0;
  double longitude = 0.0;
  Set<Marker> markers = {}; // Add this line
  late GoogleMapController mapController;// Add this line

  Future<void> uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final request = http.MultipartRequest(
      "post",
      Uri.parse("http://192.168.1.119:5000/report"),
    );
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      pickedImage.path,
    ));

    final response = await request.send();
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(await response.stream.bytesToString());

      setState(() {
        prediction = decodedResponse['prediction'];
        latitude = decodedResponse['latitude'];
        longitude = decodedResponse['longitude'];
        markers = {
          Marker(
            markerId: MarkerId('uploadedLocation'),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: 'Uploaded Location',
              snippet: 'Prediction: $prediction',
            ),
          ),
        };

      });
    } else {
      print('Failed to upload image or retrieve data.');
    }
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
            'Pollution Report',
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
          children: <Widget>[
            Icon(Icons.location_on,
            size: 100,
            color:const Color(0xFFCE0404)),
            Text("Get Your Current Location",style:TextStyle(
                fontSize:25,
                fontWeight:FontWeight.bold,
                )),
            SizedBox(height: 80.0),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text('Upload Image'),
              style:ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCE0404),
              ),
            ),
            SizedBox(height: 20.0),
            Text('Latitude: $latitude',style:TextStyle(fontSize:20),),
            Text('Longitude: $longitude',style:TextStyle(fontSize:20),),
            SizedBox(height: 50.0),
            Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 90),
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
                                fontSize: 25,
                                color:Color(0xFFFD0000)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor:  Color(0xFFE31D1D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PollutionInfo(prediction)),
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

            // Container(
            //   height: 200.0,
            //   width: 300.0,
            //   child: GoogleMap(
            //     initialCameraPosition: CameraPosition(
            //       target: LatLng(latitude, longitude),
            //       zoom: 14.0,
            //     ),
            //     markers: markers,
            //     onMapCreated: (GoogleMapController controller) {
            //       mapController = controller;
            //     },
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
