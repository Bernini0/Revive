import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:photo_gallery/photo_gallery.dart';

import 'package:revive/core/storage_permission.dart';

import '../widgets/home_screen_widgets/app_bar.dart';
import '../widgets/home_screen_widgets/build_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool closed = false;
  bool _loading = false;
  bool _accessGranted = false;
  List<Medium> _media = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    _accessGranted = await PermissionGetter.promptPermissionSetting();
    setState(() {
      _accessGranted = _accessGranted;
    });
    if (_accessGranted) {
      List<Album> albums = await PhotoGallery.listAlbums();
      int idx = 0;
      MediaPage mediaPage = await albums[idx].listMedia();
      // for (int i = 0; i < albums.length; i++) {
      //   print(albums[i].name);
      // }
      List<Medium> media = mediaPage.items;
      filterImages(media);
      setState(() {
        _loading = false;
      });
    }
  }

  void filterImages(List<Medium> media) async {
    for (var medium in media) {
      if (medium.mediumType == MediumType.image) {
        _media.add(medium);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
      body: buildBody(closed, () {
        setState(() {
          closed = true;
        });
      }, _accessGranted, _media, _loading),
    );
  }
}
