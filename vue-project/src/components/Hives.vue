<template>
    <div>
        <h1>Hives</h1>

        <!-- Create or Post -->
        <input type="text"
               v-model="name"
               placeholder="Hive name"
               class="name-input"
               required />
        <input type="number"
               step="0.1"
               min="0"
               v-model="weight"
               placeholder="Hive weight (in kg)"
               class="weight-input"
               required />

        <button @click="createHive">Create</button>

        <!-- Error Messages -->
        <div v-if="errors.length" class="error-messages">
            <p v-for="(error, index) in errors" :key="index" class="error-message">{{ error }}</p>
        </div>

        <!-- List of Hives -->
        <div v-for="hive in hives" :key="hive.id">
            <h2>Name: {{ hive.name }}</h2>
            <p>Weight: {{ hive.weight }} kg</p>
            <router-link :to="`/hives/${hive.id}`">View Details</router-link>
        </div>

    </div>
</template>

<script setup>
    import { ref, onMounted } from 'vue';

    const hives = ref([])
    const name = ref('')
    const weight = ref('')
    const errors = ref([]);
    const API_URL = "http://localhost:3000/hives";


    onMounted(async () => {
        const res = await fetch(API_URL)
        hives.value = await res.json()
    })


    const createHive = async () => {
        errors.value = [];

        // Validation
        if (!name.value.trim()) {
            errors.value.push('Hive name is required');
        }
        if (name.value.length < 6) {
            errors.value.push('Hive name must be at least 6 characters');
        }
        if (hives.value.some(hive => hive.name === name.value.trim())) {
            errors.value.push('Hive name must be unique');
        }
        if (weight.value === '' || isNaN(weight.value) || weight.value < 0) {
            errors.value.push('Weight must be a number');
        }

        if (errors.value.length > 0) {
            return;
        }

        const res = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name.value,
                weight: parseFloat(weight.value)  // Ensure weight is a number
            })
        })

        const data = await res.json()

        hives.value.push(data)
        name.value = ''
        weight.value = '';
    }
</script>

<style scoped>
    .name-input {
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        box-sizing: border-box;
        border: 2px solid #ccc;
        background-color: #f8f8f8;
        color: #111;
        border-radius: 4px;
        resize: vertical;
    }

    .weight-input {
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        box-sizing: border-box;
        border: 2px solid #ccc;
        background-color: #f8f8f8;
        color: #111;
        border-radius: 4px;
        resize: vertical;
    }

    .error-messages {
        margin-top: 10px;
    }

    .error-message {
        color: red;
    }
</style>