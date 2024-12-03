import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/colorize_image_command.dart';
import 'package:revive/model/selected_top_button_model.dart';
import 'package:revive/model/upload_image_command.dart';
import 'package:revive/presentation/view/edited_screen.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/bottom_bar.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/image_container_widget.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/top_bar.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/blurred_bg_img_widget.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/img_card_widget.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/loading_img_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorizeScreen extends StatefulWidget {
  const ColorizeScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<ColorizeScreen> createState() => _ColorizeScreenState();

  final image;
}

class _ColorizeScreenState extends State<ColorizeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;

    var btnTwoOnTap = () async {
      setState(() {
        loading = true;
      });
      final invoker = ApiRequestInvoker();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String filepath = sharedPreferences.get('restored_image_path') as String;
      String filename = sharedPreferences.get('restored_image_name') as String;
      var file = File(filepath);
      invoker.addCommand(UploadImageCommand(file: file, imageName: filename));
      invoker.addCommand(
        ColorizeImageCommand(imageName: filename, context: context),
      );
      // sharedPreferences.setString('colorize', 'true');
      await invoker.executeCommands();
      String s = sharedPreferences.get('restored_image_name') as String;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EditedScreen(
            image: FileImage(File('/storage/emulated/0/Download/' + s)));
      }));
      print("works i guess");
    };
    return ChangeNotifierProvider(
      create: (context) => SelectedTopButtonModel(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            BlurredBgImgWidget(image: widget.image),
            !loading
                ? ImgCardWidget(
                    image: widget.image,
                    onTap: btnTwoOnTap,
                  )
                : LoadingImgCardWidget(
                    image: widget.image,
                  ),
          ],
        ),
      ),
    );
  }
}
