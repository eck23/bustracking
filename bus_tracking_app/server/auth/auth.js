const express =require("express")
const bcrypt=require("bcryptjs")
const webtoken=require("jsonwebtoken")
const User = require("../models/user")

const authRouter=express.Router()

authRouter.post("/api/signup",async(req,res)=>{

    console.log("authenticating")

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
                name,
            })
            
            user= await user.save()
            res.status(200).json(user)
        }catch(e){
                res.status(500).json({error:e.message})
        }
})

authRouter.post("/api/signin",async(req,res)=>{
        
      console.log("trying to sign in")
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
        res.status(500).json({error:e.message})
    }
              
})

authRouter.get("/api/test",async(req,res)=>{

        try{
            
            res.json({msg:"SIM900 HTTP TEST"})
        }catch(e){
            res.status(500).json({error:e.message})
        }
})



module.exports=authRouter