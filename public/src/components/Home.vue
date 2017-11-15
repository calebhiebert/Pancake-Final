<template>
  <div class="ui container">
    <h2 class="ui header">{{ header }}</h2>
    <div class="ui icon message" v-if="loading">
      <i class="notched circle loading icon"></i>
      <div class="content">
        <div class="header">Loading</div>
      </div>
    </div>
    <div class="ui divided items" v-if="!loading">
      <product-view-list-item v-for="product in products" :product="product" :key="product.id"></product-view-list-item>
    </div>
  </div>
</template>

<script>
  import {HTTP} from '../http-common'
  import ProductViewListItem from "./ProductViewListItem.vue";

  export default {
    components: {ProductViewListItem},
    name: 'Home',
    data() {
      return {
        header: "Products",
        products: [],
        loading: true
      }
    },

    created() {
      HTTP.get('/products')
        .then(response => {
          this.products = response.data;
          this.loading = false;
        })
    }
  }
</script>
