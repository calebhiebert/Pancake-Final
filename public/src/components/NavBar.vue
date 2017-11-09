<template>
  <div class="ui attached stackable menu">
    <div class="ui container">
      <router-link :to="{name: 'Home'}" class="item" :class="{ active: $route.name == 'Home' }">Home</router-link>
      <router-link :to="{name: 'PageView', params: {title: page.title}}" class="item" v-for="page in pages"
                   :key="page.id" :class="{ active: $route.params.title == page.title }">{{page.title}}
      </router-link>
      <router-link :to="{name: 'AdminIndex'}" class="item" :class="{ active: $route.name == 'AdminIndex' }" v-if="me !== null && me.is_admin">Admin
      </router-link>
      <div class="right menu">
        <router-link :to="{name: 'Register'}" class="ui item" v-if="me === null">Register</router-link>
        <a class="ui item" v-if="me === null" @click="$emit('login')">Login</a>
        <a class="ui item" v-else-if="loggingOut"><div class="ui active inline mini loader"></div></a>
        <a class="ui item" v-else @click="$emit('logout')">Logout</a>
        <div class="ui item">
          <div class="ui transparent icon input">
            <input placeholder="search..." v-model="search.query">
            <i class="search link icon"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'NavBar',

    props: ['pages', 'search', 'me', 'loggingOut'],

    watch: {
      'search.query'() {
        if(this.$route.name !== 'SearchView') {
          this.$router.push({name: 'SearchView', query: {query: this.search.query}});
          this.search.query = ''
        }
      }
    }
  }
</script>
