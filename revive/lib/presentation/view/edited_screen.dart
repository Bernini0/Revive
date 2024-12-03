import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/colorize_image_command.dart';
import 'package:revive/model/selected_top_button_model.dart';
import 'package:revive/model/upload_image_command.dart';
import 'package:revive/presentation/view/AddFilterScreen.dart';
import 'package:revive/presentation/view/ColorizeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/edited_screen_widgets/bottom_bar.dart';
import '../widgets/edited_screen_widgets/image_container_widget.dart';
import '../widgets/edited_screen_widgets/top_bar.dart';

class EditedScreen extends StatelessWidget {
  const EditedScreen({Key? key, required this.image}) : super(key: key);
  final image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    final actual_image = image is String
        ? FileImage(File('/storage/emulated/0/Download/' + image))
        : image;
    return ChangeNotifierProvider(
      create: (context) => SelectedTopButtonModel(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopBar(
                width: width,
              ),
              ImageContainer(
                image: actual_image,
              ),
              BottomBar(
                width: width,
                image: actual_image,
                btnOneText: 'Filters',
                btnTwoText: 'Colorize',
                btnOneOnTap: () {
                  // print('1');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddFilterScreen(image: actual_image);
                  }));
                },
                btnTwoOnTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ColorizeScreen(image: actual_image);
                  }));
                },
                addProLabelOne: true,
                addProLabelTwo: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
