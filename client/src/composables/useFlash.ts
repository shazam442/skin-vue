import { ref } from 'vue';
import { FlashMessage, FlashType } from '@/lib/types/flash';

const messages = ref<FlashMessage[]>([]);

export function useFlash() {
  const showMessage = (type: FlashType, message: string) => {
    const id = Math.random().toString(36).substring(2);
    const flashMessage: FlashMessage = { id, type, message };
    messages.value.push(flashMessage);

    // Remove the message after 3 seconds
    setTimeout(() => {
      messages.value = messages.value.filter(m => m.id !== id);
    }, 3000);
  };

  return {
    messages,
    positive: (message: string) => showMessage('positive', message),
    negative: (message: string) => showMessage('negative', message),
    warning: (message: string) => showMessage('warning', message),
  };
} 