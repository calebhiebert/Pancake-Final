<template>
  <div class="ui container">
    <div class="ui steps">
      <div class="step" :class="{ completed: loggedin, active: !loggedin }">
        <i class="user icon"></i>
        <div class="content">
          <div class="title">Log In</div>
          <div class="description">Tell us who you are</div>
        </div>
      </div>
      <div class="step">
        <i class="payment icon"></i>
        <div class="content">
          <div class="title">Billing</div>
          <div class="description">Confirm billing info</div>
        </div>
      </div>
    </div>
    <div class="ui message" v-if="!loggedin">
      Please log in to continue
    </div>
    <div class="ui segment" v-if="billing">
      This will contain a summary of the order
    </div>
  </div>
</template>
<script>
  import {EventBus, Me} from '../EventBus'

  export default {
    name: 'Checkout',

    data() {
      return {
        loggedin: false,
        billing: false
      }
    },

    watch: {
      loggedin() {
        this.billing = this.loggedin
      }
    },

    mounted() {
      this.loggedin = Me.me !== null;
      EventBus.$on('me-updated', () => this.loggedin = Me.me !== null)
    }
  }
</script>
