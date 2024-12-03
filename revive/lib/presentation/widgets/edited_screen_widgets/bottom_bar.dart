import 'dart:io';

import 'package:flutter/material.dart';
import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/colorize_image_command.dart';
import 'package:revive/model/upload_image_command.dart';
import 'package:revive/presentation/view/AddFilterScreen.dart';
import 'package:revive/presentation/view/edited_screen.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/pro_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pro_features_widget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {super.key,
      required this.width,
      required this.image,
      required this.btnOneText,
      required this.btnTwoText,
      required this.btnOneOnTap,
      required this.btnTwoOnTap,
      required this.addProLabelOne,
      required this.addProLabelTwo});

  final width;
  final image;
  final btnOneText;
  final btnTwoText;
  final btnOneOnTap;
  final btnTwoOnTap;
  final addProLabelOne;
  final addProLabelTwo;
  // final onTapBtn;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: ProFeatures(
                    width: width,
                    icon: Icons.invert_colors,
                    text: btnOneText,
                    // onTap: () {
                    //   // print('1');
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //     return AddFilterScreen(image: image);
                    //   }));
                    // },
                    onTap: btnOneOnTap,
                  ),
                ),
                GestureDetector(
                  child: ProFeatures(
                    width: width,
                    icon: Icons.article_outlined,
                    text: btnTwoText,
                    // onTap: () async {
                    //   final invoker = ApiRequestInvoker();
                    //   SharedPreferences sharedPreferences =
                    //       await SharedPreferences.getInstance();
                    //   String filepath = sharedPreferences
                    //       .get('restored_image_path') as String;
                    //   String filename = sharedPreferences
                    //       .get('restored_image_name') as String;
                    //   var file = File(filepath);
                    //   invoker.addCommand(
                    //       UploadImageCommand(file: file, imageName: filename));
                    //   invoker.addCommand(
                    //     ColorizeImageCommand(
                    //         imageName: filename, context: context),
                    //   );
                    //   // sharedPreferences.setString('colorize', 'true');
                    //   await invoker.executeCommands();
                    //   String s = sharedPreferences.get('restored_image_name')
                    //       as String;
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) {
                    //     return EditedScreen(
                    //         image: FileImage(
                    //             File('/storage/emulated/0/Download/' + s)));
                    //   }));
                    //   print("works i guess");
                    // },
                    onTap: btnTwoOnTap,
                  ),
                ),
              ],
            ),
            !addProLabelOne
                ? Text('')
                : ProLabel(
                    left: (width * 0.305555),
                    width: width,
                    top: width / 80.0 * 4,
                  ),
            !addProLabelTwo
                ? Text('')
                : ProLabel(
                    left: (width * 0.305555),
                    width: width,
                    top: width / 80.0 * 4,
                  ),
          ],
        ),
      ),
    );
  }
}
