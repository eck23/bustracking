const mongoose=require("mongoose")

const userSchema=mongoose.Schema({

    name:{
        required:true,
        type:String,
        trim:true
    },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(val)=>{
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
                
                return val.match(re)
            },
            message:'incorrect email format'

        }
    },
    password:{
        required:true,
        type:String,
        
    }

})
const User=mongoose.model('User',userSchema)
module.exports=User