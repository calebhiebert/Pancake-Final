<template>
  <div class="item">
    <div class="content">
      <a class="header">
        {{ item.product.name }}
      </a>
      <div class="meta">
        <span>{{ item.product.description }}</span>
      </div>
      <div class="ui input">
        <input placeholder="Quantity" v-model="item.quantity">
      </div>
      x ${{ item.product.price }} = ${{ item.quantity * item.product.price }}
      <div class="extra">
        <div class="ui right floated basic red button">
          Remove
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'CartItem',

    props: ['item']
  }
</script>
