<template>
  <div class="ui container">
    <h2 class="ui header">Admin</h2>

    <h4 class="ui header">Pages</h4>
    <admin-pages-view></admin-pages-view>

    <h4 class="ui header">Products</h4>
    <admin-products-view></admin-products-view>
  </div>
</template>
<script>
  import AdminPagesView from "./AdminPagesView.vue";
  import AdminProductsView from "./AdminProductsView.vue";

  export default {
    components: {
      AdminProductsView,
      AdminPagesView},
    name: 'AdminIndex'
  }
</script>
