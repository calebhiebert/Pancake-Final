<template>
  <div class="ui container">
    <h3 class="header">Cart</h3>
    <div class="ui segment">
      <div class="ui divided items">
        <cart-item v-for="item in cart" :item="item" :key="item.product.id"></cart-item>
      </div>
      <h4 class="ui horizontal divider header">
        <i class="dollar icon"></i>
        {{ total }}
      </h4>
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
    },

    computed: {
      total() {
        let total = 0;

        this.cart.forEach(item => total += item.quantity * item.product.price)

        return total.toFixed(2);
      }
    }
  }
</script>
