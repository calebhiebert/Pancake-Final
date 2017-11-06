<template>
  <div>
    <form class="ui form" :class="{ error: errors.any() }">
      <div class="field">
        <label for="name">Name</label>
        <input id="name" name="name" v-model="product.name" v-validate="{ required: true, min: 3, max: 255 }">
      </div>

      <div class="field">
        <label for="description">Description</label>
        <textarea id="description" v-model="product.description" name="description" v-validate="{ required: true, min: 3, max: 16000 }"></textarea>
      </div>
      <div class="field">
        <label for="stock">Stock Quantity</label>
        <input id="stock" type="number" v-model="product.stockQuantity" name="stock_quantity" v-validate="{ required: true, min_value: 0 }">
      </div>
      <div class="field">
        <label for="price">Price</label>
        <input id="price" type="number" v-model="product.price" name="price" v-validate="{ required: true, min_value: 0.00 }">
      </div>
      <div class="ui error message" v-if="errors.any()">
        <ul>
          <li v-for="error in errors.all()">{{ error }}</li>
        </ul>
      </div>
    </form>
    <button class="ui primary button" :class="{ loading: status == 'SENT', disabled: errors.any() }" @click="doCreate">Create</button>
    <button class="ui button" @click="$router.push({ name: 'AdminIndex' })">Cancel</button>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'
  import {HTTP} from '../http-common'
  Vue.use(VeeValidate);

  export default {
    name: 'ProductCreate',

    data() {
      return {
        status: '',

        product: {
          name: '',
          description: '',
          stockQuantity: 0,
          price: '',
          category: ''
        }
      }
    },

    methods: {
      doCreate() {
        this.status = 'SENT';

        HTTP.post('/products', {
          name: this.product.name,
          description: this.product.description,
          stock_quantity: this.product.stockQuantity,
          price: this.product.price
        })
          .then(response => {
            this.status = 'CREATED';
            console.log(response)
          })
          .catch(err => {
            this.status = 'ERROR';
            console.log(err)
          })
      }
    }
  }
</script>
<style>
  form {
    margin-bottom: 10px;
  }
</style>
