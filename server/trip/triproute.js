const express = require("express")
const Trips = require("../models/trips")
const webtoken = require("jsonwebtoken")
const Admins = require("../models/admin")

const tripsRouter = express.Router()

tripsRouter.post("/api/addtrip", async (req, res) => {

    try {
        const { tripName, stops, maxRounds, token } = req.body

        verifyToken = webtoken.verify(token, "webtokenkey")
        if (verifyToken == null)
            return res.status(400).json({ msg: "unauthorized user" })

        
        let Trip = Trips({
            tripName,
            stops,
            maxRounds,
           
        })

        Trip = await Trip.save();
        console.log(Trip['_id'])
        console.log(verifyToken._id)
        await Admins.updateOne({ _id: verifyToken._id }, { $push: { registeredTripId: Trip['_id'].toHexString() } })

        return res.status(200).json({ msg: "Success" })
    } catch (e) {
        return res.status(500).json({ msg: "Error" })
    }
})

tripsRouter.get("/api/gettrips/:id/:regno", async (req, res) => {
    try {

        var _id = req.params.id
        var regno=req.params.regno
        var result = []
        await Trips.updateOne({_id:_id},{"$set":{"regno":regno}})
        var tripDetails = Trips.findById(_id).lean().exec(function (err, doc) {

            if (doc) {
                for (var item in doc.stops) {
                    result.push({ stopId: doc.stops[item].stopId, lat: doc.stops[item].latitude, long: doc.stops[item].longitude })

                }

                return res.status(200).json({ id: doc._id, stopCoordinates: result ,currentRound:doc.currentRound,maxRounds:doc.maxRounds,initialRound: doc.initialRound});
            }
            return res.status(400).json({ msg: "Invalid ID" })
        });


    } catch (e) {
        return res.status(500).json({ msg: e })
    }
})



tripsRouter.post("/api/updatetrip", async (req, res) => {

    const { id, isReached, stopId,arrivedtime } = req.body

    try {
        Trips.updateOne(
            { "id": id, "stops.stopId": stopId },
            { "$set": { "stops.$.isReached": isReached, "stops.$.arrivedtime":arrivedtime} },
            function (err, trip) {
                if (trip.modifiedCount > 0)
                    return res.status(200).json({ msg: "ok" })
                return res.status(400).json({ msg: "error" })
            }
        )



    } catch (e) {
        return res.status(200).json({ msg: "error" })
    }
})

tripsRouter.post('/api/admin/getmytrips', async (req, res) => {

    const { token } = req.body
    verifyToken = webtoken.verify(token, "webtokenkey")

    if (verifyToken == null)
        return res.status(400).json({ msg: "unauthorized user" })

    var tripsList = await Admins.findOne({ _id: verifyToken._id }).select({ registeredTripId: 1, _id: 0 })

    if (tripsList == null)
        return res.status(400).json({ msg: "empty" })

    console.log(tripsList)

    var tripDetails = []
    var trip
    console.log(tripsList['registeredTripId'])
    for (var i = 0; i < tripsList['registeredTripId'].length; i++) {

        console.log(tripsList['registeredTripId'][i])
        trip = await Trips.find({ _id: tripsList['registeredTripId'][i] }).select({ tripName: 1 })
        tripDetails.push(trip[0])
    }
    // console.log(trip)
    return res.status(200).json(tripDetails)
})

tripsRouter.post("/api/updateround",async(req,res)=>{

    try{
        const{id,initialRound}=req.body;

        await Trips.updateOne({_id:id},{"$set": {'initialRound':initialRound} })
        
        var result=await Trips.findOne({_id:id}).select({stops:1})
        for(var i=0;i<result['stops'].length;i++){
            await Trips.updateMany({_id:id,"stops.stopId":result['stops'][i]['stopId']},{"$set": {'stops.$.isReached':false}})
        }
       
        
        res.status(200).json({msg:"success"})
    }catch(e){
        res.status(500).json({msg:e})
    }
     
})

tripsRouter.post("/api/updatecurrent",async(req,res)=>{

   try{
    const{id,currentRound}=req.body;
    await Trips.updateOne({_id:id},{"$set": {'currentRound':currentRound} })
    res.status(200).json({msg:"success"})
   }catch(e){
    res.status(500).json({msg:"error"})
   }

})

tripsRouter.get("/api/get_trips_by_location/:source/:destination",async(req,res)=>{
    try{
    var source=req.params.source
    var destination=req.params.destination
    var result=await Trips.find({'stops.stopName':{$all:[source,destination]}})
    console.log(result)
    var finalresult=[];
    for(var i=0;i<result.length;i++){
        
        var sourceFound=false
        var stopName;
        var currentStops=result[i]['stops']
        var initialRound=result[i]['initialRound']  
        var maxRounds=result[i]['maxRounds']
        
        if(initialRound==0){
            initialRound=currentStops[0]['time'].length
            console.log(initialRound)
        }

        if(initialRound%2==0){
            currentStops.reverse()
        }
        
        initialRound=initialRound-1
            
            var source;
            var destination;
            var sourceTime;
            var destinationTime;
            for(var j=0;j<currentStops.length;j++){
                stopName=currentStops[j]['stopName'];
                
                if(stopName==source){
                    source=stopName
                    sourceTime=currentStops[j]['time'][initialRound]
                    sourceFound=true
                }
                if(stopName==destination){
                    destination=stopName
                    if(sourceFound==true){
                       
                        destinationTime=currentStops[j]['time'][initialRound]
                        finalresult.push({_id:result[i]['_id'],tripName:result[i]['tripName'],regno:result[i]['regno'],source:source,sourceTime:sourceTime,destination:destination,destinationTime:destinationTime,index:initialRound,maxRounds:maxRounds})
                        break;
                    }
                    else{
                        initialRound=initialRound+1
                        
                        if(initialRound==maxRounds){
                            initialRound=0
                        }

                        destinationTime=currentStops[j]['time'][initialRound]
                        for(var k=j+1;k<currentStops.length;k++){
                            stopName=currentStops[k]['stopName'];
                            if(stopName==source){
                                source=stopName
                                sourceTime=currentStops[k]['time'][initialRound]
                                break;
                            }
                        }
                        finalresult.push({_id:result[i]['_id'],tripName:result[i]['tripName'],regno:result[i]['regno'],source:source,sourceTime:sourceTime,destination:destination,destinationTime:destinationTime,index:initialRound,maxRounds:maxRounds})
                        break;
                    }
                }
            }


        
        
    }
        return res.status(200).json(finalresult)
    }catch(e){
        res.sendStatus(500).json({msg:"error occured"})
    }
})

module.exports = tripsRouter