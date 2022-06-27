import 'package:bus_tracking_app/login/styles.dart';
import 'package:bus_tracking_app/providers/authlisten.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../authentication/authfunctions.dart';



class MyLogin extends StatefulWidget{


  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
TextEditingController usercontroller=TextEditingController();

TextEditingController passcontroller=TextEditingController();


final formKey = GlobalKey<FormState>();  



var emailValid;  //validate msg for email
var passValid;  //validate msg for password


@override
  void dispose(){

  usercontroller.dispose();
  passcontroller.dispose();
  super.dispose();
}

loading() {
  showDialog(
    barrierDismissible: false,
    builder: (ctx) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blue.shade700,
          strokeWidth: 5,
        ),
      );
    },
    context: context,
  );
}

onLoginClick()async{

  var email=usercontroller.text.trim();
  var password=passcontroller.text.trim();

  emailValid=null;
  passValid=null;
 


  if(email.isNotEmpty && password.isNotEmpty){

  loading();
  
  var response = await Auth.callSignIn(email: email, password: password);
 
  Navigator.pop(context);
  
  if(response=="OK"){
     Provider.of<AuthListen>(context,listen: false).signInUser();
     
  }
  else{

        if(response=="Invalid Email"){
          
          emailValid="Invalid Email";
          passValid=null;
          
        }
        else if(response=="Incorrect password"){

          passValid=response;
          emailValid=null;
          
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in Signing In")));
        }

        

    }
  }else{

         if(email.isEmpty){
            emailValid="Email cannot be empty";
          }

      if(password.isEmpty){
           passValid="Password cannot be empty";
      }
  }
  formKey.currentState!.validate();
  
  
}








  @override
  Widget build(BuildContext context) {
        
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  
                  children: [
                    Container(
                      height: 350.h,
                      width: 300.w,
                      child: Image.asset("assets/image.png")),
              
                      loginContainer()
                ]
              
                ),
              ),
            ),
          ),
        );
  }

  Widget loginContainer(){

        return Padding(
          padding: EdgeInsets.only(top:300.h),
          child: Container(
            height :350.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white70,borderRadius: BorderRadius.only(topLeft:Radius.circular(25.r) ,topRight:Radius.circular(25.r) )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 15.h,bottom:15.h ),
                      child: Text("Login",style: GoogleFonts.aladin(color: Colors.black,fontSize: 40.sp,fontWeight: FontWeight.bold),),
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
                            padding:  EdgeInsets.only(right: 20.w),
                            child: Icon(Icons.email),
                          ),
                          Container(
                            width:150.w,
                            
                            child: TextFormField(
                              controller: usercontroller ,
                              decoration: InputDecoration(hintText: "Email"),
                              validator: (val)=>emailValid,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 20.w),
                          child: Icon(Icons.lock),
                        ),
                        Container(
                          width:150.w,
                          
                          child: TextFormField(
                            controller: passcontroller,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "Password"),
                            validator: (val)=>passValid,
                            ))
                      ],
                    ),
                    ],
                  )),
            
                  Padding(
                    padding: EdgeInsets.only(top:5.h, left: 90.w),
                    child: TextButton(onPressed: null, child: Text("Forgot Password",style: TextStyle(color: Colors.orange),)),
                  ),
            
                  SizedBox(
                    width: buttonwidth,
                    child: ElevatedButton(onPressed:onLoginClick, child: Text("Login",style: buttonTextStyle,),style: loginbuttonstyle)),
            
                  Padding(
                    padding: EdgeInsets.only(top: 5.h,bottom: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                          Container(height:1.h,width: 70.w,color: Colors.black26,),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                            child: Text("OR",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
                          ),
                           Container(height:1.h ,width:70.w,color: Colors.black26,),
                    ]),
                  ),
            
                  SizedBox(
                    width: buttonwidth,
                    child: ElevatedButton(onPressed: null, child: Text("Register",style: buttonTextStyle,),style: regbuttonstyle,))
                ],
              ),
            ),
          ),
        );

    }
}