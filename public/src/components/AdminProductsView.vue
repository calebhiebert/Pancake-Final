<template>
  <table class="ui compact celled table">
    <thead>
    <tr>
      <th></th>
      <th>Name</th>
      <th>Description</th>
      <th>Stock</th>
      <th>Price</th>
      <th>Created</th>
      <th>Last Updated</th>
    </tr>
    </thead>
    <tbody>
    <tr v-for="product in products">
      <td class="collapsing"><button class="ui basic icon button"><i class="edit icon"></i></button></td>
      <td>{{product.name}}</td>
      <td>{{product.description}}</td>
      <td>{{product.stock_quantity}}</td>
      <td>{{product.price}}</td>
      <td>{{product.created_at}}</td>
      <td>{{product.updated_at}}</td>
    </tr>
    </tbody>
  </table>
</template>
<script>
  import {HTTP} from '../http-common'

  export default {
    name: 'AdminProductsView',

    data() {
      return {
        products: []
      }
    },

    created() {
      HTTP.get('/products')
        .then(response => {
          this.products = response.data
        })
        .catch(err => console.log(err))
    }
  }
</script>
