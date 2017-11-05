<template>
  <div v-if="page != null">
    <h2 class="ui header">{{page.title}}</h2>
    <p>{{page.content}}</p>
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
          .then(response => { this.page = response.data })
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
