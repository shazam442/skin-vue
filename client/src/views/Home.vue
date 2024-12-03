<script setup lang="ts">
import ItemCard from '@/components/ItemCard.vue';
import { onMounted } from 'vue';
import { items } from '@/store/itemsStore';

const fetchItems = async () => {
    const res = await fetch('http://localhost:3000/items');
    items.value = await res.json();
}

onMounted(fetchItems);
</script>

<template>
    <div class="grid grid-cols-5 gap-5">
        <div v-for="item in items" :key="item.id">
            <ItemCard :item="item" />
        </div>
    </div>
</template>