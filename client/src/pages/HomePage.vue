<script setup lang="ts">
import ItemCard from '@/components/ItemCard.vue';
import { Item } from '@/lib/types';
import { itemsApi } from '@/lib/api';
import { onMounted, ref, computed, provide, Ref, watch } from 'vue';
import ItemFormModal from '@/components/crud/ItemFormModal.vue';

const isFetchingItems = ref(true);
const isReseeding = ref(false);
const itemFormModalRef = ref<InstanceType<typeof ItemFormModal>>()
const items = ref<Item[]>([]);

const isDevelopment = computed(() => import.meta.env.DEV)

onMounted(async () => {
  await fetchItems();
});

const fetchItems = async () => {
  isFetchingItems.value = true;
  items.value = await itemsApi.getAll();
  isFetchingItems.value = false;
}

const handleReseed = async () => {
  if (!import.meta.env.DEV) return;
  
  try {
    isReseeding.value = true;
    await fetch(`http://localhost:3000/api/reseed`, { method: 'POST' });
    await fetchItems();
  } catch (error) {
    console.error('Failed to reseed database:', error);
  } finally {
    isReseeding.value = false;
  }
}

const syncListingsForItem = async (targetItem: Item, resolve: () => void) => {
  try {
    const syncedItem = await itemsApi.syncListings(targetItem)
    updateItemsList(syncedItem)
  } catch (error) {
    console.error('Failed to sync listings:', error)
  } finally {
    resolve()
  }
}

const updateItemsList = (updatedItem: Item) => {
  items.value = items.value.map(item => item.id === updatedItem.id ? updatedItem : item)
}

const handleItemFormSubmit = async (item: Partial<Item>, resolve: () => void) => {
  try {
    if (item.id) {
      const updatedItem = await itemsApi.update(item as Item)
      updateItemsList(updatedItem)
    } else {
      const createdItem = await itemsApi.create(item as Partial<Item>)
      items.value = [...items.value, createdItem]
    }
  } catch (error) {
    console.error('Failed to update item:', error)
  } finally {
    resolve()
  }
}

const handleDeleteItem = async (itemId: number) => {
  try {
    await itemsApi.destroy(itemId)
    items.value = items.value.filter(item => item.id !== itemId)
    itemFormModalRef.value?.closeModal()
  } catch (error) {
    console.error('Failed to delete item:', error)
  }
}

const handleEditItem = (item: Item) => {
  itemFormModalRef.value!.setFormItem(item)
  itemFormModalRef.value!.openModal()
}
</script>

<template>
  <div>
    <div class="flex justify-between items-center mb-4">
      <h1 class="text-2xl font-bold">Items</h1>
      <button
        v-if="isDevelopment"
        @click="handleReseed"
        :disabled="isReseeding"
        class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg disabled:opacity-50"
      >
        {{ isReseeding ? 'Reseeding...' : 'Reseed DB' }}
      </button>
    </div>
    
    <ItemFormModal
      @submit="handleItemFormSubmit"
      @delete="handleDeleteItem"
      ref="itemFormModalRef"
    />
    <div class="grid grid-cols-5 gap-5 debug">
      <div v-if="isFetchingItems" class="text-3xl animate-spin">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-loader"><path d="M21 12a9 9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /><path d="M21 12a9 0 1 1-9 9" /></svg>
      </div>
      <div v-for="item in items" v-else :key="item.id">
        <ItemCard
          :item="item"
          @sync-listings="syncListingsForItem"
          @edit="handleEditItem"
        />
      </div>
    </div>
  </div>
</template>