
const authRouter=require("./auth/auth.js")
require('dotenv').config()
const express=require("express")
const mongoose=require("mongoose")

const app =express()
const PORT=process.env.PORT || 3000


DB=process.env.DB_PASS
//middleware
app.use(express.json())

app.use(authRouter)

mongoose.connect(DB).then(()=>{
    console.log("connection created")
}).catch((e)=>{
        console.log(e)
})


app.listen(PORT,()=>{
    console.log(`connected to PORT : ${PORT}`)
})