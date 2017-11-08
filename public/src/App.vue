<template>
  <div id="app">
    <login-modal v-if="login" @close="login = false" @login="onLoggedIn"></login-modal>
    <nav-bar :pages="pages" :search="search" :me="me" @logout="logout" @login="login = true" :loggingOut="loggingOut"></nav-bar>
    <br/>
    <router-view></router-view>
  </div>
</template>

<script>
  import {HTTP} from './http-common'
  import NavBar from "./components/NavBar.vue";
  import LoginModal from "./components/LoginModal.vue";

  export default {
    components: {
      LoginModal,
      NavBar},
    name: 'app',

    data() {
      return {
        me: null,
        login: false,
        loggingOut: false,
        pages: [],
        search: {
          query: ''
        }
      }
    },

    methods: {
      update() {
        HTTP.get('/pages')
          .then(pages => {this.pages = pages.data})
          .catch(err => console.log(err));

        HTTP.get('/me')
          .then(response => this.me = response.data)
          .catch(err => {
            if(!err.response)
              console.log(err)
          });
      },

      logout() {
        this.loggingOut = true;

        HTTP.post('/logout')
          .then(response => { this.me = null; this.loggingOut = false })
          .catch(err => console.log(err))
      },

      onLoggedIn() {
        this.login = false;
        this.update()
      }
    },

    created() {
      this.update()
    }
  }
</script>
