<template>
  <table class="ui celled table">
    <thead>
    <tr>
      <th></th>
      <th>Name</th>
      <th>Created</th>
      <th>Last Updated</th>
    </tr>
    </thead>
    <tbody>
    <tr v-for="page in pages">
      <td class="collapsing"><button class="ui basic icon button" @click="$router.push({ name: 'AdminPagesEdit', params: { title: page.title }})"><i class="edit icon"></i></button></td>
      <td>{{page.title}}</td>
      <td>{{page.created_at}}</td>
      <td>{{page.updated_at}}</td>
    </tr>
    </tbody>
  </table>
</template>
<script>
  import {HTTP} from '../http-common'

  export default {
    name: 'AdminPagesView',

    data() {
      return {
        pages: []
      }
    },

    created() {
      HTTP.get('/pages')
        .then(response => {
          this.pages = response.data
        })
        .catch(err => console.log(err))
    }
  }
</script>
