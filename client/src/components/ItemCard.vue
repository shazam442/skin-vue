<script setup lang="ts">
import { Item } from '@/lib/types'

const props = defineProps<{
  item: Item
}>()

const emit = defineEmits(['sync-listings', 'edit'])
const isSyncing = ref(false)

const handleSync = async () => {
  isSyncing.value = true
  await new Promise(resolve => {
    emit('sync-listings', props.item, resolve)
  })
  isSyncing.value = false
}

const handleEdit = () => {
  emit('edit', props.item)
}

const { img_url, name, cheapest_listing } = props.item

watch(props.item, (newItem) => {
  console.log('item changed', newItem)
})

const formattedPrice = computed(() => {
  return props.item.cheapest_listing?.price 
    ? `$${props.item.cheapest_listing.price}` 
    : 'No price'
})
</script>

<template>
  <div class="w-full relative bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 flex flex-col h-full">
    <button
      @click="handleSync"
      :disabled="isSyncing"
      class="absolute top-2 right-2 p-2 bg-blue-500 hover:bg-blue-600 text-white rounded-full shadow-md transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="h-4 w-4"
        :class="isSyncing ? 'animate-spin' : ''"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
      >
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
      </svg>
    </button>
    <a href="#" class="flex-1">
      <img class="w-full h-full object-contain p-4 min-h-[200px]" :src="img_url" alt="product image">
    </a>
    <div class="border-t border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 px-5 py-4 rounded-b-lg flex flex-col gap-4">
      <a href="#" @click="handleEdit">
        <h5 class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white">{{ name }}</h5>
      </a>
      <div class="text-2xl font-bold text-gray-900 dark:text-white">
        {{ formattedPrice }}
      </div>
    </div>
  </div>
</template>
