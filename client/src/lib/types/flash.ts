export type FlashType = 'positive' | 'negative' | 'warning';

export interface FlashMessage {
  id: string;
  type: FlashType;
  message: string;
} 