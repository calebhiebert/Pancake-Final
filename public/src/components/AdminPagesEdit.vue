<template>
  <div class="ui clearing segment">
    <form class="ui form" :class="{ error: errors.any() }">
      <div class="field">
        <label for="title">Title</label>
        <input id="title" name="title" v-model="page.title" v-validate="{ required: true, min: 3, max: 255 }">
      </div>
      <div class="field">
        <label for="content">Content</label>
        <textarea id="content" name="content" v-model="page.content" v-validate="{ required: true, min: 3, max: 16000}"></textarea>
      </div>
      <div class="ui error message" v-if="errors.any()">
        <ul>
          <li v-for="error in errors.all()">{{ error }}</li>
        </ul>
      </div>
    </form>
    <button class="ui right floated primary button" :class="{ disabled: errors.any(), loading: status == 'SENT' }" @click="doEdit">Save</button>
    <button class="ui right floated button" @click="$router.push({name: 'AdminIndex'})">Cancel</button>
  </div>
</template>
<style>
  form {
    margin-bottom: 10px !important;
  }
</style>
<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'
  import {HTTP} from '../http-common'
  Vue.use(VeeValidate);

  export default {
    name: 'AdminPagesCreate',

    data() {
      return {
        status: '',

        originalTitle: '',

        page: {
          title: '',
          content: ''
        }
      }
    },

    created() {
      HTTP.get('/pages/' + this.$route.params.title)
        .then(response => {
          this.originalTitle = response.data.title;
          this.page = response.data
        })
        .catch(err => console.log(err))
    },

    methods: {
      doEdit() {
        this.status = 'SENT';

        HTTP.post('/pages/' + this.originalTitle, this.page)
          .then(response => { this.$router.push({name: 'AdminIndex'}); this.status = 'OK' })
          .catch(err => { console.log(err); this.status = 'ERR' })
      }
    }
  }
</script>
