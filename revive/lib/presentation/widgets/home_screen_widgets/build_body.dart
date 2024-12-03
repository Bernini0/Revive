import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:revive/presentation/widgets/home_screen_widgets/subscription_card_widget.dart';
import 'package:revive/presentation/widgets/home_screen_widgets/title_choose_image_options_widget.dart';

import '../../../utils/constants.dart';
import 'gallery_grid_widget.dart';

Padding buildBody(closed, onTap, _accessGranted, _media, _loading){
  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding / 2,
      ),
      child: Column(
        children: [
          if (!closed) Spacer(),
          if (!closed)
            SubscriptionCardWidget(
              onTap: onTap
            ),
          if (!closed) Spacer(),
          TitleChooseImageOptionsWidget(),
          Spacer(),
          Expanded(
            flex: !closed ? 8 : 20,
            child: Container(
                width: double.infinity,
                child: AnimationLimiter(
                  child: _accessGranted == false
                      ? Container(
                          child: Text("No permission"),
                        )
                      : GalleryGridWidget(
                          media: _media,
                          loading: _loading,
                        ),
                )),
          ),
          Spacer(),
        ],
      ),
    );
  }