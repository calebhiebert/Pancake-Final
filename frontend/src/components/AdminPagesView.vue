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
            <th>Created</th>
            <th>Last Updated</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="page in pages">
            <td class="collapsing" @click="$router.push({ name: 'AdminPagesEdit', params: { title: page.title }})"><i
                    class="edit link icon"></i></td>
            <td>
                <router-link :to="{name: 'PageView', params: {title: page.title}}">{{page.title}}</router-link>
            </td>
            <td>{{ moment(page.created_at).format('llll') }}</td>
            <td>{{ moment(page.updated_at).format('llll') }}</td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="4">
                <button class="ui primary button" @click="$router.push({name: 'AdminPagesCreate'})">Add Page</button>
            </th>
        </tr>
        </tfoot>
    </table>
</template>
<script>
    import {HTTP} from '../http-common'
    import moment from 'moment'

    export default {
        name: 'AdminPagesView',

        data() {
            return {
                pages: [],
                loading: true,
                moment
            }
        },

        created() {
            HTTP.get('/pages')
                .then(response => {
                    this.pages = response.data;
                    this.loading = false;
                })
                .catch(err => console.log(err))
        }
    }
</script>
