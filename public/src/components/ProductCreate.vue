<template>
  <div>
    <form class="ui form" :class="{ error: errors.any() }">
      <div class="field">
        <label>Name</label>
        <input type="text" name="name" v-model="product.name" v-validate="{ required: true, min: 3, max: 255 }">
      </div>

      <div class="field">
        <label>Description</label>
        <textarea v-model="product.description" name="description" v-validate="{ required: true, min: 3, max: 16000 }"></textarea>
      </div>
      <div class="field">
        <label>Stock Quantity</label>
        <input type="number" v-model="product.stockQuantity" name="stock_quantity" v-validate="{ required: true, min_value: 0 }">
      </div>
      <div class="field">
        <label>Price</label>
        <input type="number" v-model="product.price" name="price" v-validate="{ required: true, min_value: 0.00 }">
      </div>
      <div class="ui error message" v-if="errors.any()">
        <ul>
          <li v-for="error in errors.all()">{{ error }}</li>
        </ul>
      </div>
    </form>
    <button class="ui primary button">Create</button>
    <button class="ui button" @click="$router.push({ name: 'Home' })">Cancel</button>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'
  Vue.use(VeeValidate);

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
