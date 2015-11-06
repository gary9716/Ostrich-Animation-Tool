var express = require("express");
var bodyParser = require("body-parser");
var app = express();
var exposePath = "./";

var serverPort = 8081;

app.use(bodyParser.urlencoded({ extended: false }));
app.use('/',express.static(exposePath)); //expose Recog.html

app.listen(serverPort ,function(){
  console.log("server started listen on " + serverPort);
});
