<script setup lang="ts">
import { useFlash } from '@/composables/useFlash';
import FlashMessage from './FlashMessage.vue';

const { messages } = useFlash();
</script>

<template>
  <TransitionGroup
    tag="div"
    enter-active-class="transition duration-300 ease-out"
    enter-from-class="transform -translate-y-full opacity-0"
    enter-to-class="transform translate-y-0 opacity-100"
    leave-active-class="transition duration-200 ease-in"
    leave-from-class="transform translate-y-0 opacity-100"
    leave-to-class="transform -translate-y-full opacity-0"
  >
    <FlashMessage
      v-for="message in messages"
      :key="message.id"
      :type="message.type"
      :message="message.message"
    />
  </TransitionGroup>
</template> 