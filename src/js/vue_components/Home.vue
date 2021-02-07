<template>
    <div>
        <section class="hero is-fullheight">
            <div class="hero-body">
                <div class="container">
                    <div class="columns is-centered">
                        <div class="column is-5">
                            <img src="https://opendoodles.s3-us-west-1.amazonaws.com/dancing.png" alt="" srcset="">
                        </div>
                    </div>
                    <div class="columns is-centered">
                        <div class="overlay">
                            <p class="title">
                            WebRTC Video Call
                            </p>
                            <p class="subtitle">
                                Trao đổi video trực tiếp giữa các trình duyệt. Nhanh chóng, an toàn.
                            </p>
                            <a data-turbolinks="false" href="/rooms" class="button is-warning">Bắt đầu ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>
<style lang="scss" scoped>
    section.hero{
        //background-image: url("https://assets.website-files.com/5d5d5904f8a21bfe5ff69367/601490af893a7fbcadb82d51_swinging.svg");
        background-size: cover;
        background-position: 50% 50%;
        div.overlay{
            display: inline-block;
            padding: 3rem 3rem 3rem 3rem;
            background-color: rgba(41, 128, 185, 0.4);
        }
    }
</style>
<script>
export default {
    
}
</script>