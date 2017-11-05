import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import ProductCreate from '@/components/ProductCreate'

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/product/new',
      name: 'ProductCreate',
      component: ProductCreate
    }
  ]
})
