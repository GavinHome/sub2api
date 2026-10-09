<template>
  <div
    v-for="provider in providers"
    :key="provider.key"
    class="flex items-center gap-2 rounded-xl border border-primary-200 bg-white/60 px-5 py-3 ring-1 ring-primary-500/20 backdrop-blur-sm dark:border-primary-800 dark:bg-dark-800/60"
  >
    <div
      :class="[
        'flex h-8 w-8 items-center justify-center rounded-lg',
        provider.iconClass
      ]"
    >
      <span class="text-xs font-bold text-white">{{ provider.iconText }}</span>
    </div>
    <span class="text-sm font-medium text-gray-700 dark:text-dark-200">
      {{ currentLocale.startsWith('zh') ? provider.labels.zh : provider.labels.en }}
    </span>
    <span
      class="rounded bg-primary-100 px-1.5 py-0.5 text-[10px] font-medium text-primary-600 dark:bg-primary-900/30 dark:text-primary-400"
    >
      {{ supportedLabel }}
    </span>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'

interface HomeSupportedModelItem {
  key: string
  labels: {
    zh: string
    en: string
  }
  iconText: string
  iconClass: string
}

const providers: HomeSupportedModelItem[] = [
  {
    key: 'qwen',
    labels: {
      zh: 'Qwen',
      en: 'Qwen'
    },
    iconText: 'Q',
    iconClass: 'bg-gradient-to-br from-indigo-500 to-violet-600'
  },
  {
    key: 'kimi',
    labels: {
      zh: 'Kimi',
      en: 'Kimi'
    },
    iconText: 'K',
    iconClass: 'bg-gradient-to-br from-sky-500 to-cyan-600'
  },
  {
    key: 'glm',
    labels: {
      zh: 'GLM',
      en: 'GLM'
    },
    iconText: 'G',
    iconClass: 'bg-gradient-to-br from-blue-500 to-indigo-600'
  }
]

const { locale } = useI18n()

const currentLocale = computed(() => locale.value.toLowerCase())
const supportedLabel = computed(() => currentLocale.value.startsWith('zh') ? '已支持' : 'Supported')
</script>
