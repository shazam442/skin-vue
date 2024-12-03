import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/Home.vue'),
    },
    {
      path: '/items/new',
      name: 'new_item',
      component: () => import('../views/NewItem.vue'),
    },
  ],
})

export default router
