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
    <tr v-for="province in provinces">
      <td class="collapsing" @click="$router.push({ name: 'AdminProvincesEdit', params: { id: province.id }})"><i class="edit link icon"></i></td>
      <td>{{province.province_code}}</td>
      <td>{{province.name}}</td>
      <td>{{province.gst}}</td>
      <td>{{province.pst}}</td>
      <td>{{province.hst}}</td>
    </tr>
    <admin-province-row-create></admin-province-row-create>
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

  export default {
    components: {AdminProvinceRowCreate},
    name: 'AdminProvincesView',

    data() {
      return {
        provinces: []
      }
    },

    created() {
      HTTP.get('/provinces')
        .then(response => {
          this.provinces = response.data
        })
        .catch(err => console.log(err))
    }
  }
</script>
