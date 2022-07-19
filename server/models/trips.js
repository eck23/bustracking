const mongoose=require("mongoose")

const tripsSchema=mongoose.Schema({
    tripName:{type:String,required:true,trim:true},
    stops:{
        type:Array,
        
        
            stopId:{type:String,required:true,trim:true},
            stopName:{type:String,required:true,trim:true},
            latitude:{type:Number,required:true,trim:true},
            longitude:{type:Number,required:true,trim:true},
            time:{type:Array,required:true,trim:true},
            isReached:{type:Boolean,required:true},
        
    },
    maxRounds:{type:Number,required:true}

})

const Trips=mongoose.model('trips',tripsSchema)
module.exports=Trips