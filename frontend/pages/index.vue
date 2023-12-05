<template>
  <v-container class="fill-height" fluid>
    <v-row>
      <v-col>
        <v-sheet border="md" class="pa-6 mx-auto rounded-lg" max-width="400">
          <v-text-field
            label="ID"
            v-model="id"
            variant="outlined"
          ></v-text-field>
          <v-text-field
            label="Key"
            v-model="key"
            variant="outlined"
          ></v-text-field>
          <v-btn
            block
            class="text-none text-black"
            :color="loginButtonColor"
            size="x-large"
            variant="flat"
            @click="loginAsync"
          >
            <v-icon v-if="state === LoginState.None" left size="x-large"
              >mdi-login</v-icon
            >
            <v-progress-circular
              v-else-if="state === LoginState.Waiting"
              indeterminate
            ></v-progress-circular>
            <v-icon v-else-if="state === LoginState.Success" left size="x-large"
              >mdi-check</v-icon
            >
            <v-icon v-else-if="state === LoginState.Failure" left size="x-large"
              >mdi-close</v-icon
            >
          </v-btn>
        </v-sheet>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { StorageService } from "../scripts/storageService";
import { UserService } from "../scripts/userService";

if (UserService.isLoggedIn) {
  navigateTo("/inventory");
}

const id = ref("");
const key = ref("");

onMounted(() => {
  id.value = StorageService.getId();
});

watch(id, (newId) => {
  StorageService.setId(newId);
});

enum LoginState {
  None,
  Waiting,
  Success,
  Failure,
}

const state = ref(LoginState.None);

const loginButtonColor = computed(() => {
  switch (state.value) {
    case LoginState.None:
      return "primary";
    case LoginState.Waiting:
      return "amber";
    case LoginState.Success:
      return "success";
    case LoginState.Failure:
      return "red";
  }
});

async function loginAsync() {
  // UserService.id = id.value;
  // UserService.key = key.value;
  // UserService.isLoggedIn = true;
  // navigateTo("/inventory");
  if (state.value !== LoginState.None) {
    return;
  }
  state.value = LoginState.Waiting;
  await new Promise((resolve) => setTimeout(resolve, 250));
  if (await UserService.login(id.value, key.value)) {
    state.value = LoginState.Success;
    setTimeout(() => {
      navigateTo("/inventory");
    }, 500);
  } else {
    state.value = LoginState.Failure;
    setTimeout(() => {
      state.value = LoginState.None;
    }, 2000);
  }
}
</script>
