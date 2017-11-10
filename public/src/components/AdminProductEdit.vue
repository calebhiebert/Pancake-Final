<template>
  <div class="ui clearing container segment">
    <form class="ui form" :class="{ error: errors.any(), loading: loading }">
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
        <input id="stock" type="number" v-model="product.stock_quantity" name="stock_quantity" v-validate="{ required: true, min_value: 0 }">
      </div>
      <div class="field">
        <label for="price">Price</label>
        <input id="price" type="number" v-model="product.price" name="price" v-validate="{ required: true, min_value: 0.00 }">
      </div>
      <div class="field">
        <label for="category">Category</label>
        <input id="category" v-model="product.category" name="category" v-validate="{ required: false, min: 3, max: 255 }">
      </div>
      <div class="ui error message" v-if="errors.any()">
        <ul>
          <li v-for="error in errors.all()">{{ error }}</li>
        </ul>
      </div>
    </form>
    <button class="ui right floated primary button" :class="{ loading: status == 'SENT', disabled: errors.any() }" @click="doEdit">Save</button>
    <button class="ui right floated button" @click="$router.push({ name: 'AdminIndex' })">Cancel</button>
    <button class="ui right floated basic red button" :class="{ loading: status == 'DELETING'}" @click="doDelete">Delete</button>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'
  import {HTTP} from '../http-common'
  Vue.use(VeeValidate);

  export default {
    name: 'AdminProductEdit',

    data() {
      return {
        status: '',
        loading: false,

        product: {
          name: '',
          description: '',
          stock_quantity: 0,
          price: 0,
          category: ''
        }
      }
    },

    created() {
      this.loading = true;

      HTTP.get('/products/' + this.$route.params.id)
        .then(response => { this.product = response.data; this.loading = false })
        .catch(err => console.log(err))
    },

    methods: {
      doEdit() {
        this.status = 'SENT';

        HTTP.post('/products/' + this.product.id, {
          name: this.product.name,
          description: this.product.description,
          stock_quantity: this.product.stock_quantity,
          price: this.product.price,
          category: this.product.category
        })
          .then(() => {
            this.$router.push({name: 'AdminIndex'})
          })
          .catch(err => {
            this.status = 'ERROR';
            console.log(err)
          })
      },

      doDelete() {
        this.status = 'DELETING';

        HTTP.delete('/products/' + this.product.id)
          .then(() => this.$router.push({name: 'AdminIndex'}))
          .catch(err => console.log(err))
      }
    }
  }
</script>
<style>
  form {
    margin-bottom: 10px;
  }
</style>
