<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <header>
    <nav class="bg-slate-700 border-b p-4 flex divide-x">
      <RouterLink to="/" class="text-3xl font-bold">Home</RouterLink>
      <p class="text-3xl font-bold">cockadoo</p>
    </nav>
  </header>
  <RouterView />
</template>

<style scoped>

</style>
