<template>
  <div class="item">
    <div class="ui tiny image">
      <img :src="img + '/50'">
    </div>
    <div class="content">
      <div class="ui right floated blue label">
        <i class="dollar icon"></i>
        {{ (item.product.price * item.quantity).toFixed(2) }}
      </div>
      <a class="header">
        {{ item.product.name }}
      </a>
      <div class="meta">
        <span>${{ item.product.price }}</span>
        <span>x{{ item.quantity }}</span>
      </div>
      <div class="extra">
        <div class="ui right floated mini action input" v-if="editMode">
          <input type="number" placeholder="Quantity" min="1" v-model.number="editedQuantity">
          <button class="ui teal button" :class="{loading: saving}" @click="doSave">Save</button>
          <button class="ui button" @click="editMode = false">Cancel</button>
        </div>
        <a :title="'Remove ' + item.product.name" @click="doRemove" v-if="!removing">Remove</a>
        <span v-else>Removing...<span class="ui active inline mini loader"></span></span>
        <a title="Edit Quantity" @click="doEdit">Edit Quantity</a>
      </div>
    </div>
  </div>
</template>
<script>
  import {HTTP, GETIMG} from '../http-common'

  export default {
    name: 'CartItem',

    props: ['item'],

    data() {
      return {
        editedQuantity: 0,
        saving: false,
        removing: false,
        editMode: false
      }
    },

    computed: {
      img() {
        if(this.item.product.images.length === 0) {
          return ''
        } else {
          let img = this.item.product.images[0];
          return GETIMG(img.ident)
        }
      }
    },

    methods: {
      doEdit() {
        this.editedQuantity = this.item.quantity;
        this.editMode = true;
      },

      doSave() {
        if(this.editedQuantity <= 0) {
          this.editMode = false;
          return
        }

        this.saving = true;

        HTTP.post('/cart/add', {product_id: this.item.product.id, quantity: this.editedQuantity})
          .then(response => {
            this.saving = false;
            this.editMode = false;
            this.$emit('cart-changed', response.data)
          })
          .catch(err => console.log(err))
      },

      doRemove() {
        this.removing = true;

        HTTP.post('/cart/remove', {product_id: this.item.product.id})
          .then(response => {
            this.removing = false;
            this.$emit('cart-changed', response.data)
          })
          .catch(err => console.log(err))
      }
    }
  }
</script>
