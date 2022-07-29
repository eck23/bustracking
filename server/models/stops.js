const mongoose=require('mongoose')

const stopsSchema=mongoose.Schema({
    stopId:{
        type:String,
        required:true,
        trim:true,
    },
    name:{
        required:true,
        type:String,
        trim:true
    },
    latitude:{
        required:true,
        type:Number,
        
    },
    longitude:{
        required:true,
        type:Number
    }
})
const Stops=mongoose.model('Stops',stopsSchema)
module.exports=Stops