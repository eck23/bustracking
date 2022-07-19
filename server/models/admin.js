const mongoose=require("mongoose")

const adminsSchema=mongoose.Schema({

    username:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(val)=>{
                const re=/^[a-z0-9_.]+$/
                return val.match(re)
            },
            message:'username can only contain letters, numbers, underscores, and periods'
        }
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
        
    },
    companytype:{
        required:true,
        trim:true,
        type:String,
        validate:{
            validator:(val)=>{
                if( val=='PRVT' || val=='GOVT'){
                    return true
                }else{
                    return false
                }
            },
            message:'inavlid company type'
        }
    },
    companyname:{
        required:true,
        trim:true,
        type:String
    },
    registeredTripId:{
        type:Array,
        tripID:{type:String,required:true,trim:true}

    }

})
const Admins=mongoose.model('admins',adminsSchema)
module.exports=Admins