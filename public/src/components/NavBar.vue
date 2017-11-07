<template>
  <div class="ui attached stackable menu">
    <div class="ui container">
      <router-link :to="{name: 'Home'}" class="item" :class="{ active: $route.name == 'Home' }">Home</router-link>
      <router-link :to="{name: 'PageView', params: {title: page.title}}" class="item" v-for="page in pages"
                   :key="page.id" :class="{ active: $route.params.title == page.title }">{{page.title}}
      </router-link>
      <router-link :to="{name: 'AdminIndex'}" class="item" :class="{ active: $route.name == 'AdminIndex' }">Admin
      </router-link>
      <div class="right menu">
        <a class="ui item">Logout</a>
        <div class="ui item">
          <div class="ui transparent icon input">
            <input placeholder="search...">
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

    props: ['pages']
  }
</script>
