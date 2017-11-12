<template>
  <div class="ui bottom attached progress">
    <div class="bar"></div>
  </div>
</template>
<script>
  export default {
    name: 'ProgressBar',

    props: ['percentage'],

    mounted() {
      $(this.$el).progress({percent: this.percentage})
    },

    watch: {
      percentage() {
        console.log(this.percentage);
        $(this.$el).progress('set', this.percentage)
      }
    }
  }
</script>
