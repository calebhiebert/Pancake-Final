<template>
  <div class="ui secondary pointing menu">
    <router-link :to="{name: 'Home'}" class="item" :class="{ active: $route.name == 'Home' }">Home</router-link>
    <a class="item">Editorials</a>
    <a class="item">Reviews</a>
    <div class="right menu">
      <a class="ui item">Logout</a>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'NavBar'
  }
</script>
