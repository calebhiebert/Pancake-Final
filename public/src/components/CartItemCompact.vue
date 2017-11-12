<template>
  <div class="item">
    <div class="ui right floated active inline mini loader" v-if="status == 'REMOVING'"></div>
    <i class="ui right floated red link remove icon" @click="doRemove" v-else></i>
    <img class="ui avatar image" :src="img" v-if="img != ''">
    <div class="content">
      <router-link :to="{name: 'ProductView', params: {id: item.product.id}}" class="header">{{item.product.name}} x {{item.quantity}}</router-link>
      <div class="description">
        <b>$</b>{{item.product.price * item.quantity}}
      </div>
    </div>
  </div>
</template>
<script>
  import {IMGURL} from '../imageTools'
  import {HTTP, GETIMG} from '../http-common'

  export default {
    name: 'CartItemCompactView',

    props: ['item'],

    data() {
      return {
        status: 'IDLE'
      }
    },

    methods: {
      IMG() {return IMGURL.getImg(0, 0, 64, 64)},

      doRemove() {
        this.status = 'REMOVING';

        HTTP.post('/cart/remove', { product_id: this.item.product.id })
          .then(response => this.$emit('removed'))
          .catch(err => console.log(err))
      }
    },

    computed: {
      img() {
        if(this.item.product.images.length === 0) {
          return ''
        } else {
          let img = this.item.product.images[0];
          return GETIMG(img.ident, img.ext)
        }
      }
    }
  }
</script>
