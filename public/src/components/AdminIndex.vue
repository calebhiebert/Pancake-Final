<template>
  <div class="ui container">
    <h2 class="ui header">Admin</h2>

    <h4 class="ui header">Pages</h4>
    <admin-pages-view></admin-pages-view>

    <h4 class="ui header">Products</h4>
    <admin-products-view></admin-products-view>

    <h4 class="ui header">Provinces</h4>
    <admin-provinces-view></admin-provinces-view>
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
    name: 'AdminIndex'
  }
</script>
