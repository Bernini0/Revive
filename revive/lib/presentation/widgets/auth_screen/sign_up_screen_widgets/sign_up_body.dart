import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revive/domain/user_api.dart';
import 'package:revive/model/user.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:revive/presentation/widgets/auth_screen/auth_screens_common_widgets/dialog_widget.dart';

import '../../../../utils/constants.dart';
import '../../landing_screen_widgets/start_button_widget.dart';
import '../auth_screens_common_widgets/alternate_login_options_widget.dart';
import '../auth_screens_common_widgets/auth_option_widget.dart';
import '../auth_screens_common_widgets/text_input_widget.dart';
import '../auth_screens_common_widgets/top_container_widget.dart';
import '../auth_screens_common_widgets/alternate_login_divider_widget.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({
    super.key,
    required this.obscureText,
    required this.togglePassWisibility,
  });

  final obscureText;
  final togglePassWisibility;

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  @override
  Widget build(BuildContext context) {
    bool onTap = false;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    FirebaseAuth auth = FirebaseAuth.instance;
    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainer(
            text1: 'Register',
            text2: 'Create your account',
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                TextInput(
                  text: 'Name',
                  obscureText: false,
                  isPass: false,
                  controller: nameController, // Add this line
                  togglePasswordVisibility: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput(
                  text: 'Email',
                  obscureText: false,
                  isPass: false,
                  controller: emailController, // Add this line
                  togglePasswordVisibility: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput(
                  text: 'Password',
                  obscureText: widget.obscureText,
                  isPass: true,
                  controller: passwordController, // Add this line
                  togglePasswordVisibility: widget.togglePassWisibility,
                ),
                SizedBox(
                  height: 20,
                ),
                StartButtonWidget(
                  text: 'Register',
                  onTap: () async {
                    setState(() {
                      onTap = true;
                    });
                    String email = emailController.text;
                    String password = passwordController.text;
                    String name = nameController.text;
                    List<String> nameParts = name.split(' ');

                    if(email.isEmpty){
                      showDialog(context: context, builder: (BuildContext context) {
                        return DialogWidget(
                          text: "Please Fill Up Email",
                        );
                      });
                    }
                    else if(password.isEmpty){
                      showDialog(context: context, builder: (BuildContext context) {
                        return DialogWidget(
                          text: "Please Fill Up Password",
                        );
                      });
                    }
                    else if(name.isEmpty){
                      showDialog(context: context, builder: (BuildContext context) {
                        return DialogWidget(
                          text: "Please Fill Up Name",
                        );
                      });
                    }
                    else{
                      String firstName = name;
                      String lastName = "";

                      if (nameParts.length >= 2) {
                        firstName = nameParts[0];
                        lastName = nameParts.sublist(1).join(' ');

                        print("First Name: $firstName");
                        print("Last Name: $lastName");
                      } else {
                        // Handle the case where there are not enough parts to split
                        print("Invalid full name format");
                      }
                      AuthUser auth_user = AuthUser(
                          email: email,
                          password: password,
                          firstName: firstName,
                          lastName: lastName,
                          country: 'Bangladesh');
                      var rr = await auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      print(rr);
                      UserAPI userAPI = UserAPI(auth_user);

                      String? result = await userAPI.createUser();
                      print("abcd $result");
                      if (result == "User created successfully") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(), // Replace 'YourNewScreen' with the name of your new screen widget
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogWidget(
                                text: result,
                              );
                            });
                      }
                      setState(() {
                        onTap = false;
                      });
                    }
                  },
                ),
                onTap
                    ? CircularProgressIndicator(
                        color: kPrimary,
                      )
                    : SizedBox(
                        height: 20,
                      ),
                SizedBox(
                  height: 40,
                ),
                AlternateLoginDividerWidget(
                  text: 'register',
                ),
                SizedBox(
                  height: 20,
                ),
                AlternateLoginOptions(),
                SizedBox(
                  height: 80,
                ),
                AuthOption(
                  text1: 'Already have an account?',
                  text2: 'Login',
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
