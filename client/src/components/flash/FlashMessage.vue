<script setup lang="ts">
import { FlashType } from '@/lib/types/flash';
import { computed } from 'vue';

const props = defineProps<{
  type: FlashType;
  message: string;
}>();

const iconClass = computed(() => {
  switch (props.type) {
    case 'positive':
      return 'text-green-500';
    case 'negative':
      return 'text-red-500';
    case 'warning':
      return 'text-yellow-500';
  }
});

const bgClass = computed(() => {
  switch (props.type) {
    case 'positive':
      return 'bg-green-50 dark:bg-green-900/20';
    case 'negative':
      return 'bg-red-50 dark:bg-red-900/20';
    case 'warning':
      return 'bg-yellow-50 dark:bg-yellow-900/20';
  }
});

const textClass = computed(() => {
  switch (props.type) {
    case 'positive':
      return 'text-green-800 dark:text-green-200';
    case 'negative':
      return 'text-red-800 dark:text-red-200';
    case 'warning':
      return 'text-yellow-800 dark:text-yellow-200';
  }
});
</script>

<template>
  <div
    class="fixed top-4 left-1/2 -translate-x-1/2 z-50 flex items-center p-4 rounded-lg shadow"
    :class="[bgClass, textClass]"
    role="alert"
  >
    <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 rounded-lg">
      <!-- Positive Icon -->
      <svg
        v-if="type === 'positive'"
        :class="iconClass"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="currentColor"
        viewBox="0 0 20 20"
      >
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>
      </svg>
      <!-- Negative Icon -->
      <svg
        v-if="type === 'negative'"
        :class="iconClass"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="currentColor"
        viewBox="0 0 20 20"
      >
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 11.793a1 1 0 1 1-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 10 6.293 7.707a1 1 0 0 1 1.414-1.414L10 8.586l2.293-2.293a1 1 0 0 1 1.414 1.414L11.414 10l2.293 2.293Z"/>
      </svg>
      <!-- Warning Icon -->
      <svg
        v-if="type === 'warning'"
        :class="iconClass"
        aria-hidden="true"
        xmlns="http://www.w3.org/2000/svg"
        fill="currentColor"
        viewBox="0 0 20 20"
      >
        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM10 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2Zm1-4a1 1 0 0 1-2 0V6a1 1 0 0 1 2 0v5Z"/>
      </svg>
    </div>
    <div class="ms-3 text-sm font-normal">{{ message }}</div>
  </div>
</template> 