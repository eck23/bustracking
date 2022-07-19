import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../authentication/authfunctions.dart';
import '../providers/authlisten.dart';
import '../widgets/widgets.dart';
import '../styles/styles.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usercontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var userValid; //validate msg for email
  var passValid; //validate msg for password

  @override
  void dispose() {
    usercontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  onLoginClick() async {
    var username = usercontroller.text.trim();
    var password = passcontroller.text.trim();

    userValid = null;
    passValid = null;

    if (username.isNotEmpty && password.isNotEmpty) {
      loading(context);

      var response =
          await Auth.callSignIn(username: username, password: password);

      Navigator.pop(context);

      if (response == "OK") {
        Provider.of<AuthListen>(context, listen: false).signInUser();
      } else {
        if (response == "Invalid Username") {
          userValid = "Invalid Username";
          passValid = null;
        } else if (response == "Incorrect password") {
          passValid = response;
          userValid = null;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error in Signing In")));
        }
      }
    } else {
      if (username.isEmpty) {
        userValid = "Email cannot be empty";
      }

      if (password.isEmpty) {
        passValid = "Password cannot be empty";
      }
    }
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WindowButtons(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [LoginText(), loginContainer()],
          ),
        ],
      ),
    );
  }

  Widget LoginText() {
    return Center(
      child: Text("Welcome To \nWhere's my bus",
          style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget loginForm() {
    return Material(
      elevation: 10,
      child: Container(
        color: Colors.orange,
        width: 150.w,
        height: 550.h,
        child: Center(
          child: loginContainer(),
        ),
      ),
    );
  }

  Widget loginContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Material(
        elevation: 10,
        child: Container(
          height: 600.h,
          width: appWindow.isMaximized ? 100.w : 120.w,
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 150.h, bottom: 50.h),
                  child: Text(
                    "Login",
                    style: authHeading,
                  ),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Icon(Icons.person),
                              ),
                              Container(
                                  width: 70.w,
                                  child: TextFormField(
                                    controller: usercontroller,
                                    textInputAction: TextInputAction.next,
                                    decoration:
                                        InputDecoration(hintText: "Username"),
                                    validator: (val) => userValid,
                                  ))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Icon(Icons.lock),
                            ),
                            Container(
                                width: 70.w,
                                child: TextFormField(
                                  controller: passcontroller,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      hintText: "Password"),
                                  validator: (val) => passValid,
                                ))
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 3.w),
                  child: TextButton(
                      onPressed: null,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.orange),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SizedBox(
                      width: buttonwidth,
                      child: ElevatedButton(
                          onPressed: onLoginClick,
                          child: Text(
                            "Login",
                            style: buttonTextStyle,
                          ),
                          style: loginbuttonstyle)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
