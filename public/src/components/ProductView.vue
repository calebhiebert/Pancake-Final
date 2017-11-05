<template>
  <div class="ui icon message" v-if="product == null">
    <i class="notched circle loading icon"></i>
    <div class="content">
      <div class="header">Loading</div>
    </div>
  </div>
  <div class="ui three column grid" v-else>
    <div class="four wide column">
      <img class="ui fluid image" src="https://images-na.ssl-images-amazon.com/images/I/71hg2oI%2BETL._SL1500_.jpg">
    </div>
    <div class="eight wide column">
      <h3 class="ui header">{{product.name}}</h3>
      <div class="ui left pointing basic label"><i class="dollar icon"></i>{{product.price}}</div>
      <div class="ui green label" v-if="product.stock_quantity > 3">In stock</div>
      <div class="ui orange label" v-else-if="product.stock_quantity > 0">{{product.stock_quantity}} left</div>
      <div class="ui red label" v-else>Out of stock</div>
      <div class="ui divider"></div>
      <p>{{product.description}}</p>
    </div>
    <div class="right floated left aligned four wide column">
      <cart></cart>
    </div>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import Cart from "./CartView.vue";

  export default {
    components: {Cart},
    name: 'ProductView',

    data() {
      return {
        loadStatus: 'LOADING',
        product: null
      }
    },

    created() {
      HTTP.get('/products/' + this.$route.params.id)
        .then(response => {
          console.log(response);
          this.product = response.data
        })
        .catch(err => console.log(err))
    }
  }
</script>
<style>
  .ui.pointing.label {
    margin-top: 0 !important;
  }
</style>
