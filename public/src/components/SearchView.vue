<template>
  <div class="ui container">
    <div class="center aligned basic segment">
      <div class="ui fluid action input">
        <input id="search" placeholder="Search..." v-model="query" autofocus>
        <select class="ui compact selection dropdown">
          <option>This is an option</option>
        </select>
      </div>
    </div>

    <div class="ui divided items" v-if="items.length > 0 || query.trim() != ''">
      <product-view-list-item v-for="product in items" :product="product" :key="product.id"></product-view-list-item>
    </div>
    <div v-else>
      There were no results :(
    </div>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import ProductView from "./ProductView.vue";
  import ProductViewListItem from "./ProductViewListItem.vue";

  export default {
    components: {
      ProductViewListItem,
      ProductView},
    name: 'SearchView',

    data() {
      return {
        query: '',
        items: []
      }
    },

    watch: {
      $route() {
        this.doSearch(this.query = this.$route.query.query)
      },

      query() {
        this.$router.replace({name: 'SearchView', query: {query: this.query}})
      }
    },

    mounted() {
      this.query = this.$route.query.query;
      document.getElementById('search').focus()
    },

    methods: {
      doSearch(query) {
        if(query.trim() === '') {
          this.items = [];
          return;
        }

        HTTP.get('/products/search?query=' + query)
          .then(response => this.items = response.data)
          .catch(err => console.log(err))
      }
    }
  }
</script>
