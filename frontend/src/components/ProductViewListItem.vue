<template>
    <div class="item">
        <div class="ui small rounded image">
            <div class="ui blue ribbon label" v-if="moment(product.created_at).isBetween(moment().subtract(5, 'days'), moment())">New!</div>
            <div class="ui orange ribbon label" v-else-if="moment(product.updated_at).isBetween(moment().subtract(5, 'days'), moment())">Recently Updated!</div>
            <img :src="img">
        </div>
        <div class="content">
            <router-link :to="{ name: 'ProductView', params: { id: product.id } }" class="header">{{ product.name }}
            </router-link>
            <div class="description">
                <p>{{ product.description }}</p>
            </div>
        </div>
    </div>
</template>
<script>
    import {GETIMG} from '../http-common'
    import moment from 'moment'

    export default {
        name: 'ProductViewListItem',
        props: ['product'],

        data() {
            return {
                moment
            }
        },

        computed: {
            img() {
                if (this.product.images.length === 0) {
                    return ''
                } else {
                    return GETIMG(this.product.images[0].ident, this.product.images[0].ext)
                }
            }
        }
    }
</script>
