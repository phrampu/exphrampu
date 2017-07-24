// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"
import Vue from 'vue'
import MyApp from "../components/my-app.vue"

let socket = new Socket("/socket", {params: {token: window.userToken}});

socket.connect();

Vue.component('my-app', MyApp)

window.addEventListener('load', function () {
  new Vue({
    el: '#app',
   	mounted() {
			this.channel = socket.channel("room:phrampu", {});
			this.channel.on("new_message", payload => {
				this.whos = payload['whos'];
				console.log(this.whos);
			});
			this.channel.join()
				.receive("ok", response => {
					console.log("Joined successfully", response);
					this.channel.push("send_data", {});
				}).receive("error", response => { console.log("Unable to join", response) })
		},
		data() {
			return {
				channel: null,
				whos: []
			}
		},
    render(createElement) {
      return createElement(MyApp, {})
    }
  });
})

export default socket
