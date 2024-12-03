<template>
  <main class="flex flex-col gap-4 selection:w-full h-full p-4 font-mono font-bold text-lg">
    <div class="flex gap-4">
      <div>
        <label for="item" class="">Item Name</label>
        <input type="text"
          v-model="item"
          name="item"
          placeholder="AK-47 | Bloodsport"
          class="border-2 border-black block p-2 rounded"
        >
      </div>
      <div>
        <label for="category" class="">Category</label>
        <select
          name="category"
          placeholder="AK-47 | Bloodsport"
          class="border-2 border-black block p-2 rounded"
          v-model="selectedWear"
        >
          <option value="weapon">Weapon</option>
          <option value="knife">Knife</option>
          <option value="gloves">Gloves</option>
        </select>
      </div>
    </div>
    <div>
      <label for="wear" class="">Wear</label>
      <select
        v-model="wear"
        name="wear"
        placeholder="AK-47 | Bloodsport"
        class="border-2 border-black block p-2 rounded w-fit"
      >
        <option value="factory_new">Factory New</option>
        <option value="minimal_wear">Minimal Wear</option>
        <option value="field_tested">Field-Tested</option>
        <option value="well_worn">Well-Worn</option>
        <option value="battle_scarred">Battle-Scarred</option>
        <option class="text-red-400" value="no_wear">No Wear</option>
      </select>
    </div>
    <div class="flex items-center">
      <input 
        v-model="stattrak"
        value="stattrak"
        name="stattrak"
        type="checkbox"
        class="size-4 mr-4"
      >
      <label for="stattrak" class="">StatTrak</label>
    </div>
    <div class="flex items-center">
      <input 
        v-model="souvenir"
        value="souvenir"
        name="souvenir"
        type="checkbox"
        class="size-4 mr-4"
      >
      <label for="souvenir" class="">Souvenir</label>
    </div>
    
    <input name="create" @click="createItemRequest" type="submit" class="border w-fit py-2 px-8 self-center">


  </main>
</template>

<script setup>
import { ref } from 'vue'
const selectedWear = ref('weapon')
const item = ref('')
const wear = ref('factory_new')
const stattrak = ref(false)
const souvenir = ref(false)

const createItemRequest = async () => {
  res = await fetch('http://localhost:3000/items', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: item.value,
      category: selectedWear.value,
      wear: wear.value,
      stattrak: stattrak.value,
      souvenir: souvenir.value
    })
  })
}

</script>

<style scoped>
</style>