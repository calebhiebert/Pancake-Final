<template>
  <div class="ui bottom attached progress">
    <div class="bar"></div>
  </div>
</template>
<script>
  export default {
    name: 'ProgressBar',

    props: ['percentage', 'done'],

    mounted() {
      $(this.$el).progress({percent: this.percentage})
    },

    watch: {
      percentage() {
        $(this.$el).progress('set percent', this.percentage)
      },

      done() {
        if(this.done) {
          $(this.$el).progress('complete')
        }
      }
    }
  }
</script>
