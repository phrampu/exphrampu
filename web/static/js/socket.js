// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}});

socket.connect();

let channel = socket.channel("phrampu", {});

var data = [];

channel.on('new_message', payload => {
  data = payload.data;
  console.log(data);
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp);
    channel.push('send_data', {});
  })
  .receive("error", resp => { console.log("Unable to join", resp) });



export default socket
