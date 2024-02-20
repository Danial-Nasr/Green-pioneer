import 'package:flutter/material.dart';
import 'package:plantapp/ui/screens/Useful%20Insects.dart';
import 'package:plantapp/ui/screens/seedlings_screen.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'MyGardenPage.dart';

class UsefulInfoScreen extends StatefulWidget {
  final String prediction;

  const UsefulInfoScreen(this.prediction, {Key? key}) : super(key: key);

  @override
  _UsefulInfoScreenState createState() => _UsefulInfoScreenState();
}

class _UsefulInfoScreenState extends State<UsefulInfoScreen> {
  bool isLoading = true;
  bool isSavedToGarden = false;
  late String plantPhotoUrl;
  late String plantName;
  late String info;
  late String lightNeed;
  late String lightDetails;
  late String wateringNeed;
  late String wateringDetails;
  late String fertlizeNeed;
  late String fertlizeDetails;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getPlantData(widget.prediction);
    checkPlantIsSaved();
  }

  checkPlantIsSaved() {
    // Simulated check for saving the plant to the garden
    // Replace this logic with your data source or Firebase if needed
    setState(() {
      isSavedToGarden = false; // Simulated, set to true if it's saved
    });
  }

  void getPlantData(String prediction) {
    // Simulated plant data, replace with your data source
    setState(() {
      plantPhotoUrl = 'assets/images/aweq.jpg';
      plantName = prediction;
      info = 'Useful insects play a crucial role in maintaining ecological balance by controlling pests and promoting pollination.';
      lightNeed = 'Varies';
      lightDetails = 'Adaptable to different light conditions';
      wateringNeed = 'N/A';
      wateringDetails = 'Does not require watering like plants.';
      fertlizeNeed = 'N/A';
      fertlizeDetails = 'Does not require fertilization.';
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Seedlings(),
                  type: PageTransitionType.bottomToTop,
                ),
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
            child: Text(
              'Insects Information',
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
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: UsefulInsects(),
                  type: PageTransitionType.bottomToTop,
                ),
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
            child: Text(
              'Insects Information',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant Photo
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                child: Image.asset(
                  'assets/images/abcw.jpg',
                  width: 396,
                  height: 210,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plant Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              plantName,
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF19311C),
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'About',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:Color(0xFF246549)
                          ),
                        ),
                      ],
                    ),
                    // Plant Information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: Text(
                              info,
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: Text(
                              'How to Deal With $plantName',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF828882),
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                                child: Text(
                                  'Light',
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color:Color(0xFF246549),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                                child: Text(
                                  lightNeed,
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                                  child: Text(
                                    lightDetails,
                                    style: FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Treatment',
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color:Color(0xFF246549),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  wateringNeed,
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                                  child: Text(
                                    wateringDetails,
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Fertilizing  ',
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color:Color(0xFF246549),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                fertlizeNeed,
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:Colors.white
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                  child: Text(
                                    fertlizeDetails,
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Add To Garden Button
                          if (!isSavedToGarden)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 2),
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
                                    MaterialPageRoute(builder: (context) => MyGardenPage()),
                                  );
                                },
                                child: Text(
                                  'Add to Useful Insects',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
