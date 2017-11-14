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
      <div class="step" :class="{ completed: confirmed, active: loggedin }">
        <i class="shopping basket icon"></i>
        <div class="content">
          <div class="title">Confirm Order</div>
          <div class="description">Lock in those products</div>
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
    <table class="ui celled padded table" v-if="!loading && loggedin">
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
    <div class="ui basic right aligned segment" v-if="!loading && loggedin">
      <span>Subtotal: {{ subtotal.toFixed(2) }}</span>
      <br/>
      <span v-if="gst != 0">GST: {{ gst.toFixed(2) }}</span>
      <br v-if="gst != 0" />
      <span v-if="pst != 0">PST: {{ pst.toFixed(2) }}</span>
      <br v-if="pst != 0" />
      <span v-if="hst != 0">HST: {{ hst.toFixed(2) }}</span>
      <br v-if="hst != 0" />
      <h4>Total: {{ total.toFixed(2) }}</h4>
    </div>
    <button class="ui right floated right labeled green icon button" v-if="!loading && loggedin" @click="confirmOrder">
      <i class="checkmark icon"></i>
      Confirm Order
    </button>
    <button class="ui right floated labeled green icon button" v-if="!loading && billing" @click="pay">
      <i class="payment icon"></i>
      Pay Now
    </button>
  </div>
</template>
<script>
  let handler = StripeCheckout.configure({
    key: 'pk_test_xWpnvA7uBgwI34wvfT4ZsFbH',
    locale: 'auto',

    token(token) {
      console.log(token)
    }
  });

  import {EventBus, Me} from '../EventBus'
  import {HTTP} from '../http-common'

  export default {
    name: 'Checkout',

    data() {
      return {
        cart: [],
        loggedin: false,
        confirmed: false,
        confirming: false,
        billing: false,
        loading: true,
        me: null
      }
    },

    watch: {
      loggedin() {
        this.billing = this.loggedin && this.confirmed
      },

      confirmed() {
        this.billing = this.loggedin && this.confirmed
      }
    },

    computed: {
      subtotal() {
        let st = 0;
        this.cart.forEach(it => st += (it.product.price * it.quantity));
        return st;
      },

      gst() {
        if(this.me != null)
          return this.subtotal * Me.me.location.province.gst;
        else
          return 0
      },

      pst() {
        if(this.me != null)
          return this.subtotal * Me.me.location.province.pst;
        else
          return 0
      },

      hst() {
        if(this.me != null)
          return this.subtotal * Me.me.location.province.hst;
        else
          return 0
      },

      total() {
        return this.subtotal + this.gst + this.pst + this.hst;
      }
    },

    methods: {
      load() {
        this.loading = true;

        HTTP.get('/cart')
          .then(response => {
            this.cart = response.data;

            if(this.me !== null) {
              this.loading = false;
            }
          })
          .catch(err => console.log(err));

        HTTP.get('/me')
          .then(response => {
            Me.me = response.data;
            EventBus.$emit('me-updated');

            if(this.cart.length > 0) {
              this.loading = false;
            }
          })
          .catch(err => console.log(err))
      },

      confirmOrder() {
        this.confirming = true;

        HTTP.post('/orders')
          .then(response => {
            this.confirming = false;
            console.log(response)
          })
          .catch(err => console.log(err))
      },

      pay() {
        handler.open({
          name: 'Willy\'s Wood',
          currency: 'cad',
          amount: this.total * 100
        })
      }
    },

    mounted() {
      this.loggedin = Me.me !== null;
      EventBus.$on('me-updated', () => {
        this.loggedin = Me.me !== null;
        this.me = Me.me
      });
      this.load()
    }
  }
</script>
