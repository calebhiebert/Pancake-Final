<template>
    <div class="ui container">
        <div class="center aligned basic segment">
            <div class="ui fluid action left icon input" :class="{loading: loadingResults}">
                <input id="search" placeholder="Search..." v-model="query">
                <i class="search icon"></i>
                <select class="ui compact selection dropdown" v-model="category">
                    <option value="">All</option>
                    <option v-for="category in categories" :key="category" :value="category">{{ titleCase(category) }}
                    </option>
                </select>
            </div>
        </div>

        <div class="ui divided items" v-if="items.length > 0">
            <product-view-list-item v-for="product in items" :product="product" :key="product.id"></product-view-list-item>
        </div>
        <div class="ui visible message" v-else>
            <p>There were no results :(</p>
        </div>
    </div>
</template>
<script>
    import {HTTP} from '../http-common'
    import ProductView from "./ProductView.vue";
    import ProductViewListItem from "./ProductViewListItem.vue";
    import axios from 'axios'

    let CancelToken = axios.CancelToken;
    let source = CancelToken.source();

    export default {
        components: {
            ProductViewListItem,
            ProductView
        },
        name: 'SearchView',

        data() {
            return {
                loadingResults: false,
                query: '',
                items: [],
                categories: [],
                category: ''
            }
        },

        watch: {
            $route() {
                this.query = this.$route.query.query;
                this.doSearch()
            },

            query() {
                this.$router.replace({name: 'SearchView', query: {query: this.query}})
            },

            category() {
                if (this.category.trim() !== '')
                    this.$router.replace({name: 'SearchView', query: {query: this.query, category: this.category}});
                else
                    this.$router.replace({name: 'SearchView', query: {query: this.query}});
            }
        },

        mounted() {
            document.getElementById('search').focus();
            this.query = this.$route.query.query;
            this.category = (this.$route.query.category || '');
        },

        created() {
            this.loadCategories()
        },

        methods: {
            doSearch() {
                if(this.loadingResults) {
                    source.cancel('Another Search');
                    source = CancelToken.source();
                }

                if (this.query.trim() === '') {
                    this.items = [];
                    this.loadingResults = false;
                    return;
                }

                this.loadingResults = true;

                HTTP.get('/products/search?query=' + this.query + (this.category !== '' ? '&category=' + this.category : ''), {
                    cancelToken: source.token
                })
                    .then(response => {
                        this.items = response.data;
                        this.loadingResults = false
                    })
                    .catch(err => {
                        if(axios.isCancel(err)) {
                            console.log('Request Canceled')
                        } else {
                            console.log(err)
                        }
                    })
            },

            loadCategories() {
                HTTP.get('/products/categories')
                    .then(response => this.categories = response.data)
                    .catch(err => console.log(err))
            },

            titleCase(str) {
                return str.replace(/\w\S*/g, function (txt) {
                    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
                });
            }
        }
    }
</script>
