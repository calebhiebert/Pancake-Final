<template>
  <div class="ui container">
    <h3 class="header">Cart</h3>
    <div class="ui segment">
      <div class="ui divided items">
        <cart-item v-for="item in cart" :item="item"></cart-item>
      </div>
    </div>
  </div>
</template>
<script>
  import CartItem from "./CartItem.vue";
  import {HTTP} from '../http-common'

  export default {
    components: {CartItem},
    name: 'CartManage',

    data() {
      return {
        cart: []
      }
    },

    created() {
      this.loadCart()
    },

    methods: {
      loadCart() {
        HTTP.get('/cart')
          .then(response => this.cart = response.data)
          .catch(err => console.log(err))
      }
    }
  }
</script>
