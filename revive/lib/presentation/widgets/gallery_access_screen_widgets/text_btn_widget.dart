import 'package:flutter/material.dart';
import 'package:revive/presentation/view/edited_screen.dart';
import 'package:revive/presentation/view/home_bottom_nav.dart';
import '../../../core/storage_permission.dart';
import '../../../utils/constants.dart';
import '../../view/home_screen.dart';
import '../landing_screen_widgets/start_button_widget.dart';

class TextButtonsWidget extends StatelessWidget {
  const TextButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Try it with your photos',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Spacer(),
            Text(
              'To continue, Revive needs access to your photos.',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Spacer(
              flex: 3,
            ),
            StartButtonWidget(
              text: 'Give Access To Photos',
              onTap: () async {
                getPermission(context);
              },
            ),
            Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPermission(BuildContext context) async {
    if (await PermissionGetter.promptPermissionSetting()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return HomeBottomNav();
          // return EditedScreen(image: 'thekid.jpg');
        }),
      );
    }
  }
}
