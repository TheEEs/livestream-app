import {startVueApp} from "./vue";

var socket;
var peers = {};
var video,remote_video;
var my_id;
var root_stream;

const configuration = {
    iceServers: [{
        urls: ["stun:stun.l.google.com:19302"] // Google's public STUN server
    }]
};
document.addEventListener("DOMContentLoaded", function(){
    startVueApp();
});

