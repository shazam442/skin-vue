import axios from 'axios';
import type { App } from 'vue';

// Set default base URL for all requests
axios.defaults.baseURL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

// Add default headers if needed
axios.defaults.headers.common['Content-Type'] = 'application/json';

// Add request interceptor if needed
axios.interceptors.request.use((config) => {
  // You can add auth tokens here
  return config;
});

// Add response interceptor if needed
axios.interceptors.response.use(
  (response) => response,
  (error) => {
    // Handle errors globally
    return Promise.reject(error);
  }
);

export default {
  install: (app: App) => {
    app.config.globalProperties.$axios = axios
  }
}