<template>
  <div class="ui fluid container">
    <div class="ui icon message" v-if="product == null">
      <i class="notched circle loading icon"></i>
      <div class="content">
        <div class="header">Loading</div>
      </div>
    </div>
    <div class="ui stackable three column grid" v-else>
      <div class="three wide column">
        <img class="ui centered medium rounded image" :src="IMG()">
      </div>
      <div class="eight wide column">
        <h3 class="ui header">{{product.name}}</h3>
        <div class="ui left pointing basic label"><i class="dollar icon"></i>{{product.price}}</div>
        <div class="ui green label" v-if="product.stock_quantity > 3">In stock</div>
        <div class="ui orange label" v-else-if="product.stock_quantity > 0">Only {{product.stock_quantity}} left in stock</div>
        <div class="ui red label" v-else>Out of stock</div>
        <div class="ui divider"></div>
        <p>{{product.description}}</p>
      </div>
      <div class="right floated left aligned five wide column">
        <cart :product="product"></cart>
      </div>
    </div>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import Cart from "./CartView.vue";
  import {IMGURL} from '../imageTools'

  export default {
    components: {Cart},
    name: 'ProductView',

    props: ['search'],

    data() {
      return {
        loadStatus: 'LOADING',
        product: null
      }
    },

    created() {
      this.load()
    },

    watch: {
      $route: 'load'
    },

    methods: {
      IMG() {
        return IMGURL.getImg(0, 1084, 300, 300)
      },

      load() {
        HTTP.get('/products/' + this.$route.params.id)
          .then(response => {
            console.log(response);
            this.product = response.data
          })
          .catch(err => console.log(err))
      }
    }
  }
</script>
<style>
  .ui.pointing.label {
    margin-top: 0 !important;
  }

  .ui.fluid.container {
    padding-left: 1em !important;
    padding-right: 1em !important;
  }
</style>
