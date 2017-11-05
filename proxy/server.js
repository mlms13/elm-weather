const request = require("request");
const express = require("express");
const app = express();

const port = process.env.PORT || 7777;
const clientPort = process.env.CLIENT || 8080;
const apiKey = process.env.API_KEY || "";

app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:' + clientPort);
  res.setHeader('Access-Control-Allow-Methods', 'GET');
  next();
});

app.get("/weather/:lat/:long", function (req, res) {
  request("https://api.darksky.net/forecast/" + apiKey + "/" + req.params.lat + "," + req.params.long, function (err, r, body) {
    if (err) return res.status(502).send("Failed to connect to darksky api: " + err);

    return res.status(200).send(body);
  });
});

app.listen(port, () => console.log("Proxy server running on port 7777"));
