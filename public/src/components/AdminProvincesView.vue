<template>
  <table class="ui compact celled table">
    <thead>
    <tr>
      <th></th>
      <th>Code</th>
      <th>Name</th>
      <th>GST</th>
      <th>PST</th>
      <th>HST</th>
    </tr>
    </thead>
    <tbody>
    <admin-province-row-view v-for="province in provinces" :province="province" :key="province.id"></admin-province-row-view>
    <admin-province-row-create @created="onNewProvince"></admin-province-row-create>
    </tbody>
    <tfoot>
    <tr>
      <th colspan="6">
        <button class="ui primary button" @click="$router.push({name: 'AdminProvincesCreate'})">Add Province</button>
      </th>
    </tr>
    </tfoot>
  </table>
</template>
<script>
  import {HTTP} from '../http-common'
  import AdminProvinceRowCreate from "./AdminProvinceRowCreate.vue";
  import AdminProvinceRowView from "./AdminProvincesRowView.vue";

  export default {
    components: {
      AdminProvinceRowView,
      AdminProvinceRowCreate},
    name: 'AdminProvincesView',

    data() {
      return {
        provinces: []
      }
    },

    created() {
      this.load()
    },

    methods: {
      load() {
        HTTP.get('/provinces')
          .then(response => {
            response.data.forEach(p => p.editMode = false);
            this.provinces = response.data;
          })
          .catch(err => console.log(err))
      },

      onNewProvince(province) {
        province.editMode = false;
        this.provinces.push(province);
      }
    }
  }
</script>
