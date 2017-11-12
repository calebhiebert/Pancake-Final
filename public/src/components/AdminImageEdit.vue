<template>
  <div id="dzone" class="ui segment" :class="{ raised: hovering }">
    <div class="ui four stackable cards">
      <div class="card" v-for="image in images">
        <div class="ui image">
          <img src="https://picsum.photos/200/200">
        </div>
        <div class="extra content">
          {{ image.ext }}
          <a class="right floated star">
            <i class="remove icon"></i>
            Remove
          </a>
        </div>
      </div>

      <div class="card" v-for="image in files">
        <div class="ui image">
          <img :src="image.src">
        </div>
        <div class="extra content">{{ image.type }}</div>
        <progress-bar :percentage="image.percentage" :done=""></progress-bar>
      </div>
    </div>
  </div>
</template>
<script>
  import Dropzone from 'dropzone'
  import ProgressBar from "./ProgressBar.vue";

  let dropzone;

  export default {
    components: {ProgressBar},
    name: 'AdminImageEdit',

    props: ['images'],

    data() {
      return {
        hovering: false,
        files: {}
      }
    },

    mounted() {
      let vm = this;

      dropzone = new Dropzone('div#dzone', {
        url: 'http://192.168.1.110:3000/images/1',
        paramName: 'image',

        autoQueue: true,

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
            percentage: 0
          });
        },

        removedfile(file) {
          delete vm.files[file.upload.uuid]
        },

        thumbnail(file, datauri) {
          vm.$set(vm.files[file.upload.uuid], 'src', datauri);
        },

        error(file, err) {
          console.log(err)
        },

        uploadprogress(file, percent) {
          vm.$set(vm.files[file.upload.uuid], 'percentage', percent)
        }
      });
    }
  }
</script>
