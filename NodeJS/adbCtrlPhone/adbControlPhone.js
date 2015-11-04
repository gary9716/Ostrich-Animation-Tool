var Promise = require('bluebird');
var client = require('adbkit').createClient();
var express = require("express");
var bodyParser = require("body-parser");
var app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static("./")); //expose Recog.html

Promise.promisify(client.shell);

//cmd list
var swipeDownCmd = "input swipe 596 915 657 1530";
var swipeUpCmd = "input swipe 657 1530 596 915";
var pressSmallAnimalButton = "input tap 758 942";

client.listDevices().then(function(devices) {
  
  var fileIsLoaded = false;
  var previousEffect = undefined;
  var device = undefined;

  if(devices.length > 0) {
    device = devices[0];
  }
  else {
    console.log("no device found");
    process.exit();
  }

  var loadAudioFile = function() {
    return  client.shell(device.id, "input tap 1019 159")  //menu
                  .delay(650)
                  .then(function(){
                    client.shell(device.id, "input tap 737 171"); //menu first option
                  })
                  .delay(650)
                  .then(function(){
                    client.shell(device.id, "input tap 326 1008"); //directory option
                  })
                  .delay(650)
                  .then(function(){
                    client.shell(device.id, "input tap 338 1334");  //download folder
                  })
                  .delay(650)
                  .then(function(){
                    client.shell(device.id, "input tap 491 320"); //list first option
                    fileIsLoaded = true;
                  })
                  .delay(1500);
  }

  var uploadAudioFile = function(fileName) {
    return  client.push(device.id, fileName, "/storage/self/primary/Download/myrecording.wav")
                  .then(function(transfer) {
                    transfer.on('end',function() {
                      console.log('transfer done');
                    });
                    transfer.on('error',function() {
                      console.log('transfer failed');
                    });
                  })
                  .delay(500);
  };

  var playSmallAnimalEffect = function() {
    var curEffect = 'smallAnimal';
    if(previousEffect === curEffect) {
      return client.shell(device.id, pressSmallAnimalButton); //press small animal play button
    }
    else {
      //swipe from the top twice and press
      previousEffect = curEffect;
      return loadAudioFile().then(function() {
         return  client.shell(device.id, swipeUpCmd)
                       .delay(700)
                       .then(function(){
                          client.shell(device.id, swipeUpCmd);
                       })
                       .delay(1000)
                       .then(function(){
                          client.shell(device.id, pressSmallAnimalButton);
                       });
      });
    }

  };

  var playHeliumEffect = function() {
    //from top
    previousEffect = 'helium';
    return client.shell(device.id, "input tap 737 862"); //press helium play button
  };

  app.post('/PhoneCtrl',function(request,response){
    var fileName = request.body.filename;
    var cmd = request.body.command;

    if(cmd == 'push') { //push file
      uploadAudioFile(fileName);
    }
    else if(cmd == 'play'){ //play audio
      playSmallAnimalEffect();
    }

    response.end();
  });


  var keypress = require('keypress');
  keypress(process.stdin);

  //keypress logic
  process.stdin.on('keypress', function (ch, key) {
    if(key) {
      console.log('got keypress '+ key.name);
    }

    if (key && key.ctrl && key.name == 'c') { //terminate the app: ctrl + c
      return process.exit();
    }
    else if(key.name == 'up'){
      return client.shell(device.id, "input keyevent 4");  //back   
    }
    else if(key.name == 'space'){
      return client.shell(device.id, "input keyevent 3");  //Home
    }
    else if(key.name == 'u'){
      return client.shell(device.id, swipeUpCmd); //swipe up
    }
    else if(key.name == 'd'){
      return client.shell(device.id, swipeDownCmd); //swipe down
    }
    else if(key.name == 'o'){
      return client.shell(device.id, "input keyevent 26"); //Power
    }
    else if(key.name == 'h'){
      return playHeliumEffect();
    }
    else if(key.name == 's'){
      return playSmallAnimalEffect();
    }
    else if(key.name == 'q'){
      return loadAudioFile();
    }
    else if(key.name == 'p'){
      return uploadAudioFile();
    }

  });
    
  process.stdin.setRawMode(true);
  console.log("start to detect keypress");
  process.stdin.resume();

});

