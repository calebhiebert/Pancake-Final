<template>
  <div class="ui container">
    <div class="ui pointing menu">
      <router-link replace :to="{name: 'AdminIndex', query: {view: 'pages'}}" class="item" :class="{active: view == 'pages'}">Pages</router-link>
      <router-link replace :to="{name: 'AdminIndex', query: {view: 'products'}}" class="item" :class="{active: view == 'products'}">Products</router-link>
      <router-link replace :to="{name: 'AdminIndex', query: {view: 'provinces'}}" class="item" :class="{active: view == 'provinces'}">Provinces</router-link>
    </div>

    <admin-pages-view v-if="view == 'pages'"></admin-pages-view>
    <admin-products-view v-else-if="view == 'products'" :pageState="product"></admin-products-view>
    <admin-provinces-view v-else-if="view == 'provinces'"></admin-provinces-view>
    <div v-else>This page does not exist</div>
  </div>
</template>
<script>
  import AdminPagesView from "./AdminPagesView.vue";
  import AdminProductsView from "./AdminProductsView.vue";
  import AdminProvincesView from "./AdminProvincesView.vue";

  export default {
    components: {
      AdminProvincesView,
      AdminProductsView,
      AdminPagesView},

    name: 'AdminIndex',

    data() {
      return {
        view: 'pages',
        product: {
          productsPerPage: 2,
          page: 1
        }
      }
    },

    mounted() {
      this.view = (this.$route.query.view || 'pages');
      this.product.productsPerPage = (this.$route.query.ppp || 5);
      this.product.page = (this.$route.query.page || 1);

      if(this.view === 'products') {

      }
    },

    watch: {
      $route() {
        this.view = (this.$route.query.view || 'pages');
        this.product.productsPerPage = (this.$route.query.ppp || 5);
        this.product.page = (this.$route.query.page || 1);
      },

      'product.page'() {
        this.$router.replace({name: 'AdminIndex', query: {view: this.$route.query.view, ppp: this.product.productsPerPage, page: this.product.page}})
      }
    }
  }
</script>
