<template>
  <div id="app">
    <nav-bar :pages="pages"></nav-bar>
    <br/>
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
        .then(pages => {console.log(pages); this.pages = pages.data})
        .catch(err => console.log(err))
    }
  }
</script>
