<template>
  <div class="ui clearing container segment">
    <form class="ui form" :class="{ error: errors.any() }">
      <div class="field">
        <label for="name">Name</label>
        <input id="name" name="name" v-model="product.name" v-validate="{ required: true, min: 3, max: 255 }">
      </div>

      <div class="field">
        <label for="description">Description</label>
        <textarea id="description" v-model="product.description" name="description"
                  v-validate="{ required: true, min: 3, max: 16000 }"></textarea>
      </div>
      <div class="field">
        <label for="stock">Stock Quantity</label>
        <input id="stock" type="number" v-model="product.stock_quantity" name="stock_quantity"
               v-validate="{ required: true, min_value: 0 }" data-vv-as="stock quantity">
      </div>
      <div class="field">
        <label for="price">Price</label>
        <div class="ui left icon input">
          <input id="price" type="number" v-model="product.price" name="price"
                 v-validate="{ required: true, min_value: 0.00 }">
          <i class="dollar icon"></i>
        </div>
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
    <button class="ui right floated green left labeled icon button" :class="{ loading: status == 'SENT_IMG', disabled: errors.any() }"
            @click="doCreate(true)">
      <i class="image icon"></i>
      Create & Add Images
    </button>
    <button class="ui right floated primary button" :class="{ loading: status == 'SENT', disabled: errors.any() }"
            @click="doCreate">Create
    </button>
    <button class="ui right floated button" @click="$router.push({ name: 'AdminIndex' })">Cancel</button>
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
          stock_quantity: 0,
          price: '',
          category: ''
        }
      }
    },

    methods: {
      doCreate(addimg = false) {
        this.$validator.validateAll();
        if(this.errors.any()) {
          return
        }

        this.status = addimg ? 'SENT_IMG' : 'SENT';

        HTTP.post('/products', {
          name: this.product.name,
          description: this.product.description,
          stock_quantity: this.product.stock_quantity,
          price: this.product.price,
          category: this.product.category
        })
          .then(response => {
            this.status = 'CREATED';
            if(addimg) {
              this.$router.push({name: 'AdminProductEdit', params: {id: response.data.id}})
            } else {
              this.$router.push({name: 'AdminIndex', query: {view: 'products'}})
            }
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
