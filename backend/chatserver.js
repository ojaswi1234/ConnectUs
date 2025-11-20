const express = require('express')
const app = express()
const http = require('http')

app.use(express.json())





const PORT = process.env.PORT || 3000

app.listen(PORT, () => {
    console.log("Chat Server Comming Up.....")
})