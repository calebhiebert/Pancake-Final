<template>
  <div class="ui container">
    <h3 class="header">Cart</h3>
    <div class="ui clearing segment" v-if="cart.length > 0">
      <div class="ui divided items">
        <cart-item @cart-changed="onCartChanged" v-for="item in sortedCart" :item="item" :key="item.product.id"></cart-item>
      </div>
      <h4 class="ui horizontal divider header">
        <i class="dollar icon"></i>
        {{ total }}
      </h4>

      <button class="ui right floated right labeled green icon button">
        <i class="right arrow icon"></i>
        Check Out
      </button>
      <button class="ui right floated labeled blue icon button" @click="$router.push({name: 'Home'})">
        <i class="shop icon"></i>
        Continue Shopping
      </button>
    </div>
    <div class="ui message" v-if="cart.length == 0">Your cart is empty</div>
    <button class="ui right floated labeled blue icon button" @click="$router.push({name: 'Home'})" v-if="cart.length == 0">
      <i class="shop icon"></i>
      Add Some Items
    </button>
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
      },

      onCartChanged(cart) {
        this.cart = cart
      }
    },

    computed: {
      total() {
        let total = 0;

        this.cart.forEach(item => total += item.quantity * item.product.price);

        return total.toFixed(2);
      },

      sortedCart() {
        return this.cart.sort((a, b) => {
          if(a.product.id > b.product.id)
            return 1;
          else
            return -1;
        })
      }
    }
  }
</script>
