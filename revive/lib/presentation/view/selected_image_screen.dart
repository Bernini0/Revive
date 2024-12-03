import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:revive/core/storage_permission.dart';
import 'package:revive/model/business_logic/restored_image_count_singleton.dart';
import 'package:revive/model/restore_image_command.dart';
import 'package:revive/model/upload_image_command.dart';
import 'package:revive/presentation/view/sign_up_screen.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/img_card_widget.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/blurred_bg_img_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/api_invoker.dart';
import '../widgets/selected_image_screen_widgets/loading_img_card_widget.dart';
import 'package:http/http.dart' as http;

class SelectedImageScreen extends StatefulWidget {
  final ImageProvider image;
  final Medium medium;

  SelectedImageScreen({
    super.key,
    required this.image,
    required this.medium,
  });

  @override
  State<SelectedImageScreen> createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  bool _isLoading = false;
  bool permissionGranted = false;

  Future<void> uploadImage(String signedUrl, File imageFile) async {
    try {
      final request = http.Request('PUT', Uri.parse(signedUrl));
      request.bodyBytes = await imageFile.readAsBytes();
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Error uploading image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future _getStoragePermission() async {
    print("here");
    if (await Permission.storage.request().isGranted) {
      print("here 2");
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      print("here 3");
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      print("here 4");
      if (await PermissionGetter.promptPermissionSetting()) {
        setState(() {
          permissionGranted = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            BlurredBgImgWidget(image: widget.image),
            !_isLoading
                ? ImgCardWidget(
                    image: widget.image,
                    onTap: () async {
                      final instance = await RestoredImageCount.internal();
                      if (instance.restored_count >= instance.restored_limit) {
                        //snackbar or Alert Box
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                          width: size.width,
                          buttonsBorderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                          dismissOnTouchOutside: true,
                          dismissOnBackKeyPress: false,
                          onDismissCallback: (type) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Dismissed by $type'),
                              ),
                            );
                          },
                          headerAnimationLoop: false,
                          animType: AnimType.bottomSlide,
                          title: 'Limit\nExceeded',
                          titleTextStyle: TextStyle(color: Colors.black),
                          desc:
                              'Please subscribe to out paid plans to be able to restore more images.',
                          descTextStyle: TextStyle(color: Colors.black),
                          showCloseIcon: true,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        String ACCESS_TOKEN =
                            sharedPreferences.get('ACCESS_TOKEN') as String;
                        instance.increment_image_count();
                        if (ACCESS_TOKEN != '') {
                          permissionGranted = true;
                          print("permissionGranted: $permissionGranted");
                          if (!permissionGranted) {
                            print("trying");
                            _getStoragePermission();
                          }
                          if (permissionGranted) {
                            var file = await widget.medium.getFile();

                            final invoker = ApiRequestInvoker();
                            print(widget.medium.filename);
                            invoker.addCommand(UploadImageCommand(
                                file: file,
                                imageName:
                                    widget.medium.filename ?? "lkasdjf"));
                            setState(() {
                              _isLoading = true;
                            });
                            invoker.addCommand(RestoreImageCommand(
                                imageName: widget.medium.filename ?? 'kj.jpg',
                                context: context));

                            await invoker.executeCommands();
                            print('why not work?');
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return EditedScreen(
                            //         image: widget.medium.filename,
                            //       );
                            //     },
                            //   ),
                            // );
                          }
                        } else {
                          print('hi');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpScreen();
                          }));
                        }
                      }
                    },
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
