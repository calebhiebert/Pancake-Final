<template>
  <div>
    <form class="ui form">
      <div class="field">
        <label>Name</label>
        <input type="text" v-model="product.name">
      </div>
      <div class="field">
        <label>Description</label>
        <textarea v-model="product.description"></textarea>
      </div>
      <div class="field">
        <label>Stock Quantity</label>
        <input type="number" v-model="product.stockQuantity">
      </div>
      <div class="field">
        <label>Price</label>
        <input type="number" v-model="product.price">
      </div>
    </form>
    <button class="ui primary button">Create</button>
    <button class="ui button" @click="$router.push({ name: 'Home' })">Cancel</button>
  </div>
</template>
<script>
  export default {
    name: 'ProductCreate',

    data() {
      return {
        product: {
          name: '',
          description: '',
          stockQuantity: 0,
          price: '',
          category: ''
        }
      }
    }
  }
</script>
<style>
  form {
    margin-bottom: 10px;
  }
</style>
