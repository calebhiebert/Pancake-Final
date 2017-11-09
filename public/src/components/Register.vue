<template>
  <div class="ui clearing container segment">
    <form class="ui form" :class="{ error: errors.any() }">
      <div class="field">
        <label>Name</label>
        <div class="two fields">
          <div class="field">
            <input placeholder="First Name" name="first_name" v-model="first_name" v-validate="{required: true}">
          </div>
          <div class="field">
            <input placeholder="Last Name" name="last_name" v-model="last_name" v-validate="{required: true}">
          </div>
        </div>
      </div>
      <div class="field">
        <label>Email</label>
        <input placeholder="Email" type="email" name="email" v-model="email" v-validate="{required: true, email: true}">
      </div>
      <div class="field">
        <label>Password</label>
        <div class="two fields">
          <div class="field">
            <input placeholder="Password" type="password" name="password" v-model="password" v-validate="{required: true}">
          </div>
          <div class="field">
            <input placeholder="Password Confirmation" type="password" name="password_confirmation"
                   v-model="password_confirmation" v-validate="{required: true, confirmed: 'password'}">
          </div>
        </div>
      </div>
      <h4 class="ui dividing header">Shipping Information</h4>
      <div class="field">
        <label>Address</label>
        <div class="fields">
          <div class="twelve wide field">
            <input name="address" placeholder="Address" v-model="address" v-validate="{required: true}">
          </div>
          <div class="four wide field">
            <input name="postal_code" placeholder="Postal Code" v-model="postal_code"
                   v-validate="{required: true, regex: /^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ -]?\d[ABCEGHJ-NPRSTV-Z]\d$/i}">
          </div>
        </div>
      </div>
      <div class="field">
        <label>Province</label>
        <select class="ui fluid dropdown" v-model="province_code" name="province_code" v-validate="{required: true}">
          <option value="">Province</option>
          <option v-for="province in provinces" :value="province.province_code">{{ province.name }}</option>
        </select>
      </div>
      <div class="ui error message" v-if="errors.any()">
        <ul>
          <li v-for="error in errors.all()">{{ error }}</li>
        </ul>
      </div>
      <button type="button" class="ui right floated primary button">Register</button>
    </form>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'
  import {HTTP} from '../http-common'
  Vue.use(VeeValidate);

  export default {
    name: 'Register',

    created() {
      this.getProvinces()
    },

    data() {
      return {
        status: 'IDLE',
        email_status: 'IDLE',
        provinces: [],
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        password_confirmation: '',
        address: '',
        postal_code: '',
        province_code: ''
      }
    },

    methods: {
      getProvinces() {
        HTTP.get('/provinces')
          .then(response => this.provinces = response.data)
          .catch(err => console.log(err))
      }
    }
  }
</script>
