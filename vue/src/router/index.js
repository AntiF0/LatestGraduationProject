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
        path: 'daily-record',
        name: 'Daily-record',
        component: () => import("@/views/Daily-record")
      },
      {
        path: 'data-analysis',
        name: 'Data-analysis',
        component: () => import("@/views/Data-analysis")
      },
      {
        path: 'setting',
        name: 'Setting',
        component: () => import("@/views/Setting")
      },
      {
        path: 'easyUse',
        name: 'EasyUse',
        component: () => import("@/views/EasyUse")
      },
      {
        path: 'taskInfo',
        name: 'TaskInfo',
        component: () => import("@/views/TaskInfo")
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import("@/views/Login")
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import("@/views/Register")
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
