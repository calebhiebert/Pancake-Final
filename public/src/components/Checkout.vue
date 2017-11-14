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
    <table class="ui celled padded table" v-if="billing">
      <thead>
      <tr>
        <th>Product</th>
        <th>Quantity</th>
        <th>Price</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in cart">
        <td>{{ item.product.name }}</td>
        <td>{{ item.quantity }}</td>
        <td>{{ (item.product.price * item.quantity).toFixed(2) }}</td>
      </tr>
      </tbody>
    </table>
    <button class="ui right floated labeled green button">
      Pay Now
    </button>
  </div>
</template>
<script>
  import {EventBus, Me} from '../EventBus'
  import {HTTP} from '../http-common'

  export default {
    name: 'Checkout',

    data() {
      return {
        cart: [],
        loggedin: false,
        billing: false,
        loading: true
      }
    },

    watch: {
      loggedin() {
        this.billing = this.loggedin
      }
    },

    methods: {
      loadCart() {
        this.loading = true;
        HTTP.get('/cart')
          .then(response => {
            this.cart = response.data;
            this.loading = false
          })
          .catch(err => console.log(err))
      },
    },

    mounted() {
      this.loggedin = Me.me !== null;
      EventBus.$on('me-updated', () => this.loggedin = Me.me !== null);
      this.loadCart()
    }
  }
</script>
