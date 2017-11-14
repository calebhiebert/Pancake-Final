<template>
  <div>
    <table class="ui celled padded table">
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
    <div class="ui basic right aligned segment">
      <span>Subtotal: {{ subtotal.toFixed(2) }}</span>
      <br/>
      <span v-if="gst != 0">GST: {{ gst.toFixed(2) }}</span>
      <br v-if="gst != 0"/>
      <span v-if="pst != 0">PST: {{ pst.toFixed(2) }}</span>
      <br v-if="pst != 0"/>
      <span v-if="hst != 0">HST: {{ hst.toFixed(2) }}</span>
      <br v-if="hst != 0"/>
      <h4>Total: {{ total.toFixed(2) }}</h4>
    </div>
  </div>
</template>
<script>
  export default {
    name: 'CheckoutCartDisplay',

    props: ['cart', 'me'],

    computed: {
      subtotal() {
        let st = 0;
        this.cart.forEach(it => st += (it.product.price * it.quantity));
        return st;
      },

      gst() {
        if (this.me != null)
          return this.subtotal * this.me.location.province.gst;
        else
          return 0
      },

      pst() {
        if (this.me != null)
          return this.subtotal * this.me.location.province.pst;
        else
          return 0
      },

      hst() {
        if (this.me != null)
          return this.subtotal * this.me.location.province.hst;
        else
          return 0
      },

      total() {
        return this.subtotal + this.gst + this.pst + this.hst;
      }
    }
  }
</script>
