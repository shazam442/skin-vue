<script setup lang="ts">
import { ref } from 'vue'
import { Item } from '@/lib/types'
import { buildItem } from '@/lib/utils/type_utils'

const emit = defineEmits(['submit', 'delete'])

const isOpen = ref(false)
const formItem = ref<Partial<Item>>(buildItem())
const isSubmitting = ref(false)

const openModal = () => {
  isOpen.value = true
}

const handleDelete = () => { if (formItem.value.id) emit('delete', formItem.value.id) }

const closeModal = () => {
  resetForm()
  isOpen.value = false
}

defineExpose({
  openModal,
  closeModal,
  setFormItem: (item: Item) => formItem.value = item,
})

const resetForm = () => { formItem.value = buildItem() }

const handleSubmit = async () => {
  isSubmitting.value = true

  await new Promise(resolve =>
    emit('submit', formItem.value, resolve)
  )

  closeModal()
  isSubmitting.value = false
}
</script>

<template>
  <!-- Modal toggle -->
  <div class="flex justify-center m-5">
    <button
      id="createModalButton"
      class="block text-white bg-primary-700 hover:bg-primary-800 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800"
      type="button"
      @click="openModal"
    >
      + Create Item
    </button>
  </div>

  <!-- Main modal -->
  <div
    id="itemFormModal"
    tabindex="-1"
    aria-hidden="true"
    class="overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-screen md:inset-0 h-modal md:h-full backdrop-blur-sm backdrop-brightness-50"
    :class="isOpen ? 'flex' : 'hidden'"
  >
    <div class="relative p-4 w-full max-w-2xl h-full md:h-auto">
      <!-- Modal content -->
      <div class="relative p-4 bg-white rounded-lg shadow-2xl dark:bg-gray-800 sm:p-5 border-2 border-slate-400">
        <!-- Modal header -->
        <div class="flex justify-between items-center pb-4 mb-4 rounded-t border-b sm:mb-5 dark:border-gray-600">
          <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
            {{ formItem.id ? 'Edit Item' : 'Add Item' }}
          </h3>
          <div class="flex items-center gap-2">
            <button
              v-if="formItem.id"
              type="button"
              class="text-red-600 bg-transparent hover:bg-red-100 hover:text-red-900 rounded-lg text-sm p-1.5 inline-flex items-center dark:hover:bg-red-900 dark:hover:text-red-200"
              @click="handleDelete"
            >
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M16.5 4.478v.227a48.816 48.816 0 013.878.512.75.75 0 11-.256 1.478l-.209-.035-1.005 13.07a3 3 0 01-2.991 2.77H8.084a3 3 0 01-2.991-2.77L4.087 6.66l-.209.035a.75.75 0 01-.256-1.478A48.567 48.567 0 017.5 4.705v-.227c0-1.564 1.213-2.9 2.816-2.951a52.662 52.662 0 013.369 0c1.603.051 2.815 1.387 2.815 2.951zm-6.136-1.452a51.196 51.196 0 013.273 0C14.39 3.05 15 3.684 15 4.478v.113a49.488 49.488 0 00-6 0v-.113c0-.794.609-1.428 1.364-1.452zm-.355 5.945a.75.75 0 10-1.5.058l.347 9a.75.75 0 101.499-.058l-.346-9zm5.48.058a.75.75 0 10-1.498-.058l-.347 9a.75.75 0 001.5.058l.345-9z" clip-rule="evenodd" />
              </svg>
              <span class="sr-only">Delete item</span>
            </button>
            <button
              type="button"
              class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
              @click="closeModal"
            >
              <svg
                aria-hidden="true"
                class="w-5 h-5"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd"
                />
              </svg>
              <span class="sr-only">Close modal</span>
            </button>
          </div>
        </div>
        <!-- Modal body -->
        <form @submit.prevent="handleSubmit">
          <div class="grid gap-4 mb-4 sm:grid-cols-2">
            <!-- Item Name Text Field -->
            <div>
              <label
                for="item-name"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >Item Name</label>
              <input
                v-model="formItem.name"
                type="text"
                name="item-name"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                placeholder="Type product name"
                required
              >
            </div>
            <!-- Wear Select -->
            <div>
              <label
                for="wear"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >Condition</label>
              <select
                v-model="formItem.wear"
                name="wear"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                required
              >
                <option value="factory_new">Factory New</option>
                <option value="minimal_wear">Minimal Wear</option>
                <option value="field_tested">Field-Tested</option>
                <option value="well_worn">Well-Worn</option>
                <option value="battle_scarred">Battle-Scarred</option>
                <option value="no_wear">None</option>
              </select>
            </div>
            <!-- Category select -->
            <div>
              <label
                for="category"
                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
              >Category</label>
              <select
                id="category"
                v-model="formItem.category"
                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                required
              >
                <option value="weapon">Weapon</option>
                <option value="knife">Knife</option>
                <option value="gloves">Gloves</option>
              </select>
            </div>
            <div />
            <!-- Modifier Checkboxes -->
            <div class="col-span-2">
              <ul class="flex flex-col justify-center w-full gap-x-20 md:flex-row">
                <li>
                  <input
                    id="stattrak"
                    v-model="formItem.stattrak"
                    type="checkbox"
                    name="stattrak"
                    class="hidden peer"
                  >
                  <label
                    for="stattrak"
                    class="grid place-items-center w-full peer-checked:text-yellow-700 px-5 py-2 text-gray-500 bg-white border-2 border-gray-200 rounded-lg cursor-pointer dark:hover:text-gray-300 dark:border-gray-700 peer-checked:border-yellow-700 hover:text-gray-600 hover:bg-gray-50 dark:text-gray-400 dark:bg-gray-800 dark:hover:bg-gray-700"
                  >
                    <div class="block">
                      <div class="w-full text-md font-semibold">StatTrak</div>
                    </div>
                  </label>
                </li>
                <li>
                  <input
                    id="souvenir"
                    v-model="formItem.souvenir"
                    type="checkbox"
                    name="souvenir"
                    class="hidden peer"
                  >
                  <label
                    for="souvenir"
                    class="grid place-items-center w-full px-5 py-2 text-gray-500 border-2 rounded-lg cursor-pointer hover:text-gray-300 border-gray-700 peer-checked:border-yellow-500 peer-checked:text-yellow-500 hover:bg-gray-700 bg-gray-800"
                  >
                    <div class="block">
                      <div class="w-full text-md font-semibold">Souvenir</div>
                    </div>
                  </label>
                </li>
              </ul>
            </div>
            <button
              type="submit"
              :disabled="isSubmitting"
              class="text-white w-fit mt-8 inline-flex items-center bg-primary-700 hover:bg-primary-800 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800 disabled:opacity-75 disabled:cursor-wait"
            >
              <svg
                class="w-5 h-5 mr-2"
                :class="{ 'animate-spin': isSubmitting }"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  v-if="isSubmitting"
                  class="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="4"
                ></circle>
                <path
                  v-if="isSubmitting"
                  class="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                ></path>
                <path
                  v-else
                  fill="currentColor"
                  d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                />
              </svg>
              <p v-if="formItem.id" class="ml-2">{{ isSubmitting ? 'Updating...' : 'Update Item' }}</p>
              <p v-else class="ml-2">{{ isSubmitting ? 'Creating...' : 'Add Item' }}</p>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

