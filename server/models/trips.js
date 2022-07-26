<<<<<<< HEAD
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
    maxRounds:{type:Number,required:true},
    currentRound:{type:Number,required:true}
})

const Trips=mongoose.model('trips',tripsSchema)
=======
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
    maxRounds:{type:Number,required:true},
    currentRound:{type:Number,required:true}
})

const Trips=mongoose.model('trips',tripsSchema)
>>>>>>> b2251873e23e2bbf9a14d70dabb52e12183ca44b
module.exports=Trips