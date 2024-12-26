<script setup>
import { RouterView } from 'vue-router'
import Navbar from './components/layout/Navbar.vue'
</script>

<template>
  <Navbar />
  <div class="max-w-screen-xl mx-auto min-h-screen p-8">
    <RouterView />
  </div>
  </template>

<style scoped>

</style>
