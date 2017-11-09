<template>
  <div class="ui container segment">
    <form class="ui form">
      <div class="field">
        <label>Name</label>
        <div class="two fields">
          <div class="field">
            <input placeholder="First Name" name="first_name" v-model="first_name">
          </div>
          <div class="field">
            <input placeholder="Last Name" name="last_name" v-model="last_name">
          </div>
        </div>
      </div>
      <div class="field">
        <label>Email</label>
        <input placeholder="Email" type="email" name="email" v-model="email">
      </div>
      <div class="field">
        <label>Password</label>
        <div class="two fields">
          <div class="field">
            <input placeholder="Password" type="password" name="password" v-model="password">
          </div>
          <div class="field">
            <input placeholder="Password Confirmation" type="password" name="password_confirmation"
                   v-model="password_confirmation">
          </div>
        </div>
      </div>
      <h4 class="ui dividing header">Shipping Information</h4>
      <div class="field">
        <label>Address</label>
        <div class="fields">
          <div class="twelve wide field">
            <input name="address" placeholder="Address" v-model="address">
          </div>
          <div class="four wide field">
            <input name="postal_code" placeholder="Postal Code" v-model="postal_code">
          </div>
        </div>
      </div>
      <div class="field">
        <label>Province</label>
        <select class="ui fluid dropdown">
          <option value="">Province</option>
        </select>
      </div>
    </form>
  </div>
</template>
<script>
  export default {
    name: 'Register',

    data() {
      return {
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        password_confirmation: '',
        address: '',
        postal_code: ''
      }
    }
  }
</script>
