<template>
  <div class="ui container" id="app">
    <nav-bar :pages="pages"></nav-bar>
    <router-view></router-view>
  </div>
</template>

<script>
  import {HTTP} from './http-common'
  import NavBar from "./components/NavBar.vue";

  export default {
    components: {NavBar},
    name: 'app',

    data() {
      return {
        pages: []
      }
    },

    created() {
      HTTP.get('/pages')
        .then(pages => {console.log(pages); this.pages = pages})
        .catch(err => console.log(err))
    }
  }
</script>
