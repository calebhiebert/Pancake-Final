<template>
  <div class="item">
    <div class="ui small image">
      <img src="https://picsum.photos/100/100">
    </div>
    <div class="content">
      <a class="header">
        {{ item.product.name }}
      </a>
      <div class="meta">
        <span>${{ item.product.price }}</span>
        <span>x{{ item.quantity }}</span>
      </div>
      <div class="description">
        <p>{{ item.product.description }}</p>
      </div>
      <div class="extra">
        <i class="red right floated large remove link icon" :title="'Remove ' + item.product.name"></i>

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
