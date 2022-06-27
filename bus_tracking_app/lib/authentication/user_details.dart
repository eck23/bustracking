import 'dart:convert';


UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails{

 late String email;
 late String name;
 late String token;

 UserDetails({required email,required name,required token});

 factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        email: json["email"],
        token: json["token"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "token":token,
        "name": name,
    }; 
 

}