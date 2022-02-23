import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Layout',
    component: () => import("../layout/Layout"),
    redirect: '/task',
    children: [
      {
        path: 'task',
        name: 'Task',
        component: () => import("@/views/Task")
      },
      {
        path: 'user',
        name: 'User',
        component: () => import("@/views/User")
      },
      {
        path: 'cardtest',
        name: 'Cardtest',
        component: () => import("@/views/CardTest")
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import("@/views/Login")
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
