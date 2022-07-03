const express =require("express")
const Stops = require("../models/stops")

const stopRouter=express.Router()

stopRouter.post("/api/addstop",async(req,res)=>{

     console.log("in add stop")

        try{
            const {name,latitude,longitude}=req.body

            var existingStop= await Stops.findOne({name})

            if(existingStop){
                return res.status(400).json({msg:"stop name already exist"})
            }
            existingStop=await Stops.findOne({latitude,longitude})

            if(existingStop){
                
                return res.status(400).json({msg:"same coordinates exist",name:existingStop['name']})
            }

            let stop=Stops({
                name,
                latitude,
                longitude
            })
            await stop.save()
            return res.status(200).json({msg:"successfully added"})


        }catch(e){
           return  res.status(500).json({error:e.message})
        }
})



module.exports=stopRouter