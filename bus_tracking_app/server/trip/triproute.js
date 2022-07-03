const express =require("express")
const Trips = require("../models/trips")

const tripsRouter=express.Router()

tripsRouter.post("/api/addtrip",async(req,res)=>{
    
    try{
        const {stops}=req.body

        let Trip=Trips({
            stops
        })
        Trip= await Trip.save();
        res.status(200).json(Trip)
    }catch(e){
            res.status(500).json({msg :"Error"})
    }
})

tripsRouter.get("/api/alltrips",async(req,res)=>{
    try{

          var _id="62c1aab7ba1cfd417fd75556"
          var tripDetails=Trips.findById(_id).lean().exec(function(err, doc) {
            
            res.json(doc);
        });
         // console.log(tripDetails);
          //res.status(200).json({allDetails:"message"})

    }catch(e){
        res.status(500).json({msg:e})
    }
})

module.exports=tripsRouter