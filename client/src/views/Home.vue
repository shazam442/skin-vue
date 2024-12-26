<script setup lang="ts">
import ItemCard from '@/components/ItemCard.vue';
import { onMounted } from 'vue';
import { items } from '@/store/itemsStore';

const isFetchingPrices = ref(false);
const isFetchingItems = ref(true);

const fetchItems = async () => {
    const res = await fetch('http://localhost:3000/items');
    items.value = await res.json();
}

const fetchPrices = async () => {
  const res = await fetch('http://localhost:3000/items/update_prices', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  });
  items.value = await res.json();
}

onMounted(async () => {
    await fetchItems();
    isFetchingItems.value = false;
});
</script>

<template>
  <button
    type="button"
    class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg px-2 py-1 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
    :disabled="isFetchingPrices"
    @click="fetchPrices"
  >
    <span v-if="isFetchingPrices" class="text-3xl animate-spin">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="lucide lucide-loader"
      ><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /></svg>
    </span>
    <span v-else class="text-3xl">🤑</span>
  </button>
  <div class="grid grid-cols-5 gap-5 debug">
    <div v-if="isFetchingItems" class="text-3xl animate-spin">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="lucide lucide-loader"
      ><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /></svg>
    </div>
    <div v-for="item in items" v-else :key="item.id">
      <ItemCard :item="item" />
    </div>
  </div>
</template>