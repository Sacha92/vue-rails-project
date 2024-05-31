<template>
    <div>
        <h1>Hive Details</h1>
        <div v-if="error">
            <p class="error-message">{{ error }}</p>
            <router-link to="/">Back to Hives</router-link>
        </div>
        <div v-else-if="hive">
            <h2>Name: {{ hive.name }}</h2>
            <p>Weight: {{ hive.weight }} kg</p>
            <router-link to="/">Back to Hives</router-link>
        </div>
        <div v-else>
            <p>Loading...</p>
        </div>
    </div>
</template>

<script setup>
    import { ref, onMounted } from 'vue';
    import { useRoute } from 'vue-router';

    const route = useRoute();
    const hive = ref(null);
    const error = ref(null);

    onMounted(async () => {
        try {
            const res = await fetch(`http://localhost:3000/hives/${route.params.id}`);
            if (res.status === 404) {
                throw new Error('Hive not found');
            }
            hive.value = await res.json();
        } catch (err) {
            error.value = err.message;
        }
    });
</script>

<style scoped>
    .error-message {
        color: red;
    }
</style>
