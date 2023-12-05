<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <v-sheet border="md" class="pa-6 mx-auto rounded-lg w-100">
          <h1>{{ UserService.id }}'s Inventory</h1>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { UserService } from "~/scripts/userService";

if (!UserService.isLoggedIn) {
  navigateTo("/");
}
</script>
