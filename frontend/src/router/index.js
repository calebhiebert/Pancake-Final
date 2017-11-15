import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import AdminProductCreate from '@/components/AdminProductCreate'
import AdminProductEdit from '@/components/AdminProductEdit'
import ProductView from '@/components/ProductView'
import AdminPagesCreate from '@/components/AdminPagesCreate'
import AdminPagesEdit from '@/components/AdminPagesEdit'
import PageView from '@/components/PageView'
import AdminIndex from '@/components/AdminIndex'
import SearchView from '@/components/SearchView'
import Register from '@/components/Register'
import CartManage from '@/components/CartManage'
import Checkout from '@/components/Checkout'
import Me from '@/components/Me'
import Four04 from '@/components/404'

Vue.use(Router);

export default new Router({
    mode: 'history',

    routes: [
        {path: '/', name: 'Home', component: Home},

        //Products
        {path: '/admin/product/create', name: 'AdminProductCreate', component: AdminProductCreate},
        {path: '/admin/product/:id', name: 'AdminProductEdit', component: AdminProductEdit},
        {path: '/product/search', name: 'SearchView', component: SearchView},
        {path: '/product/:id', name: 'ProductView', component: ProductView},

        //Pages
        {path: '/admin/pages/create', name: 'AdminPagesCreate', component: AdminPagesCreate},
        {path: '/admin/pages/:title', name: 'AdminPagesEdit', component: AdminPagesEdit},
        {path: '/page/:title', name: 'PageView', component: PageView},

        {path: '/register', name: 'Register', component: Register},

        //Admin
        {path: '/admin', name: 'AdminIndex', component: AdminIndex},

        //Cart
        {path: '/cart', name: 'CartManage', component: CartManage},

        {path: '/checkout', name: 'Checkout', component: Checkout},
        {path: '/checkout/:orderid', name: 'CheckoutOrderConf', component: Checkout},

        //Me
        {path: '/me', name: 'Me', component: Me},

        {path: '*', name: '404', component: Four04}

    ]
})
