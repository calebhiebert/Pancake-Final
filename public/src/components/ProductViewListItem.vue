<template>
  <div class="item">
    <div class="ui small rounded image">
      <div class="ui red ribbon label">New!</div>
      <img :src="IMG(0, 1084, 150, 150)">
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
  import {IMGURL} from '../imageTools'

  export default {
    name: 'ProductViewListItem',
    props: ['product'],

    methods: { IMG: IMGURL.getImg }
  }
</script>
