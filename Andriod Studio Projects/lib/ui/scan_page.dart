import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:plantapp/ui/screens/Harmful_Insects.dart';
import 'package:plantapp/ui/screens/Rice_Classification.dart';
import 'package:plantapp/ui/screens/Useful%20Insects.dart';
import 'package:plantapp/ui/screens/flower_screen.dart';
import 'package:plantapp/ui/screens/pollution_report_last.dart';
import 'package:plantapp/flutter_flow/flutter_flow_theme.dart';
import 'package:plantapp/ui/screens/seedlings_screen.dart';

class ScanPage extends StatelessWidget {
  Color transparentBlack = Color(0xFF246549).withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF246549),
        title: Text('ScanPage',style:FlutterFlowTheme.of(context).title2.override(
          fontFamily: 'Poppins',
            color: Colors.white,
          fontSize: 20
        ),),
      ),
      body: Container(
        decoration:BoxDecoration(
            color:transparentBlack,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                    child: Text(
                      'Planting Guide',
                      style: FlutterFlowTheme.of(context).bodyLight.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                ContainerWithStack("Flowers", "assets/images/img_flower.png",  Flowers()),
                ContainerWithStack("Seedlings", "assets/images/img_seed.png",  Seedlings()),
                ContainerWithStack("Pollution Report", "assets/images/download (1).png",ImageUploadScreen()),
                ContainerWithStack("Rice", "assets/images/rice-field.jpg",RiceClassification()),
                ContainerWithStack("Useful Insects", "assets/images/742094.jpg",UsefulInsects()),
                ContainerWithStack("Harmful Insects", "assets/images/aweq.jpg",HarmfulInsects()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerWithStack extends StatelessWidget {
  final String title;
  final String imagePath;
  final Widget detailScreen;

  ContainerWithStack(this.title, this.imagePath, this.detailScreen);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the specified detail screen when the container is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => detailScreen,
          ),
        );
      },
      child: Align(
        alignment: AlignmentDirectional(-1.00, 0.00),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(70, 25, 0, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 270,
              height: 133,
              decoration: BoxDecoration(
                color: Color(4283996538),
                borderRadius: BorderRadius.circular(25),
                shape: BoxShape.rectangle,
              ),
              alignment: AlignmentDirectional(0.00, 0.00),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Opacity(
                        opacity:0.78,
                        child: Image.asset(
                          imagePath,
                          width:double.infinity,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(title,style:FlutterFlowTheme.of(context).bodyLight.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 22,
                          color:Colors.white,
                          fontWeight: FontWeight.w700),),)
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
