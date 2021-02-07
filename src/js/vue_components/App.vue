<template>
    <div>
        <nav class="navbar is-link" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a href="/" data-turbolinks="false" class="navbar-item">
                    RTC Video Call
                </a>
                <a @click="toggleMenu" role="button" :class="'navbar-burger ' + menuActivation" aria-label="menu" aria-expanded="false" data-target="navbarMenu">
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                    <span aria-hidden="true"></span>
                </a>
            </div>
            <section id="navbarMenu" :class="'navbar-menu ' + menuActivation">
                <div class="navbar-start">
                    <div class="navbar-item">
                        <input v-model="partner_id" class="input is-link" type="text" placeholder="Id của người dùng khác">
                    </div>
                    <div class="navbar-item">
                        <button class="button is-success" @click="addPartner">Gửi Video</button>
                    </div>
                </div>
                <div class="navbar-end">
                    <h2 v-if="my_id" class="navbar-item">
                        ID của tôi: &nbsp; <span v-if="my_id" class="tag is-danger m-l-1">{{my_id}}</span>
                    </h2>
                </div>
            </section>
        </nav>
        <div id="videos" class="columns is-multiline">
            <div class="column is-4 has-text-centered">
                <video ref="my-video" id="my-video"></video>
                <p class="has-text-left has-text-primary">{{my_id}}</p>
            </div>
            <div v-for="(value,name) in video_tracks" :key="name" class="column is-4 has-text-centered">
               <video :srcObject.prop="value" autoplay="true"></video>
              <p class="has-text-left has-text-primary">{{name}}</p>
            </div>
        </div>
    </div>
</template>
<style lang="scss" scoped>
div#videos{
    video{
        transform: rotateY(180deg);
        -webkit-transform:rotateY(180deg); /* Safari and Chrome */
        -moz-transform:rotateY(180deg); /* Firefox */
    }
}
</style>
<script>
import Vue from "vue";
import {
    socket,
    send_message,
    create_peer_and_offer_to,
    create_peer_and_answer_to
} from "../socket.js";

let mediaSource = null;
import swal from "sweetalert";
export default {
    data (){
        return {
            is_menu_actived: false,
            peers: {},
            root_stream : null,
            my_id: "",
            partner_id: null,
            video_tracks: {}
        };
    },
    methods:{
        toggleMenu(){
            this.is_menu_actived = !this.is_menu_actived;
        },
        addPartner(){
            if(this.partner_id){
                const peer_id = this.partner_id;
                let pc = create_peer_and_offer_to(peer_id);
                this.peers[peer_id] = pc;
                if(mediaSource){
                    mediaSource.getTracks().forEach(track => {
                        pc.addTrack(track,mediaSource);
                    });
                }
            }
        }
    },
    computed:{
        menuActivation(){
            return this.is_menu_actived ? "is-active" : "";
        }
    },
    mounted(){
        window.navigator.mediaDevices.getUserMedia({
            video: true,
            audio: true
        }).then(stream => {
            if(!mediaSource){
                mediaSource = stream;
                let videoPlayer = this.$refs['my-video'];
                videoPlayer.srcObject = stream;
                videoPlayer.volume = 0.0001;
                videoPlayer.play();
            }
        }).catch(err => {
            console.error(err);
        });           
        socket.onmessage = (message) =>{
            let {sender,candidate,offer,answer, connected, closed} = JSON.parse(message.data);
            if(connected){
                this.my_id = connected;
            }
            else if (offer){
                swal(`Người dùng ${sender} muốn gửi video cho bạn. Đồng ý?`,{
                    buttons: ["Không", "Nhận video"]
                }).then((accepted)=>{
                    if(accepted){
                        let pc = create_peer_and_answer_to(sender,offer);
                        this.peers[sender] = pc;
                        pc.ontrack = (e) => {
                            if(!this.video_tracks[sender]){
                                Vue.set(this.video_tracks,sender,e.streams[0]);
                                console.log(this.video_tracks);
                            }
                        };
                    }
                });
            }else if(answer){
                let pc = this.peers[sender];
                if(pc)
                    pc.setRemoteDescription(answer);
            } else if(candidate){
                let pc = this.peers[sender];
                if(pc)
                    pc.addIceCandidate(candidate);
            } else if(closed){
                console.log(closed);
                delete this.peers[closed];
                Vue.delete(this.video_tracks,closed);
            }else{
                console.log("Control Frame received");
            }
        };
        socket.onclose = () => {
            window.location.pathname = "/";
        };
        setInterval(()=>{
            send_message(null,{});
        },1000);
    }
}
</script>