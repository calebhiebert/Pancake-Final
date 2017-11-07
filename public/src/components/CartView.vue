<template>
  <div class="ui clearing segment">
    <!--<button class="ui primary button" @click="addToCart">-->
      <!--Add To Cart-->
    <!--</button>-->
    <h3 class="ui header">Cart</h3>
    <div class="ui celled list">
      <div class="item" v-for="cItem in cart" >
        <img class="ui avatar image" :src="IMG()">
        <div class="content">
          <router-link :to="{name: 'ProductView', params: {id: cItem.product.id}}" class="header">{{cItem.product.name}} x {{cItem.quantity}}</router-link>
          <div class="description">
            <b>$</b>{{cItem.product.price * cItem.quantity}}
          </div>
        </div>
      </div>
    </div>
    <button class="ui basic green right floated mini circular icon button" :class="{loading: status == 'ADDING'}" @click="addToCart"><i class="plus icon"></i></button>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import {IMGURL} from '../imageTools'

  export default {
    name: 'Cart',

    props: ['product'],

    data() {
      return {
        status: 'IDLE',
        cart: []
      }
    },

    created() {
      HTTP.get('/cart')
        .then(response => this.cart = response.data)
        .catch(err => console.log(err))
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

      IMG() { return IMGURL.getImg(0, 1080, 64, 64) }
    }
  }
</script>
