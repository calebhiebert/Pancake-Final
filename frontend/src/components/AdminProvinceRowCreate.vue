<template>
  <tr class="ui form">
    <td class="collapsing"><i class="save link icon" v-if="!saving" @click="doSave"></i><div class="ui mini active inline loader" v-else></div></td>
    <td class="inline field"><input name="code" placeholder="Code" v-model="code" v-validate="{required: true, min: 2, max: 2}"></td>
    <td class="inline field"><input name="name" placeholder="Name" v-model="name" v-validate="'required'"></td>
    <td class="inline field"><input type="number" name="gst" placeholder="GST" v-model="gst" v-validate="'decimal'"></td>
    <td class="inline field"><input type="number" name="pst" placeholder="PST" v-model="pst" v-validate="'decimal'"></td>
    <td class="inline field"><input type="number" name="hst" placeholder="HST" v-model="hst" v-validate="'decimal'"></td>
  </tr>
</template>
<script>
  import {HTTP} from '../http-common'
  import Vue from 'vue';
  import VeeValidate from 'vee-validate';

  Vue.use(VeeValidate);

  export default {
    name: 'AdminProvinceRowCreate',

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

        HTTP.post('/provinces', {province_code: this.code, name: this.name, gst: this.gst, pst: this.pst, hst: this.hst})
          .then(response => {
            this.$emit('created', response.data);
            this.reset()
          })
          .catch(err => console.log(err))
      },

      reset() {
        this.saving = false;
        this.code = this.name = '';
        this.gst = this.pst = this.hst = 0;
      }
    },

    created() {
      this.$parent.$on('reset-new-province-row', () => this.reset())
    }
  }
</script>
