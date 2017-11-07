<template>
  <div class="ui container">
    <h2 class="ui header">{{ header }}</h2>
    <div class="ui divided items">
      <product-view v-for="product in products" :product="product" :key="product.id"></product-view>
    </div>
  </div>
</template>

<script>
  import {HTTP} from '../http-common'
  import ProductView from "./ProductViewListItem.vue";

  export default {
    components: {ProductView},
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
