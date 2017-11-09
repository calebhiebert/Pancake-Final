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
    <tr v-for="product in productsInPage">
      <td class="collapsing">
        <i class="edit link icon" @click="$router.push({name: 'AdminProductEdit', params: {id: product.id}})"></i>
      </td>
      <td><router-link :to="{name: 'ProductView', params: {id: product.id}}">{{product.name}}</router-link></td>
      <td>{{ truncate(product.description, 150) }}</td>
      <td>{{product.stock_quantity}}</td>
      <td>{{product.price}}</td>
      <td>{{product.created_at}}</td>
      <td>{{product.updated_at}}</td>
    </tr>
    </tbody>
    <tfoot>
    <tr>
      <th colspan="7">
        <button class="ui primary button" @click="$router.push({name: 'AdminProductCreate'})">Add Product</button>
        <div class="ui right floated pagination menu" v-if="numPages > 1">
          <a class="icon item" @click="prevPage()"><i class="left chevron icon"></i></a>
          <a class="item" v-for="n in numPages" :class="{ active: page == n }" @click="page = n">{{n}}</a>
          <a class="icon item" @click="nextPage()"><i class="right chevron icon"></i></a>
        </div>
      </th>
    </tr>
    </tfoot>
  </table>
</template>
<script>
  import {HTTP} from '../http-common'

  export default {
    name: 'AdminProductsView',

    data() {
      return {
        page: 1,
        productsPerPage: 3,
        products: []
      }
    },

    computed: {
      numPages() {
        return Math.ceil(this.products.length / this.productsPerPage)
      },
      productsInPage() {
        let start = (this.page - 1) * this.productsPerPage;
        return this.products.slice(start, start + this.productsPerPage)
      }
    },

    methods: {
      nextPage() {
        if(this.page < this.numPages)
          this.page++
      },

      prevPage() {
        if(this.page > 1)
          this.page--
      },

      truncate(str, num) {
        if(str.length > num) {
          str = str.slice(0, num);
          return str + '...';
        } else {
          return str
        }
      }
    },

    created() {
      HTTP.get('/products')
        .then(response => {
          this.products = response.data;
        })
        .catch(err => console.log(err))
    }
  }
</script>
