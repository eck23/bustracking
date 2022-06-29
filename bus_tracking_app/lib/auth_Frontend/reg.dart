import 'package:bus_tracking_app/auth_Frontend/styles.dart';
import 'package:bus_tracking_app/authentication/authfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/authlisten.dart';
import '../widgets/widgets.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {


var emailValid;
var passValid;
var confirmPassValid;
var nameValid;

TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
TextEditingController confirmPassController=TextEditingController();

final regFormKey = GlobalKey<FormState>();  

onRegClick()async{

  var email=emailController.text.trim();
  var name=nameController.text.trim();
  var password=passController.text.trim();
  var confirmPass=confirmPassController.text.trim();

  emailValid=null;
  passValid=null;
  confirmPassValid=null;
  nameValid=null;


  if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPass.isNotEmpty && confirmPass==password){

    loading(context);
    
    var response =await Auth.callSignUp(email: email, password: password,name: name);

    Navigator.pop(context);
    print("resposne $response");
    
    if(response=="OK"){
     Provider.of<AuthListen>(context,listen: false).signInUser();
     Navigator.pop(context);
     
   }
    else{
        
        if(response=="Email Already Exists"){
          
          emailValid=response;
          
        }
        else if(response=="Invalid"){
          emailValid="Invalid Email Format";
        }
        
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error in Signing Up")));
        }

  }

  }else{

       if(name.isEmpty){
        nameValid="Name Cannot be Empty";
      }
      if(email.isEmpty){
        emailValid="Email cannot be empty";
      }
      if(password.isEmpty){
        passValid="Password cannot be empty";
      }
      if(password!=confirmPass){
        confirmPassValid="Passwords doesn't match";
      }


  }
  regFormKey.currentState!.validate();
}

  @override
  Widget build(BuildContext context) {

      return GestureDetector(
        onTap: () =>FocusScope.of(context).unfocus() ,
        child: SafeArea(
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
                         key: regFormKey,
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
                                controller: nameController,
                                
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(hintText: "Name"),
                                validator: (val)=>nameValid,
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
                                  controller: emailController ,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(hintText: "Email"),
                                  validator: (val)=>emailValid,
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
                                controller: passController,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(hintText: "Password"),
                                validator: (val)=>passValid,
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
                                controller: confirmPassController,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(hintText: "Confirm Password"),
                                validator: (val)=>confirmPassValid,
                                ))
                          ],
                        ),
                      ],
                      )),
                    
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: SizedBox(
                          width: buttonwidth,
                          child: ElevatedButton(onPressed:onRegClick , child: Text("Create Account",style: buttonTextStyle,),style: regbuttonstyle,)),
                    )
          ]),
        ),
      ),
    );
  }
}