<template>
    <div class="ui container" v-if="page != null">
        <h2 class="ui header">{{page.title}}</h2>
        <p>{{page.content}}</p>
    </div>
    <div class="ui container" v-else>
        <div class="ui icon message">
            <i class="notched circle loading icon"></i>
            <div class="content">
                <div class="header">Loading</div>
            </div>
        </div>
    </div>
</template>
<script>
    import {HTTP} from '../http-common'

    export default {
        name: 'PageView',

        data() {
            return {
                page: null
            }
        },

        methods: {
            load() {
                HTTP.get('/pages/' + this.$route.params.title)
                    .then(response => {
                        this.page = response.data
                    })
                    .catch(err => console.log(err))
            }
        },

        watch: {
            $route: 'load'
        },

        created() {
            this.load()
        }
    }
</script>
