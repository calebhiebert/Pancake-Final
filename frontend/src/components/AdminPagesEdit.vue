<template>
  <div class="ui clearing container segment">
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
    <button class="ui right floated basic red button" :class="{ loading: status == 'DELETING' }"  @click="doDelete">Delete</button>
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
  import {EventBus} from '../EventBus'
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
          .then(response => {
            EventBus.$emit('page-edited');
            this.$router.push({name: 'AdminIndex'})
          })
          .catch(err => { console.log(err); this.status = 'ERR' })
      },

      doDelete() {
        this.status = 'DELETING';

        HTTP.delete('/pages/' + this.originalTitle)
          .then(response => {
            this.$router.push({name: 'AdminIndex'});
            EventBus.$emit('page-edited');
          })
          .catch(err => console.log(err))
      }
    }
  }
</script>
