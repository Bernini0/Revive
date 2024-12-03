import 'package:flutter/material.dart';
import 'package:revive/model/api_invoker.dart';
import 'package:revive/model/get_user_info_command.dart';
import 'package:revive/presentation/view/gallery_access_screen.dart';
import 'package:revive/presentation/view/sign_in_screen.dart';
import 'package:revive/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/landing_screen_widgets/vector_widget.dart';
import '../widgets/landing_screen_widgets/start_button_widget.dart';
import '../widgets/landing_screen_widgets/terms_conditions_widget.dart';
import '../widgets/landing_screen_widgets/title_text_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 4,
              child: vectorWidget(),
            ),
            Spacer(),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    Expanded(flex: 4, child: TitleTextWidget()),
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: StartButtonWidget(
                        text: 'Get Started',
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          var access_token =
                              sharedPreferences.get('ACCESS_TOKEN');
                          var refresh_token =
                              sharedPreferences.get('REFRESH_TOKEN');
                          var invoker = ApiRequestInvoker();
                          invoker
                              .addCommand(GetUserInfoCommand(context: context));
                          await invoker.executeCommands();
                          bool loggedIn =
                              sharedPreferences.get('LOGGED_IN') as bool;
                          if (access_token == null ||
                              refresh_token == null ||
                              loggedIn == false) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignInScreen();
                            }));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GalleryAccessScreen();
                            }));
                          }
                        },
                      ),
                    ),
                    Spacer(),
                    Expanded(flex: 3, child: TermsConditionsWidget()),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
