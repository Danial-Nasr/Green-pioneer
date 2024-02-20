import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:plantapp/const/constant.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;


class Flowers extends StatefulWidget {
  const Flowers({super.key});

  @override
  _FlowersState createState() => _FlowersState();
}

class _FlowersState extends State<Flowers> {
  XFile? image;
  bool IsSent = false;
  late String prediction = '';
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
        backgroundColor: Color(0xFF246549),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
          child: Text(
            'Flowers',
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
                          'Recognize Your Flowers  ',
                          style: TextStyle(
                              color:Colors.white,
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
                          'Select Flower image',
                          style: TextStyle(
                              color:Colors.white,
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
                            backgroundColor:Color(0xFF246549),
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
                  color:Colors.grey[200], // Customize the background color
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
                      'Prediction:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height:2), // Add some spacing
                    Text(
                      prediction,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Customize the text color
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
    var uri = Uri.parse("http://192.168.1.2:5000/flowers");

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

      var collection = await db.collection("flower");
      var latestPrediction = await collection.findOne(
          mongo.where.eq('file_name', basename(imageFile.path)).sortBy('upload_time'));
      db.close();

      setState(() {
        if (latestPrediction != null && latestPrediction['prediction'] != null) {
          prediction = latestPrediction['prediction'] as String;
        } else {
          prediction = 'Prediction not available';
        }
      });

    } else {
      print('Image upload failed with status code ${response.statusCode}');
    }



  }

}





























