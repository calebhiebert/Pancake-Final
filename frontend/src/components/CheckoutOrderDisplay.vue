<template>
  <div>
    <table class="ui padded celled table">
      <thead>
      <tr>
        <th>Product</th>
        <th>Quantity</th>
        <th>Price</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="li in order.order_product">
        <td>{{ li.product.name }}</td>
        <td>{{ li.quantity }}</td>
        <td>{{ (li.product.price * li.quantity).toFixed(2) }}</td>
      </tr>
      </tbody>
    </table>
    <div class="ui right aligned basic segment">
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

    <button class="ui right floated labeled green icon button" @click="$emit('pay', total)">
      <i class="payment icon"></i>
      Pay Now
    </button>
  </div>
</template>
<script>
  export default {
    name: 'CheckoutOrderDisplay',

    props: ['order'],

    computed: {
      subtotal() {
        let st = 0;

        this.order.order_product.forEach(li => {
          st += li.quantity * li.price
        });

        return st;
      },

      gst() {
        return this.subtotal * this.order.gst
      },

      pst() {
        return this.subtotal * this.order.pst
      },

      hst() {
        return this.subtotal * this.order.hst
      },

      total() {
        return this.subtotal + this.gst + this.pst + this.hst
      }
    }
  }
</script>
