<template>
    <div class="ui container" v-if="loading">
        <div class="ui icon message">
            <i class="notched circle loading icon"></i>
            <div class="content">
                <div class="header">Loading</div>
            </div>
        </div>
    </div>
    <table class="ui compact celled table" v-else>
        <thead>
        <tr>
            <th></th>
            <th>Name</th>
            <th>Stock</th>
            <th>Price</th>
            <th>Created</th>
            <th>Last Updated</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="product in productsInPage">
            <td class="collapsing">
                <i class="edit link icon"
                   @click="$router.push({name: 'AdminProductEdit', params: {id: product.id}})"></i>
            </td>
            <td>
                <router-link :to="{name: 'ProductView', params: {id: product.id}}">{{product.name}}</router-link>
            </td>
            <td>{{product.stock_quantity}}</td>
            <td>{{product.price}}</td>
            <td>{{ moment(product.created_at).format('llll') }}</td>
            <td>{{ moment(product.updated_at).format('llll') }}</td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="7">
                <button class="ui primary button" @click="$router.push({name: 'AdminProductCreate'})">Add Product
                </button>
                <div class="ui right floated pagination menu" v-if="numPages > 1">
                    <a class="icon item" @click="prevPage()"><i class="left chevron icon"></i></a>
                    <a class="item" v-for="n in numPages" :class="{ active: pageState.page == n }"
                       @click="pageState.page = n">{{n}}</a>
                    <a class="icon item" @click="nextPage()"><i class="right chevron icon"></i></a>
                </div>
            </th>
        </tr>
        </tfoot>
    </table>
</template>
<script>
    import {HTTP} from '../http-common'
    import moment from 'moment'

    export default {
        name: 'AdminProductsView',

        props: ['pageState'],

        data() {
            return {
                loading: true,
                products: [],
                moment
            }
        },

        computed: {
            numPages() {
                return Math.ceil(this.products.length / this.pageState.productsPerPage)
            },
            productsInPage() {
                let start = (this.pageState.page - 1) * this.pageState.productsPerPage;
                return this.products.slice(start, start + this.pageState.productsPerPage)
            }
        },

        methods: {
            nextPage() {
                if (this.pageState.page < this.numPages)
                    this.pageState.page++
            },

            prevPage() {
                if (this.pageState.page > 1)
                    this.pageState.page--
            }
        },

        created() {
            HTTP.get('/products')
                .then(response => {
                    this.products = response.data;
                    this.loading = false;
                })
                .catch(err => console.log(err))
        }
    }
</script>
