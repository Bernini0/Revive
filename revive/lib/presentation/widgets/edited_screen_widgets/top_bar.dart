import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/pro_label.dart';
import 'package:revive/presentation/widgets/edited_screen_widgets/version_type_widget.dart';

import '../../../model/selected_top_button_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.width
  });

  final width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(right: width / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: (width / 80.0) * 6,
              ),
            ),
            Consumer<SelectedTopButtonModel>(
              builder: (context, x, child) => Stack(
                children: [
                  VersionType(
                    x: x,
                    width: width,
                  ),
                  ProLabel(
                    top: 0.0,
                    left: (width * 0.491435),
                    width: width,
                  ),
                  ProLabel(
                    top: 0.0,
                    left: (width *
                        0.305555),
                    width: width,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.download_for_offline,
                size: (width / 80) * 8,
                color: Colors.white.withOpacity(0.8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
