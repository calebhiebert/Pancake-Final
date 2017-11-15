<template>
  <div id="app">
    <login-modal v-if="login" @close="login = false"></login-modal>
    <nav-bar :pages="pages" :search="search" :me="me" @logout="logout" @login="login = true" :loggingOut="loggingOut"></nav-bar>
    <br/>
    <router-view></router-view>
  </div>
</template>

<script>
  import {HTTP} from './http-common'
  import {EventBus, Me} from './EventBus'
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
          .then(response => { Me.me = response.data; EventBus.$emit('me-updated') })
          .catch(err => {
            if(!err.response) {
              console.log(err);
              this.me = null;
            }
          });
      },

      logout() {
        this.loggingOut = true;

        HTTP.post('/logout')
          .then(response => { Me.me = null; EventBus.$emit('me-updated'); this.loggingOut = false })
          .catch(err => console.log(err))
      }
    },

    created() {
      EventBus.$on('me-updated', () => { this.login = false; this.me = Me.me });
      EventBus.$on('page-created', () => this.update());
      EventBus.$on('page-edited', () => this.update());
      this.update()
    }
  }
</script>
