<template>
  <div class="ui modal">
    <i class="close icon"></i>
    <div class="header">Login</div>
    <div class="content ui form">
      <div class="field">
        <label for="email">Email</label>
        <div class="ui fluid input">
          <input id="email" name="email" v-model="email" v-validate="'required'" placeholder="Email" @keyup.enter="doLogin">
        </div>
      </div>
      <div class="ui visible negative message" v-if="errors.has('email')">{{ errors.first('email') }}</div>
      <div class="field">
        <label for="password">Password</label>
        <div class="ui fluid input">
          <input id="password" name="password" v-model="password" v-validate="'required'" type="password" placeholder="Password" @keyup.enter="doLogin">
        </div>
      </div>
      <div class="ui visible negative message" v-if="errors.has('password')">{{ errors.first('password') }}</div>
      <div class="ui visible negative message" v-if="status == 'BAD_LOGIN'">The username or password were incorrect</div>
    </div>
    <div class="actions">
      <div class="ui black deny button">
        Cancel
      </div>
      <div class="ui positive right labeled icon button" :class="{ loading: status == 'LOGGING_IN' }" @click="doLogin">
        Login
        <i class="checkmark icon"></i>
      </div>
    </div>
  </div>
</template>
<script>
  import {HTTP} from '../http-common'
  import {EventBus, Me} from '../EventBus'
  import Vue from 'vue';
  import VeeValidate from 'vee-validate';

  Vue.use(VeeValidate);

  export default {
    name: 'LoginModal',

    data() {
      return {
        status: 'IDLE',
        email: '',
        password: ''
      }
    },

    methods: {
      doLogin() {
        this.status = 'LOGGING_IN';

        HTTP.post('/login', { email: this.email, password: this.password })
          .then(response => {
            console.log(response);
            $(this.$el).modal('hide');
            this.$emit('close');

            HTTP.get('/me')
              .then(response => {
                Me.me = response.data;
                EventBus.$emit('me-updated');
              })
              .catch(err => console.log(err))
          })
          .catch(err => {
            if(err.response && err.response.status === 400)
              this.status = 'BAD_LOGIN';
            else
              console.log(err)
          })
      }
    },

    mounted() {
      let vm = this;

      $(this.$el)
        .modal({
          onDeny() {
            vm.$emit('close')
          },

          onApprove() {
            return false
          },

          onHide() {
            vm.$emit('close')
          }
        })
        .modal('show')
    }
  }
</script>
