<template>
    <!-- Modal toggle -->
    <div class="flex justify-center m-5">
        <button id="createModalButton" @click="toggleCreateModal"
            class="block text-white bg-primary-700 hover:bg-primary-800 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
            type="button">
            + Create Item
        </button>
    </div>

    <!-- Main modal -->
    <div id="defaultModal" tabindex="-1" aria-hidden="true"
        class="overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-screen md:inset-0 h-modal md:h-full backdrop-blur-sm backdrop-brightness-50"
        :class="isCreateModalOpen ? 'flex' : 'hidden'">
        <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
            <!-- Modal content -->
            <div class="relative p-4 bg-white rounded-lg shadow-2xl dark:bg-gray-800 sm:p-5 border-2 border-slate-400">
                <!-- Modal header -->
                <div
                    class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                        Add Skin
                    </h3>
                    <button type="button" @click="toggleCreateModal"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
                        data-modal-toggle="defaultModal">
                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                clip-rule="evenodd"></path>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <form @submit.prevent="createItem">
                    <div class="grid gap-4 mb-4 sm:grid-cols-2">
                        <!-- Item Name Text Field -->
                        <div>
                            <label for="item-name"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Item Name</label>
                            <input type="text" name="item-name" v-model="itemName"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="Type product name">
                        </div>
                        <!-- Wear Select -->
                        <div>
                            <label for="wear"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Condition</label>
                            <select type="text" name="wear" v-model="wear"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="Product brand">
                                <option value="no_wear">None</option>
                                <option value="factory_new">Factory New</option>
                                <option value="minimal_wear">Minimal Wear</option>
                                <option value="field_tested">Field-Tested</option>
                                <option value="well_worn">Well-Worn</option>
                                <option value="battle_scarred">Battle-Scarred</option>
                            </select>
                        </div>
                        <!-- Category select -->
                        <div>
                            <label for="category"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category</label>
                            <select id="category" v-model="category"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                                <option value="weapon">Weapon</option>
                                <option value="knife">Knife</option>
                            </select>
                        </div>
                        <div></div>
                        <!-- Modifier Checkboxes -->
                        <div class="col-span-2">
                            <ul class="flex flex-col justify-center w-full gap-x-20 md:flex-row">
                                <!-- counter strike stattrak color code is: -->
                                <!-- #ffcc00 -->
                                <li>
                                    <input type="checkbox" name="stattrak" id="stattrak" v-model="stattrak" class="hidden peer">
                                    <label for="stattrak"
                                        class="grid place-items-center w-full peer-checked:text-yellow-700 px-5 py-2 text-gray-500 bg-white border-2 border-gray-200 rounded-lg cursor-pointer dark:hover:text-gray-300 dark:border-gray-700 peer-checked:border-yellow-700 hover:text-gray-600 hover:bg-gray-50 dark:text-gray-400 dark:bg-gray-800 dark:hover:bg-gray-700">
                                        <div class="block">
                                            <div class="w-full text-md font-semibold">StatTrak</div>
                                        </div>
                                    </label>
                                </li>
                                <li>
                                    <!-- counter strike yellow souvenir color code is: -->
                                    <!-- #ffcc00 -->
                                    <input type="checkbox" name="souvenir" id="souvenir" v-model="souvenir" class="hidden peer">
                                    <label for="souvenir"
                                        class="grid place-items-center w-full px-5 py-2 text-gray-500 border-2 rounded-lg cursor-pointer hover:text-gray-300 border-gray-700 peer-checked:border-yellow-500 peer-checked:text-yellow-500 hover:bg-gray-700 bg-gray-800">
                                        <div class="block">
                                            <div class="w-full text-md font-semibold">Souvenir</div>
                                        </div>
                                    </label>
                                </li>
                            </ul>
                        </div>
                        <button type="submit"
                            class="text-white w-fit mt-8 inline-flex items-center bg-primary-700 hover:bg-primary-800 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">
                            <svg class="mr-1 -ml-1 w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Create Item
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { items } from '@/store/itemsStore'

const isCreateModalOpen = ref(false)
const toggleCreateModal = () => isCreateModalOpen.value = !isCreateModalOpen.value

const itemName = ref('')
const wear = ref('')
const category = ref('')
const stattrak = ref(false)
const souvenir = ref(false)

const createItem = async () => {
    const newItem = {
        name: itemName.value,
        wear: wear.value,
        category: category.value,
        stattrak: stattrak.value,
        souvenir: souvenir.value
    }
    const response = await fetch('http://localhost:3000/items', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(newItem)
    })
    if (response.ok) {
        const createdItem = await response.json();
        items.value.push(createdItem);
    } else {
        console.error('Network response was not ok', response)
    }
    toggleCreateModal()
}
</script>