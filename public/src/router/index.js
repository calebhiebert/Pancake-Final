import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import ProductCreate from '@/components/ProductCreate'
import ProductView from '@/components/ProductView'
import AdminPagesView from '@/components/AdminPagesView'
import AdminPagesCreate from '@/components/AdminPagesCreate'
import PageView from '@/components/PageView'

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
    },
    {
      path: '/product/:id',
      name: 'ProductView',
      component: ProductView
    },
    {
      path: '/admin/pages',
      name: 'AdminPagesView',
      component: AdminPagesView
    },
    {
      path: '/admin/pages/create',
      name: 'AdminPagesCreate',
      component: AdminPagesCreate
    },
    {
      path: '/page/:title',
      name: 'PageView',
      component: PageView
    }
  ]
})
