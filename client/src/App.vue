<script setup>
import { RouterView } from 'vue-router'
import Navbar from './components/layout/Navbar.vue'
import FlashContainer from './components/flash/FlashContainer.vue'
</script>

<template>
  <Navbar />
  <FlashContainer />
  <div class="max-w-screen-xl mx-auto min-h-screen p-8">
    <RouterView />
  </div>
</template>

<style scoped>

</style>
