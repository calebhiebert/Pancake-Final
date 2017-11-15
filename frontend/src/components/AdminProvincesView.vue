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
            <th>Code</th>
            <th>Name</th>
            <th>GST</th>
            <th>PST</th>
            <th>HST</th>
        </tr>
        </thead>
        <tbody>
        <admin-province-row-view v-for="province in provinces" :province="province" :key="province.id"
                                 @deleted="load()"></admin-province-row-view>
        <admin-province-row-create @created="onNewProvince" v-if="addingProvince"></admin-province-row-create>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="6">
                <button class="ui primary button" @click="onAddProvince">{{ addingProvince ? 'Cancel' : 'Add Province'
                    }}
                </button>
            </th>
        </tr>
        </tfoot>
    </table>
</template>
<script>
    import {HTTP} from '../http-common'
    import AdminProvinceRowCreate from "./AdminProvinceRowCreate.vue";
    import AdminProvinceRowView from "./AdminProvincesRowView.vue";

    export default {
        components: {
            AdminProvinceRowView,
            AdminProvinceRowCreate
        },
        name: 'AdminProvincesView',

        data() {
            return {
                loading: true,
                addingProvince: false,
                provinces: []
            }
        },

        created() {
            this.load()
        },

        methods: {
            load() {
                this.loading = true;

                HTTP.get('/provinces')
                    .then(response => {
                        response.data.forEach(p => p.editMode = false);
                        this.provinces = response.data;
                        this.loading = false;
                    })
                    .catch(err => console.log(err))
            },

            onNewProvince(province) {
                province.editMode = false;
                this.provinces.push(province);
                this.addingProvince = false;
            },

            onAddProvince() {
                if (this.addingProvince)
                    this.$emit('reset-new-province-row');

                this.addingProvince = !this.addingProvince
            }
        }
    }
</script>
