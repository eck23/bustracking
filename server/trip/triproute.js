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
        return res.status(200).json(Trip)
    }catch(e){
           return res.status(500).json({msg :"Error"})
    }
})

tripsRouter.get("/api/gettrips/:id",async(req,res)=>{
    try{

          var _id=req.params.id
         
          var result=[]
          var tripDetails=Trips.findById(_id).lean().exec(function(err, doc) {
            
                if(doc){
                    for(var item in doc.stops){
                        result.push({stopId :doc.stops[item].stopId,lat:doc.stops[item].latitude,long:doc.stops[item].longitude})
                    
                        }
                    
                     return res.status(200).json({id:doc._id,stopCoordinates:result});
                }
               return  res.status(400).json({msg:"Invalid ID"})
            });
         

    }catch(e){
        return res.status(500).json({msg:e})
    }
})

tripsRouter.post("/api/updatetrip",async(req,res)=>{

        const{id,isReached,stopId}=req.body

       try{
        Trips.updateOne(
            {"_id":id,"stops.stopId":stopId},
            {"$set":{"stops.$.isReached":isReached}},
            function (err,trip){
                if(trip.modifiedCount>0)
                    return res.status(200).json({msg:"ok"})
                return res.status(400).json({msg:"error"})
            }
           )
        
       
       
        }catch(e){
        return res.status(200).json({msg:"error"})
       }
})
module.exports=tripsRouter