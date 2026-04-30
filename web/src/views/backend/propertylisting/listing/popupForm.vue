<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div
                class="ba-operate-form"
                :class="'ba-' + baTable.form.operate + '-form'"
                :style="config.layout.shrink ? '':'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'"
            >
                <el-form
                    v-if="!baTable.form.loading"
                    ref="formRef"
                    @submit.prevent=""
                    @keyup.enter="baTable.onSubmit(formRef)"
                    :model="baTable.form.items"
                    :label-position="config.layout.shrink ? 'top' : 'right'"
                    :label-width="baTable.form.labelWidth + 'px'"
                    :rules="rules"
                >
                    <FormItem :label="t('propertylisting.listing.openid')" type="remoteSelect" v-model="baTable.form.items!.openid" prop="openid" :input-attr="{ pk: 'account.openid', field: 'openid', remoteUrl: '/admin/Account/index' }" :placeholder="t('Please select field', { field: t('propertylisting.listing.openid') })" />
                    <FormItem :label="t('propertylisting.listing.city')" type="string" v-model="baTable.form.items!.city" prop="city" :placeholder="t('Please input field', { field: t('propertylisting.listing.city') })" />
                    <FormItem :label="t('propertylisting.listing.address')" type="string" v-model="baTable.form.items!.address" prop="address" :placeholder="t('Please input field', { field: t('propertylisting.listing.address') })" />
                    <FormItem :label="t('propertylisting.listing.lat')" type="string" v-model="baTable.form.items!.lat" prop="lat" :placeholder="t('Please input field', { field: t('propertylisting.listing.lat') })" />
                    <FormItem :label="t('propertylisting.listing.lng')" type="string" v-model="baTable.form.items!.lng" prop="lng" :placeholder="t('Please input field', { field: t('propertylisting.listing.lng') })" />
                    <FormItem :label="t('propertylisting.listing.rentType')" type="string" v-model="baTable.form.items!.rentType" prop="rentType" :placeholder="t('Please input field', { field: t('propertylisting.listing.rentType') })" />
                    <FormItem :label="t('propertylisting.listing.house')" type="string" v-model="baTable.form.items!.house" prop="house" :placeholder="t('Please input field', { field: t('propertylisting.listing.house') })" />
                    <FormItem :label="t('propertylisting.listing.area')" type="string" v-model="baTable.form.items!.area" prop="area" :placeholder="t('Please input field', { field: t('propertylisting.listing.area') })" />
                    <FormItem :label="t('propertylisting.listing.money')" type="string" v-model="baTable.form.items!.money" prop="money" :placeholder="t('Please input field', { field: t('propertylisting.listing.money') })" />
                    <FormItem :label="t('propertylisting.listing.introduction')" type="textarea" v-model="baTable.form.items!.introduction" prop="introduction" :input-attr="{ rows: 3 }" @keyup.enter.stop="" @keyup.ctrl.enter="baTable.onSubmit(formRef)" :placeholder="t('Please input field', { field: t('propertylisting.listing.introduction') })" />
                    <FormItem :label="t('propertylisting.listing.telephone')" type="string" v-model="baTable.form.items!.telephone" prop="telephone" :placeholder="t('Please input field', { field: t('propertylisting.listing.telephone') })" />
                    <FormItem :label="t('propertylisting.listing.type')" type="string" v-model="baTable.form.items!.type" prop="type" :placeholder="t('Please input field', { field: t('propertylisting.listing.type') })" />
                    <FormItem :label="t('propertylisting.listing.time')" type="datetime" v-model="baTable.form.items!.time" prop="time" :placeholder="t('Please select field', { field: t('propertylisting.listing.time') })" />
                    <FormItem :label="t('propertylisting.listing.trade_no')" type="string" v-model="baTable.form.items!.trade_no" prop="trade_no" :placeholder="t('Please input field', { field: t('propertylisting.listing.trade_no') })" />
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div :style="'width: calc(100% - ' + baTable.form.labelWidth! / 1.8 + 'px)'">
                <el-button @click="baTable.toggleForm()">{{ t('Cancel') }}</el-button>
                <el-button v-blur :loading="baTable.form.submitLoading" @click="baTable.onSubmit(formRef)" type="primary">
                    {{ baTable.form.operateIds && baTable.form.operateIds.length > 1 ? t('Save and edit next item') : t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import type { FormItemRule } from 'element-plus'
import { inject, reactive, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = useTemplateRef('formRef')
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    time: [buildValidatorData({ name: 'date', title: t('propertylisting.listing.time') })],
})
</script>

<style scoped lang="scss"></style>
