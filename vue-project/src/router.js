import { createRouter, createWebHistory } from 'vue-router';
import Hives from './components/Hives.vue';
import Hive from './components/Hive.vue';

const routes = [
    {
        path: '/',
        name: 'Index',
        component: Hives
    },
    {
        path: '/hives/:id',
        name: 'Hive',
        component: Hive,
        props: true
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
