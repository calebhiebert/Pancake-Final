<template>
  <div id="dzone" class="ui segment" :class="{ raised: hovering }">
    <a>
      <div class="ui basic center aligned segment" id="clickme">
        <div class="ui horizontal divider header">
          <i class="upload icon"></i>
          Drag / Click
        </div>
      </div>
    </a>
    <div class="ui four stackable cards">
      <div class="card" v-for="image in product.images">
        <div class="ui image">
          <img :src="getImg(image.ident, image.ext)">
        </div>
        <div class="extra content">
          {{ image.ext }}
          <a class="right floated star" @click="removeImage(image.ident)">
            <i class="remove icon"></i>
            Remove
          </a>
        </div>
      </div>

      <div class="card" v-for="image in files">
        <div class="ui image">
          <img :src="image.src">
        </div>
        <div class="extra content">Uploading... <span class="ui active inline mini loader"></span></div>
        <progress-bar :percentage="image.percentage" :done="image.done"></progress-bar>
      </div>
    </div>
  </div>
</template>
<script>
  import {HTTP, BASEURL, GETIMG} from '../http-common'
  import Dropzone from 'dropzone'
  import ProgressBar from "./ProgressBar.vue";

  let dropzone;

  export default {
    components: {ProgressBar},
    name: 'AdminImageEdit',

    props: ['product'],

    data() {
      return {
        hovering: false,
        files: {}
      }
    },

    methods: {
      removeImage(ident) {
        HTTP.delete('/images/' + ident)
          .then(response => {
            this.product.images = this.product.images.filter(i => i.ident !== response.data.ident)
          })
          .catch(err => console.log(err))
      },

      getImg(ident, ext) {
        return GETIMG(ident, ext)
      }
    },

    mounted() {
      let vm = this;

      dropzone = new Dropzone('div#dzone', {
        url: BASEURL + '/images/' + this.product.id,
        paramName: 'image',
        clickable: '#clickme',
        autoQueue: true,
        acceptedFiles: 'image/*',

        dragenter(event) {
          vm.hovering = true;
        },

        dragleave(event) {
          vm.hovering = false;
        },

        dragover(event) {
          vm.hovering = true;
        },

        drop(event) {
          vm.hovering = false;
        },

        addedfile(file) {
          vm.$set(vm.files, file.upload.uuid, {
            type: file.type,
            src: null,
            done: false,
            percentage: 0
          });
        },

        removedfile(file) {
          delete vm.files[file.upload.uuid]
        },

        thumbnail(file, datauri) {
          vm.$set(vm.files[file.upload.uuid], 'src', datauri);
        },

        error(file, err, xhr) {
          console.log(err);
          console.log(xhr);
        },

        uploadprogress(file, percent) {
          vm.$set(vm.files[file.upload.uuid], 'percentage', percent)
        },

        success(file, response) {
          vm.$set(vm.files[file.upload.uuid], 'done', true);
          vm.product.images.push(response);
        }
      });

      dropzone.on('success', file => {
        dropzone.removeFile(file);
      })
    }
  }
</script>
