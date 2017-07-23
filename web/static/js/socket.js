// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}});

socket.connect();

let channel = socket.channel("phrampu", {});
let list    = $('#message-list');
let message = $('#message');
let name    = $('#name');

channel.on('new_message', payload => {
  console.log(payload);
  list.text(payload.data);
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });



export default socket
