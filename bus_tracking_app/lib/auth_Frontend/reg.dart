import 'package:bus_tracking_app/auth_Frontend/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

      return SafeArea(
        child: Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: 
                   [
                      Container(
                        height: 320.h,
                        width: 300.w,
                        
                        child: Image.asset("assets/image.png")),
                      regContainer(),
                    ],
                  ),
                ),
              
          ),
      );
  }

  var iconRightpadding=20.w;
  var formbottompadding=10.h;
  double dividerHeight=10.h;
  var textContainerWidth=200.w;
  Color dividerColor=Colors.white;
  Widget regContainer(){

    return Padding(
      padding: EdgeInsets.only(top: 190.h),
      child: Container(

        height :470.h,
              width: double.infinity,
              decoration: BoxDecoration(
                
                border: Border.all(color: Colors.black87),
      
                color: Colors.white70,borderRadius: BorderRadius.only(topLeft:Radius.circular(25.r) ,topRight:Radius.circular(25.r) )),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
                Padding(
                    padding:  EdgeInsets.only(top: 50.h,bottom:30.h ),
                    child: Text("Create Account",style:authHeading,),
                ),
                 Form(
                        // key: formKey,
                        child: Column(
                        
                        children: [
        
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: iconRightpadding),
                              child: Icon(Icons.person)
                            ),
                            Container(
                              width:textContainerWidth,
                              
                              child: TextFormField(
                                // controller: passcontroller,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(hintText: "Name"),
                                // validator: (val)=>passValid,
                                ))
                          ],
                        ),
                        Divider(height:dividerHeight,color:dividerColor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: iconRightpadding),
                                child: Icon(Icons.email),
                              ),
                              Container(
                                width:textContainerWidth,
                                
                                child: TextFormField(
                                  // controller: usercontroller ,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(hintText: "Email"),
                                  // validator: (val)=>emailValid,
                                  ))
                            ],
                          ),
                          Divider(height:dividerHeight,color:dividerColor),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 20.w),
                              child: Icon(Icons.lock),
                            ),
                            Container(
                              width:textContainerWidth,
                              
                              child: TextFormField(
                                // controller: passcontroller,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(hintText: "Password"),
                                // validator: (val)=>passValid,
                                ))
                          ],
                        ),
                        Divider(height:dividerHeight,color:dividerColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: iconRightpadding),
                              child: Icon(Icons.lock),
                            ),
                            Container(
                              width:textContainerWidth,
                              
                              child: TextFormField(
                                // controller: passcontroller,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(hintText: "Confirm Password"),
                                // validator: (val)=>passValid,
                                ))
                          ],
                        ),
                      ],
                      )),
                    
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: SizedBox(
                          width: buttonwidth,
                          child: ElevatedButton(onPressed:null , child: Text("Create Account",style: buttonTextStyle,),style: regbuttonstyle,)),
                    )
          ]),
        ),
      ),
    );
  }
}