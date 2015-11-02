var Promise = require('bluebird');
var adb = require('adbkit');
var keypress = require('keypress');
var client = adb.createClient();
keypress(process.stdin);
Promise.promisify(client.shell);

client.listDevices()
      .then(function(devices) {
              console.log(devices);
              var device;
              if(devices.length > 0) {
                device = devices[0];
              }
              else {
                return;
              }

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
                  return client.shell(device.id, "input swipe 657 1530 596 915");
                }
                else if(key.name == 'd'){
                  return client.shell(device.id, "input swipe 596 915 657 1530");
                }
                else if(key.name == 'o'){
                  return client.shell(device.id, "input keyevent 26"); //Power
                }
                else if(key.name == 'h'){
                  //from top
                  return client.shell(device.id, "input tap 737 862"); //press helium play button
                }
                else if(key.name == 's'){
                  //swipe from the top twice and press
                  return client.shell(device.id, "input swipe 657 1530 596 915")
                               .delay(500)
                               .then(function(){
                                client.shell(device.id, "input swipe 657 1530 596 915");
                               })
                               .delay(1000)
                               .then(function(){
                                client.shell(device.id, "input tap 758 942"); //press small animal play button
                               }); 
                }
                else if(key.name == 'q'){
                  //load an audio file
                  return client.shell(device.id, "input tap 1019 159")  //menu
                          .delay(600)
                          .then(function(){
                            client.shell(device.id, "input tap 737 171"); //menu first option
                          })
                          .delay(600)
                          .then(function(){
                            client.shell(device.id, "input tap 326 1008"); //directory option
                          })
                          .delay(600)
                          .then(function(){
                            client.shell(device.id, "input tap 338 1334");  //download folder
                          })
                          .delay(600)
                          .then(function(){
                            client.shell(device.id, "input tap 491 320"); //list first option
                          })
                          .delay(800);
                  
                }
                else if(key.name == 'p'){
                  //push an audio file to phone
                  return  client.push(device.id, "myrecording.wav", "/storage/self/primary/Download/myrecording.wav")
                                .then(function(transfer) {
                                  transfer.on('end',function() {
                                    console.log('transfer done');
                                  });
                                  transfer.on('error',function() {
                                    console.log('transfer failed');
                                  });
                                })
                                .delay(500);
                }

              });
              
              
              process.stdin.setRawMode(true);
              console.log("start to detect keypress");
              process.stdin.resume();

            });