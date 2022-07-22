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
            maxRounds
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

tripsRouter.get("/api/gettrips/:id", async (req, res) => {
    try {

        var _id = req.params.id

        var result = []
        var tripDetails = Trips.findById(_id).lean().exec(function (err, doc) {

            if (doc) {
                for (var item in doc.stops) {
                    result.push({ stopId: doc.stops[item].stopId, lat: doc.stops[item].latitude, long: doc.stops[item].longitude })

                }

                return res.status(200).json({ id: doc._id, stopCoordinates: result });
            }
            return res.status(400).json({ msg: "Invalid ID" })
        });


    } catch (e) {
        return res.status(500).json({ msg: e })
    }
})

tripsRouter.post("/api/updatetrip", async (req, res) => {

    const { id, isReached, stopId } = req.body

    try {
        Trips.updateOne(
            { "_id": id, "stops.stopId": stopId },
            { "$set": { "stops.$.isReached": isReached } },
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

tripsRouter.post('/api/getmytrips', async (req, res) => {

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

module.exports = tripsRouter