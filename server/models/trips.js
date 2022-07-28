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
            arrivedtime:{type:Array,required:true,trim:true,default:"NA"},
            isReached:{type:Boolean,required:true},
        
    },
    maxRounds:{type:Number,required:true},
    initialRound:{type:Number,required:true,default:0},
    currentRound:{type:Number,required:true,default:0}
})

const Trips=mongoose.model('trips',tripsSchema)
module.exports=Trips