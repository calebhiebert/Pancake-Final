<template>
    <div class="ui clearing segment" :class="{loading: loading}">
        <h3 class="ui header">
            <router-link :to="{name: 'CartManage'}">Cart</router-link>
        </h3>
        <div class="ui celled list">
            <cart-item-compact-view v-for="item in cart" :item="item" :key="item.product.id"
                                    @removed="refreshCart"></cart-item-compact-view>
        </div>
        <button class="ui green right floated labeled icon button" @click="$router.push({name: 'CartManage'})">
            <i class="right arrow icon"></i>
            Checkout
        </button>
        <button class="ui primary right floated button" :class="{loading: status == 'ADDING'}"
                @click="addToCart">
            Add {{ quantity }} to Cart
        </button>
        <select id="quantselect" class="ui basic selection dropdown" v-model="quantity">
            <option v-for="n in 10" :value="n">{{n}}</option>
        </select>
    </div>
</template>
<script>
    import {HTTP} from '../http-common'
    import CartItemCompactView from "./CartItemCompact.vue";

    export default {
        components: {CartItemCompactView},
        name: 'Cart',

        props: ['product'],

        data() {
            return {
                status: 'IDLE',
                quantity: 1,
                cart: [],
                loading: true
            }
        },

        created() {
            this.refreshCart()
        },

        mounted() {
            $('#quantselect').dropdown()
        },

        methods: {
            addToCart() {
                this.status = 'ADDING';

                if (this.product !== null) {
                    HTTP.post('/cart/add', {product_id: this.product.id, quantity: this.quantity})
                        .then(response => {
                            this.cart = response.data;
                            this.status = 'IDLE'
                        })
                        .catch(err => console.log(err))
                }
            },

            refreshCart() {
                this.loading = true;

                HTTP.get('/cart')
                    .then(response => { this.cart = response.data; this.loading = false; })
                    .catch(err => console.log(err))
            }
        }
    }
</script>
