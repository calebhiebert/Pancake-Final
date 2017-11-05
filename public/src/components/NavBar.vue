<template>
  <div class="ui secondary pointing menu">
    <router-link :to="{name: 'Home'}" class="item" :class="{ active: $route.name == 'Home' }">Home</router-link>
    <a class="item" v-for="page in pages">{{page.title}}</a>
    <div class="right menu">
      <a class="ui item">Logout</a>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'NavBar',

    props: ['pages']
  }
</script>
