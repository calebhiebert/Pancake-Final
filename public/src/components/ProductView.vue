<template>
  <div class="item">
    <div class="image">
      <img src="https://semantic-ui.com/images/wireframe/image.png">
    </div>
    <div class="content">
      <a class="header">{{ product.name }}</a>
      <div class="description">
        <p>{{ product.description }}</p>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'ProductView',
    props: ['product']
  }
</script>
