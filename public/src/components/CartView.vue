<template>
  <div class="ui clearing segment">
    <h3 class="ui header">Cart</h3>
    <div class="ui celled list">
      <cart-item-compact-view v-for="item in cart" :item="item" :key="item.product.id" @removed="refreshCart"></cart-item-compact-view>
    </div>
    <button class="ui basic green right floated mini circular icon button" :class="{loading: status == 'ADDING'}" @click="addToCart"><i class="plus icon"></i></button>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import {IMGURL} from '../imageTools'
  import CartItemCompactView from "./CartItemCompact.vue";

  export default {
    components: {CartItemCompactView},
    name: 'Cart',

    props: ['product'],

    data() {
      return {
        status: 'IDLE',
        cart: []
      }
    },

    created() {
      this.refreshCart()
    },

    methods: {
      addToCart() {
        this.status = 'ADDING';

        if(this.product !== null) {
          HTTP.post('/cart/add', { product_id: this.product.id, quantity: 1 })
            .then(response => {this.cart = response.data; this.status = 'IDLE'})
            .catch(err => console.log(err))
        }
      },

      refreshCart() {
        HTTP.get('/cart')
          .then(response => this.cart = response.data)
          .catch(err => console.log(err))
      },

      IMG() { return IMGURL.getImg(0, 1080, 64, 64) }
    }
  }
</script>
