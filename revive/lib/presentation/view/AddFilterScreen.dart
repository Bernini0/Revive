import 'dart:io';

import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/add_filter_command.dart';
import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/selected_top_button_model.dart';
import 'package:revive/model/upload_image_command.dart';
import 'package:revive/presentation/widgets/add_filter_screen/add_filter_btn.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/image_container_widget.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/top_bar.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/enhance_btn_widget.dart';
import 'package:revive/presentation/widgets/selected_image_screen_widgets/loading_img_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFilterScreen extends StatefulWidget {
  AddFilterScreen({required this.image});
  final image;

  @override
  State<AddFilterScreen> createState() => _AddFilterScreenState();
}

class _AddFilterScreenState extends State<AddFilterScreen> {
  var filters = [
    'ins1977',
    'aden',
    'brannan',
    'brooklyn',
    'clarendon',
    'earlybird',
    'gingham',
    'hudson',
    'inkwell',
    'kelvin',
    'lark',
    'lofi',
    'maven',
    'mayfair',
    'moon',
    'nashville',
    'perpetua',
    'reyes',
    'rise',
    'slumber',
    'stinson',
    'toaster',
    'valencia',
    'walden',
    'willow',
    'xpro2'
  ];
  double value = 0.5;
  int selectedFilter = 0;
  bool filter_used = false;
  bool loading = false;
  var filter_image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return ChangeNotifierProvider(
      create: (context) => SelectedTopButtonModel(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TopBar(
                  width: width,
                ),
                loading
                    ? LoadingImgCardWidget(
                        image: widget.image,
                      )
                    : !filter_used
                        ? SizedBox(
                            height: size.height * 0.8,
                            child: Column(
                              children: [
                                ImageContainer(image: widget.image),
                                Container(
                                  color: Colors.black,
                                  height: size.height / 15,
                                  child: Center(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: filters.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 20),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedFilter = index;
                                            });
                                          },
                                          child: Center(
                                            child: Text(
                                              filters[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        index == selectedFilter
                                                            ? Colors.white
                                                            : Colors.white54,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  // color: Colors.black,
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: AddFilterBtnWidget(
                                      image: widget.image,
                                      onTap: () async {
                                        setState(() {
                                          filter_used = true;
                                          loading = true;
                                        });
                                        final invoker = ApiRequestInvoker();
                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        String filepath = sharedPreferences.get(
                                            'restored_image_path') as String;
                                        String filename = sharedPreferences.get(
                                            'restored_image_name') as String;
                                        var file = File(filepath);
                                        invoker.addCommand(UploadImageCommand(
                                            file: file, imageName: filename));
                                        invoker.addCommand(AddFilterCommand(
                                            imageName: filename,
                                            context: context,
                                            filter_name:
                                                filters[selectedFilter]));
                                        await invoker.executeCommands();
                                        filter_image = Image.file(File(
                                            sharedPreferences
                                                    .get('restored_image_path')
                                                as String));
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      width: width),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            flex: 8,
                            child: Container(
                              color: Colors.black,
                              child: BeforeAfter(
                                value: value,
                                trackWidth: 3,
                                trackColor: Colors.white,
                                thumbDivisions: 3,
                                overlayColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  // print(states);
                                  if (states.contains(MaterialState.dragged)) {
                                    // print('jajaja');
                                    return Colors.green;
                                  }
                                  return Colors.blue;
                                }),
                                before: Image(image: widget.image),
                                after: filter_image,
                                onValueChanged: (value) {
                                  setState(() => this.value = value);
                                },
                              ),
                            ),
                          ),
                // Container(
                //   color: Colors.black,
                //   height: size.height / 20,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: filters.length,
                //     itemBuilder: (context, index) => Padding(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: size.width / 20),
                //       child: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             selectedFilter = index;
                //           });
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Text(
                //               filters[index],
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayLarge
                //                   ?.copyWith(
                //                     fontWeight: FontWeight.w600,
                //                     color: index == selectedFilter
                //                         ? Colors.white
                //                         : Colors.white54,
                //                   ),
                //             ),
                //
                //             // Container(
                //             //   margin: EdgeInsets.symmetric(
                //             //       vertical: size.height / 100),
                //             //   height: size.height / 120,
                //             //   width: size.width / 20,
                //             //   decoration: BoxDecoration(
                //             //     borderRadius: BorderRadius.circular(10),
                //             //     color: index == selectedFilter
                //             //         ? Colors.redAccent
                //             //         : Colors.transparent,
                //             //   ),
                //             // )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.only(
                //       bottomRight: Radius.circular(20),
                //       bottomLeft: Radius.circular(20),
                //     ),
                //   ),
                //   // color: Colors.black,
                //   padding: EdgeInsets.only(bottom: 20),
                //   child: AddFilterBtnWidget(
                //       image: widget.image,
                //       onTap: () async {
                //         setState(() {
                //           filter_used = true;
                //           loading = true;
                //         });
                //         final invoker = ApiRequestInvoker();
                //         SharedPreferences sharedPreferences =
                //             await SharedPreferences.getInstance();
                //         String filepath = sharedPreferences
                //             .get('restored_image_path') as String;
                //         String filename = sharedPreferences
                //             .get('restored_image_name') as String;
                //         var file = File(filepath);
                //         invoker.addCommand(UploadImageCommand(
                //             file: file, imageName: filename));
                //         invoker.addCommand(AddFilterCommand(
                //             imageName: filename,
                //             context: context,
                //             filter_name: filters[selectedFilter]));
                //         await invoker.executeCommands();
                //         filter_image = Image.file(File(sharedPreferences
                //             .get('restored_image_path') as String));
                //         setState(() {
                //           loading = false;
                //         });
                //       },
                //       width: width),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
