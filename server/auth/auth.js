const express =require("express")
const bcrypt=require("bcryptjs")
const webtoken=require("jsonwebtoken")
const User = require("../models/user")
const Admins = require("../models/admin")

const authRouter=express.Router()

authRouter.post("/api/signup",async(req,res)=>{

    

        try{
            const {email,password,name}=req.body

            const existingUser= await User.findOne({email})
            
            if(existingUser){
                return res.status(400).json({msg:"Email Already Exists"})
            }
            
            const hashedpassword=bcrypt.hashSync(password,8)
            
            let user=new User({
                email,
                password:hashedpassword,
                name
            })
            
            user= await user.save()
           return res.status(200).json(user)
        }catch(e){
               return res.status(500).json({error:e.message})
        }
})

authRouter.post("/api/signin",async(req,res)=>{
        
      
        try{
            const {email,password}=req.body;

            const existinguser= await User.findOne({email});
        
        if(existinguser==null){
            return res.status(400).json({msg:"Invalid Email"})
        }

        const isCorrect=await bcrypt.compare(password, existinguser.password)
        
        
        if(isCorrect==false){
            // console.log("incorrect password")
            return res.status(400).json({msg:"Incorrect password"})
        }

        const token=webtoken.sign({id:existinguser._id},"webtokenkey")
        
        var user=existinguser._doc
        return res.status(200).json({token:token,email:user['email'],name:user['name']})
    }catch(e){
       return res.status(500).json({error:e.message})
    }
              
})

authRouter.post("/api/admin/signup",async(req,res)=>{

    
    try{
        const {username,email,password,companytype,companyname,registeredTripId}=req.body
       

        var existingUser=await Admins.findOne({username})   
        

        if(existingUser!=null){
            return res.status(400).json({message:"username already exists"})
        }

        existingUser=await Admins.findOne({email})

        if(existingUser!=null){
            return res.status(400).json({message:"email already exists"})
        }


      
        // const re = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()+=-\?;,./{}|\":<>\[\]\\\' ~_]).{8,}/
        // var valid= {password}.match(re)

        // print(valid)

        // if(valid==null){
        //     return res.status(400).json({message:"Password must contain minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character"})
        // }
      
        

        const hashedpassword=bcrypt.hashSync(password,8)
        
        let admin=new Admins({
            username,
            email,
            password:hashedpassword,
            companytype,
            companyname,
            registeredTripId

        })

        

        admin=await admin.save()
        console.log("in admin login ")
        return res.status(200).json(admin)

        
    }catch(e){
        res.status(500).json({message:e})
    }


})

authRouter.post("/api/admin/signin",async(req,res)=>{
    try{
        const {username,password}=req.body;

        const existingadmin= await Admins.findOne({username});
    
        if(existingadmin==null){
            return res.status(400).json({msg:"Invalid Username"})
        }

        const isCorrect=await bcrypt.compare(password, existingadmin.password)
    
    
        if(isCorrect==false){
        // console.log("incorrect password")
        return res.status(400).json({msg:"Incorrect password"})
        }

         const token=webtoken.sign({_id:existingadmin._id},"webtokenkey")
    
        var admin=existingadmin._doc
        return res.status(200).json({token:token,...admin})
    }catch(e){
        return res.status(500).json({error:e.message})
    }


})





module.exports=authRouter