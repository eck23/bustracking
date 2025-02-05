const authRouter=require("./auth/auth.js")
require('dotenv').config()
const express=require("express")
const mongoose=require("mongoose")
const http=require('http')
const Trips= require("./models/trips.js")
const stopRouter = require("./trip/stoproute.js")
const tripsRouter = require("./trip/triproute.js")
const Stops = require("./models/stops.js")


const app =express()
const server=http.createServer(app)
const io=require('socket.io')(server)

const PORT=process.env.PORT || 3000


const DB=process.env.DB_PASS

//middleware
app.use(express.json())
// app.use(io)
app.use(authRouter)
app.use(stopRouter)
app.use(tripsRouter)
//

mongoose.connect(DB).then(()=>{
    console.log("connection created")
}).catch((e)=>{
        console.log(e)
})

var tripId;

io.on("connection",(socket)=>{
    console.log("connected to socket")

    socket.on('/getTripStatus',async (data)=>{
        
            var id=data['id']
            var index=data['index']
            var tripdata=await Trips.find({_id:id})
            var initialRound=tripdata[0]['initialRound']
            var currentRound=tripdata[0]['currentRound']
            var maxRounds=tripdata[0]['maxRounds']
            var stops=tripdata[0]['stops']
            var finalstops=[];
            
            if(index%2!=0){
                stops.reverse()
            }
            
            var temp=index+1
            var tripStarted=true
            if(temp==maxRounds){
              temp=0;
            }
            if(temp!=initialRound || initialRound==currentRound){
               tripStarted=false
            }
            
           

            for(var i=0;i<stops.length;i++){
                finalstops.push({stopName:stops[i]['stopName'],stopTime:stops[i]['time'][index],arrivedTime:stops[i]['arrivedtime'],isReached:stops[i]['isReached']})
            }
            
            var finaldata=[{_id:tripdata[0]['_id'],tripName:tripdata[0]['tripName'],regno:tripdata[0]['regno'],stops:finalstops,tripStarted:tripStarted}]
            console.log(finaldata)
            socket.emit('/returnData',finaldata)
     })
     socket.on('/stopsearch',async(filter)=>{
        console.log(filter)
        try{
            var regexp = new RegExp("^"+ filter);
            const filteredStops= await Stops.find({
                "name": {
                  "$regex": regexp,
                  "$options":"i"
                }
              },
              (err, docs) => {
                socket.emit('/filterstop',docs)
              }
            );
          
        }catch(e){
            
        }
        
     })
})

Trips.watch().on('change',async(data)=>{
    
   
    io.emit("/datachange","data changed")

})

server.listen(PORT,()=>{
    console.log(`connected to PORT : ${PORT}`)
})

