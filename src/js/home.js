import Vue from "vue";
import Home from "./vue_components/Home.vue";
var vm = new Vue({
    components:{
        Home
    },
    template: "<Home/>"
});

document.addEventListener("DOMContentLoaded",function(){
    vm.$mount("#app");
});