<template>
    <div class="ui container">
        <div class="ui four steps">
            <div class="step" :class="{ completed: loggedin, active: !loggedin }">
                <i class="user icon"></i>
                <div class="content">
                    <div class="title">Log In</div>
                    <div class="description">Tell us who you are</div>
                </div>
            </div>
            <div class="step" :class="{ completed: confirmed && order !== null, active: loggedin && !confirmed }">
                <i class="shopping basket icon"></i>
                <div class="content">
                    <div class="title">Confirm Order</div>
                    <div class="description">Lock in those products</div>
                </div>
            </div>
            <div class="step"
                 :class="{ active: confirmed && order !== null && order.status == 'UNPAID', completed: order !== null && order.status == 'PAID' }">
                <i class="payment icon"></i>
                <div class="content">
                    <div class="title">Billing</div>
                    <div class="description">Confirm billing info</div>
                </div>
            </div>
            <div class="step" :class="{completed: order !== null && order.status == 'PAID'}">
                <i class="payment icon"></i>
                <div class="content">
                    <div class="title">Payment</div>
                    <div class="description">Please give us your money</div>
                </div>
            </div>
        </div>


        <div class="ui message" v-if="!loggedin">
            Please log in to continue
        </div>


        <checkout-cart-display :cart="cart" :me="me" v-if="!loading && loggedin && !confirmed"></checkout-cart-display>
        <button class="ui right floated right labeled green icon button" :class="{ loading: confirming }"
                v-if="!loading && loggedin && !confirmed" @click="confirmOrder">
            <i class="checkmark icon"></i>
            Confirm Order
        </button>

        <checkout-order-display :processing="processing" :order="order"
                                v-if="!loading && order !== null && order.status == 'UNPAID'" @pay="pay"
                                :class="{loading: processing}"></checkout-order-display>

        <div class="ui positive visible message" v-if="!loading && order !== null && order.status == 'PAID'">
            <span class="header">All Done!</span>
            <p>Your order is complete and will be shipped soon</p>
        </div>
    </div>
</template>
<script>
    import CheckoutOrderDisplay from "./CheckoutOrderDisplay.vue";

    let order = null;
    let vm = null;
    let handler = StripeCheckout.configure({
        key: 'pk_test_xWpnvA7uBgwI34wvfT4ZsFbH',
        locale: 'auto',

        token(token) {
            console.log(token);
            HTTP.post('/billme', {token: token, orderid: order.id})
                .then(response => {
                    console.log(response);
                    vm.order = response.data;
                    vm.processing = false;
                })
                .catch(err => console.log(err))
        }
    });

    import {EventBus, Me} from '../EventBus'
    import {HTTP} from '../http-common'
    import CheckoutCartDisplay from "./CheckoutCartDisplay.vue";

    export default {
        components: {
            CheckoutCartDisplay,
            CheckoutOrderDisplay
        },
        name: 'Checkout',

        data() {
            return {
                order: null,
                cart: [],
                loggedin: false,
                confirmed: false,
                confirming: false,
                processing: false,
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
            },

            $route() {
                if (this.$route.params.orderid !== undefined) {
                    this.loadOrder(this.$route.params.orderid)
                }
            }
        },

        methods: {
            load() {
                this.loading = true;

                HTTP.get('/me')
                    .then(response => {
                        Me.me = response.data;
                        EventBus.$emit('me-updated');

                        if (this.cart.length > 0) {
                            this.loading = false;
                        }
                    })
                    .catch(err => console.log(err))
            },

            loadOrder(id) {
                HTTP.get('/orders/' + id)
                    .then(response => {
                        this.order = response.data;
                        this.confirmed = true;
                        order = this.order;

                        if (this.me !== null) {
                            this.loading = false;
                        }
                    })
                    .catch(err => console.log(err))
            },

            loadCart() {
                HTTP.get('/cart')
                    .then(response => {
                        this.cart = response.data;

                        if (this.me !== null) {
                            this.loading = false;
                        }

                        if (this.cart.length === 0) {
                            this.$router.replace({name: 'Home'});
                        }
                    })
                    .catch(err => console.log(err));
            },

            confirmOrder() {
                this.confirming = true;

                HTTP.post('/orders')
                    .then(response => {
                        this.confirming = false;
                        this.confirmed = true;

                        this.$router.replace({name: 'CheckoutOrderConf', params: {orderid: response.data.id}});
                    })
                    .catch(err => console.log(err))
            },

            pay(total) {
                this.processing = true;

                handler.open({
                    name: 'Willy\'s Wood',
                    currency: 'cad',
                    amount: total * 100
                });
            }
        },

        created() {
            vm = this;
            this.loggedin = Me.me !== null;

            EventBus.$on('me-updated', () => {
                this.loggedin = Me.me !== null;
                this.me = Me.me
            });

            this.load();

            if (this.$route.params.orderid !== undefined) {
                this.loadOrder(this.$route.params.orderid)
            } else {
                this.loadCart()
            }
        }
    }
</script>
