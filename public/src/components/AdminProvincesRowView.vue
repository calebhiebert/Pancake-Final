<template>
  <tr class="ui form" v-if="province.editMode">
    <td class="collapsing"><i class="save link icon" v-if="!saving" @click="doSave"></i><div class="ui mini active inline loader" v-else></div></td>
    <td class="inline field"><input name="code" placeholder="Code" v-model="province.province_code" v-validate="{required: true, min: 2, max: 2}"></td>
    <td class="inline field"><input name="name" placeholder="Name" v-model="province.name" v-validate="'required'"></td>
    <td class="inline field"><input type="number" name="gst" placeholder="GST" v-model="province.gst" v-validate="'decimal'"></td>
    <td class="inline field"><input type="number" name="pst" placeholder="PST" v-model="province.pst" v-validate="'decimal'"></td>
    <td class="inline field"><input type="number" name="hst" placeholder="HST" v-model="province.hst" v-validate="'decimal'"></td>
  </tr>
  <tr v-else>
    <td class="collapsing" @click="province.editMode = true"><i class="edit link icon"></i></td>
    <td>{{province.province_code}}</td>
    <td>{{province.name}}</td>
    <td>{{province.gst}}</td>
    <td>{{province.pst}}</td>
    <td>{{province.hst}}</td>
  </tr>
</template>
<script>
  import {HTTP} from '../http-common'
  import Vue from 'vue';
  import VeeValidate from 'vee-validate';

  Vue.use(VeeValidate);

  export default {
    name: 'AdminProvinceRowView',

    props: ['province'],

    data() {
      return {
        saving: false,
        code: '',
        name: '',
        gst: 0,
        pst: 0,
        hst: 0
      }
    },

    methods: {
      doSave() {
        this.saving = true;

        HTTP.post('/provinces/' + this.province.id, {province_code: this.code, name: this.name, gst: this.gst, pst: this.pst, hst: this.hst})
          .then(response => {
            this.$emit('edited', response.data);
            this.saving = false;
            this.province.editMode = false;
          })
          .catch(err => console.log(err))
      }
    }
  }
</script>
