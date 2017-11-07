<template>
  <div class="ui container">
    <h2 class="ui header">{{ header }}</h2>
    <div class="ui divided items">
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
        products: []
      }
    },

    created() {
      HTTP.get('/products').then(response => this.products = response.data)
    }
  }
</script>
