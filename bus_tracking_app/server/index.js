
const authRouter=require("./auth/auth.js")
require('dotenv').config()
const express=require("express")
const mongoose=require("mongoose")
const http=require('http')
const User = require("./models/user.js")

const app =express()
const server=http.createServer(app)
const io=require('socket.io')(server)

const PORT=process.env.PORT || 3000


// const DB=process.env.DB_PASS
const DB="mongodb+srv://eck_base:minnalproject@cluster0.35jc7.mongodb.net/?retryWrites=true&w=majority"
//middleware
app.use(express.json())
// app.use(io)
app.use(authRouter)
//

mongoose.connect(DB).then(()=>{
    console.log("connection created")
}).catch((e)=>{
        console.log(e)
})


io.on("connection",(socket)=>{
    console.log("connected to socket")

    socket.on('/listenDB',async (msg)=>{
        console.log(msg)
       
            socket.emit('/message',"hoooi")
        })
})

User.watch().on('change',async(data)=>{
    
    var users=await User.find()
    io.emit("/datachange",users)

})

server.listen(PORT,()=>{
    console.log(`connected to PORT : ${PORT}`)
})

