<template>
  <div class="item">
    <div class="ui small rounded image">
      <div class="ui red ribbon label">New!</div>
      <img :src="img">
    </div>
    <div class="content">
      <router-link :to="{ name: 'ProductView', params: { id: product.id } }" class="header">{{ product.name }}</router-link>
      <div class="description">
        <p>{{ product.description }}</p>
      </div>
    </div>
  </div>
</template>
<script>
  import {GETIMG} from '../http-common'

  export default {
    name: 'ProductViewListItem',
    props: ['product'],

    computed: {
      img() {
        if(this.product.images.length === 0) {
          return ''
        } else {
          return GETIMG(this.product.images[0].ident, this.product.images[0].ext)
        }
      }
    }
  }
</script>
