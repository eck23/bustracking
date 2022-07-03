const mongoose=require("mongoose")

const tripsSchema=mongoose.Schema({

    stops:{
        type:Array,
        
        
            stopId:{type:String,required:true,trim:true},
            latitude:{type:Number,required:true,trim:true},
            longitude:{type:Number,required:true,trim:true},
            altitude:{type:Number,required:true,trim:true},
            time:{type:String,required:true,trim:true},
            isReached:{type:Boolean,required:true},
        
    }

})

const Trips=mongoose.model('trips',tripsSchema)
module.exports=Trips