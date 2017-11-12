<template>
  <div class="ui segment">
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
    </div>
  </div>
</template>
<script>
  export default {
    name: 'AdminImageEdit',

    props: ['images']
  }
</script>
