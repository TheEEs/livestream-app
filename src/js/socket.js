import adapter from 'webrtc-adapter';
const configuration = {
    iceServers: [
        {
            urls: ["stun:stun.l.google.com:19302"] // Google's public STUN server
        },
        {
            urls: ["turn:loaphuong.xyz"],
            username: "trandat",
            credential: "trandat"
        }
    ]
};

const protocol = window.location.protocol === "http:" ? "ws":"wss";
const host = window.location.host;
const path = window.location.pathname;
const url = `${protocol}://${host}${path}`; 
let socket = new WebSocket(url);

function create_peer_and_offer_to(peer_id){
    let pc = new RTCPeerConnection(configuration);
    pc.onnegotiationneeded = ()=> {
        pc.createOffer({
            offerToReceiveVideo: true
        }).then(async (offer) => {
            pc.setLocalDescription(offer);
            send_message(peer_id,{offer});
        });
    };
    pc.onicecandidate = ({candidate}) => {
        send_message(peer_id,{candidate});
    };
    return pc;
}

function create_peer_and_answer_to(peer_id,offer){
    let pc = new RTCPeerConnection(configuration);
    pc.setRemoteDescription(offer);
    pc.createAnswer().then(async (answer)=>{
        pc.setLocalDescription(answer);
        send_message(peer_id,{answer});
    });
    pc.onicecandidate = ({candidate}) => {
        send_message(peer_id,{candidate});
    };
    return pc;
}

function send_message(receiver,content){
    const payload = JSON.stringify({
        receiver, 
        ...content
    });
    socket.send(payload);
}


export {send_message,socket,create_peer_and_offer_to,create_peer_and_answer_to};