import Vue from "vue";
import App from "./vue_components/App.vue";

var vm = new Vue({
    components:{
        App
    },
    template: "<App/>"
});

function startVueApp(){
    vm.$mount("#app");
}

export {startVueApp};