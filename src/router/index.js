import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Config from '../views/Config.vue'
Vue.use(VueRouter)

  const routes = [
  {
    path:'/',
    redirect:'/xgCrypt',
    component: () => import(/* webpackChunkName: "about" */ '../views/XgCrypt.vue')

  },
  {
    path: '/home',
    name: 'Home',
    component: Home
  },
  {
    path: '/kits',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
   {
    path: '/config',
    name: 'Config',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
  //  component: () => import(/* webpackChunkName: "about" */ '../views/Config.vue')
    component: Config
  },
    {
      path: '/xgCrypt',
      name: 'XgCrypt',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/XgCrypt.vue')
      //component: XgCrypt
    },
  {
         path: '/iosAudit',
        name: 'IosAudit',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ '../views/IosAudit.vue')
    //component: XgCrypt
  }
]

const router = new VueRouter({
  mode: 'history',
  //base: process.env.BASE_URL,
  //routes
  routes
})

export default router
