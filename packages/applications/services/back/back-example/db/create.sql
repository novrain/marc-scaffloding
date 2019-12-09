--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE IF EXISTS ONLY public.act_de_model_relation DROP CONSTRAINT IF EXISTS fk_relation_parent;
ALTER TABLE IF EXISTS ONLY public.act_de_model_relation DROP CONSTRAINT IF EXISTS fk_relation_child;
ALTER TABLE IF EXISTS ONLY public.act_ru_variable DROP CONSTRAINT IF EXISTS act_fk_var_procinst;
ALTER TABLE IF EXISTS ONLY public.act_ru_variable DROP CONSTRAINT IF EXISTS act_fk_var_exe;
ALTER TABLE IF EXISTS ONLY public.act_ru_variable DROP CONSTRAINT IF EXISTS act_fk_var_bytearray;
ALTER TABLE IF EXISTS ONLY public.act_ru_identitylink DROP CONSTRAINT IF EXISTS act_fk_tskass_task;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_fk_timer_job_process_instance;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_fk_timer_job_proc_def;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_fk_timer_job_execution;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_fk_timer_job_exception;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_fk_timer_job_custom_values;
ALTER TABLE IF EXISTS ONLY public.act_ru_task DROP CONSTRAINT IF EXISTS act_fk_task_procinst;
ALTER TABLE IF EXISTS ONLY public.act_ru_task DROP CONSTRAINT IF EXISTS act_fk_task_procdef;
ALTER TABLE IF EXISTS ONLY public.act_ru_task DROP CONSTRAINT IF EXISTS act_fk_task_exe;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_fk_suspended_job_process_instance;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_fk_suspended_job_proc_def;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_fk_suspended_job_execution;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_fk_suspended_job_exception;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_fk_suspended_job_custom_values;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_sentry_part_inst DROP CONSTRAINT IF EXISTS act_fk_sentry_plan_item;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_sentry_part_inst DROP CONSTRAINT IF EXISTS act_fk_sentry_case_inst;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_sentry_part_inst DROP CONSTRAINT IF EXISTS act_fk_sentry_case_def;
ALTER TABLE IF EXISTS ONLY public.act_id_priv_mapping DROP CONSTRAINT IF EXISTS act_fk_priv_mapping;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_plan_item_inst DROP CONSTRAINT IF EXISTS act_fk_plan_item_case_inst;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_plan_item_inst DROP CONSTRAINT IF EXISTS act_fk_plan_item_case_def;
ALTER TABLE IF EXISTS ONLY public.act_re_model DROP CONSTRAINT IF EXISTS act_fk_model_source_extra;
ALTER TABLE IF EXISTS ONLY public.act_re_model DROP CONSTRAINT IF EXISTS act_fk_model_source;
ALTER TABLE IF EXISTS ONLY public.act_re_model DROP CONSTRAINT IF EXISTS act_fk_model_deployment;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_mil_inst DROP CONSTRAINT IF EXISTS act_fk_mil_case_inst;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_mil_inst DROP CONSTRAINT IF EXISTS act_fk_mil_case_def;
ALTER TABLE IF EXISTS ONLY public.act_id_membership DROP CONSTRAINT IF EXISTS act_fk_memb_user;
ALTER TABLE IF EXISTS ONLY public.act_id_membership DROP CONSTRAINT IF EXISTS act_fk_memb_group;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_fk_job_process_instance;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_fk_job_proc_def;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_fk_job_execution;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_fk_job_exception;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_fk_job_custom_values;
ALTER TABLE IF EXISTS ONLY public.act_procdef_info DROP CONSTRAINT IF EXISTS act_fk_info_procdef;
ALTER TABLE IF EXISTS ONLY public.act_procdef_info DROP CONSTRAINT IF EXISTS act_fk_info_json_ba;
ALTER TABLE IF EXISTS ONLY public.act_ru_identitylink DROP CONSTRAINT IF EXISTS act_fk_idl_procinst;
ALTER TABLE IF EXISTS ONLY public.act_ru_execution DROP CONSTRAINT IF EXISTS act_fk_exe_super;
ALTER TABLE IF EXISTS ONLY public.act_ru_execution DROP CONSTRAINT IF EXISTS act_fk_exe_procinst;
ALTER TABLE IF EXISTS ONLY public.act_ru_execution DROP CONSTRAINT IF EXISTS act_fk_exe_procdef;
ALTER TABLE IF EXISTS ONLY public.act_ru_execution DROP CONSTRAINT IF EXISTS act_fk_exe_parent;
ALTER TABLE IF EXISTS ONLY public.act_ru_event_subscr DROP CONSTRAINT IF EXISTS act_fk_event_exec;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_fk_deadletter_job_process_instance;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_fk_deadletter_job_proc_def;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_fk_deadletter_job_execution;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_fk_deadletter_job_exception;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_fk_deadletter_job_custom_values;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_deployment_resource DROP CONSTRAINT IF EXISTS act_fk_cmmn_rsrc_dpl;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_case_inst DROP CONSTRAINT IF EXISTS act_fk_case_inst_case_def;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_casedef DROP CONSTRAINT IF EXISTS act_fk_case_def_dply;
ALTER TABLE IF EXISTS ONLY public.act_ge_bytearray DROP CONSTRAINT IF EXISTS act_fk_bytearr_depl;
ALTER TABLE IF EXISTS ONLY public.act_ru_identitylink DROP CONSTRAINT IF EXISTS act_fk_athrz_procedef;
ALTER TABLE IF EXISTS ONLY public.act_app_deployment_resource DROP CONSTRAINT IF EXISTS act_fk_app_rsrc_dpl;
ALTER TABLE IF EXISTS ONLY public.act_app_appdef DROP CONSTRAINT IF EXISTS act_fk_app_def_dply;
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserPosition" DROP CONSTRAINT IF EXISTS "UserPosition_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserPosition" DROP CONSTRAINT IF EXISTS "UserPosition_positionId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserOrganization" DROP CONSTRAINT IF EXISTS "UserOrganization_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserOrganization" DROP CONSTRAINT IF EXISTS "UserOrganization_organizationId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserExtention" DROP CONSTRAINT IF EXISTS "UserExtention_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."SubUser" DROP CONSTRAINT IF EXISTS "SubUser_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."SubUser" DROP CONSTRAINT IF EXISTS "SubUser_parentId_fkey";
ALTER TABLE IF EXISTS ONLY public."RoleOperation" DROP CONSTRAINT IF EXISTS "RoleOperation_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."RoleOperation" DROP CONSTRAINT IF EXISTS "RoleOperation_operationId_fkey";
ALTER TABLE IF EXISTS ONLY public."RoleMenu" DROP CONSTRAINT IF EXISTS "RoleMenu_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."RoleMenu" DROP CONSTRAINT IF EXISTS "RoleMenu_menuId_fkey";
ALTER TABLE IF EXISTS ONLY public."Position" DROP CONSTRAINT IF EXISTS "Position_parentId_fkey";
ALTER TABLE IF EXISTS ONLY public."PositionRole" DROP CONSTRAINT IF EXISTS "PositionRole_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."PositionRole" DROP CONSTRAINT IF EXISTS "PositionRole_positionId_fkey";
ALTER TABLE IF EXISTS ONLY public."Organization" DROP CONSTRAINT IF EXISTS "Organization_parentId_fkey";
ALTER TABLE IF EXISTS ONLY public."OrganizationRole" DROP CONSTRAINT IF EXISTS "OrganizationRole_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."OrganizationRole" DROP CONSTRAINT IF EXISTS "OrganizationRole_organizationId_fkey";
ALTER TABLE IF EXISTS ONLY public."Operation" DROP CONSTRAINT IF EXISTS "Operation_parentId_fkey";
ALTER TABLE IF EXISTS ONLY public."OperationPreDepends" DROP CONSTRAINT IF EXISTS "OperationPreDepends_operationId_fkey";
ALTER TABLE IF EXISTS ONLY public."OperationPreDepends" DROP CONSTRAINT IF EXISTS "OperationPreDepends_dependOperationId_fkey";
ALTER TABLE IF EXISTS ONLY public."Menu" DROP CONSTRAINT IF EXISTS "Menu_parentId_fkey";
ALTER TABLE IF EXISTS ONLY public."MenuPreDepends" DROP CONSTRAINT IF EXISTS "MenuPreDepends_menuId_fkey";
ALTER TABLE IF EXISTS ONLY public."MenuPreDepends" DROP CONSTRAINT IF EXISTS "MenuPreDepends_dependMenuId_fkey";
ALTER TABLE IF EXISTS ONLY public."DictionaryItem" DROP CONSTRAINT IF EXISTS "DictionaryItem_dictionaryId_fkey";
ALTER TABLE IF EXISTS ONLY public."CommunistPartyProcessCategory" DROP CONSTRAINT IF EXISTS "CommunistPartyProcessCategory_parentId_fkey";
DROP INDEX IF EXISTS public.idx_proc_mod_history_proc;
DROP INDEX IF EXISTS public.idx_proc_mod_created;
DROP INDEX IF EXISTS public.idx_contitem_taskid;
DROP INDEX IF EXISTS public.idx_contitem_scope;
DROP INDEX IF EXISTS public.idx_contitem_procid;
DROP INDEX IF EXISTS public.act_idx_variable_task_id;
DROP INDEX IF EXISTS public.act_idx_var_procinst;
DROP INDEX IF EXISTS public.act_idx_var_exe;
DROP INDEX IF EXISTS public.act_idx_var_bytearray;
DROP INDEX IF EXISTS public.act_idx_tskass_task;
DROP INDEX IF EXISTS public.act_idx_tjob_sub_scope;
DROP INDEX IF EXISTS public.act_idx_tjob_scope_def;
DROP INDEX IF EXISTS public.act_idx_tjob_scope;
DROP INDEX IF EXISTS public.act_idx_timer_job_process_instance_id;
DROP INDEX IF EXISTS public.act_idx_timer_job_proc_def_id;
DROP INDEX IF EXISTS public.act_idx_timer_job_execution_id;
DROP INDEX IF EXISTS public.act_idx_timer_job_exception_stack_id;
DROP INDEX IF EXISTS public.act_idx_timer_job_custom_values_id;
DROP INDEX IF EXISTS public.act_idx_task_sub_scope;
DROP INDEX IF EXISTS public.act_idx_task_scope_def;
DROP INDEX IF EXISTS public.act_idx_task_scope;
DROP INDEX IF EXISTS public.act_idx_task_procinst;
DROP INDEX IF EXISTS public.act_idx_task_procdef;
DROP INDEX IF EXISTS public.act_idx_task_exec;
DROP INDEX IF EXISTS public.act_idx_task_create;
DROP INDEX IF EXISTS public.act_idx_suspended_job_process_instance_id;
DROP INDEX IF EXISTS public.act_idx_suspended_job_proc_def_id;
DROP INDEX IF EXISTS public.act_idx_suspended_job_execution_id;
DROP INDEX IF EXISTS public.act_idx_suspended_job_exception_stack_id;
DROP INDEX IF EXISTS public.act_idx_suspended_job_custom_values_id;
DROP INDEX IF EXISTS public.act_idx_sjob_sub_scope;
DROP INDEX IF EXISTS public.act_idx_sjob_scope_def;
DROP INDEX IF EXISTS public.act_idx_sjob_scope;
DROP INDEX IF EXISTS public.act_idx_sentry_plan_item;
DROP INDEX IF EXISTS public.act_idx_sentry_case_inst;
DROP INDEX IF EXISTS public.act_idx_sentry_case_def;
DROP INDEX IF EXISTS public.act_idx_ru_var_sub_id_type;
DROP INDEX IF EXISTS public.act_idx_ru_var_scope_id_type;
DROP INDEX IF EXISTS public.act_idx_ru_acti_start;
DROP INDEX IF EXISTS public.act_idx_ru_acti_proc_act;
DROP INDEX IF EXISTS public.act_idx_ru_acti_proc;
DROP INDEX IF EXISTS public.act_idx_ru_acti_exec_act;
DROP INDEX IF EXISTS public.act_idx_ru_acti_exec;
DROP INDEX IF EXISTS public.act_idx_ru_acti_end;
DROP INDEX IF EXISTS public.act_idx_procdef_info_proc;
DROP INDEX IF EXISTS public.act_idx_procdef_info_json;
DROP INDEX IF EXISTS public.act_idx_priv_user;
DROP INDEX IF EXISTS public.act_idx_priv_mapping;
DROP INDEX IF EXISTS public.act_idx_priv_group;
DROP INDEX IF EXISTS public.act_idx_plan_item_stage_inst;
DROP INDEX IF EXISTS public.act_idx_plan_item_case_inst;
DROP INDEX IF EXISTS public.act_idx_plan_item_case_def;
DROP INDEX IF EXISTS public.act_idx_model_source_extra;
DROP INDEX IF EXISTS public.act_idx_model_source;
DROP INDEX IF EXISTS public.act_idx_model_deployment;
DROP INDEX IF EXISTS public.act_idx_mil_case_inst;
DROP INDEX IF EXISTS public.act_idx_mil_case_def;
DROP INDEX IF EXISTS public.act_idx_memb_user;
DROP INDEX IF EXISTS public.act_idx_memb_group;
DROP INDEX IF EXISTS public.act_idx_job_sub_scope;
DROP INDEX IF EXISTS public.act_idx_job_scope_def;
DROP INDEX IF EXISTS public.act_idx_job_scope;
DROP INDEX IF EXISTS public.act_idx_job_process_instance_id;
DROP INDEX IF EXISTS public.act_idx_job_proc_def_id;
DROP INDEX IF EXISTS public.act_idx_job_execution_id;
DROP INDEX IF EXISTS public.act_idx_job_exception_stack_id;
DROP INDEX IF EXISTS public.act_idx_job_custom_values_id;
DROP INDEX IF EXISTS public.act_idx_idl_procinst;
DROP INDEX IF EXISTS public.act_idx_ident_lnk_user;
DROP INDEX IF EXISTS public.act_idx_ident_lnk_scope_def;
DROP INDEX IF EXISTS public.act_idx_ident_lnk_scope;
DROP INDEX IF EXISTS public.act_idx_ident_lnk_group;
DROP INDEX IF EXISTS public.act_idx_hi_var_sub_id_type;
DROP INDEX IF EXISTS public.act_idx_hi_var_scope_id_type;
DROP INDEX IF EXISTS public.act_idx_hi_task_sub_scope;
DROP INDEX IF EXISTS public.act_idx_hi_task_scope_def;
DROP INDEX IF EXISTS public.act_idx_hi_task_scope;
DROP INDEX IF EXISTS public.act_idx_hi_task_inst_procinst;
DROP INDEX IF EXISTS public.act_idx_hi_procvar_task_id;
DROP INDEX IF EXISTS public.act_idx_hi_procvar_proc_inst;
DROP INDEX IF EXISTS public.act_idx_hi_procvar_name_type;
DROP INDEX IF EXISTS public.act_idx_hi_procvar_exe;
DROP INDEX IF EXISTS public.act_idx_hi_pro_inst_end;
DROP INDEX IF EXISTS public.act_idx_hi_pro_i_buskey;
DROP INDEX IF EXISTS public.act_idx_hi_ident_lnk_user;
DROP INDEX IF EXISTS public.act_idx_hi_ident_lnk_task;
DROP INDEX IF EXISTS public.act_idx_hi_ident_lnk_scope_def;
DROP INDEX IF EXISTS public.act_idx_hi_ident_lnk_scope;
DROP INDEX IF EXISTS public.act_idx_hi_ident_lnk_procinst;
DROP INDEX IF EXISTS public.act_idx_hi_ent_lnk_scope_def;
DROP INDEX IF EXISTS public.act_idx_hi_ent_lnk_scope;
DROP INDEX IF EXISTS public.act_idx_hi_detail_time;
DROP INDEX IF EXISTS public.act_idx_hi_detail_task_id;
DROP INDEX IF EXISTS public.act_idx_hi_detail_proc_inst;
DROP INDEX IF EXISTS public.act_idx_hi_detail_name;
DROP INDEX IF EXISTS public.act_idx_hi_detail_act_inst;
DROP INDEX IF EXISTS public.act_idx_hi_act_inst_start;
DROP INDEX IF EXISTS public.act_idx_hi_act_inst_procinst;
DROP INDEX IF EXISTS public.act_idx_hi_act_inst_exec;
DROP INDEX IF EXISTS public.act_idx_hi_act_inst_end;
DROP INDEX IF EXISTS public.act_idx_form_def_uniq;
DROP INDEX IF EXISTS public.act_idx_exec_buskey;
DROP INDEX IF EXISTS public.act_idx_exe_super;
DROP INDEX IF EXISTS public.act_idx_exe_root;
DROP INDEX IF EXISTS public.act_idx_exe_procinst;
DROP INDEX IF EXISTS public.act_idx_exe_procdef;
DROP INDEX IF EXISTS public.act_idx_exe_parent;
DROP INDEX IF EXISTS public.act_idx_event_subscr_config_;
DROP INDEX IF EXISTS public.act_idx_event_subscr;
DROP INDEX IF EXISTS public.act_idx_ent_lnk_scope_def;
DROP INDEX IF EXISTS public.act_idx_ent_lnk_scope;
DROP INDEX IF EXISTS public.act_idx_djob_sub_scope;
DROP INDEX IF EXISTS public.act_idx_djob_scope_def;
DROP INDEX IF EXISTS public.act_idx_djob_scope;
DROP INDEX IF EXISTS public.act_idx_dec_tbl_uniq;
DROP INDEX IF EXISTS public.act_idx_deadletter_job_process_instance_id;
DROP INDEX IF EXISTS public.act_idx_deadletter_job_proc_def_id;
DROP INDEX IF EXISTS public.act_idx_deadletter_job_execution_id;
DROP INDEX IF EXISTS public.act_idx_deadletter_job_exception_stack_id;
DROP INDEX IF EXISTS public.act_idx_deadletter_job_custom_values_id;
DROP INDEX IF EXISTS public.act_idx_cmmn_rsrc_dpl;
DROP INDEX IF EXISTS public.act_idx_case_inst_parent;
DROP INDEX IF EXISTS public.act_idx_case_inst_case_def;
DROP INDEX IF EXISTS public.act_idx_case_def_uniq;
DROP INDEX IF EXISTS public.act_idx_case_def_dply;
DROP INDEX IF EXISTS public.act_idx_bytear_depl;
DROP INDEX IF EXISTS public.act_idx_athrz_procedef;
DROP INDEX IF EXISTS public.act_idx_app_rsrc_dpl;
DROP INDEX IF EXISTS public.act_idx_app_def_uniq;
DROP INDEX IF EXISTS public.act_idx_app_def_dply;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_sentry_part_inst DROP CONSTRAINT IF EXISTS pk_cmmn_sentry_part_inst;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_plan_item_inst DROP CONSTRAINT IF EXISTS pk_cmmn_plan_item_inst;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_deployment_resource DROP CONSTRAINT IF EXISTS pk_cmmn_deployment_resource;
ALTER TABLE IF EXISTS ONLY public.act_app_deployment_resource DROP CONSTRAINT IF EXISTS pk_app_deployment_resource;
ALTER TABLE IF EXISTS ONLY public.act_re_procdef DROP CONSTRAINT IF EXISTS act_uniq_procdef;
ALTER TABLE IF EXISTS ONLY public.act_id_priv DROP CONSTRAINT IF EXISTS act_uniq_priv_name;
ALTER TABLE IF EXISTS ONLY public.act_procdef_info DROP CONSTRAINT IF EXISTS act_uniq_info_procdef;
ALTER TABLE IF EXISTS ONLY public.act_ru_variable DROP CONSTRAINT IF EXISTS act_ru_variable_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_timer_job DROP CONSTRAINT IF EXISTS act_ru_timer_job_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_task DROP CONSTRAINT IF EXISTS act_ru_task_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_suspended_job DROP CONSTRAINT IF EXISTS act_ru_suspended_job_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_job DROP CONSTRAINT IF EXISTS act_ru_job_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_identitylink DROP CONSTRAINT IF EXISTS act_ru_identitylink_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_history_job DROP CONSTRAINT IF EXISTS act_ru_history_job_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_execution DROP CONSTRAINT IF EXISTS act_ru_execution_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_event_subscr DROP CONSTRAINT IF EXISTS act_ru_event_subscr_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_entitylink DROP CONSTRAINT IF EXISTS act_ru_entitylink_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_deadletter_job DROP CONSTRAINT IF EXISTS act_ru_deadletter_job_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ru_actinst DROP CONSTRAINT IF EXISTS act_ru_actinst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_re_procdef DROP CONSTRAINT IF EXISTS act_re_procdef_pkey;
ALTER TABLE IF EXISTS ONLY public.act_re_model DROP CONSTRAINT IF EXISTS act_re_model_pkey;
ALTER TABLE IF EXISTS ONLY public.act_re_deployment DROP CONSTRAINT IF EXISTS act_re_deployment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_procdef_info DROP CONSTRAINT IF EXISTS act_procdef_info_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_user DROP CONSTRAINT IF EXISTS act_id_user_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_token DROP CONSTRAINT IF EXISTS act_id_token_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_property DROP CONSTRAINT IF EXISTS act_id_property_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_priv DROP CONSTRAINT IF EXISTS act_id_priv_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_priv_mapping DROP CONSTRAINT IF EXISTS act_id_priv_mapping_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_membership DROP CONSTRAINT IF EXISTS act_id_membership_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_info DROP CONSTRAINT IF EXISTS act_id_info_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_group DROP CONSTRAINT IF EXISTS act_id_group_pkey;
ALTER TABLE IF EXISTS ONLY public.act_id_bytearray DROP CONSTRAINT IF EXISTS act_id_bytearray_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_varinst DROP CONSTRAINT IF EXISTS act_hi_varinst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_tsk_log DROP CONSTRAINT IF EXISTS act_hi_tsk_log_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_taskinst DROP CONSTRAINT IF EXISTS act_hi_taskinst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_procinst DROP CONSTRAINT IF EXISTS act_hi_procinst_proc_inst_id__key;
ALTER TABLE IF EXISTS ONLY public.act_hi_procinst DROP CONSTRAINT IF EXISTS act_hi_procinst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_identitylink DROP CONSTRAINT IF EXISTS act_hi_identitylink_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_entitylink DROP CONSTRAINT IF EXISTS act_hi_entitylink_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_detail DROP CONSTRAINT IF EXISTS act_hi_detail_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_comment DROP CONSTRAINT IF EXISTS act_hi_comment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_attachment DROP CONSTRAINT IF EXISTS act_hi_attachment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_hi_actinst DROP CONSTRAINT IF EXISTS act_hi_actinst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ge_property DROP CONSTRAINT IF EXISTS act_ge_property_pkey;
ALTER TABLE IF EXISTS ONLY public.act_ge_bytearray DROP CONSTRAINT IF EXISTS act_ge_bytearray_pkey;
ALTER TABLE IF EXISTS ONLY public.act_fo_form_resource DROP CONSTRAINT IF EXISTS act_fo_form_resource_pkey;
ALTER TABLE IF EXISTS ONLY public.act_fo_form_instance DROP CONSTRAINT IF EXISTS act_fo_form_instance_pkey;
ALTER TABLE IF EXISTS ONLY public.act_fo_form_deployment DROP CONSTRAINT IF EXISTS act_fo_form_deployment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_fo_form_definition DROP CONSTRAINT IF EXISTS act_fo_form_definition_pkey;
ALTER TABLE IF EXISTS ONLY public.act_fo_databasechangeloglock DROP CONSTRAINT IF EXISTS act_fo_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_evt_log DROP CONSTRAINT IF EXISTS act_evt_log_pkey;
ALTER TABLE IF EXISTS ONLY public.act_dmn_hi_decision_execution DROP CONSTRAINT IF EXISTS act_dmn_hi_decision_execution_pkey;
ALTER TABLE IF EXISTS ONLY public.act_dmn_deployment_resource DROP CONSTRAINT IF EXISTS act_dmn_deployment_resource_pkey;
ALTER TABLE IF EXISTS ONLY public.act_dmn_deployment DROP CONSTRAINT IF EXISTS act_dmn_deployment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_dmn_decision_table DROP CONSTRAINT IF EXISTS act_dmn_decision_table_pkey;
ALTER TABLE IF EXISTS ONLY public.act_dmn_databasechangeloglock DROP CONSTRAINT IF EXISTS act_dmn_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_de_model_relation DROP CONSTRAINT IF EXISTS act_de_model_relation_pkey;
ALTER TABLE IF EXISTS ONLY public.act_de_model DROP CONSTRAINT IF EXISTS act_de_model_pkey;
ALTER TABLE IF EXISTS ONLY public.act_de_model_history DROP CONSTRAINT IF EXISTS act_de_model_history_pkey;
ALTER TABLE IF EXISTS ONLY public.act_de_databasechangeloglock DROP CONSTRAINT IF EXISTS act_de_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_co_databasechangeloglock DROP CONSTRAINT IF EXISTS act_co_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_co_content_item DROP CONSTRAINT IF EXISTS act_co_content_item_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_mil_inst DROP CONSTRAINT IF EXISTS act_cmmn_ru_mil_inst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_ru_case_inst DROP CONSTRAINT IF EXISTS act_cmmn_ru_case_inst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_hi_plan_item_inst DROP CONSTRAINT IF EXISTS act_cmmn_hi_plan_item_inst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_hi_mil_inst DROP CONSTRAINT IF EXISTS act_cmmn_hi_mil_inst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_hi_case_inst DROP CONSTRAINT IF EXISTS act_cmmn_hi_case_inst_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_deployment DROP CONSTRAINT IF EXISTS act_cmmn_deployment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_databasechangeloglock DROP CONSTRAINT IF EXISTS act_cmmn_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_cmmn_casedef DROP CONSTRAINT IF EXISTS act_cmmn_casedef_pkey;
ALTER TABLE IF EXISTS ONLY public.act_app_deployment DROP CONSTRAINT IF EXISTS act_app_deployment_pkey;
ALTER TABLE IF EXISTS ONLY public.act_app_databasechangeloglock DROP CONSTRAINT IF EXISTS act_app_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public.act_app_appdef DROP CONSTRAINT IF EXISTS act_app_appdef_pkey;
ALTER TABLE IF EXISTS ONLY public.act_adm_server_config DROP CONSTRAINT IF EXISTS act_adm_server_config_pkey;
ALTER TABLE IF EXISTS ONLY public.act_adm_databasechangeloglock DROP CONSTRAINT IF EXISTS act_adm_databasechangeloglock_pkey;
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_username_key";
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_pkey";
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_mobile_key";
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_email_key";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_userId_roleId_key";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_pkey";
ALTER TABLE IF EXISTS ONLY public."UserPosition" DROP CONSTRAINT IF EXISTS "UserPosition_userId_positionId_key";
ALTER TABLE IF EXISTS ONLY public."UserPosition" DROP CONSTRAINT IF EXISTS "UserPosition_pkey";
ALTER TABLE IF EXISTS ONLY public."UserOrganization" DROP CONSTRAINT IF EXISTS "UserOrganization_userId_organizationId_key";
ALTER TABLE IF EXISTS ONLY public."UserOrganization" DROP CONSTRAINT IF EXISTS "UserOrganization_pkey";
ALTER TABLE IF EXISTS ONLY public."UserExtention" DROP CONSTRAINT IF EXISTS "UserExtention_pkey";
ALTER TABLE IF EXISTS ONLY public."SubUser" DROP CONSTRAINT IF EXISTS "SubUser_pkey";
ALTER TABLE IF EXISTS ONLY public."Role" DROP CONSTRAINT IF EXISTS "Role_pkey";
ALTER TABLE IF EXISTS ONLY public."RoleOperation" DROP CONSTRAINT IF EXISTS "RoleOperation_pkey";
ALTER TABLE IF EXISTS ONLY public."RoleOperation" DROP CONSTRAINT IF EXISTS "RoleOperation_operationId_roleId_key";
ALTER TABLE IF EXISTS ONLY public."RoleMenu" DROP CONSTRAINT IF EXISTS "RoleMenu_pkey";
ALTER TABLE IF EXISTS ONLY public."RoleMenu" DROP CONSTRAINT IF EXISTS "RoleMenu_menuId_roleId_key";
ALTER TABLE IF EXISTS ONLY public."ProcessDef" DROP CONSTRAINT IF EXISTS "ProcessDef_pkey";
ALTER TABLE IF EXISTS ONLY public."ProcessDef" DROP CONSTRAINT IF EXISTS "ProcessDef_flowableInstance_key";
ALTER TABLE IF EXISTS ONLY public."Position" DROP CONSTRAINT IF EXISTS "Position_pkey";
ALTER TABLE IF EXISTS ONLY public."PositionRole" DROP CONSTRAINT IF EXISTS "PositionRole_positionId_roleId_key";
ALTER TABLE IF EXISTS ONLY public."PositionRole" DROP CONSTRAINT IF EXISTS "PositionRole_pkey";
ALTER TABLE IF EXISTS ONLY public."Organization" DROP CONSTRAINT IF EXISTS "Organization_pkey";
ALTER TABLE IF EXISTS ONLY public."OrganizationRole" DROP CONSTRAINT IF EXISTS "OrganizationRole_pkey";
ALTER TABLE IF EXISTS ONLY public."OrganizationRole" DROP CONSTRAINT IF EXISTS "OrganizationRole_organizationId_roleId_key";
ALTER TABLE IF EXISTS ONLY public."Operation" DROP CONSTRAINT IF EXISTS "Operation_pkey";
ALTER TABLE IF EXISTS ONLY public."OperationPreDepends" DROP CONSTRAINT IF EXISTS "OperationPreDepends_pkey";
ALTER TABLE IF EXISTS ONLY public."OperationPreDepends" DROP CONSTRAINT IF EXISTS "OperationPreDepends_operationId_dependOperationId_key";
ALTER TABLE IF EXISTS ONLY public."Menu" DROP CONSTRAINT IF EXISTS "Menu_pkey";
ALTER TABLE IF EXISTS ONLY public."MenuPreDepends" DROP CONSTRAINT IF EXISTS "MenuPreDepends_pkey";
ALTER TABLE IF EXISTS ONLY public."MenuPreDepends" DROP CONSTRAINT IF EXISTS "MenuPreDepends_menuId_dependMenuId_key";
ALTER TABLE IF EXISTS ONLY public."Dictionary" DROP CONSTRAINT IF EXISTS "Dictionary_pkey";
ALTER TABLE IF EXISTS ONLY public."Dictionary" DROP CONSTRAINT IF EXISTS "Dictionary_name_key";
ALTER TABLE IF EXISTS ONLY public."Dictionary" DROP CONSTRAINT IF EXISTS "Dictionary_key_key";
ALTER TABLE IF EXISTS ONLY public."DictionaryItem" DROP CONSTRAINT IF EXISTS "DictionaryItem_pkey";
ALTER TABLE IF EXISTS ONLY public."CommunistPartyProcessCategory" DROP CONSTRAINT IF EXISTS "CommunistPartyProcessCategory_pkey";
ALTER TABLE IF EXISTS public.act_hi_tsk_log ALTER COLUMN id_ DROP DEFAULT;
ALTER TABLE IF EXISTS public.act_evt_log ALTER COLUMN log_nr_ DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.userextention_id_seq;
DROP TABLE IF EXISTS public.act_ru_variable;
DROP TABLE IF EXISTS public.act_ru_timer_job;
DROP TABLE IF EXISTS public.act_ru_task;
DROP TABLE IF EXISTS public.act_ru_suspended_job;
DROP TABLE IF EXISTS public.act_ru_job;
DROP TABLE IF EXISTS public.act_ru_identitylink;
DROP TABLE IF EXISTS public.act_ru_history_job;
DROP TABLE IF EXISTS public.act_ru_execution;
DROP TABLE IF EXISTS public.act_ru_event_subscr;
DROP TABLE IF EXISTS public.act_ru_entitylink;
DROP TABLE IF EXISTS public.act_ru_deadletter_job;
DROP TABLE IF EXISTS public.act_ru_actinst;
DROP TABLE IF EXISTS public.act_re_procdef;
DROP TABLE IF EXISTS public.act_re_model;
DROP TABLE IF EXISTS public.act_re_deployment;
DROP TABLE IF EXISTS public.act_procdef_info;
DROP TABLE IF EXISTS public.act_id_user;
DROP TABLE IF EXISTS public.act_id_token;
DROP TABLE IF EXISTS public.act_id_property;
DROP TABLE IF EXISTS public.act_id_priv_mapping;
DROP TABLE IF EXISTS public.act_id_priv;
DROP TABLE IF EXISTS public.act_id_membership;
DROP TABLE IF EXISTS public.act_id_info;
DROP TABLE IF EXISTS public.act_id_group;
DROP TABLE IF EXISTS public.act_id_bytearray;
DROP TABLE IF EXISTS public.act_hi_varinst;
DROP SEQUENCE IF EXISTS public.act_hi_tsk_log_id__seq;
DROP TABLE IF EXISTS public.act_hi_tsk_log;
DROP TABLE IF EXISTS public.act_hi_taskinst;
DROP TABLE IF EXISTS public.act_hi_procinst;
DROP TABLE IF EXISTS public.act_hi_identitylink;
DROP TABLE IF EXISTS public.act_hi_entitylink;
DROP TABLE IF EXISTS public.act_hi_detail;
DROP TABLE IF EXISTS public.act_hi_comment;
DROP TABLE IF EXISTS public.act_hi_attachment;
DROP TABLE IF EXISTS public.act_hi_actinst;
DROP TABLE IF EXISTS public.act_ge_property;
DROP TABLE IF EXISTS public.act_ge_bytearray;
DROP TABLE IF EXISTS public.act_fo_form_resource;
DROP TABLE IF EXISTS public.act_fo_form_instance;
DROP TABLE IF EXISTS public.act_fo_form_deployment;
DROP TABLE IF EXISTS public.act_fo_form_definition;
DROP TABLE IF EXISTS public.act_fo_databasechangeloglock;
DROP TABLE IF EXISTS public.act_fo_databasechangelog;
DROP SEQUENCE IF EXISTS public.act_evt_log_log_nr__seq;
DROP TABLE IF EXISTS public.act_evt_log;
DROP TABLE IF EXISTS public.act_dmn_hi_decision_execution;
DROP TABLE IF EXISTS public.act_dmn_deployment_resource;
DROP TABLE IF EXISTS public.act_dmn_deployment;
DROP TABLE IF EXISTS public.act_dmn_decision_table;
DROP TABLE IF EXISTS public.act_dmn_databasechangeloglock;
DROP TABLE IF EXISTS public.act_dmn_databasechangelog;
DROP TABLE IF EXISTS public.act_de_model_relation;
DROP TABLE IF EXISTS public.act_de_model_history;
DROP TABLE IF EXISTS public.act_de_model;
DROP TABLE IF EXISTS public.act_de_databasechangeloglock;
DROP TABLE IF EXISTS public.act_de_databasechangelog;
DROP TABLE IF EXISTS public.act_co_databasechangeloglock;
DROP TABLE IF EXISTS public.act_co_databasechangelog;
DROP TABLE IF EXISTS public.act_co_content_item;
DROP TABLE IF EXISTS public.act_cmmn_ru_sentry_part_inst;
DROP TABLE IF EXISTS public.act_cmmn_ru_plan_item_inst;
DROP TABLE IF EXISTS public.act_cmmn_ru_mil_inst;
DROP TABLE IF EXISTS public.act_cmmn_ru_case_inst;
DROP TABLE IF EXISTS public.act_cmmn_hi_plan_item_inst;
DROP TABLE IF EXISTS public.act_cmmn_hi_mil_inst;
DROP TABLE IF EXISTS public.act_cmmn_hi_case_inst;
DROP TABLE IF EXISTS public.act_cmmn_deployment_resource;
DROP TABLE IF EXISTS public.act_cmmn_deployment;
DROP TABLE IF EXISTS public.act_cmmn_databasechangeloglock;
DROP TABLE IF EXISTS public.act_cmmn_databasechangelog;
DROP TABLE IF EXISTS public.act_cmmn_casedef;
DROP TABLE IF EXISTS public.act_app_deployment_resource;
DROP TABLE IF EXISTS public.act_app_deployment;
DROP TABLE IF EXISTS public.act_app_databasechangeloglock;
DROP TABLE IF EXISTS public.act_app_databasechangelog;
DROP TABLE IF EXISTS public.act_app_appdef;
DROP TABLE IF EXISTS public.act_adm_server_config;
DROP TABLE IF EXISTS public.act_adm_databasechangeloglock;
DROP TABLE IF EXISTS public.act_adm_databasechangelog;
DROP TABLE IF EXISTS public."UserRole";
DROP TABLE IF EXISTS public."UserPosition";
DROP TABLE IF EXISTS public."UserOrganization";
DROP SEQUENCE IF EXISTS public."UserExtention_id_seq";
DROP TABLE IF EXISTS public."UserExtention";
DROP TABLE IF EXISTS public."User";
DROP TABLE IF EXISTS public."SubUser";
DROP TABLE IF EXISTS public."RoleOperation";
DROP TABLE IF EXISTS public."RoleMenu";
DROP TABLE IF EXISTS public."Role";
DROP TABLE IF EXISTS public."ProcessDef";
DROP TABLE IF EXISTS public."PositionRole";
DROP TABLE IF EXISTS public."Position";
DROP TABLE IF EXISTS public."OrganizationRole";
DROP TABLE IF EXISTS public."Organization";
DROP TABLE IF EXISTS public."OperationPreDepends";
DROP TABLE IF EXISTS public."Operation";
DROP TABLE IF EXISTS public."MenuPreDepends";
DROP TABLE IF EXISTS public."Menu";
DROP TABLE IF EXISTS public."DictionaryItem";
DROP TABLE IF EXISTS public."Dictionary";
DROP TABLE IF EXISTS public."CommunistPartyProcessCategory";
DROP TYPE IF EXISTS public."enum_User_type";
DROP TYPE IF EXISTS public."enum_UserExtention_sex";
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: enum_UserExtention_sex; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "enum_UserExtention_sex" AS ENUM (
    'male',
    'famale'
);


ALTER TYPE "enum_UserExtention_sex" OWNER TO postgres;

--
-- Name: enum_User_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "enum_User_type" AS ENUM (
    'Master',
    'Sub'
);


ALTER TYPE "enum_User_type" OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: CommunistPartyProcessCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "CommunistPartyProcessCategory" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    index integer,
    "belongTo" character varying(255),
    "createdAt" timestamp(6) with time zone NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "CommunistPartyProcessCategory" OWNER TO postgres;

--
-- Name: Dictionary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Dictionary" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    "belongTo" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE "Dictionary" OWNER TO postgres;

--
-- Name: DictionaryItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "DictionaryItem" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    index integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "dictionaryId" character varying(255) NOT NULL
);


ALTER TABLE "DictionaryItem" OWNER TO postgres;

--
-- Name: Menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Menu" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    "linkTo" character varying(255),
    icon character varying(255),
    "desc" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "Menu" OWNER TO postgres;

--
-- Name: MenuPreDepends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "MenuPreDepends" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "menuId" character varying(255),
    "dependMenuId" character varying(255)
);


ALTER TABLE "MenuPreDepends" OWNER TO postgres;

--
-- Name: Operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Operation" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    method character varying(255) DEFAULT 'GET'::character varying,
    verify boolean DEFAULT true,
    "desc" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "Operation" OWNER TO postgres;

--
-- Name: OperationPreDepends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "OperationPreDepends" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "operationId" character varying(255),
    "dependOperationId" character varying(255)
);


ALTER TABLE "OperationPreDepends" OWNER TO postgres;

--
-- Name: Organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Organization" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    "belongTo" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "Organization" OWNER TO postgres;

--
-- Name: OrganizationRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "OrganizationRole" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "organizationId" character varying(255),
    "roleId" character varying(255)
);


ALTER TABLE "OrganizationRole" OWNER TO postgres;

--
-- Name: Position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Position" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    "belongTo" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "Position" OWNER TO postgres;

--
-- Name: PositionRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PositionRole" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "positionId" character varying(255),
    "roleId" character varying(255)
);


ALTER TABLE "PositionRole" OWNER TO postgres;

--
-- Name: ProcessDef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ProcessDef" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "flowableInstance" character varying(255) NOT NULL,
    "formDef" text NOT NULL,
    "belongTo" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE "ProcessDef" OWNER TO postgres;

--
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Role" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "desc" character varying(255),
    "belongTo" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE "Role" OWNER TO postgres;

--
-- Name: RoleMenu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "RoleMenu" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "menuId" character varying(255),
    "roleId" character varying(255)
);


ALTER TABLE "RoleMenu" OWNER TO postgres;

--
-- Name: RoleOperation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "RoleOperation" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "operationId" character varying(255),
    "roleId" character varying(255)
);


ALTER TABLE "RoleOperation" OWNER TO postgres;

--
-- Name: SubUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "SubUser" (
    "userId" character varying(255) NOT NULL,
    dependent boolean DEFAULT true,
    enable boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "SubUser" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "User" (
    id character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    type "enum_User_type" DEFAULT 'Master'::"enum_User_type",
    email character varying(255),
    mobile character varying(255),
    "actEmail" boolean DEFAULT false,
    gravatar character varying(255),
    key character varying(255),
    secret character varying(255),
    "isAdmin" boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE "User" OWNER TO postgres;

--
-- Name: UserExtention; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "UserExtention" (
    fullname character varying(255),
    sex "enum_UserExtention_sex",
    education character varying(255),
    birthday timestamp(6) with time zone,
    telephone character varying(255),
    "createdAt" timestamp(6) with time zone NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL,
    "userId" character varying(255) NOT NULL
);


ALTER TABLE "UserExtention" OWNER TO postgres;

--
-- Name: UserExtention_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "UserExtention_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE "UserExtention_id_seq" OWNER TO postgres;

--
-- Name: UserOrganization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "UserOrganization" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" character varying(255),
    "organizationId" character varying(255)
);


ALTER TABLE "UserOrganization" OWNER TO postgres;

--
-- Name: UserPosition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "UserPosition" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" character varying(255),
    "positionId" character varying(255)
);


ALTER TABLE "UserPosition" OWNER TO postgres;

--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "UserRole" (
    id character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" character varying(255),
    "roleId" character varying(255)
);


ALTER TABLE "UserRole" OWNER TO postgres;

--
-- Name: act_adm_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_adm_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_adm_databasechangelog OWNER TO postgres;

--
-- Name: act_adm_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_adm_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_adm_databasechangeloglock OWNER TO postgres;

--
-- Name: act_adm_server_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_adm_server_config (
    id_ character varying(255) NOT NULL,
    name_ character varying(50),
    description_ character varying(255),
    server_address_ character varying(100),
    port_ integer,
    context_root_ character varying(100),
    rest_root_ character varying(100),
    user_name_ character varying(100),
    password_ character varying(100),
    endpoint_type_ integer,
    tenant_id_ character varying(50)
);


ALTER TABLE act_adm_server_config OWNER TO postgres;

--
-- Name: act_app_appdef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_app_appdef (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    category_ character varying(255),
    deployment_id_ character varying(255),
    resource_name_ character varying(4000),
    description_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_app_appdef OWNER TO postgres;

--
-- Name: act_app_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_app_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_app_databasechangelog OWNER TO postgres;

--
-- Name: act_app_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_app_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_app_databasechangeloglock OWNER TO postgres;

--
-- Name: act_app_deployment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_app_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_app_deployment OWNER TO postgres;

--
-- Name: act_app_deployment_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_app_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE act_app_deployment_resource OWNER TO postgres;

--
-- Name: act_cmmn_casedef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_casedef (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    category_ character varying(255),
    deployment_id_ character varying(255),
    resource_name_ character varying(4000),
    description_ character varying(4000),
    has_graphical_notation_ boolean,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    dgrm_resource_name_ character varying(4000),
    has_start_form_key_ boolean
);


ALTER TABLE act_cmmn_casedef OWNER TO postgres;

--
-- Name: act_cmmn_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_cmmn_databasechangelog OWNER TO postgres;

--
-- Name: act_cmmn_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_cmmn_databasechangeloglock OWNER TO postgres;

--
-- Name: act_cmmn_deployment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    deploy_time_ timestamp without time zone,
    parent_deployment_id_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_cmmn_deployment OWNER TO postgres;

--
-- Name: act_cmmn_deployment_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea,
    generated_ boolean
);


ALTER TABLE act_cmmn_deployment_resource OWNER TO postgres;

--
-- Name: act_cmmn_hi_case_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_hi_case_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    business_key_ character varying(255),
    name_ character varying(255),
    parent_id_ character varying(255),
    case_def_id_ character varying(255),
    state_ character varying(255),
    start_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_cmmn_hi_case_inst OWNER TO postgres;

--
-- Name: act_cmmn_hi_mil_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_hi_mil_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    case_inst_id_ character varying(255) NOT NULL,
    case_def_id_ character varying(255) NOT NULL,
    element_id_ character varying(255) NOT NULL,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_cmmn_hi_mil_inst OWNER TO postgres;

--
-- Name: act_cmmn_hi_plan_item_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_hi_plan_item_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    state_ character varying(255),
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    stage_inst_id_ character varying(255),
    is_stage_ boolean,
    element_id_ character varying(255),
    item_definition_id_ character varying(255),
    item_definition_type_ character varying(255),
    create_time_ timestamp without time zone,
    last_available_time_ timestamp without time zone,
    last_enabled_time_ timestamp without time zone,
    last_disabled_time_ timestamp without time zone,
    last_started_time_ timestamp without time zone,
    last_suspended_time_ timestamp without time zone,
    completed_time_ timestamp without time zone,
    occurred_time_ timestamp without time zone,
    terminated_time_ timestamp without time zone,
    exit_time_ timestamp without time zone,
    ended_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    entry_criterion_id_ character varying(255),
    exit_criterion_id_ character varying(255)
);


ALTER TABLE act_cmmn_hi_plan_item_inst OWNER TO postgres;

--
-- Name: act_cmmn_ru_case_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_ru_case_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    business_key_ character varying(255),
    name_ character varying(255),
    parent_id_ character varying(255),
    case_def_id_ character varying(255),
    state_ character varying(255),
    start_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    lock_time_ timestamp without time zone,
    is_completeable_ boolean
);


ALTER TABLE act_cmmn_ru_case_inst OWNER TO postgres;

--
-- Name: act_cmmn_ru_mil_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_ru_mil_inst (
    id_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    case_inst_id_ character varying(255) NOT NULL,
    case_def_id_ character varying(255) NOT NULL,
    element_id_ character varying(255) NOT NULL,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_cmmn_ru_mil_inst OWNER TO postgres;

--
-- Name: act_cmmn_ru_plan_item_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_ru_plan_item_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    stage_inst_id_ character varying(255),
    is_stage_ boolean,
    element_id_ character varying(255),
    name_ character varying(255),
    state_ character varying(255),
    create_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    item_definition_id_ character varying(255),
    item_definition_type_ character varying(255),
    is_completeable_ boolean,
    is_count_enabled_ boolean,
    var_count_ integer,
    sentry_part_inst_count_ integer,
    last_available_time_ timestamp(3) without time zone,
    last_enabled_time_ timestamp(3) without time zone,
    last_disabled_time_ timestamp(3) without time zone,
    last_started_time_ timestamp(3) without time zone,
    last_suspended_time_ timestamp(3) without time zone,
    completed_time_ timestamp(3) without time zone,
    occurred_time_ timestamp(3) without time zone,
    terminated_time_ timestamp(3) without time zone,
    exit_time_ timestamp(3) without time zone,
    ended_time_ timestamp(3) without time zone,
    entry_criterion_id_ character varying(255),
    exit_criterion_id_ character varying(255)
);


ALTER TABLE act_cmmn_ru_plan_item_inst OWNER TO postgres;

--
-- Name: act_cmmn_ru_sentry_part_inst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_cmmn_ru_sentry_part_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    plan_item_inst_id_ character varying(255),
    on_part_id_ character varying(255),
    if_part_id_ character varying(255),
    time_stamp_ timestamp without time zone
);


ALTER TABLE act_cmmn_ru_sentry_part_inst OWNER TO postgres;

--
-- Name: act_co_content_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_co_content_item (
    id_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    mime_type_ character varying(255),
    task_id_ character varying(255),
    proc_inst_id_ character varying(255),
    content_store_id_ character varying(255),
    content_store_name_ character varying(255),
    field_ character varying(400),
    content_available_ boolean DEFAULT false,
    created_ timestamp(6) without time zone,
    created_by_ character varying(255),
    last_modified_ timestamp(6) without time zone,
    last_modified_by_ character varying(255),
    content_size_ bigint DEFAULT 0,
    tenant_id_ character varying(255),
    scope_id_ character varying(255),
    scope_type_ character varying(255)
);


ALTER TABLE act_co_content_item OWNER TO postgres;

--
-- Name: act_co_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_co_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_co_databasechangelog OWNER TO postgres;

--
-- Name: act_co_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_co_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_co_databasechangeloglock OWNER TO postgres;

--
-- Name: act_de_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_de_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_de_databasechangelog OWNER TO postgres;

--
-- Name: act_de_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_de_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_de_databasechangeloglock OWNER TO postgres;

--
-- Name: act_de_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_de_model (
    id character varying(255) NOT NULL,
    name character varying(400) NOT NULL,
    model_key character varying(400) NOT NULL,
    description character varying(4000),
    model_comment character varying(4000),
    created timestamp(6) without time zone,
    created_by character varying(255),
    last_updated timestamp(6) without time zone,
    last_updated_by character varying(255),
    version integer,
    model_editor_json text,
    thumbnail bytea,
    model_type integer,
    tenant_id character varying(255)
);


ALTER TABLE act_de_model OWNER TO postgres;

--
-- Name: act_de_model_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_de_model_history (
    id character varying(255) NOT NULL,
    name character varying(400) NOT NULL,
    model_key character varying(400) NOT NULL,
    description character varying(4000),
    model_comment character varying(4000),
    created timestamp(6) without time zone,
    created_by character varying(255),
    last_updated timestamp(6) without time zone,
    last_updated_by character varying(255),
    removal_date timestamp(6) without time zone,
    version integer,
    model_editor_json text,
    model_id character varying(255) NOT NULL,
    model_type integer,
    tenant_id character varying(255)
);


ALTER TABLE act_de_model_history OWNER TO postgres;

--
-- Name: act_de_model_relation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_de_model_relation (
    id character varying(255) NOT NULL,
    parent_model_id character varying(255),
    model_id character varying(255),
    relation_type character varying(255)
);


ALTER TABLE act_de_model_relation OWNER TO postgres;

--
-- Name: act_dmn_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_dmn_databasechangelog OWNER TO postgres;

--
-- Name: act_dmn_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_dmn_databasechangeloglock OWNER TO postgres;

--
-- Name: act_dmn_decision_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_decision_table (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE act_dmn_decision_table OWNER TO postgres;

--
-- Name: act_dmn_deployment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE act_dmn_deployment OWNER TO postgres;

--
-- Name: act_dmn_deployment_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE act_dmn_deployment_resource OWNER TO postgres;

--
-- Name: act_dmn_hi_decision_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_dmn_hi_decision_execution (
    id_ character varying(255) NOT NULL,
    decision_definition_id_ character varying(255),
    deployment_id_ character varying(255),
    start_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    instance_id_ character varying(255),
    execution_id_ character varying(255),
    activity_id_ character varying(255),
    failed_ boolean DEFAULT false,
    tenant_id_ character varying(255),
    execution_json_ text,
    scope_type_ character varying(255)
);


ALTER TABLE act_dmn_hi_decision_execution OWNER TO postgres;

--
-- Name: act_evt_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_evt_log (
    log_nr_ integer NOT NULL,
    type_ character varying(64),
    proc_def_id_ character varying(64),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ bytea,
    lock_owner_ character varying(255),
    lock_time_ timestamp without time zone,
    is_processed_ smallint DEFAULT 0
);


ALTER TABLE act_evt_log OWNER TO postgres;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE act_evt_log_log_nr__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE act_evt_log_log_nr__seq OWNER TO postgres;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE act_evt_log_log_nr__seq OWNED BY act_evt_log.log_nr_;


--
-- Name: act_fo_databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE act_fo_databasechangelog OWNER TO postgres;

--
-- Name: act_fo_databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE act_fo_databasechangeloglock OWNER TO postgres;

--
-- Name: act_fo_form_definition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_form_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE act_fo_form_definition OWNER TO postgres;

--
-- Name: act_fo_form_deployment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_form_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE act_fo_form_deployment OWNER TO postgres;

--
-- Name: act_fo_form_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_form_instance (
    id_ character varying(255) NOT NULL,
    form_definition_id_ character varying(255) NOT NULL,
    task_id_ character varying(255),
    proc_inst_id_ character varying(255),
    proc_def_id_ character varying(255),
    submitted_date_ timestamp without time zone,
    submitted_by_ character varying(255),
    form_values_id_ character varying(255),
    tenant_id_ character varying(255),
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE act_fo_form_instance OWNER TO postgres;

--
-- Name: act_fo_form_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_fo_form_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE act_fo_form_resource OWNER TO postgres;

--
-- Name: act_ge_bytearray; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE act_ge_bytearray OWNER TO postgres;

--
-- Name: act_ge_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_ge_property OWNER TO postgres;

--
-- Name: act_hi_actinst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_actinst OWNER TO postgres;

--
-- Name: act_hi_attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64),
    time_ timestamp without time zone
);


ALTER TABLE act_hi_attachment OWNER TO postgres;

--
-- Name: act_hi_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE act_hi_comment OWNER TO postgres;

--
-- Name: act_hi_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_hi_detail OWNER TO postgres;

--
-- Name: act_hi_entitylink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_entitylink (
    id_ character varying(64) NOT NULL,
    link_type_ character varying(255),
    create_time_ timestamp without time zone,
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE act_hi_entitylink OWNER TO postgres;

--
-- Name: act_hi_identitylink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    create_time_ timestamp without time zone,
    proc_inst_id_ character varying(64),
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE act_hi_identitylink OWNER TO postgres;

--
-- Name: act_hi_procinst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_procinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255)
);


ALTER TABLE act_hi_procinst OWNER TO postgres;

--
-- Name: act_hi_taskinst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE act_hi_taskinst OWNER TO postgres;

--
-- Name: act_hi_tsk_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_tsk_log (
    id_ integer NOT NULL,
    type_ character varying(64),
    task_id_ character varying(64) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ character varying(4000),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    scope_definition_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_tsk_log OWNER TO postgres;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE act_hi_tsk_log_id__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE act_hi_tsk_log_id__seq OWNER TO postgres;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE act_hi_tsk_log_id__seq OWNED BY act_hi_tsk_log.id_;


--
-- Name: act_hi_varinst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_hi_varinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE act_hi_varinst OWNER TO postgres;

--
-- Name: act_id_bytearray; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    bytes_ bytea
);


ALTER TABLE act_id_bytearray OWNER TO postgres;

--
-- Name: act_id_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE act_id_group OWNER TO postgres;

--
-- Name: act_id_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE act_id_info OWNER TO postgres;

--
-- Name: act_id_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE act_id_membership OWNER TO postgres;

--
-- Name: act_id_priv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_priv (
    id_ character varying(64) NOT NULL,
    name_ character varying(255) NOT NULL
);


ALTER TABLE act_id_priv OWNER TO postgres;

--
-- Name: act_id_priv_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_priv_mapping (
    id_ character varying(64) NOT NULL,
    priv_id_ character varying(64) NOT NULL,
    user_id_ character varying(255),
    group_id_ character varying(255)
);


ALTER TABLE act_id_priv_mapping OWNER TO postgres;

--
-- Name: act_id_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_id_property OWNER TO postgres;

--
-- Name: act_id_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_token (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    token_value_ character varying(255),
    token_date_ timestamp without time zone,
    ip_address_ character varying(255),
    user_agent_ character varying(255),
    user_id_ character varying(255),
    token_data_ character varying(2000)
);


ALTER TABLE act_id_token OWNER TO postgres;

--
-- Name: act_id_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    display_name_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_id_user OWNER TO postgres;

--
-- Name: act_procdef_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_procdef_info (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    rev_ integer,
    info_json_id_ character varying(64)
);


ALTER TABLE act_procdef_info OWNER TO postgres;

--
-- Name: act_re_deployment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    parent_deployment_id_ character varying(255),
    engine_version_ character varying(255)
);


ALTER TABLE act_re_deployment OWNER TO postgres;

--
-- Name: act_re_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_model OWNER TO postgres;

--
-- Name: act_re_procdef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    has_graphical_notation_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    derived_version_ integer DEFAULT 0 NOT NULL,
    engine_version_ character varying(255)
);


ALTER TABLE act_re_procdef OWNER TO postgres;

--
-- Name: act_ru_actinst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_actinst OWNER TO postgres;

--
-- Name: act_ru_deadletter_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_deadletter_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_deadletter_job OWNER TO postgres;

--
-- Name: act_ru_entitylink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_entitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    create_time_ timestamp without time zone,
    link_type_ character varying(255),
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE act_ru_entitylink OWNER TO postgres;

--
-- Name: act_ru_event_subscr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    sub_scope_id_ character varying(64),
    scope_id_ character varying(64),
    scope_definition_id_ character varying(64),
    scope_type_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_event_subscr OWNER TO postgres;

--
-- Name: act_ru_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    root_proc_inst_id_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    is_mi_root_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    start_act_id_ character varying(255),
    start_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    lock_time_ timestamp without time zone,
    is_count_enabled_ boolean,
    evt_subscr_count_ integer,
    task_count_ integer,
    job_count_ integer,
    timer_job_count_ integer,
    susp_job_count_ integer,
    deadletter_job_count_ integer,
    var_count_ integer,
    id_link_count_ integer,
    callback_id_ character varying(255),
    callback_type_ character varying(255)
);


ALTER TABLE act_ru_execution OWNER TO postgres;

--
-- Name: act_ru_history_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_history_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    adv_handler_cfg_id_ character varying(64),
    create_time_ timestamp without time zone,
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_history_job OWNER TO postgres;

--
-- Name: act_ru_identitylink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE act_ru_identitylink OWNER TO postgres;

--
-- Name: act_ru_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_job OWNER TO postgres;

--
-- Name: act_ru_suspended_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_suspended_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_suspended_job OWNER TO postgres;

--
-- Name: act_ru_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    form_key_ character varying(255),
    claim_time_ timestamp without time zone,
    is_count_enabled_ boolean,
    var_count_ integer,
    id_link_count_ integer,
    sub_task_count_ integer
);


ALTER TABLE act_ru_task OWNER TO postgres;

--
-- Name: act_ru_timer_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_timer_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_timer_job OWNER TO postgres;

--
-- Name: act_ru_variable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_ru_variable OWNER TO postgres;

--
-- Name: userextention_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE userextention_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE userextention_id_seq OWNER TO postgres;

--
-- Name: act_evt_log log_nr_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('act_evt_log_log_nr__seq'::regclass);


--
-- Name: act_hi_tsk_log id_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_tsk_log ALTER COLUMN id_ SET DEFAULT nextval('act_hi_tsk_log_id__seq'::regclass);


--
-- Data for Name: Dictionary; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Dictionary" (id, name, key, "belongTo", "createdAt", "updatedAt") VALUES ('c563fee9-dc87-44c9-8778-0345b915615b', '学历', 'frame_education', NULL, '2019-12-05 18:34:09.809+08', '2019-12-05 18:34:09.809+08');


--
-- Data for Name: DictionaryItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "DictionaryItem" (id, name, key, index, "createdAt", "updatedAt", "dictionaryId") VALUES ('a3c13fe5-ee4e-4c5f-9037-5269bf309058', '大专', 'junior_college', 1, '2019-12-05 18:34:28.602+08', '2019-12-05 18:34:28.602+08', 'c563fee9-dc87-44c9-8778-0345b915615b');
INSERT INTO "DictionaryItem" (id, name, key, index, "createdAt", "updatedAt", "dictionaryId") VALUES ('28f983f3-83e6-41e4-a3d6-ab9389ca3cf0', '本科', 'bachelor', 2, '2019-12-05 18:34:39.984+08', '2019-12-05 18:34:39.984+08', 'c563fee9-dc87-44c9-8778-0345b915615b');
INSERT INTO "DictionaryItem" (id, name, key, index, "createdAt", "updatedAt", "dictionaryId") VALUES ('e555ed62-9618-44c4-9a46-b833c77a6ae3', '硕士', 'master', 3, '2019-12-05 18:34:52.701+08', '2019-12-05 18:34:52.701+08', 'c563fee9-dc87-44c9-8778-0345b915615b');
INSERT INTO "DictionaryItem" (id, name, key, index, "createdAt", "updatedAt", "dictionaryId") VALUES ('3a0d4431-e469-487f-8409-67f8ba2fc89e', '博士', 'doctor', 4, '2019-12-05 18:35:05.981+08', '2019-12-05 18:35:05.981+08', 'c563fee9-dc87-44c9-8778-0345b915615b');
INSERT INTO "DictionaryItem" (id, name, key, index, "createdAt", "updatedAt", "dictionaryId") VALUES ('2f463a7c-92da-4298-b840-cc2b4d5dbb62', '其他', 'others', 5, '2019-12-05 18:35:17.343+08', '2019-12-05 18:35:17.343+08', 'c563fee9-dc87-44c9-8778-0345b915615b');


--
-- Data for Name: Menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('0', '管理控制台', '/console', NULL, NULL, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', NULL);
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('1', '总览', '/console/overview', '/console/overview', 'overview', '', '2018-05-15 19:26:27.603+08', '2018-05-15 19:26:27.603+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1', '菜单与操作', '/console/authorizations/overview', '/console/authorizations/overview', 'menu', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '6');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6', '权限管理', '/console/authorizations', NULL, 'authorization', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2', '角色', '/console/authorizations/roles', '/console/authorizations/roles', 'role', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '6');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3', '组织', '/console/authorizations/organizations', '/console/authorizations/organizations', 'organization', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '6');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4', '职位', '/console/authorizations/positions', '/console/authorizations/positions', 'user-position', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '6');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.5', '用户', '/console/authorizations/users', '/console/authorizations/users', 'subuser', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '6');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1', '字典管理', '/console/system/dictionaries', '/console/system/dictionaries', 'dictionary', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '8');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8', '系统管理', '/console/system', NULL, 'system', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('9.1', '账号安全', '/console/account/profile', '/console/account/profile', 'profile', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '9');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('9', '账号管理', '/console/account', NULL, 'account-sec', '', '2018-05-15 19:26:27.651+08', '2018-05-15 19:26:27.651+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5', '党建管理', '/console.cpp', '', 'antv-hdd', NULL, '2018-05-15 19:26:27.603+08', '2018-05-15 19:26:27.603+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1', 'Example', '/console/applications/communist_party_process', '/console/applications/communist_party_process', 'antv-schedule', NULL, '2018-05-15 19:26:27.603+08', '2018-05-15 19:26:27.603+08', '5');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('4', '项目管理', '/console/applications/project', '', 'antv-layout', NULL, '2018-05-15 19:26:27.603+08', '2019-11-13 17:26:41+08', '0');
INSERT INTO "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") VALUES ('4.1', '年度工程项目', '/console/applications/project_of_year', '/console/applications/project_of_year', 'antv-audit', NULL, '2018-05-15 19:26:27.603+08', '2019-11-13 17:27:31+08', '4');


--
-- Data for Name: MenuPreDepends; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('0', '控制台操作', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', NULL);
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('1', '总览', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5', '流程管理', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1', '基础查询', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.1', '查询流程定义', '/processdefs/:id', 'GET', false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.2', '查询流程BPMN模型', '/fl/process/repository/process-definitions/:flowableInstance/resourcedata', 'GET', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.3', '查询流程', '/fl/iota/query/process-instances', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.4', '查询历史流程', '/fl/iota/query/historic-process-instances', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.5', '查询待处理任务（流程）', '/fl/iota/query/tasks', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.6', '查询指定流程', '/fl/process/runtime/process-instances/:processInstanceId', 'GET', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.1.0.7', '查询流程中的任务', '/fl/process/query/historic-task-instances', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2', '流程操作', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2.0.1', '创建流程', '/fl/process/runtime/process-instances', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2.1', '更新流程', '/fl/process/runtime/process-instances/:processInstanceId', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2.1.1', '挂起', '/fl/process/runtime/process-instances/:processInstanceId/suspend', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2.1.2', '激活', '/fl/process/runtime/process-instances/:processInstanceId/activate', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.2.2.1', '删除流程', '/fl/process/runtime/process-instances/:processInstanceId', 'DELETE', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3', '任务管理', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.0', '更新任务', '/fl/process/runtime/tasks/:id', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.0.1', '认领', '/fl/process/runtime/tasks/:id/claim', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.0.2', '指派', '/fl/process/runtime/tasks/:id/assignee', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.0.3', '截至时间', '/fl/process/runtime/tasks/:id/duedate', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.2.1', '提交任务', '/fl/process/runtime/tasks/:id', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.1', '任务相关人和群组', '/fl/process/runtime/tasks/:taskId/identitylinks', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.1.1', '增加任务相关人', '/fl/process/runtime/tasks/:taskId/identitylinks/users', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.1.2', '增加任务相关群组', '/fl/process/runtime/tasks/:taskId/identitylinks/groups', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.1.3', '删除任务关联人', '/fl/process/runtime/tasks/:taskId/identitylinks/users/:user/:type', 'DELETE', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.3.1.4', '删除任务关联群组', '/fl/process/runtime/tasks/:taskId/identitylinks/groups/:group/:type', 'DELETE', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.4', '评论管理', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.4.0.1', '查询评论', '/fl/process/history/historic-process-instances/:instanceId/comments', 'GET', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.4.0.2', '创建评论', '/fl/process/history/historic-process-instances/:instanceId/comments', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.4.0.3', '更新评论', '/fl/process/history/historic-process-instances/:instanceId/comments/:id', 'PUT', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.4.0.4', '删除评论', '/fl/process/history/historic-process-instances/:instanceId/comments/:id', 'DELETE', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.5', '附件管理', '', NULL, false, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.5.0.1', '查询附件', '/fl/content/content-service/content-items', 'GET', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.5.0.2', '添加附件', '/fl/content/content-service/content-items', 'POST', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.5.0.3', '删除附件', '/fl/content/content-service/content-items/:id', 'DELETE', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('5.5.0.4', '下载附件', '/fl/content/content-service/content-items/:attachmentId/data', 'GET', true, NULL, '1900-01-20 03:49:45.598+07:36:42', '1900-01-20 03:49:45.598+07:36:42', '5.5');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6', '权限管理', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1', '角色', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.0.1', '查询角色', '/authorizations/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.0.2', '创建角色', '/authorizations/roles', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.0.3', '修改角色', '/authorizations/roles/:id', 'PUT', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.0.4', '删除角色', '/authorizations/roles/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1', '角色权限分配', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.1', '菜单', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.1.1', '查询角色已分配菜单', '/authorizations/roles/:roleId/menus', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.1.2', '分配菜单至角色', '/authorizations/roles/:roleId/menus', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.1.3', '删除角色已分配菜单', '/authorizations/roles/:roleId/menus/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.2', '操作', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.2.1', '查询角色已分配操作', '/authorizations/roles/:roleId/operations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.2.2', '分配操作至角色', '/authorizations/roles/:roleId/operations', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.1.2.3', '删除角色已分配操作', '/authorizations/roles/:roleId/operations/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.2', '角色关联组织', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.2.1', '查询角色已关联组织', '/authorizations/roles/:roleId/organizations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.2.2', '查询角色未关联组织', '/authorizations/roles/:roleId/not_bind/organizations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.2.3', '关联角色至组织', '/authorizations/roles/:roleId/organizations', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.2.4', '删除角色已关联组织', '/authorizations/roles/:roleId/organizations/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.3', '角色关联职位', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.3.1', '查询角色已关联职位', '/authorizations/roles/:roleId/positions', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.3.2', '查询角色未关联职位', '/authorizations/roles/:roleId/not_bind/positions', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.3.3', '关联角色至职位', '/authorizations/roles/:roleId/positions', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.3.4', '删除角色已关联职位', '/authorizations/roles/:roleId/positions/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.4', '角色关联用户', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.4.1', '查询角色已关联用户', '/authorizations/roles/:roleId/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.4.2', '查询角色未关联用户', '/authorizations/roles/:roleId/not_bind/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.4.3', '关联角色至用户', '/authorizations/roles/:roleId/users', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.1.4.4', '删除角色已关联用户', '/authorizations/roles/:roleId/users/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.1.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2', '组织', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.0.1', '查询组织', '/authorizations/organizations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.0.2', '创建组织', '/authorizations/organizations', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.0.3', '修改组织', '/authorizations/organizations/:id', 'PUT', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.0.4', '删除组织', '/authorizations/organizations/:id', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.1', '组织关联角色', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.1.1', '查询组织已关联角色', '/authorizations/organizations/:organizationId/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.1.2', '查询组织未关联角色', '/authorizations/organizations/:organizationId/not_assigned/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.1.3', '关联组织至角色', '/authorizations/organizations/:organizationId/roles', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.1.4', '删除组织已关联角色', '/authorizations/organizations/:organizationId/roles/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.2', '组织关联用户', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.2.1', '查询组织已关联用户', '/authorizations/organizations/:organizationId/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.2.2', '查询组织未关联用户', '/authorizations/organizations/:organizationId/not_in/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.2.3', '关联组织至用户', '/authorizations/organizations/:organizationId/users', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.2.2.4', '删除组织已关联用户', '/authorizations/organizations/:organizationId/users/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.2.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3', '职位', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.0.1', '查询职位', '/authorizations/positions', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.0.2', '创建职位', '/authorizations/positions', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.0.3', '修改职位', '/authorizations/positions/:id', 'PUT', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.0.4', '删除职位', '/authorizations/positions/:id', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.1', '职位关联角色', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.1.1', '查询组织已关联角色', '/authorizations/positions/:positionId/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.1.2', '查询组织未关联角色', '/authorizations/positions/:positionId/not_assigned/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.1.3', '关联组织至角色', '/authorizations/positions/:positionId/roles', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.1.4', '删除组织已关联角色', '/authorizations/positions/:positionId/roles/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.2', '职位关联用户', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.2.1', '查询组织已关联用户', '/authorizations/positions/:positionId/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.2.2', '查询组织未关联用户', '/authorizations/positions/:positionId/not_in/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.2.3', '关联组织至用户', '/authorizations/positions/:positionId/users', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.3.2.4', '删除组织已关联用户', '/authorizations/positions/:positionId/users/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.3.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4', '用户', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.1', '查询用户', '/authorizations/users', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.2', '创建用户', '/authorizations/users', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.3', '修改用户', '/authorizations/users/:id', 'PUT', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.4', '删除用户', '/authorizations/users/:id', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.5', '禁用用户', '/authorizations/users/disable/:id?', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.6', '启用用户', '/authorizations/users/enable/:id?', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.7', '查看用户详细信息', '/authorizations/users/:userId/extention', 'GET', true, '', '2019-12-05 10:14:17+08', '2019-12-05 10:14:20+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.0.8', '修改用户详细信息', '/authorizations/users/:userId/extention', 'PUT', true, '', '2019-12-05 10:17:01+08', '2019-12-05 10:16:39+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.1', '用户分配角色', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.1.1', '查询用户已分配角色', '/authorizations/users/:userId/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.1.2', '查询用户未分配角色', '/authorizations/users/:userId/not_assigned/roles', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.1.3', '分配角色至用户', '/authorizations/users/:userId/roles', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.1.4', '删除用户已分配角色', '/authorizations/users/:userId/roles/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.2', '用户归属组织', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.2.1', '查询用户归属的组织', '/authorizations/users/:userId/organizations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.2.2', '查询用户未归属组织', '/authorizations/users/:userId/not_assigned/organizations', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.2.3', '分配用户至组织', '/authorizations/users/:userId/organizations', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.2.4', '删除用户已归属组织', '/authorizations/users/:userId/organizations/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.2');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.3', '用户分配职位', '', '', false, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.3.1', '查询用户归属的职位', '/authorizations/users/:userId/positions', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.3.2', '查询用户未归属职位', '/authorizations/users/:userId/not_assigned/positions', 'GET', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.3.3', '赋予用户职位', '/authorizations/users/:userId/positions', 'POST', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('6.4.3.4', '删除用户已赋予职位', '/authorizations/users/:userId/positions/:id?', 'DELETE', true, '', '2018-05-15 19:26:27.598+08', '2018-05-15 19:26:27.598+08', '6.4.3');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8', '系统管理', '', '', false, '', '2019-12-05 10:21:09+08', '2019-12-05 10:21:12+08', '0');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1', '字典管理', '', '', false, '', '2019-12-05 10:22:52+08', '2019-12-05 10:22:57+08', '8');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.0.1', '查询字典', '/dictionaries/:key?', 'GET', true, ' ', '2019-12-05 10:26:09+08', '2019-12-05 10:26:12+08', '8.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.0.2', '创建字典', '/dictionaries', 'POST', true, '', '2019-12-05 10:39:21+08', '2019-12-05 10:39:23+08', '8.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.0.3', '修改字典', '/dictionaries/:id', 'PUT', true, '', '2019-12-05 10:40:18+08', '2019-12-05 10:40:20+08', '8.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.0.4', '删除字典', '/dictionaries/:id', 'DELETE', true, '', '2019-12-05 10:40:18+08', '2019-12-05 10:40:20+08', '8.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.1', '字典条目', '', '', false, '', '2019-12-05 10:25:26+08', '2019-12-05 10:25:29+08', '8.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.1.1', '创建字典条目', '/dictionaries/:dictionaryId/items', 'POST', true, ' ', '2019-12-05 10:26:09+08', '2019-12-05 10:26:12+08', '8.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.1.2', '修改字典条目', '/dictionaries/:dictionaryId/items/:id', 'PUT', true, ' ', '2019-12-05 10:26:09+08', '2019-12-05 10:26:12+08', '8.1.1');
INSERT INTO "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") VALUES ('8.1.1.3', '删除字典条目', '/dictionaries/:dictionaryId/items/:id', 'DELETE', true, ' ', '2019-12-05 10:26:09+08', '2019-12-05 10:26:12+08', '8.1.1');


--
-- Data for Name: OperationPreDepends; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Organization; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: OrganizationRole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Position; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: PositionRole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ProcessDef; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "ProcessDef" (id, name, "flowableInstance", "formDef", "belongTo", "createdAt", "updatedAt") VALUES ('project_of_year', '年度工程项目', 'process:4:942d7f66-11af-11ea-aa8d-7c7a916bf543', '{
    "type": "object",
    "properties": {
        "projectId": {
            "type": "string",
            "ui": {
                "columns": 5,
                "label": "项目ID",
                "hidden": true
            }
        },
        "projectYear": {
            "type": "string",
            "ui": {
                "columns": 5,
                "label": "年度",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')",
                "placeholder": "选择年份……",
                "enumSource": [
                    {
                        "value": 2020,
                        "label": "2020"
                    },
                    {
                        "value": 2021,
                        "label": "2021"
                    },
                    {
                        "value": 2022,
                        "label": "2022"
                    },
                    {
                        "value": 2023,
                        "label": "2023"
                    },
                    {
                        "value": 2024,
                        "label": "2024"
                    },
                    {
                        "value": 2025,
                        "label": "2025"
                    }
                ],
                "widget": "select"
            }
        },
        "initiatorName": {
            "type": "string",
            "ui": {
                "columns": 5,
                "label": "发起人",
                "disabled": true
            }
        },
        "projectNumber": {
            "type": "select",
            "ui": {
                "label": "项目编号",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')"
            }
        },
        "projectName": {
            "type": "string",
            "ui": {
                "label": "项目名称",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')"
            }
        },
        "projectDescribe": {
            "type": "string",
            "ui": {
                "label": "项目描述",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')",
                "widget": "textarea",
                "widgetConfig": {
                    "rows": 3,
                    "autoSize": {
                        "minRows": 2,
                        "maxRows": 4
                    }
                }
            }
        },
        "startTime": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')",
                "columns": 5,
                "widget": "date-picker",
                "label": "开始时间"
            }
        },
        "finishTime": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''acceptance'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' ||{{$const.currentTaskId}} === ''contact'')",
                "columns": 5,
                "widget": "date-picker",
                "label": "结束时间"
            }
        },
        "constructionCost": {
            "type": "string",
            "ui": {
                "columns": 5,
                "label": "施工费用",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')"
            }
        },
        "deviceCost": {
            "type": "select",
            "ui": {
                "columns": 5,
                "label": "设备费用",
                "disabled": "dx: !({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit_modify'')"
            }
        },
        "memo": {
            "type": "text",
            "ui": {
                "label": "备注",
                "widget": "textarea"
            }
        },
        "contractTime": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''contact'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'')",
                "columns": 5,
                "widget": "date-picker",
                "label": "合同时间"
            }
        },
        "constructCorp": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''contact'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'')",
                "columns": 5,
                "label": "施工单位"
            }
        },
        "constructSponsor": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''contact'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'')",
                "columns": 5,
                "label": "施工联系人"
            }
        },
        "constructSponsorPhone": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''contact'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'')",
                "columns": 5,
                "label": "联系人电话"
            }
        },
        "processBar": {
            "type": "number",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''acceptance'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' ||{{$const.currentTaskId}} === ''contact'')",
                "widget": "slider",
                "label": "施工进度"
            }
        },
        "finalReportTime": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' || {{$const.currentTaskId}} === ''contact''||{{$const.currentTaskId}} === ''acceptance'')",
                "columns": 5,
                "widget": "date-picker",
                "label": "决算时间"
            }
        },
        "finalReportSponsor": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' || {{$const.currentTaskId}} === ''contact''||{{$const.currentTaskId}} === ''acceptance'')",
                "columns": 5,
                "label": "决算人"
            }
        },
        "finalReportConstructionCost": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' || {{$const.currentTaskId}} === ''contact''||{{$const.currentTaskId}} === ''acceptance'')",
                "columns": 5,
                "label": "决算施工费"
            }
        },
        "finalReportDeviceCost": {
            "type": "string",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "hidden": "dx: ({{$const.currentTaskId}} === ''start'' || {{$const.currentTaskId}} === ''audit'' ||{{$const.currentTaskId}} === ''audit_modify'' || {{$const.currentTaskId}} === ''contact''||{{$const.currentTaskId}} === ''acceptance'')",
                "columns": 5,
                "label": "决算设备费"
            }
        },
        "resendRequest": {
            "type": "boolean",
            "value": "",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''audit_modify'')",
                "hidden": "dx: !({{$const.currentTaskId}} === ''audit_modify'')",
                "label": "重新提交"
            }
        },
        "vacationApproved": {
            "type": "boolean",
            "value": "",
            "ui": {
                "disabled": "dx: {{$const.currentTaskId}} !== ''audit''",
                "hidden": "dx: {{$const.currentTaskId}} !== ''audit'' ",
                "label": "审核通过"
            }
        },
        "vacationReason": {
            "type": "text",
            "value": "",
            "ui": {
                "disabled": "dx: {{$const.currentTaskId}} !== ''audit''",
                "hidden": "dx: !({{$const.currentTaskId}} === ''audit'' || {{$const.currentTaskId}} === ''audit_modify'') ",
                "label": "审核意见",
                "widget": "textarea"
            }
        },
        "acceptanceOpt": {
            "type": "number",
            "value": "",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''acceptance'')",
                "hidden": "dx: !({{$const.currentTaskId}} === ''acceptance'')",
                "label": "施工提交选项",
                "widget": "radio",
                "widgetConfig": {
                    "enumSource": [
                        {
                            "value": 0,
                            "label": "开始施工，填写施工信息"
                        },
                        {
                            "value": 1,
                            "label": "合同信息错误，回退上一流程处理"
                        },
                        {
                            "value": 2,
                            "label": "实施完毕，提交验收"
                        }
                    ]
                }
            }
        },
        "finalReportOpt": {
            "type": "number",
            "value": "",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "hidden": "dx: !({{$const.currentTaskId}} === ''finalReport'')",
                "label": "决算提交选项",
                "widget": "radio",
                "widgetConfig": {
                    "enumSource": [
                        {
                            "value": 0,
                            "label": "开始决算，更新决算信息信息"
                        },
                        {
                            "value": 1,
                            "label": "施工信息错误，回退上一流程处理"
                        },
                        {
                            "value": 2,
                            "label": "决算完毕，提交付款"
                        }
                    ]
                }
            }
        },
        "paymentOpt": {
            "type": "number",
            "value": "",
            "ui": {
                "disabled": "dx: !({{$const.currentTaskId}} === ''payment'')",
                "hidden": "dx: !({{$const.currentTaskId}} === ''payment'')",
                "label": "付款提交选项",
                "widget": "radio",
                "widgetConfig": {
                    "enumSource": [
                        {
                            "value": 0,
                            "label": "开始付款，更新付款信息"
                        },
                        {
                            "value": 1,
                            "label": "决算信息错误，回退上一流程处理"
                        },
                        {
                            "value": 2,
                            "label": "付款完毕，提交归档"
                        }
                    ]
                }
            }
        }
    },
    "ui": {
        "width": 700,
        "widgetConfig": {
            "layout": "h"
        }
    }
}', '', '2019-11-22 17:01:18+08', '2019-11-22 17:01:23+08');


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: RoleMenu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: RoleOperation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: SubUser; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "User" (id, username, password, type, email, mobile, "actEmail", gravatar, key, secret, "isAdmin", "createdAt", "updatedAt", "deletedAt") VALUES ('admin', 'admin', '35d4da11e2589bf03821ec777ddfe53761fa9b70', 'Master', NULL, NULL, false, NULL, '95895af3e41795de1303e409baa4bd4e346ad6e9', '0b34ed42c8f1aafc7c1e81ec09aed6aab16737ca', true, '2019-12-05 16:09:02.424+08', '2019-12-05 16:09:02.424+08', NULL);


--
-- Data for Name: UserExtention; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UserOrganization; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UserPosition; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_adm_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_adm_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'META-INF/liquibase/flowable-admin-app-db-changelog.xml', '2019-12-05 16:14:25.411031', 1, 'EXECUTED', '8:655e3bb142f7d051dfc2d641ee0eeebd', 'createTable tableName=ACT_ADM_SERVER_CONFIG', '', NULL, '3.6.3', NULL, NULL, '5533665353');


--
-- Data for Name: act_adm_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_adm_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_adm_server_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423a2b77-1737-11ea-9a8b-7c7a916bf543', 'Flowable Process app', 'Flowable Process REST config', 'http://localhost', 8080, 'flowable-task', 'process-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 1, NULL);
INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423b8b08-1737-11ea-9a8b-7c7a916bf543', 'Flowable CMMN app', 'Flowable CMMN REST config', 'http://localhost', 8080, 'flowable-task', 'cmmn-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 5, NULL);
INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423bd929-1737-11ea-9a8b-7c7a916bf543', 'Flowable App app', 'Flowable App REST config', 'http://localhost', 8080, 'flowable-task', 'app-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 6, NULL);
INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423c003a-1737-11ea-9a8b-7c7a916bf543', 'Flowable DMN app', 'Flowable DMN REST config', 'http://localhost', 8080, 'flowable-task', 'dmn-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 2, NULL);
INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423c4e5b-1737-11ea-9a8b-7c7a916bf543', 'Flowable Form app', 'Flowable Form REST config', 'http://localhost', 8080, 'flowable-task', 'form-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 3, NULL);
INSERT INTO act_adm_server_config (id_, name_, description_, server_address_, port_, context_root_, rest_root_, user_name_, password_, endpoint_type_, tenant_id_) VALUES ('423c9c7c-1737-11ea-9a8b-7c7a916bf543', 'Flowable Content app', 'Flowable Content REST config', 'http://localhost', 8080, 'flowable-task', 'content-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 4, NULL);


--
-- Data for Name: act_app_appdef; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_app_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2019-12-05 16:13:26.23082', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '3.8.0', NULL, NULL, '5533606176');
INSERT INTO act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2019-12-05 16:13:26.243529', 2, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '3.8.0', NULL, NULL, '5533606176');


--
-- Data for Name: act_app_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_app_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_app_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_app_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_casedef; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:25.902614', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '3.8.0', NULL, NULL, '5533605684');
INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:25.924595', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '3.8.0', NULL, NULL, '5533605684');
INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:25.937833', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '3.8.0', NULL, NULL, '5533605684');
INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:25.981872', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '3.8.0', NULL, NULL, '5533605684');
INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:25.992563', 5, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '3.8.0', NULL, NULL, '5533605684');
INSERT INTO act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2019-12-05 16:13:26.028054', 6, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '3.8.0', NULL, NULL, '5533605684');


--
-- Data for Name: act_cmmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_cmmn_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_cmmn_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_hi_case_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_hi_mil_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_hi_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_ru_case_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_ru_mil_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_ru_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_cmmn_ru_sentry_part_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_co_content_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_co_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2019-12-05 16:13:25.282473', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '3.8.0', NULL, NULL, '5533605258');
INSERT INTO act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2019-12-05 16:13:25.294326', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '3.8.0', NULL, NULL, '5533605258');


--
-- Data for Name: act_co_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_co_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_de_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_de_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2019-12-05 16:15:14.096606', 1, 'EXECUTED', '8:e70d1d9d3899a734296b2514ccc71501', 'createTable tableName=ACT_DE_MODEL; createIndex indexName=idx_proc_mod_created, tableName=ACT_DE_MODEL; createTable tableName=ACT_DE_MODEL_HISTORY; createIndex indexName=idx_proc_mod_history_proc, tableName=ACT_DE_MODEL_HISTORY; createTable tableN...', '', NULL, '3.6.3', NULL, NULL, '5533713777');
INSERT INTO act_de_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2019-12-05 16:15:14.171131', 2, 'EXECUTED', '8:3a9143bef2e45f2316231cc1369138b6', 'addColumn tableName=ACT_DE_MODEL; addColumn tableName=ACT_DE_MODEL_HISTORY', '', NULL, '3.6.3', NULL, NULL, '5533713777');


--
-- Data for Name: act_de_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_de_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_de_model; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_de_model_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_de_model_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_dmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2019-12-05 16:13:24.421581', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.0', NULL, NULL, '5533604336');
INSERT INTO act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2019-12-05 16:13:24.44368', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '3.8.0', NULL, NULL, '5533604336');
INSERT INTO act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2019-12-05 16:13:24.449704', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '3.8.0', NULL, NULL, '5533604336');
INSERT INTO act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2019-12-05 16:13:24.455137', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.0', NULL, NULL, '5533604336');
INSERT INTO act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2019-12-05 16:13:24.46169', 5, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.0', NULL, NULL, '5533604336');


--
-- Data for Name: act_dmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_dmn_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_dmn_decision_table; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_dmn_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_dmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_dmn_hi_decision_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_fo_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2019-12-05 16:13:24.675007', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.0', NULL, NULL, '5533604623');
INSERT INTO act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2019-12-05 16:13:24.684167', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.0', NULL, NULL, '5533604623');
INSERT INTO act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2019-12-05 16:13:24.689233', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '3.8.0', NULL, NULL, '5533604623');
INSERT INTO act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2019-12-05 16:13:24.696378', 4, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '3.8.0', NULL, NULL, '5533604623');


--
-- Data for Name: act_fo_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_fo_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_fo_form_definition; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_fo_form_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_fo_form_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_fo_form_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('7127433c-1737-11ea-ac1a-7c7a916bf543', 1, 'VacationRequest.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822203f3e0a0a3c646566696e6974696f6e732069643d22646566696e6974696f6e73220a202020202020202020202020207461726765744e616d6573706163653d22687474703a2f2f61637469766974692e6f72672f62706d6e323022200a20202020202020202020202020786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c220a20202020202020202020202020786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20202020202020202020202020786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e223e0a20200a20203c70726f636573732069643d227661636174696f6e5265717565737422206e616d653d225661636174696f6e2072657175657374223e0a20200a202020203c73746172744576656e742069643d2272657175657374222061637469766974693a696e69746961746f723d22656d706c6f7965654e616d65223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d226e756d6265724f664461797322206e616d653d224e756d626572206f6620646179732220747970653d226c6f6e67222076616c75653d2231222072657175697265643d2274727565222f3e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d2273746172744461746522206e616d653d22466972737420646179206f6620686f6c69646179202864642d4d4d2d797979292220646174655061747465726e3d2264642d4d4d2d797979792068683a6d6d2220747970653d2264617465222072657175697265643d227472756522202f3e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d227661636174696f6e4d6f7469766174696f6e22206e616d653d224d6f7469766174696f6e2220747970653d22737472696e6722202f3e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f73746172744576656e743e0a202020203c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d227265717565737422207461726765745265663d2268616e646c655265717565737422202f3e0a202020200a202020203c757365725461736b2069643d2268616e646c655265717565737422206e616d653d2248616e646c65207661636174696f6e207265717565737422203e0a2020202020203c646f63756d656e746174696f6e3e0a2020202020202020247b656d706c6f7965654e616d657d20776f756c64206c696b6520746f2074616b6520247b6e756d6265724f66446179737d20646179287329206f66207661636174696f6e20284d6f7469766174696f6e3a20247b7661636174696f6e4d6f7469766174696f6e7d292e0a2020202020203c2f646f63756d656e746174696f6e3e200a2020202020203c657874656e73696f6e456c656d656e74733e0a2020202020202020203c61637469766974693a666f726d50726f70657274792069643d227661636174696f6e417070726f76656422206e616d653d22446f20796f7520617070726f76652074686973207661636174696f6e2220747970653d22656e756d222072657175697265643d2274727565223e0a202020202020202020203c61637469766974693a76616c75652069643d227472756522206e616d653d22417070726f766522202f3e0a202020202020202020203c61637469766974693a76616c75652069643d2266616c736522206e616d653d2252656a65637422202f3e0a20202020202020203c2f61637469766974693a666f726d50726f70657274793e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d226d616e616765724d6f7469766174696f6e22206e616d653d224d6f7469766174696f6e2220747970653d22737472696e6722202f3e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a2020202020203c706f74656e7469616c4f776e65723e0a20202020202020203c7265736f7572636541737369676e6d656e7445787072657373696f6e3e0a202020202020202020203c666f726d616c45787072657373696f6e3e6d616e6167656d656e743c2f666f726d616c45787072657373696f6e3e0a20202020202020203c2f7265736f7572636541737369676e6d656e7445787072657373696f6e3e0a2020202020203c2f706f74656e7469616c4f776e65723e2020202020202020200a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d2268616e646c655265717565737422207461726765745265663d2272657175657374417070726f7665644465636973696f6e22202f3e0a202020200a202020203c6578636c7573697665476174657761792069643d2272657175657374417070726f7665644465636973696f6e22206e616d653d225265717565737420617070726f7665643f22202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77332220736f757263655265663d2272657175657374417070726f7665644465636973696f6e22207461726765745265663d2273656e64417070726f76616c4d61696c223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b7661636174696f6e417070726f766564203d3d202774727565277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020200a202020203c7461736b2069643d2273656e64417070726f76616c4d61696c22206e616d653d2253656e6420636f6e6669726d6174696f6e20652d6d61696c22202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d2273656e64417070726f76616c4d61696c22207461726765745265663d22746865456e643122202f3e0a202020203c656e644576656e742069643d22746865456e643122202f3e0a202020200a202020203c73657175656e6365466c6f772069643d22666c6f77352220736f757263655265663d2272657175657374417070726f7665644465636973696f6e22207461726765745265663d2261646a7573745661636174696f6e526571756573745461736b223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b7661636174696f6e417070726f766564203d3d202766616c7365277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020200a202020203c757365725461736b2069643d2261646a7573745661636174696f6e526571756573745461736b22206e616d653d2241646a757374207661636174696f6e2072657175657374223e0a2020202020203c646f63756d656e746174696f6e3e0a2020202020202020596f7572206d616e616765722068617320646973617070726f76656420796f7572207661636174696f6e207265717565737420666f7220247b6e756d6265724f66446179737d20646179732e0a2020202020202020526561736f6e3a20247b6d616e616765724d6f7469766174696f6e7d0a2020202020203c2f646f63756d656e746174696f6e3e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d226e756d6265724f664461797322206e616d653d224e756d626572206f662064617973222076616c75653d22247b6e756d6265724f66446179737d2220747970653d226c6f6e67222072657175697265643d2274727565222f3e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d2273746172744461746522206e616d653d22466972737420646179206f6620686f6c69646179202864642d4d4d2d79797929222076616c75653d22247b7374617274446174657d2220646174655061747465726e3d2264642d4d4d2d797979792068683a6d6d2220747970653d2264617465222072657175697265643d227472756522202f3e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d227661636174696f6e4d6f7469766174696f6e22206e616d653d224d6f7469766174696f6e222076616c75653d22247b7661636174696f6e4d6f7469766174696f6e7d2220747970653d22737472696e6722202f3e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d22726573656e645265717565737422206e616d653d22526573656e64207661636174696f6e207265717565737420746f206d616e616765723f2220747970653d22656e756d222072657175697265643d2274727565223e0a202020202020202020203c61637469766974693a76616c75652069643d227472756522206e616d653d2259657322202f3e0a202020202020202020203c61637469766974693a76616c75652069643d2266616c736522206e616d653d224e6f22202f3e0a20202020202020203c2f61637469766974693a666f726d50726f70657274793e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a2020202020203c68756d616e506572666f726d65723e0a20202020202020203c7265736f7572636541737369676e6d656e7445787072657373696f6e3e0a202020202020202020203c666f726d616c45787072657373696f6e3e247b656d706c6f7965654e616d657d3c2f666f726d616c45787072657373696f6e3e0a20202020202020203c2f7265736f7572636541737369676e6d656e7445787072657373696f6e3e0a2020202020203c2f68756d616e506572666f726d65723e20200a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d22666c6f77362220736f757263655265663d2261646a7573745661636174696f6e526571756573745461736b22207461726765745265663d22726573656e64526571756573744465636973696f6e22202f3e0a202020200a202020203c6578636c7573697665476174657761792069643d22726573656e64526571756573744465636973696f6e22206e616d653d22526573656e6420726571756573743f22202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77372220736f757263655265663d22726573656e64526571756573744465636973696f6e22207461726765745265663d2268616e646c6552657175657374223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b726573656e6452657175657374203d3d202774727565277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020200a20202020203c73657175656e6365466c6f772069643d22666c6f77382220736f757263655265663d22726573656e64526571756573744465636973696f6e22207461726765745265663d22746865456e6432223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b726573656e6452657175657374203d3d202766616c7365277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c656e644576656e742069643d22746865456e643222202f3e0a2020202020200a20203c2f70726f636573733e0a20200a3c2f646566696e6974696f6e733e0a', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('7127433d-1737-11ea-ac1a-7c7a916bf543', 1, 'FixSystemFailureProcess.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e732069643d22646566696e6974696f6e7322200a2020786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c220a2020786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e220a20207461726765744e616d6573706163653d224578616d706c6573223e0a20200a20203c70726f636573732069643d2266697853797374656d4661696c75726522206e616d653d224669782073797374656d206661696c757265223e0a20200a202020203c73746172744576656e742069643d22746865537461727422202f3e0a202020200a202020203c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d22746865537461727422207461726765745265663d2273756250726f6365737322202f3e0a202020200a202020203c73756250726f636573732069643d2273756250726f63657373223e0a202020200a2020202020203c73746172744576656e742069643d2273756250726f63657373537461727422202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d2273756250726f63657373537461727422207461726765745265663d2273756250726f63657373466f726b22202f3e0a2020202020200a2020202020203c706172616c6c656c476174657761792069643d2273756250726f63657373466f726b22202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77332220736f757263655265663d2273756250726f63657373466f726b22207461726765745265663d227461736b3122202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d2273756250726f63657373466f726b22207461726765745265663d227461736b3222202f3e0a2020202020200a2020202020203c757365725461736b2069643d227461736b3122206e616d653d22496e766573746967617465206861726477617265222061637469766974693a63616e64696461746547726f7570733d22656e67696e656572696e6722202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77352220736f757263655265663d227461736b3122207461726765745265663d2273756250726f636573734a6f696e22202f3e0a2020202020200a2020202020203c757365725461736b2069643d227461736b3222206e616d653d22496e76657374696761746520736f667477617265222061637469766974693a63616e64696461746547726f7570733d22656e67696e656572696e6722202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77362220736f757263655265663d227461736b3222207461726765745265663d2273756250726f636573734a6f696e22202f3e0a2020202020200a2020202020203c706172616c6c656c476174657761792069643d2273756250726f636573734a6f696e22202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77372220736f757263655265663d2273756250726f636573734a6f696e22207461726765745265663d2273756250726f63657373456e6422202f3e0a2020202020203c656e644576656e742069643d2273756250726f63657373456e6422202f3e0a202020200a202020203c2f73756250726f636573733e0a202020200a202020203c212d2d2054696d6572206f6e2073756270726f63657373202d2d3e0a202020203c626f756e646172794576656e742069643d2274696d657222206174746163686564546f5265663d2273756250726f63657373223e0a2020202020203c74696d65724576656e74446566696e6974696f6e3e0a20202020202020203c74696d654475726174696f6e3e505434483c2f74696d654475726174696f6e3e0a2020202020203c2f74696d65724576656e74446566696e6974696f6e3e0a202020203c2f626f756e646172794576656e743e0a202020203c73657175656e6365466c6f772069643d22666c6f77382220736f757263655265663d2274696d657222207461726765745265663d227461736b416674657254696d657222202f3e0a202020203c757365725461736b2069643d227461736b416674657254696d657222206e616d653d2248616e64206f76657220746f204c6576656c203220737570706f7274222061637469766974693a63616e64696461746547726f7570733d226d616e6167656d656e7422202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77392220736f757263655265663d227461736b416674657254696d657222207461726765745265663d22746865456e643122202f3e0a202020203c656e644576656e742069643d22746865456e643122202f3e0a202020200a202020203c73657175656e6365466c6f772069643d22666c6f7731302220736f757263655265663d2273756250726f6365737322207461726765745265663d227461736b416674657253756250726f6365737322202f3e0a202020203c757365725461736b2069643d227461736b416674657253756250726f6365737322206e616d653d225772697465207265706f7274222061637469766974693a63616e64696461746547726f7570733d22656e67696e656572696e6722202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f7731312220736f757263655265663d227461736b416674657253756250726f6365737322207461726765745265663d22746865456e6422202f3e0a202020203c656e644576656e742069643d22746865456e6422202f3e0a202020200a20203c2f70726f636573733e0a0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('7127433e-1737-11ea-ac1a-7c7a916bf543', 1, 'VacationRequest.png', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x89504e470d0a1a0a0000000d49484452000002e2000001270806000000ec2e26a5000000206348524d00007a26000080840000fa00000080e8000075300000ea6000003a98000017709cba513c0000000467414d410000b18e7cfb5193000000017352474200aece1ce900000006624b474400ff00ff00ffa0bda793000000097048597300000ec400000ec401952b0e1b000020004944415478daed9d097814c5d686cf248184800a8aac9145115051f11715bd20b8b1c84e005944822cb20a5c40454082c822888080806c89102010f6b0095ea3a01715041565b90a414008a0448c2140c8fc75ba6b9299c92c3d33dd3393e47b9fa79ee9a5aabaa7a7e7d4d7a74f551101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a30e1120023309bcd111f7ef8c1a0afbffef6c523478ed6fae1871f23b2b2b27061fc4c6868a8b95ab54a7f54a850f69b73e7fe7cefd75f4f7e86ab02006c1d809d0410e2a090b278f147fd962f4f987ee2446a64af5e2f538306ffa2faf51fa388880857cd998b75b38b6deef6bbfbf4769f5ee58d3a77f5332beb2a1d3c7898f6ecf98e162d5a7bedefbfff39fcfbefe75f14bb0ee14e052010b6ce9d9d73b7cf1bdba8d58ee8656f83619b76dba9dac92356763243d8c90bb09300421c143c162dfa68c398316fb579fdf5913468d0000a0b0b73739b79daf8782bc0f512c17a8b69ff9ec39c392b68ecd80fae5cbb76ad4b66e6b58db86301d0d3d6696956cd1e08723dc5b8de02db28bb6ca410d7b60d7612f893505c02a067c33465cabb6d12135752870ed1141212aaa15132d9e5b15e3739786634697c9e3479f0ace9cf3c81aa5fe5d147efa7962d1b155bb1625b8bccccac1fc5a663b87301f0d5d68538b065ee6c9ec9c97f5bcbb22ff6c19b7af4f6d999743e7f7dcf0f76124088830207bfa21d33e6ade1dc30f1ab59c7e2da5922170d93c95061ea0ff1ebdffaddd757aedcadf4fcf30dc3e3e2363c9f9d7d638bd8741e773000bed83a4fec9d1e02dc93fdfe14d87a9f43e05edac34e0208715060e0ce4ac3870fffb457af978bb17728bfb8b64dc9c95b68f4e8b1346fde7c5abb762d454696a4dab56b7960947df580eb6de48d3ea6fe8d113732e1e1c5323ffbecdbffcbc9c989c75d0c802fb64eab0037e928c083f761bfb0003b0920c44141315643b76cd9d662f9f278198ee24818ab8d506cec78dab973179d3a758abefffe7bba7cf96fdabf7f1ffdf6db297afae9a77410d75a047c303424a6801ffb89271e2a316bd6f26257ae5cfdaf583d8d3b19006f6c9d737ba7eded9fb7025c6f0fb7dee122c16e33b5d5f7c413756127018438086eca96bdfdc3679f7da642e3c68d9c3436ea677272326dd8b081b66eddaa08f16bd7aed15f7ffd4567cf9e1542fc2455ac5891ead4b98f02e3d50e26a1ec3fce9c493bf6cd373f468ac59db89301f0c6d639b677daec8abf43438a967dd3cf4e9e879d048611824b007ce5c89123b578d82e77c4c7c72b5ef0ececec7cfb4e9f3e433d7af4c4c5f4331d3a3c57597c34c69500c05b5be7a9a88508869d04208f305c02e02b3c8185da69c935e7ce9da3df7fff9dca972f4fb56bd7a6b4736914512282cc39666ad9aaa522d4817f79f4d13a15c5c7edb81200786bebcc1e8a6b332e24ec240010e2403f781639c71358581a28f55311e0b56ad38a152be8ce3befcc973b4f887bd25019d5a8158dc63222221c7600009f6d5d7e7ba7cdae186967cc7818809d04050084a600838c7ffecf98981e4a2376cb2db7e42bb5ebd35df4f0c3ffe7a62ebdcf2918ae5330fc460000dffec38e6c8ca3440ed6895ccfb0e9eb365f6c92d987b2c16e3361ff00843828128d525e6ad9b205dd57e75e7afa99a729eb6a964de9912347525cdc12d2e6c531eb242ecd067c77238e89060380e0b675aec4b733314e1e2c0793fd803d0200421c14b8062a3dfd124d9e3c857efae9675abc68314584dbbedebde38e3bc4fe77e9d4a9d31e08eb82e88541230940e1b3759e0a724f44b859c3f1b5d801b39fed851ee7007b0620c401f0b9815aba349ea2a33bd1ddb56a2b6129952a55ca57eabefbeea3aa55abd30b9dbbd1e225712e1a1b4f8dbbd9c373363a4fa0ea0700e86feb5c097277e5f410e4ded8076feaf187c3c0ec87b200041fe87c007436aca6dce58c8c7fa87fff8174e75d77d3ba0d1b292c2c8c2a578ea25ebd7a51ebd6ade9fefbef57f21d3f7e9c8705a311afbd4eddba77a7d16f8ea2397317d0a0817d5d886a6f3d2bbe86b70483a71ea21d80e0b075aed6bd715c68d9e7ce41a155bcfb1a06130c5e77a31e00603f81ff80471c1862e852534f52cb966de8c5ee31f4daeb6f28229c79e081072869fd7a2a5fa922eddbbf9ff67ef33555ac548996af58a98caac2f9de9d3a8df6effb8e5625aef5a0a1d1ea3dd75bf06a291f0c1d330100faffb75c85a438cbefacf3a6b7225c4f5b14acde72d83e507881471ce868f4f23c42cd9bb754bce055aa54cd9793c3533a757ac1656d333ff8805ab56c419d5f684ffa8d2ee0ab17dc5763af97c7dd97630300f411788e3ce0261fed865e1e72ad76cfdbfdded81b7f84a320e40540880334500a3c557d68a8f7b797c583ee7b67263d3b070562d41684a100503004b95ea2d593753d475cf164bf2fe182c1d0b9143613040f084d013a1ab63ce3f6e083f7d3b7df7c93bbbe7cd9324db538cee769c726ad42d91f9ef260eb2c8a31c40340695c82c26beb5c8f8ae2aabcbbce9e5ad6bdb18981f0861b5916b60c40880390afb1a857efffe8c71f7fc8dd9a90b05c53e9fcf99c354466f22d56dc084fb9af02d8acf3b1d088059ac71e7bec45f171e9c9279fec81ab515805b9b3186f2d43176a11e4e4a320d77b4416b30fe5bde9cbe38dfd0e564f3c0010e2c02f8d120921fe307db7ff3b9debd622ce3d6d2cf410f09e362c7a187678bf839d060d1a74397cf870fcd0a143e9e0c1834b1e79e491185c15bf518df2422f2b1869ebb4896f775e7377dbbd15e4be0c91e86b784ba066f984f806050bc48803434479d9b2b7d2cf3fff44cf376faa6c399f9696bbec0aeb7cc78fff4abe755ef2b51393b762dd1bb1ecad904663118c3cf0c003d1df7ffffdb2152b5684b46cd9929a366d1ad2b56bd745b56bd7be76e4c89115fe7e261069b2486345da2352b6dcde4ca471227514e97421fb094e88545da45491668b5456a47622a5eb2fcaed31f9f810adc52e9903b4ec8de0d663f859d83f00210e800706516d884e9ffe9f411e0c2d8d92b722dd13816c84a03632261d1e72bfa8de060dbafcf0c30fcb2d225c51bccd9ad1ead5ab43dbb76fffb110e3e44731be50a47a7299c363ea883447ae6f16e90e91ce15f29f841f34768b5457a414fdc5b7c9477168f6c1ce044290fbda5fc793efe88dbd46580a28582034051820c4cd3e244775d86f73b4ee2e44c557a3afe78c9efe183211a3ad04028e0567119e9090902bc22d3cfbecb38a183f73e6ccc7515151edfc744abd456a25d241917a5a89702683f2876dd416a9b148a5acb6f17294d5feba76652ac83c1152f45b774e8db02b6bbdafae3c5694d5b66ab28c75f9c676656244aae1e81948a40e76e76e5def39fd6d9daff6ce971095407bc57d15d7beda2223271c826d04fe23683ce266b33962e7ce9d3db66edddaf5d8b163750f1f3e1c79e1c285b08c8c0c0a0f0f37972d5bf67ae5ca95cfdc7efbed5fddb87163c2f6eddb8fe2e70b66316ec1e443592d5e20bd3d3b7ac599eb2dba8da81be82dc239163c313131843de08ee0edebd6ad0b6ddbb66d62646464c7cccccc8d069fd64529421db1c74e189f9082bdb42cf3b814af2c6ec7c9fc2c8439cc638348fd65b995221de2670d29eeb96c7391f689545fa4a55665f961e08848db480d91d94baad77eb048db655d8922cdb47a908826d5933d42a45e321f87da7491dbb91d5b2345fbd732bf3d2cf67f090e5ba7a7903462dc71bd847a41f386834204ffdfdb8ad448da1d8bb3204bda34b6735f8ab48a82202c2fe0429c05f8db6fbffdd1d34f3fdde5d4a953618d1b37a69e3d7b529d3a75282a2a8a4a952a45428c9b2e5ebc58fcd0a143d53ffdf4d3ea9b376fee5ab366cddffefcf3cf77c4f645b8e7824984fbfa9a568f46c8a846c4e80e9d6603ae995e75035708bbd5edbbefbe7329c22db0677cc3860dc5dab469b35a88f1f6428c6f31f0d458ac6e96a2b89414ca16b8414ab55a7f88f262a82f911a431e27d72b4881dc5d0aedc322cd9502dcd2f03d241bba79527cdf2ff771feb1b22c4911cde7d14a8a717e18594f6a4cf702918693eab9e77d1c4e335db655e3e4c3011f931d31a3a510e7f3ac27cb674b41ded9ee3aa4c8733c4d7931f24162ebdc95f7547c1684f015a3874834fba90c0832587c0f0c090979322727a7b883fd11d21e559379a749dbb058a4e5813ae9800af1a4a4a49745a3f4615a5a5af8e4c993156f51de442e79b018e754ad5a35e2d7bd3366cc306ddfbebdeae8d1a3e78bfcc3cf9d3bd74a5f6f07d0bf31311964508d6874f49abdd3ac9368f75450235edc9fd4ac59b3edfefdfbe33926dc9d08b716e31b376e2c2eec190bd0d6a47a798d609748f748e17c580a5916a3bba5a0b516e22ca2d9fb5ddb413d2cda93e572aaf428d5b312e21b6579cb723fabb2a9768d5c0729ae2d82789f14faec3d4f126986f4629d930de676b9af9414f95cae34e579f35b906d27d42c07e7bf587ee747c8b010152df64eeb7fced7be328116e4beee37d21bee8df8869d0c72aa994ca6f966b35919e94188708ffc2832bd42ea1b3bbf6bc980087171b1c2a64e9dfac9a041839e1a3e7c38f1f05e8e04b82bb8c1132974ce9c39b5c78e1dfb8328ff2abce3c122c04d3e1832ad5e21231b1d4f1b063d66f634622650342246c39e7029c243ed63c2b588f1e4e4e462ad5ab55a9f9595d5d14ae8ea0d0bcf0df293bdc81c52f21ca9e11c15ac04ef4e9112a48768a05579471e64575e655f3cce1952b4b711e92aa9af8ed3659d2cb0fb5809ed6c0fdab1c9f28124437f016ed2e13fa757874d7f392bfc25c8f572de407c17623a8786867e78e3c68d32b9c256e849b6afd1d1d154bf7e7daa50a102952d5b96d2d3d3e9dcb9733c9c2cad5dbb96ed2f09db6b29c67d4c0e48fbe857efb8df85388bf0b8b8b8afe6cd9bf7c8faf5eb958be40b42ccf32805259a376ffe41993265c22f5dba3417f765a084b8496703a6d7082ade34227ac71dfa4bacc30bee2f78b29eefbefb2ede7a74144fe1c642d8c18876eddaad31408c4790ad77f80fcaebc89825536d29c479e221f62ac75aedb7705ad6154679a11f3cfaca41ab3cd61d24d953becfc579f17764cfd57cabfc1ccbbe57aeaf1569993c5673b96daf3ccf7a0e1ac9afa5d02e2d457b8c836396259f43521cd93abdff4fbe087223eda1bf04b99ee2ddc891544090d0d264322d17223cd422c0d9b13b70e0402582c29ed2a54b2b8947aeeadcb9b322caa74f9f4e3367cea4ecec6c8b1d5b266d9cdf1cbb7e1f35853de1e3c78f7fe4b3cf3ef359845ba85bb72efdf7bfff2d217e8429b241010113e3ae470530996e765846ddeea89c2fd341f3f16e93f5dfe6209fb7a3ae78ba4d6be363b6ba4e777b29ee3d693cd0c0f822c279b21e8e09f756845be0b77b9b376f8e10b087baa58ea7c9e11d3f4a91ca1d2987901a836da131e57988596c779079574ad1da86f2c23fb8815a2f853a7bce53ec84782f599613c7780f76715eef4a21cfc799203f875989ff1429a8391db12ad75dd6bf5996d929b72f970f11fc5d39fca69683631ea2fca3bd1860ebd4ffd4f1e3a9d4a851732a5efc36c5b639b37b9e8fa0927f9bc95486b48f28a5659ff3e5c4c48d54b56a3d71cc4ab9db4da6ca3e3a37bccb6b32d5f44248437c17223a0b11bec16c362b229cc5f581030768dab4690e45b823d853cef9b91cf74bb462a13fb5a45f3de21c13cee128ec09d77aa1b4c2f57df2c927a59e78e289d957ae5cd96767c0815f44b88de4d6e889f1555cfadb03a4d77087b6f92223efa3cccc43b9dbcce6ff91be61306858f44276cc8cd7d231532bec1967312e44fdeaab57afb6277d62c6d98bccfd67eacbc4611dd6f18fec254e95cb7194e721e7f86df650c750de508217a5b86e20ebdd6577ac59b26e1e56f021ca1b8980c57a17bbbcecd9be5f3e74b0c07f8ef2c7653ee5e0fbb0d8ae2ebf4b16e5c5a7f3320f07594f8af75fe40387e51c22c8f1908606d83a757fcb961d69fcf837e9b3cf92292424c4cd7fd0db500b3deda1363bd8bdfb604a4f3f22ec5589dced66f319d27f86cffcdb2223eb081bf9a3958d3ce6a1c30382bc10514d86a32822bc418306fc6651093ff10616e1bb77efa68e1d3bd2ae5db9a68dfba3f8454bfa4d88f3e828a2019bc731e17a79c2f3b97fead6a549932685bff6da6b4baf5fbffe38eed56012e6da1a964d9bb6d1c489ef8927d41fa87cf9db69ca9458ead6ad63aee7272525995e7e7910a5a59da7d9b3dfa59e3dbbd9d43962c45bb468d1328a8aaa44e3c68d74dae064655da53e7d86893fef56aa59f32edab225812a562c6793a761c3363477ee647ae0817b72b77dfdf501718cb769e4c87ee23c3f10e779489ee728719e6d955c972ea58be557c51f7a0f5dbf9e2deefd54f9dd7689327344999f4499b2a2cc6b225f1bf1bdee92dfaf8614e0aa47dcbaa1b970e14feadc7918eddfff133dfcf07db46ad574bafdf65ba547ea5e715de2c575192daecb1fe2babc29ae4b3b37d71e0d8c3738ea98c9af372b56ac982fef8913276c1c0e1c9f58a64c997cf94e9d3aa58c102563c64bb468d162edb56bd7a27512e3a932ed9262da1a8e85dc26c53a8be35576fb63e5676dbbba9cb147266bd2292fe4c41a16cf492eeabae8647bb6836358d867f7bdad1bd4c54ecec34bdbe63a342535f5a410078f09116e72b89fe352fbf41922eccf66714fd510f667b5b8872ac8ff7e693b3b37d5c6ce8d1831d6cac6bdeed4c6a976a89fb0439f0b3b745dd8930bca9e0b172e0a5bd257d892ef852d7950d89205c296e4bd3134992a88e3af17c71f2a8e7f411c7fa2387e67b15dbdc74b96bc4b8a6ff91862aa2cd64fcbe52851760d0d19328e0e1d3a4ad9d927c4b62ae27b7e4483078fa3bffeba4ccb97cfa47befbd9bdab6ed4bfffc9349b3668da3d6ad9f51caab3672ae958d1c296d648d7c76913de26673de28c6aa8dfcb79d8d2c23f3b28d8c13df698c9d8d84202f88984ca645969870f684fb22c22d70c8ca9a356b44bbdf50dcbbca333e3fbcb367bca1d1dfc76fa129efbcf3cee23ffef8a338c7741bc9d0a1434b942b578ebd260851f1bbf0d63a6985a372ea7262e25a5aba742e5dbb769e56ac584403078eb03184b3672fa02fbed842df7df739bdf1c6db36e5274e7c9f6ebbad8c103cc769efde1d74f2e469a7c78a8d9d4a0f3d743f65649ca0be7d5fa437df9c98cfe88e1af52abdfbee1c9b6dd3a7cf57447862e226719eef8bf33c21ce738e38cfd1b9a5478f9e46cf3fffb4686c8f4911ae9298982cca4c15658e8932b3449971f221f5179b4f478c1933939a34f997f86edf2a9fe3c6cdb1d93f7bf672715d3e16d725495c97191e886e34305a614ff8d9b36793ec3b66f2ebcdb8b838c5905b080d0d158dfecb36e5fbf4e9c37322e4ae57ae5c59894f64116e418ea61259ac583116a97a86a93812b61ca36d192bdc15e7dc88e61d14dca356f14808eff9d3de6dd8b04208cd6eb475eb270ecbc6c64e91f6e78cb03f31c2fed8dab2d9b33f12ffe7add2ce8dcfdd3771e27461e36e15762055d8b84f848dfbcdc939b11d9a28ecd033c20e9dce15e1bc6fcc98c9c286341675fc223e1b095b32359f2d983d7b9138fe0671fc9de2f81349f540ff2eedd41927f6435d9e3f7f196ddebc4411e116860f7f8776ee5c4efbf6250b913e5e3c4c4ca4a4a40f69c78e8f29266684031b7954d8c819c246c6ca63fe4f7e1e73fa7be4d9c86f9cd8c8046923d758d94888ef02485bb3d9ac3cb9714c388b675f45b8b5185fb972a5f5e0210dfca125fd22c4d91bfe9ffffca7130f5118111161f8f1962c59524634640371bf6a660ca9636afaf08644bbe0668f4f5e2a23631c55121216d2bdf7d622d5235d5ff1a058d71b17f7a1103015a866cd3be9fcf90b3675c7c7af1486bb97b2a554a94861ec0738f516c5c72752f7ee1d95e5be7dbb8b27ea6df91e0a584cb3c7fbd429b5e16161ffc30f87a975eb26e23c672b5e1da661c347c479fe9d5b6ed5aa4d3460c08bf95e492724ccb42a53cfaa0cb910ceeaf29a35dbc47753bd628307bf281aa964bbeb32495c97f2e2ba5415d7e54f2ae2612a3adccfb6f0643ddf7df7ddc7ce4647e9d1a307dd7df7ddb9eb376edca0fdfbf7f378e1cafa9e3d7b8410d94957af5e55d68b172fae341eafbefa6abebad8d3cea3a90856e92cc61da1a50323bf9a1de9623ff7cdd9035b974793264f0911be9ade7a6b9210e45de9d2a54b36e5e2e35708fbf382b2dcb76f0f617f926dfe9b717173a59dbbcbc6cee5d938b3b07125858d1be4d4c6ad5ab55ed8a197a51d325bd9924da28e9ecafae0c1bd852d5997af7c5cdc2c79fceae2f817353cc4e72d2f5b3693eeb8a392cd7616e6b56bdfa5d4979a7a9a264d1a99bb7ee9d25fb979131266081b5943da7f8b5dd516bab366cd76f1bdbadad948b2b391e5c431abd9d9482366fd0406fe07075a395eed63bb7d86eb1b316284f5a6578cbe207e094de119334f9c3811a6573ca53b9a346952bc448912d5af5fbf5e8d5cbf4a052a13e46726a9231a5866c2f362a82ff746cb6cfe33df3693490db33879f29468bc262b0d5366e6957c75b2c07676bce3c74fd2cd3797222d3195e7ce9da772e5eeb5f1603aca3768504f9a3d7b094d9d3a86e6ce8d13eb31f23c4f8bf39c2ece737bbef3bc7c39c3615ca85a668628b34394c9d270bdf2f65dba74597e7733454646581dd3fabae8392c62a1b89fd3e5fd9ce0fdfdac6dc64c4688747af8e187c5ef7f59de0797e995575e51e217bb74e92244c55fb9796fb9e5165ab46891d3615bd986f1d05a42f4af12768c3b516e8799d2f5de6085b789f23a7aea6eebf8eddc9e3ddb68c992e54274bf221eae56d9d99fbbedec8fb59d2be95020aa36ee264dffe7cb97ff76101aa386ac58eab7b525ee8faf45b8aaf7b4ed76555ce7e5b73824ecedd3c99367a48dfcc4ca466abbf6793692e3c9c3f37daf52a54ae8da8e019fff83ff903aacaa27ffc12893c9f494d96c56eeb32143861872825c2f8fa422873664afb8a15ad22f429ca7ad7736598f51346ddaf4dc9a356bb8017b0ff7bd66d88a759229438a9878524731c8f2cc7099bc38bc995ab478816262bad0bc79ef291d82f2463b71efb18888085706f2571b1fd7c7a952a5321d3dfa952853dca597a777efae74cf3d8d68f8f0be4a38cad1a39f2b7b5ab4e821ceb3a338cf89f23cabe496e1d86d1e0a292c2cd4eebbbd2cca448b326fcb3277696c00cc54a6cccd949191a93426fca97696d22ee48b6803c3b1222fca7451decf89daee671521a2bb6811e14c8d1a3514033e6bd62c1b31fedc73cfd11f7ffc919befd65b6fa5175e7881ead5abe7d6a120c4f88d162d5aac14f75377326e9cf1a208abd96e32f113d27aedf786f6e9edd9260d18d08b860e7dd3667b952a51c2967cabecd7e699b5b671371c3ce8e72fcb71dfaa1db215c665ca94e6d9aa15b19d91f18f4dc74bcfec8459c343bf279d45d9aef6b2b291114e468f72bcecd846ea394422d0999276ff417e305ee1e63fd8d6324a0adb63ebb03e3de170437ef39994941b9167a896f44b68cab163c7ea3ef3cc337efd85a3a3a3b9116e847bdd6bd8b5ccd34473cc067b16d9abe8c1eb2457b1e2ce63c853537f535eeb7283939cbc43d9c61d96b418fd6edd3a504282fac7397b368d060d7ac3415e75b95fbf1e1417b7cac1f9da2e172f1e462fbd142d1eecba299f6ac349caebd5264d9e94e7b94b9ee705791e6d69dab405f9ce3535f58c28d35096f95496b9a8ec2f59b28438e7f34e1b82ce9d5bd0dcb909caf2ac591f0b21d7dc830603a3a9903a42488cbc9ff9875aeaee7e7ee08107a2bffffefb650909099a474779ebadb7e8e69bf386aa638f8aa883ae5cb96225ce2268c284099aea1362bcc4860d1b8a8586867203d51266c9106eb1ba37fe94ce0717f786d9037b67a6952b93947870eb6dfdfaf514f627815cbfbdcb1f02a3dab835caf6b367cf59d938ca979ff34e9b36279fd8ecdcb9adb0254ba52d59286c496b17c2d47b51ad2dbf6d1ed5ae36501c24c9c99fd9d855e736d2f2bdd846ae90df6b99f85ecddcd8436fc73f0706fd07bb5bfd079dd9e746561acf680de9f0b80556881f3e7c38924734f127f5ead563ef6e5ddcdfbac0eab3abf41afd293fd9ca45686988b40b71332d58f03e356edc9aca96bd5b089843346c587f21881a92fb3171cd3465ca1825feb154a96ad4a0414bf144fb9cd34660d4a8c174ead4efca98b861615136e3e2da1bdf01037ad09123bf289f79e739599c6727719e0f8af3fc599c672f719ecaecba141b3b9476effe56d45b43d45bddaacc3ba24c5751a69e28734494e929cab450f6ae5efd01d5aad5c469433161c2abf4c9275f52e9d28f524aca373469d250c250863e3d64c6c8fbf82ca96352dbdccfec093f71e244a2a73366b2f7913bfb5877dce4d7a816787495b973e7daec77478b162d4a6ed9b2c50431ee17d88dfa92bc37f835c69afcb6cebdbde337799c22222a527cfc2a4a4a5a6ab37fd4a8214adf93aa551f14f74cb9dcf90edc09f32953c64a1b5755dca32d9cd838356f6cec086187be16f55712f597cfcd3361c2ebc296a4887bb0a6b0255f095bf2a61bd1ad55b46a992fc1757ed546761336f25161230f4b1bd94adac859c24636755a56b5917bc4f77accca467a2ab23d99700818f81fb4d867f654adb2fa0fd6b5d278869e849d6635544b9afc71554b952a653e7bf62c7ffaed97fcf9e79fe9befbeee38e4813715fbb659c0f658f8b74675eaf7c3d6e2bbdc6d53572164e3dc72177b7dfa84985d803f53b55afae68bbf1b89f157ea95cb9f29abffffefb75f6847b3b590f879e706f7e6b11ce71c08d1b37b61ea7d623b66ddbf6a7389fe23939391b29b8472929acf7c6af22dda5afadf354f41939f3a6b73632903376fa6712a1426a270be27f3087a403f9c2850bba8d96e208bbe166b3e4038221f825685b8d472be5d75f7af5ead596ef370ef7bda1dce97da3a24723e5e92b527f371c7ae4f5769bfbfc71719bf5308e85891a67ce9c19c5bdf17d993173ead4a98a10b76941727268ecd8b15ed7d9bc79f35befbdf7decb870e1dea869f2920dc65bcadf3d521618420f7c65e068b207777ddb479c861278386dc280e23453863f7d6d2d0e1fefc22c44b962c691662dce44f31debe7d2bf4b41b0000200049444154fb8be3c78fe72b098fb83e4fa83932d9df33c75531eecaf8997c686cb4e60f446363fc6c72facee8993f7f4c4c2b1a3f5e89672f8a1e71b3839bf3f81d77dcb16ec99225ff6edab4a9d733678e1a354ae950c7c3185a608f380fe1daa89177e1865bb66c49fbf9e79fb983130717c3231e94b6ce9dbdf345bc9b75d8eecfb786c124c8bd890bcf2326a66561b493c1fc1fbc2e3f8b39f86f2a62fce2c58b867bc4adc832f282f845888b8b75fddcb973c57954017f111111f1a7bc78b1b8ef7dfa6364cbfb244426be3b774931b05d5e63b37f1b9e400872b301f9fd199ae2f8fb56ab963b23646c11b99f73acbc2a2647f733cf74f9c8238f7c1b1d1dbd92474bf1d433ce6386efd8b1c346842b7fa4ec6c3a70e08032b678dbb66d3d16e1ad5bb72e919393c3d3c563f414fdef8d6cab36d18dad33ebec5cf0b4bc1e2325e925c8dde73399ee24b3f9d7bcc714d35d7693970563988abd9dac5418ed64b0fd07af4bfb1c6e25c0edff833f8aa408499ed1d84821cef55b71b1c00bf18a152bfe76f0e0c11afe14e2bb76ede27ffe0ddcf31e9323ff10e156f74886fc1324ca3f45bafe8d8fdea2dcd3c6c73f5e9cc8c8fb2933f347f24f688a37db0a25d6ca2944cbfdfcedb7dfaeae59b3e6b5ae5dbb26ad5ebd3a54ab679cc576b76edde8cf3fffb4121ea6dc58f1f3e7cf13cf2eccb1e25a3b6c6edcb831ad7dfbf62cc2bb4184eb6eebae91fadad9d2166ab075fefcefe8d55fc6482785eb7dd622dcf5f1fd15a6a277a80bf0812bf27f58d24a7cbbfa0f1eb408f17dfbf6e93e998f3542b392dd710bb6102f57aedce79f7efa698d0e1d3af8edd75db16205ff7b3ec77dee31215284f39f81c702dc221b7fddc6d6f5bd61739ed764aa4829296b69c890b174e8d051218c7ea3acacabd4a7cf4865f64c9e9173cb968fc5c361b9dcba468c98408b16ada432656ea131635ea5debd5f138dc76fcad8e066f349abbaab5a4d596f96f5bea14c3ec133c46dd9b258d47bbbb277ddba1de21cdea6b3672f289e519ea2d932262e7fe64dd51c4c9d380b2d26cfef6765d8d50d428c77e8d4a95392d6d153de7efbeddc31c4191eaab056ad5a5c57ee1086fcc9b1e2b367cf765bdf575f7d75363a3a3a0222dc305b17a18fadf3d4de79fbdff3ee2da13b1be8ac2eb681ebd77f4483078f5366395ebe7c9632394fdbb67de99f7f3269d6ac71d4baf5b34ade4d9b76d1c48973e8c0819fa87cf9b23465caebe2a1b4b5f480ff4ac113bee24d39887183286125beb5fc0759d3294272eddab514131363d88971fd76c72dd842fccc993393c5d345cfececec103f4dea93f5dffffeb736594d850a34c14f9e299437894fbab1de1c633c42f3e77f4c9b37c7e74eb31c1b3b9d1e7ae83e5ab66c96d8b78cde7c730a2d5d3a5dd93771e26c6506bcf4f49f94c92de6cf5faed948c7c6ce94f5be2fca25887aa7897aa72afb626246d28f3f6ea5aa552be79661f16d32d594223c909d38713f6b85c578545454c7ce9d3b27ae5ab5aa982b31fecb2fbfd0071f7c603383e64d37dda48c92c24361093ba86c636f3977e4ecd1a387cb21b86438ca2d10e105c1d6e9fdff32fb98c7769f2b1be84e9c0e1ffe0eeddc99a04c94d6b469777af0c17b2829699eb25ebf7e3b713fabcec2c4c4cd8afde3593377effe865ab5eaa30871770f090543908320f90ff24c9c3358bb6edfbe9d4e9f3e6dc8a43e1c96b279f366eb37a949467b040c67fffefdbf4644449ce00be70f3efcf0c3b5a2f1fa9d30bdbd567828071e4c9f0386dbc99bddc386c96c5072779cfc0675d9b20f7245386f8b8f5f4dddbbab83f3f7eddb55f10a59888f5f430307aae383f34c732346f4d5ec658a8f5f2bea6da72cf7eddb59f18c5bceab52a5f2b46a55b2658a5c0afee10e713f3b4318fbf5fffcf3cff32fbcf0c2359e76de193d7bf6a4ccccccdc750e3de131c3398e312121c166e428f69a737e0e657121c22de1281b60a28a82adf3c4ee9935da45b35b1b685b9ef2d5b179f362aa5dfb4ee5ad1f4fb83369d2c8dcf54b97fecacd9f9030534e5d6fa6860d1f110fa47f53308403fa665f21c883ec3f785a8a76c576f22cc646c0f55ebd7ad522c2f718ad25fd36e77c5a5adaa8d75e7b6d45b366cdc20cf68aa70f1932e45ef1f93eee77cdbca39f07c79fe3ea3acea34e2d6fb67ababd40e5ca3d98bbcea35758f61f3ffe1bdd7c7329af1a0cb5de7a76f5cac7f60df3a857af513473661c2d5d3a999a357bd20b4f8c5e229c8a9208d7e97ecec72e21b2db74e9d265fdca952b23ec3de3cb972f57e62eb87efd7aee36f68277ecd85159e691529a366d2a04d07a6518430e4fe15ef973e6cc211e2ad11ac48417355be78de0f36c0415573690c34ff2d5a284e4a9fb55714d0ed66d3979f234bdf5d60cc521919999e5e6bc8261c4154f271d0241f21f9c2b92120f3573e64ce5cda29eb1e2870e1da269d3a6597bc317187d41fc26c4fffaebaf3511111163c585bb7fc48811861da74d9b366bc593522d526763027ec71c807a5d1bd42a552ad3d1a39fcbe9e96d8d2c6fcbc9b9a10c35e7aa21c8c8c8cc67c4ab54a924eadde5b05ef6187df965226ddd9a423d7b8ea2b367bfa4c078c21ded47e3e225db333232da09712df4f4fa084b074e7e8dd9bd7bf77c99172e5c68b3be68d1229bb8437ead3a6cd830e2be3396d7abec099722fc05523b2c812267eb3c398636419e67038b3b11ddf6653d0fe768d1a217c5c444d3bc796f5364640921f06b68385f6f3cd246887084f21520d8839e225263f68ab3b363f7eeddba8ca0c2ce914e9d3add1058bc6a7bfca125c3fc79f5d2d2d25a4f9c38f1e7060d1a94a85fbfbeeef5efdcb9739380e70c7f8af286a302016f94f41eeacb5de363bbbf5fbf17292e6eb5f269bfbf5bb7b69490b05e08a9f6422c9f573a1b59f27078c9b16327e8a69b2269e0c071f98ed3af5f57516f92f2e9cce057a952d166bd64c912ca71d44e9d7abf4e8547c71f623c2b2bab55bb76ed36af59b346f18c57a850c166064d6770a88aab7c569e7088f0022dc08d1a47dc7b87842b1ba84df0bab7b31cb6d2a44903c531919cfc1fd9e65ff083d0d65384c3595140e829d2b722953d72e408097bacbc6df4458cb308efd0a183f9f0e1c31611ce1d48fbf8434b86f9f9e2a58a46ac4fdbb66d3fdabb776f64b56ad574abf8e79f7ffeb259b36675c5e248918ee03e0d44e364d2b9e1d1673cdd51a306d2e8d153a96ad5fa74e64c9a1cc5447df5ca3dfb7bf4184efdfb8f517afacf9dfbb6481f2be5b66d5b4a9d3b0f563a712e5c3859fcd177d818ea51a3fa897aa78b7a9fb4aaf77fca3eee94a90af14a4a688aa5ccead533a956ad6674f9f23e9d45b837fb8197ec6231deb163c7cdab57af2ed6aa55ab505f2b64111e1d1d5d5c86a3408417585b67a4d0f6de36bab281daea76fff0bf60c13bd4b8b13ae9ebf0e12fd3b0613de981075a6a14f5de8a705f3b6bc246165052451a2cd232d6b13c7743c3860d954ef0de84a970380a7bc2ad4438d3df5f5ad214882b58ac58b1974b972e3d6bd3a64da5f4f08cb3279c45b868c4e689d529b847fddf3299cda7fdd0f879b3df73cf8fc9545d7ca1e33e361646341ec6887093a95ec06c4101e7d9e2c58b6f4c4a4a0af7458cdb75cc444c7891b7757a0a733d4759326a6e067fdb51ef4438ec6450122312c7002a4e65ee7fc87d6e860f1faebca97407871572c74c8e09170fa7d6bfed287f6ac9b0405cb9ebd7af2fb970e14266a3468d16c4c6c6868e1c39b2a4971d38d3a3a3a337ac5bb7ae99bc7071b82f03d63e79f9cc177cd33d87871737a8b1d0434ceb2bc2814fecba76ed5a74870e1dd66ed8b021bc79f3e61e8b7184a314465b6784bdd35a877176d17b01ee2fdbe9ab20878d2c80b0e6e39ec1ec842dcd31e3efbdf79ed28993fbf0087da80c11cba29cc35638fc84c5374fd6236c2f6ddab42927333333c4ea0fcbe12883fdad25c30278015789466cefd8b163178b2792fb162f5e7c738b162d4a682c9b357ffefc0dafbefa6a0d21eab94708c784231ca5c0375ede94d37fc6cdacacc341e6bd81080f62b6b3186fd3a64d92a058ebd6ad8b6b2d888e99b077be950ff4ac9b5af29875c8eb6f1b0b0a18dc99722fa99e7165341516e43cd4acabe16625d6437873c7cc3e81d0926101be80a9376edc78262d2dad8368c8fa972851e2fe279f7cf242d7ae5d4b3dfcf0c3c5a3a2a22af0d8bb7ffffd77dad9b367ff4a4949f9dff2e5cb43bffaeaab5aa21c0f33c0c3d8f00c2ce89859e01b1e234579f04cf7ecffb16fd1c0f8438c5fbf7ebd6d870e1d3608314e5ac4b85d380a44386c9d81a23cd082dc08bb6a948d05059454919e2375d6cd57446aec81be6501be38905a322c482e629210d649191919515bb76eed20d2bfc4360ec8e2570e3c05f12d225d97ff984f490da24fc5bd57501a2723461130ebb4cf5f825caf5efe10e141ca2e16e3d1d1d1eb8518bfdea64d9b92ce32f2b4f59831b3300b71930e7518e190f0447c7b6a0783cd9901115e444992294a8a728b96ac20b5246bca8b22f174b09fcbbc01d79261417611b917cc4c99409169b87c2dab7f788a7f04792026ab00468af1ececec8eeddbb75fbb71e3c6cb2d5bb6bcd93e831c1d25023366c2dee9578737c2dc9f31e3817466c03e16510a94960cc1ef05f46b7c8261aa672257533d3b9f1ada593e57759117fb20c20b39db85c86ed3b66d5bd3860d1b2e5befb0c484dfb871e3258870d83adfed9e96a9ee3db181668ddbb4d84f2deb5af23a5bf6251fec2380100745a27132aa81f344987bd3f0686d743c6d44fc25ced1c80401bb84d86edfa14307d3faf5eb2f59443886282ccc42dc6851efcd7968dde7eb366feca92f62dd17410efb08828f305c02605c63e5effafc317457410957014122c6d7df7befbd977ffef9e792428477810887bdf3afedd3c3066ab57d7ada476f6d29ec23801007688882e458fe1c4125d804390816312ec4f7c643870eb1173c01221cb6ce7fc736aac3a61182dc08d16dbd0edb0820c441916a9c4c3ad6a5477e5fbde4c1da09098d4c01e117bb4f005ba7a3c00fd49b422304b93f6c2b0010e2a0c8345281aa5b0f515e5086e542230340e1b475de1ecbace3be6018714acfbc00408803344a7e3ea6af0d4f4199f407043196f1c433702960eb82c729e189a8d6c316fa5374c3360208710002d0e819d959299826fd412353c0282b3f2fe25200e3c47e510d5181080710e20004c00006eb082ade0a70ade21c8d0c0045cbd6797b5c23fbcd18652f7d11e4b08d00421ca07172b2dde46379a31a1d3d1b18bd1a10343400146c216ed2a91e7f38258c10df10e00040888302d46819518f3f1b9d408ca8020028fcf64e6fdbe78d0df4c4367a630fb5d83a887000210e40001b20a31a1d5fc4b79102dc7a1d8d0c00b075460af3609ce407021c408803a043e360d2b12ebdca04e2152c5eb716323a88545aa4451e9489909f59b87cb075c6897bbd479032c26642800300210e02d05005a26e7f4ef0e34d8383309402000be8dd22d52375329ebd225513e99c48ff9282bc8edcd7ce85d0ae203fcfe192c2d6f9e738fe12e5818a190700421c001bc2c38b9bb3b2b24c1111e141d81006c3043fc12bc0af5cb97a527c54c65d9c8fb6226d11e93929c059781f9482bba5cc932a52b448bd459a834b065b179c0f010565929fe015e0b09300421c043577de19757eefdeefcb376efc68001b1b234479e17fddfac927ff3d243e2ee02ecec72aabe58376fb92ac964f535ef80980ad0b80ddd3c3fe79e298307a5bf079c06127819184e012005f295bb6f49e3d7bf64b03aa7772d630b8cbebe97e7291dfd53677eb6637eb8165f1e28d97c5470aee62afe19093545c06d83ae3ed1e7950464b9d5aec9d3b3b483e6c0b4e9b083b09fc0d3ce2c0674e9cf87dea820589addf78a377b1b0b05027b94c5e7868b4122c13fc68c913540d4dea962d5f3e283e3fc05d9c8f5891c6913a35fd4507e29b4354d8533e0c970ab64e9bbd33e2ff1f88f014adb6cf173b1a54c04e024309c52500be72f972c69952a522db142b1656a97efd070d38829ed33d07628480e06c685ab51ab6e6e8d193fc303e197771fec657a48d22ad14e928a953d5cf15e973917e12a99948cb443ae4a69e185263cce3099e73d83a43ed9ed672c138824af0023b098c06a12940177efffdc28bb1b17333f7ee3d48817f4deb6abfb3f2eeb67b13b212bcaf5a5352bedb989cbcbb15c1a3eb4a88a7c8d488d49151e2649a2fd278b9dd1d51f2f3342e296c9df1e1297a84e8e9651f89dc87f00537b093c01fc0230ef4e2e2d5abd7bed9bc39a54dc386ff17111555c1cb6acc069683b7c7d2b83cf34cbffbcd66f300b1ba07b7ae5b868ab499d430150b95481d5925de4dd97f933ae2ca0c91d2712961ebf4b3799e96d7b3b3a627db0be6f083b09300421c14448efff3cf957dcb966d6e1b1616f6cfe38f3f5022242450135e183d6497fdf602d1d8a4f26bd6d1a3e73e2d1b9764dcb29ae0b1ea668bf4b748b78ad498d4f8f12f44daa941c4b3109f05210e5be71f916ed45c0b855f7cc34e824060c2250006503b343474568912e10f75edfafce9f6ed9fadd8a8d1c315f41f7bd7c88e4aeaf66fbffd895e7ffd039a346920d5afff40816b7078fc5b1e7a8b7bfd7387a39c9c9cdf497dcd7a08b7a947bc28d24091eacaf5e5220d26f733669e203546bc3a21461cb62e2002dd8898f1c225be612701843828acb068e1094f1a933a4321c65bf63fd9a48eee9122d25a52678804fe03421cb60ec04e02e0140c5f088ce420e59f0ca520c18de915abf512e4de030a0a273c9b665391be17699148f5e5f6bd1aee21c27d035b0700008ec0a8290038a7bedd7a635c9222c93452872e63afe7bfe4368efbeea1a1aca527df395c4600000010e20068a79fdd7a2f5c92227b1f3c22d262caf36cf327c20f00000040880360104decd61b8b540a97a5c8c1336b5ac6034f939f6d489de807000000f01ac48803e0189e39b18cd57a0ea9b32bf2f6245c9e22c5489176933a290f77ea6a241fc89ec3a501000000210e80feb4b45bb78c30d40642bcc8c1bff711915e91027c3fa9336c66e0d200000080100740ffffc5cb4e8438cfa6c8b1c11805a3e8f08648db491d37dc1bfb9a8d4b080000c011881107203f3c5a4a0907db5950b147b4192e5191e2165267d0fc8cd437255a3b6962c4140000002ec114f700e467aa48755c3cb8b2377c232e5391e15352a7b8bf41aa57fc6d52fb0bfc44aec3536e25758afb3f499de21e00000070282c00002a1c4ee0ae131e87a794c6a52a52f0c3579c48ad488d19e77015bc19010000e0b3e80000e4d198544fa633ae4a11de40a4645cae2201ffdecf92da59937ff7149186e1f707000000210e80bebce0667f31f9d90342acc87096d45153d68ad45fa45f7049000000408803a03f9dddecb784733d2bff3f1811a3f0539dbceb7069e9d4891176000000408803e00616d75a67cee470850e22adc2652b124c2335269cef8f5d228dd520ce316a0a00000097a0b3260079d4f3307f6d5cb222010f5d584da4b9224d24d5d3cddbe0c8000000e013684800c8638a4cd6c48a344ea4f1721914bd87b38b2275b4dab648a4a5a47ac8d14f00000080d7c0230e0000ce61ef77ba83eda7491d4b1c0000008010070000033844ea90852f4a51ce6f11ebcbf53db83c0000007c01a1290000e01cf6867358ca0c9196c96ddcf9b20fb91fc6109d3501000040880300800fa488f4904851d266b2b0d6322421862f040000e01284a6000080737888ca357299e3c25321ac0100004088030080f1f098e175282fcc04000000d00d84a6000080735880f3f085bb49ed9cc9def034b96f26391e510500000080100700001df8547ede42ea8caa55e57ab60611cfa0b32600000008710000f09023e4fd444e96ce9a5771190100004088030080e7f06829bd49f5847328ca46524752010000007c029d350100c039d5443a2052232b51be5ea4c9b8340000007c051e710000700ecfa0b95da4ee56dbca4a713e9dd48e9c0000008057c0230e0000ce497720b6799d67d574e7c808979f18771c0000008438000078489248f5456a4caa279ca92bd221723f1a0a464d010000e01284a600008073fa4921fe99837d3ceb267bbbbb88b417970a00000084380000e847ac4ca565b2b69d5172f9082e1300000008710000300e9ec0e7b4d5fa2fb82400000020c40100c018d80bbe50a4b6d25e66881427d24842274c00000010e2000060183c5e783552e3c0f791da0173a014e7dddd944567cd22c2e0c1033a9c3c79aaff6fbffdf6f09123476fc9cac2335a81114161a174f7ddd5febef3ceca3f56aa547efec2856b96e1aa0008710000080e380e9cc70b4f92eba9221d14e9b086b29629eea1ca0a292d5bb67cfcf4e9df566dda947c47efdebd4cc3860da1faf51fa38888088d35985dacebb1acf73623ebd6e3b89e7f0f7e683a78f0c84d7bf67cf7447cfcc627eebfffee4977dd55b5fb860dbb5270870308710000082c3c9dfd6322adb2b39b880f2fe2b46fdfa6f79e3d5f2d1835ea8d9041830650589875736ad228be4d76db4c76cb967d261779cc2e8ee56ebfab7cded4ed4d3de4637edf8e1f11112e1e9e1e54d28811313467ce8aa80913e67f1a1ddd64c4dab59fccc09d0e20c401002070b0379be3c3b9a3e63f72db33a47ac67bcbed71b84c454f841f38f0fdfc8d1bd787b007dcbdf8262722dd9de8762628dd094e57fbf512d8bea0777dfa316850576adcf89190162d06bcf7fcf30dae6dddba672eee78602498d00700009cc3310629a44ee65355a407a5f8e690956e22f5c0252a72d4fefcf33d1fae58b13cd4b108376948f679ed45bac989707727ec3ddd6f32f0329902fc33797ffc3a756ad0962d1f867cfdf5a119a54b977c10b73c301278c40100c0398b64f20674d62c84dc7967f53583070f2ae65c84db6e4b4e4ea6f8f88f293d3d9d6ad4a8413d7abc4479653df570eb158ae24b59a38ee14ba88bfee7ce623c367640b119333e4e4c4fffa736ee7c6014f08803008067f090865a46564067cdc247ddab57afd5e49870c722dc36bdf9e66821e6c6d3fefdfb69dfbe7df4c30f3f886d6fd29123471d942717dbc88b7c7a78c2f5cea777593d70fe1b0c1ad4858a150bab4eeaecba0018023ce20000e09cce227187ad0a76db9371698a1e5151957abdf24adfe2b61d331d0972a275ebd6d192254b282d2d2d77cf575f7d45a1a1a1d4af5f7f4a49f98cf277dc34ded30b3ca377eff6c5df7fffe397cf9ebdb817570318013ce20000e09cd7451a2fd25322cd11a921a99d33dfc5a5297a98cda6a60d1afccb81f8cebf3e69d2241b116ee1c68d1bb47bf7ee007d03137e440f69d0e0ff282727e7395c096014f0880300807322a4f0e64f9ec8678fb49b43e432284208615ddd36bedb7e041493755e8a8c8ca4f2e5cb2b9fd9d7b329b264a4b2fcd75f7f05ea51023fa287d4ad5b8b2e5c48af822b0120c40100c0fff0e43d75489d55b386482f8ad488d45154b4dad76c5cc6c24176767698e3c97aac45b8ba7cfdfa75251ebc77efde14116e5ba669b3a6e47a321f4f853304b6614fe211e1ec1147f40080100700800030ca4a480f166936a9def1ee1aca62d49442497ed1ed480c376bd68c7efdf5d77ca5bfddf72d952c59d20fe2dbac8370f7c7838039087e4f3cd880c081a73c0000704eaa48a7e53287a23c24d23da47ac8dd018f78a116e3ae96cd1417b784ae645ea1a79e7a8ab2aee60d9cd3a74f1f7af6d9675cd4e1badec00b62a38e61d6795b308a7e009c3714000000544a89d4412ea7cbc44aea9c14e535e47a2a2e555117e3f93de319197fd38c99b3684bf256aa71570dfa68c14736a1297bf7eea5fa8f3faec4890f1ad49fa2a2a2dc086e5fc5b71e9e7123857d613d3e00da80471c00006ce1f8ef1e3271a7cc71224d1669a9dcc79d366370998ab20077bc9c9292422d5bb6a6fffbbf4768c7ce5d74e6f73374db6db7d9943e9f765e99d8a7f153cfd00b2f74a3a54b3f96f5b8f37a7be3412737225fab80351b780d0bca6f0d8031c0230e0000b6a4923a5ca13306e312418cdbc786efdaf51f5ab86809ad5eb3964a962aa56c7b67e2241a307000b56edd9a6ade5d5311e6cb962da3051f2da4aad5aad1d6ed3b68cc9b6f52565626f5efff0ab90f79d122b8bd1192de886fbdc346f410bf085b01050f78c40100c0960a3ad48159358b841857c5db9e3d5fd2ecd91f8a3437578433751f7a88121357d3edb797a383df1fa462e1e194b4769d22c2199e1868cad4a9f4cdb7dfd11a21e0bd17e1de78c3cd5e7ee740085db31fea0300421c0000828179225593829ca7b6ae2db787c9ed1691bdde8568c788294540805bd6df7863342d5cb4d846845b2879d34dd42e3a9a86fe7b3875eaf4029512ebf6cc9cf501cd9d3bcf61ddfa0a7277a2542fc1ebe9b18df2ae0310fc20340500006c9925d2ff48f5661f9276f29014e1a5a430bf28d21108eda22ec85542c3c21c8a70cd0d71589807e2d85b41ae578cb9b7751a25a6cd7ed8060084380000f88b14918ad96dfb91d4b8f18b528c9785088700773665fcf265cbe8c5eeee879acf9fcfdd243f7a8b706f04b95ec29874ce57543b9482820e42530000c03df74b11ce6490daa113f1df455e889b1d0ab68484e59a6a729ecfece238de84af7893d75d395fbde1661df2e925d821ba0184380000040b1c033ed46e1b7bc1df90db23708920c69d89707dea250da25babb0f6765844234752211ff2f95b409bfd5e10142d109a020000b67007cd07ed84f97f498d09676ff867223524d7336696969fe9b89c8551849b6cd68ffffa2b3ddfbc69ee96f3696936ebceb0cec7756817b35a04b9d983f2be0872bdbde1a453dda4d3368f7956a4c572f9944863448a97ebdd447a4fa48a4e6ea660bee1cf8a3442a404d80008710000300a8efd9e20c5f76c91fe90a29c474149247566cd06a47ac7df81102fca62dc82894e9dfa9f4ef5792a28bd0951f13686dcd778736faead3fead15d90b308ef23d20e919e9076c222c41788745701bde9eb8af42b84388438000018c945d958468b348c54ef16cfb4f29c95a86e21d22fb854455d849bf4106d1a05a0de9d38bd15e17a0860bd63ccfd2eb4dd515ea45d72993de23dacf6951429cd6afdaa83136b4ceac84d75a44663a7c04291da89744cda9fb3327f7b99973deca15637a5ab3296632c91e7ca13942db53a07f6d8f7964e87f156dbd3e4f90308710000309424525f215f203514a5a34807adf6d721ccae091c8a39938fe53d1590460c73e8ebb23fc4b511425b37c13e538a592d5c73b0ad9f48ada4886762453a205277b96f92483de5be38523b929fb4abc3551992f6eb4929ac775b09f1d1a4be05e4377aa564ef2cb4200000181549444154d9824894486d456a44aa27bf82fc3edcc1fe9cb4e75f8ab44a3e70041474d60400005bd8583717e91ed9c8edb1dac70dd402c2d085455c809bddecd392dc9577754c7723a7044a84fbcbdb6da460f7d95bce616b7fc9e5a5520032ec7d3e6a97f7aa83f2ddad4438c31ef56572f92352bddc167e17a933e5ef40eeaa0c1323d21952bde5e5eccacd95cb190e1e28f8fc6f0fe23f278bef9d2121211c42c3a1851d44aa61f51bf075aa26f34d93d799fbfcbc18c89386471c00001ce3486c7378ca4c0f6c6b362e636116e4ce307959ce17b16ad418e4de2cfb22d2f514d7010b5fe1908e5852bdd23c03ef73d29ef4b7cbe7c8236e6f33d89b7bde6afd869df0e498741ecd893ddedb3594b1886c47dc29d26517df6ba6ac37d83a985633994cf3cd66b3d2f3392727c793b28d657a455e43bf871d4288030080fe44c9cfd3b814855d809b741071660ff6f932028a3f05b99e639a07d21bee93209f43795e6516c79f8b34df8d10b7e737916a91e3790b7824a77f89f43ca9def78a1acab882f373a4843325fb2ad97ad08381cea1a1a11fdeb871a34caeb00d0ba3679f7d96a2a3a3a97efdfa54a142052a5bb62ca5a7a7d3b973e7e8e0c183b476ed5a4a4e4ea6acacdc4bd4403e38f1c3d2727f7e010871000000c023d16cd24ba8192c1a0329c8bdf96e7a0af280896fee24f9a65ce6be26fbe5729a14c7d654d7501f0bf7183b01ef48ac7b5ac61109f29c9749513fda6e3f87eb5d08a23f634b93c9b45c88f0508b001f3a74280d1c3890aa55ab962f73e9d2a59554bb766deadcb9b322caa74f9f4e3367cea4ec6ce5454429f9dd39846591bfbe0462c4010000008fc5b227b1dfaecb67675fa73a751ea36bd7ae3ac9635bd6642a9dbb663295a1821143eeb9603799ee0ab020f70aee5362e9dccd232ff5f0f0c9c49ec922dd416a87cc6c273fe616b2ed8ce9aa8c2b38be9d3ba767c8ef911cc47fc2ce42846f309bcd8a0867717de0c0019a366d9a4311ee08f694737e2e57a74e1dfb8729bfc58d87c2a002e092c632f12bc5145c0ea011eea9df5636c81b71390a0db1b1b16f38d8ec5bc8ecfcf98be93ffff9822222c2e9d1471f76abd5c68f7f579cc8ebf2845e7791d7bd173c32b20a8d1e3d2c40223c6f3932f21e711e036db6c5c6beeab178d757909be5f5561ccbe335fe9cdf8bf4be48a3a418fec36adf485263baffb1fc94f63fad933aff436a7cf6db7679c6cbc4fb7ef1a08cb363729cc64a524759f940d669d9cf9d4dfbcb7d81a65a6868e8a69c9c9c485e69d0a001edd8b143b300b7a75cb972d4b56b57dabf7f3f1d3f7edcb2b909a9f1fd1721c40180100710e2403f78a6c35ba5c8c8f1b06cac2a7cf5ebabc61dcb5e7cb12f6ddab48a860c7983060fee4326936dfd23468ca54e9d7ad2f2e5abe9f6dbcbd29a351b7305b8c974ab587e4d2edf26b75b3cca65e53e33ad5b974c4d9a74a4d75e1b4fe3c6b1901f29f697535ec98f1f3f4d597724dc1b366c43f5ea3d48e5cb97cdddfaf5d7df51972e03a86cd95be9a5975ea58103dfa48f3e4a50f23cf0c03d74e9d25f141ddd977af61c4e6fbd355dd43d4c29b769d32722ffbf45feb122ff0a99bfb6388feaf23c6689bc43f21e6f4c35a41837d3850b7f52ebd6af886b348176eefc929e7fbe11952c1921f3d5a2a79e7a8c9e79264688f91954b1e2edf4d043f7e826c83d14e2161c4df8c51eea75224d2f80ff1bfebff08ff163a04f44fc3f92c4ffe65e5e664f388b708e01f785888808717fb5a62d5bb6d0f9f34a3fd7e2d28e2f35fafb20461c0000f4c7325c56062e45d031417ef2e8109b488d8bdde3d96fe5ce3bab7dd494952b9384a87c8eead4a94dad5a35a365cb12a9478f2eb9fb274e7c8f6ebbad0ca5a7a75246c63f347ffe5227e76076b93d266630fdf8e31754b56a54de1e739a1035e5954f676275d4a857e9dd77e75042c2dcdc7dd3a7cfa79123fb5362e2465abaf47dbaf7de9ab47bf7d7e2fc63a85bb776420cbf2bbed353949cbc8442424272cb2526268bfcef89fc3544fe6f45fe5e227f1b71fce3e23cee149fbf3abd4e63c6cc100f12ffa24f3f8d17e7f391789898451f7e189bbb7ff6ec65f4c517cbe89f7fae88878717c543403b37d73e2093ff2450c19d99b262909c475bb3d9fc8c2260c3c2c443e91a9f45b8058e1f5fb972a578887bc81233ce1d383944c5d0ce9b8811070000fdb1b40c7fe052042d37cb46769b48a9a47abe9a51fe31991d08332d6112da62c8274f7e9f860d1ba02c0f1bd65f88cc9936f9e3e357d1c081bdd5a7bb52913462c4400d62317f1c78a54a1568d5aaf5949575953c89137ffef9a7e9c0814374ead4efcafac993a7e9871f0e53ebd6cf09713e4711e1aae7fc51faebafbf95e555ab36d18001dd6d44b8a242136629229c69d8f01199dfddc38ababc66cd36711dd4b0ddc1835fa4152b926df6c7c54da1ca95cb53cd9ad5e8fcf93f3c10d27e9f79b3a8c36fa4f86da1b78ee0dc3f0077ccb48bedf619ae6fc48811d69b5e31fa82c0230e0000c631ce6a99c71176369c9865c63767709ca22b8f2d0f938831cbbde7365247998891d7996757e590a264e7d7d577b1b669d3367aecb187a597da2c3eef1002f5715ab76e33b56fdf52c973fc782add7c7329d21effed78fb860df1d4abd7509a3973012d5d3a8b9a357b9ab48eaa3268504f9a3d7b314d9d3a86e6ce8d13eb31caf693274f29a127ebd76fa7cccc2bb9f92f5fcec827c2d5fca745fef745fe1d227f968607813c38dc851f4498c8c812f27879794b952aa149d03bbf5610e47ec2f2468ae3e43790ea6dd6fa462aca64323d65369b156ff89021430c3941ae97475291431bb257bc9a7c5887100700800242b613311e089c3d003813ffae1e0a78fb550fcbb87bc8f075bfde94b212e5fc00b44ba478caed23e2ebd4f679bcfdf634dabfff202d59621badf0edb70772853877e0ccc9b961256cdd896f7599c358acb7d5ae5d83befc3299b66edd453d7b0ea1b3677fd024c279b977efae74cf3d8d68f8f0be9498b8898e1efd42d9dea2450f8a89e944f3e64d12e238824ca62acaf6db6fbf5579b51f16166a534f8b162f8bfc1d44fe098a98e67014ad9ef932656e11df295311dcfcc9e5b53f20f93aca0a308092a40e95c8896722e530b115f27fe6cc61d1d6324a4ab366cd282a2aca9013e3d1545ab66c49494949964d3c43e77b10e20000507058e4c0c6f2a803cec21e787b0517f595a5bcb8734744b9b0e7aeeaad5d08aeb53ba1ce0f45de4eacc4d7bdb34c0a29297ba871e3061ac49f6b3efffc4b255c64dfbe3ff2d5f5fcf39d69d7ae147af6d946d4ad5b074a4848a2eedd3b09f19c461327beef543c737dc78efd4a37dd548a060e7cdda1c8ac52a5b2cd7ac992914abd152b96772a488b172f462fbd144d4d9b76139f1dc4c34171657b6aea696ad2a4a1b29e9cfca9b22d2deda238e7b6346dda021a356a804d5d6afe06cac34572f27f72f373a7cd92254b88f3382fcea39cc3f3e8dcb905cd9dbb9c5e7fbd0fcd9a154f2fbcd0dc47410d411e44dc22527799f8554722397e23d5c8b2c093f51809d76f25c41b4188030040c18285e13b41722e159c3c003813ffae1e0a9cd515eea28cbb870c3df65773730d6ae875316363a70a31fe2f9feb79ebadc9f4fefbef90e3e1095fa77fff7bac22c4a74c194b3d7a0ca2fefd4708c17abb10a353455a9c2b1643434373ebd8b66d9510ac7d156ff8c2851c32b235379fc9a45e4216e24b97cecc2db37af54754ab5603ba7cf9984b413a60400f9a3c798e38c6b2dc3d0b164c160f259d94e5e1c3fbd0b061bde981079ad0afbf7e419d3a0da4b163a7d38d1b37c86c3e21f34f14f9bbc8fcbd44fe9745fee78518ff5a9cc76c711ecf89f338e8f07a4d983044d439449cc3027ae491fb69d52afb0712b306c1edebac9fc00ff0ab8e1899d853be5da438523de5752d99ead5ab67e849d4ad5bd766d5c86399f09b03e0badd2535b460bc5c06000417ee843a3b9cacdf617fe6cbc1366d5a4ead5a3535a009357b9c8763ae9f7cb2b5f8dcafb13eb30feb9ec5a4076e59dfbca9a967a87a75254c683cfe6abae04ba81e0f37aac4685db87041b7d1521c919e9e4e65ca94b1ac66c907044380471c00004041861bc95437797ef1b63d2635469c83b8d93377254f846b15cfc608f38888282a5ebc38cd9b375543192304b81ef98c58d6376f5cdc663d0424d087dc8e12468a70868732b47bd8370c08710000004519565ed6aeed0c29ba13a5084ff744206bf3929bbd3c4daba78fac5356dbbd1d13bbb00a72fdc47b4c4c2b1a3f7e012fc223ae0f5a1e68aecbcf6276db733de2172f5e34dc236ef7b00f210e000000188089f2862cdc426a07b12cedba5d0f91ed4979b387fb8c14e4c128ce3d8915772fdeab55cb9dc726167f154385f87529b4c3ad04b8fd1b299ed553e9ef71eedc39438538d76f85a1d3dc4388030000288a70239f42794313a6eb2796f5424f51eeab20d7cf5b1e19598732330f91b1a129ee45b66fd717e8c01529be4b5a896f576fa40e5a84f8be7dfb749fccc79a83076d3a0d1f841007000000f4612ca931e5ec01f7e295b32b7166d2b12edf84b7c954895252d6d2902163e9d0a1a3949dfd9b32ab669f3e239409786ad6bc93b66cf93877b8c0112326d0a2452b95f1bac78c79957af77e8dcce6df481d71a5aa583e997b1c93a99a584f55d678d2933e7dde10757e22eaac2eea5c2ceb245ab76ebb38fedb74f6ec05397aca2fa26c0d797e35c4faffc8786fb95ea21e1840092bf1ade58dd4e7a48ee94d6bd7aea5989818c34e8cebb73b2e8438000000a003060e2b69f6635dee45f9fcf91fd3e6cdf174c71d95946db1b1efd1430fd5a165cb3e50f6bdf9e6645abaf47d9a387136dd765b194a4fff4919fa70fefce51a04aaba1e1b3b53d4799fa8f37d512e41d4f99ea8f35d655f4ccc48faf1c76d54b56aa5bc52427c9b4c771700116e36e037055678f3468a67e29cc1da75fbf6ed74faf4694326f5e1b094cd9b375bc7a02519792142702f000000009e08647f2477c775bf6fd9b259428457ccdd161fbf86ba776fafacf7eddb4df18c5bb60f1cd84359e669e4478ce8eb56805b888f5f2bea6ca72cf7eddb4599bede42a54ae569d5aacd8a27debde8353b5886082f84f01b299eb8876fcc76525c6b0d0b3b2d45bb3273ebac59b30c3941aef7ead5ab1611be870c9cde9e81471c000000f04888332603ebf6255fdebeb0b0309b6de7ce5da072e5f2e626b14c0674fcf86f74f3cd25c9b33870759b5a673dbb3ad57d1b36cca35ebd46d1cc9971b474e9146ad6ec49f2dd0bee4a28438417007c7d233557a4677961e6cc99d4a3470f5d63c50f1d3a44d3a64db3f6862f30fa82408803000000868966a38fa13d6e9c67d53c7a34459962de3a0fafe7e4e450484808b9f380676464da6caf52a592a87397559d791eeddab5efa22fbf4ca4ad5b53a867cf37e8ecd92f7d14e19e8a7388f042087bd053446acc5ef18e1d3bd2eeddbb75194185872cecd4a9d30d81e56992bde1ab8cfe42084d010000003c12c79e8494785387d6f014b38b7df9cbf5ebf722c5c5adc997af5bb7b69490b05e593f7bf63c0d1af4968d20e5109363c74e887d69f4d24bffb6abb3aba873ad8bf361b15ed1e66c4a962ca11cc73e9ff7e2594f110e0a003d490e2978e4c8116ad7ae9d32aeb8af22bc43870ee6c3870f5b44387720ed2352b6d15f061e71000000c023211ec871c4b5e4732c4c478d1a40a3474fa3aa551fa73367d2e44826a93465caebd4a3c770eadf7f0c952f5f96e6ce7d5ba48f734b6edbb6943a771eac74e45cb870924d1cf8a851fd449dd3459d4f5ad5f93f651f77ca548578255aba7472ee79ac5e3d8b6ad56a4a972fef77f17dcc41b00c82945491068bb48c75ec9e3d7ba861c386b466cd1aafc254381c853de156229ce9cf3adf1f5fc684df130097c4923a01c178c2840e001479156e369f0e80f0f7368fd9eb6d265375f1658f7b502e306392fb43849b4cf5a097829318911692742a739f88a14387d2f0e1c3a942850a6e0bf3e828dc319363c2c503a4f5ef3b4aa429fefa12f08803000000ba0ae34079cccd3a6c57b7858717f740b81b2dc8fd2dce4101218ed431c7e789549a63c6df7bef3da51367b366cd283a3a9aead5aba788728e21e7f01316df3c59cfc68d1b69d3a64d3999999921567f580e47192cebf51b10e200000080dfc5baafe5bd1d675c9b473c2beb30691935c5fbfd7a0a6d5f8437047801873b53ee25d533ae8ca6c2823c393959496eb0ee27c91d333926fc88bfbf008438000000e037916dd4f1cc5e94376bc8eb6b1e6f3de47a7ac121c20b39a9223d47eaac9baf88d4d8037dcb027cb1483c8b5576204e1e421c000000d04d189b74a8c397b29e86ae6815f08112e410e140334932454951fe2f9138c09f03c623480d63e1e1550e923a6d7d12193c590f84380000001054425def3abc11e6be84ad7893c7ecc77dde4c04040a19dca37aa64c410f8438000000e057a16de471f5ebb0a9af00f74458fb2ab43d290300843800000050c085b849e7fa7c2dab47884a41f1907b9b0f000871000000a0100b747fd46bec082afe17e07a0b72087000210e0000004070fbe5d84675d8d44390eb15ce022f388010070000008ab010371954af9ee5fc15331eec9d38018010070000000aa9280f86e30463ccb82f13fd782bba21c001843800000000f11db07308f4b0867a0a706f05390010e2000000003054ecfb22ccfd1da2e28b0077551704388010070000002092037e5c6f42548c16e446ae4384030871000000a0880b71934ef5e829d0f512e5c128c821c0018438000000000c1386464f77af87f886000700421c000000289062db88e317c4497ebc590700421c00000028a242dc6450bd7a97351bb8dd08416ebf0d021c4088030000004037016dc4310a7acc380438801007000000801da1a1a1d7b3b2b28a45448417a007806098e4a7e00af0acac6b1412129223c01f001842082e01000000e09ef0f0e2dfefddfbbd9f44b6bba4b58cab3c5af619b5cd591e33059317fce0c1a3e2772ff613ee7e00210e0000000490cccc2bdbb76fdf9da64d28fb92bc11e87a89724f043991fe823cb8f8e493bd17af5cb9ba03773f80100700000002cbda79f356856567677b29a6f516e8bee47327bcc9c3ed5a44bafd362d0f1f8165ce9cd5d7f977c7ad0f20c401000080c072f0f2e58c6f274dfae894fbac9e78babd15edde1cd7682fb9966dc12dbe2d4c9ab4f8b78b17d37f168b7b71eb03087100000020f00c9b30615e893d7bf6a707263c85c8b710156f44b9bbed9e86ad043f3ffcf04be6b8711f459acde6a1b8e5819184e21200e092c6327d2e520a2e0700459e8b3939e6032b576e6ddea851bdecaa552b46fa3e96b8d90f65f59ce0c793ed056ff8c1efbf3f76e9f1c7632e5fbb76bd8f58dd835b1e40880300210e00081e8e6767dff8313e7e53c78b172fed6bd2e489aa212126030e6336a89c59e77d8567f6cb1123667ed5b3e7f8d2d7af67f715abc9b8d581d1987009007049ac48e3441a2f970100c0426d91668487177fa075ebc63f75ebd6e2f6a64d9fa81d11111e61ec61fd3bc14f6aeaef1417b79962625a51b56a950a95f8cecaba9af5c517077e5eb972c71f89899f54bf72e56aaad83c4ca443b8bd0184380010e20080e0a7ae48d1a4be3dab2752042e49818187c03948ea1b4f1e1d051d33815fc1cc9a000000806f1c94a9b0124b7048006008183505000000000000087100000000000020c40100000000000010e200000000000040880300000000000020c4010000000000801007000000000000408803000000000000210e000000000000801007000000000000421c000000000000087100000000000000843800000000000010e200000000000000087100000000000020c40100000000000010e200000000000040880300000000000020c4010000000000801007000000000000421c00000000000000210e000000000000843800000000000000421c000000000000087100000000000000843800000000000010e200000000000000087100000000000020c4010000000000801007000000000000408803000000000000210e000000000000801007000000000000421c00000000000000210e000000000000843800000000000000421c000000000000087100000000000020c4010000000000007e200c9700004d8cc3250000c0fe010020c4014063040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0ff03e5e49926fa8fae150000000049454e44ae426082', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('7127433f-1737-11ea-ac1a-7c7a916bf543', 1, 'Helpdesk.png', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x89504e470d0a1a0a0000000d49484452000001fb0000010408060000002f4f9d1e000000206348524d00007a26000080840000fa00000080e8000075300000ea6000003a98000017709cba513c0000000467414d410000b18e7cfb5193000000017352474200aece1ce900000006624b474400ff00ff00ffa0bda793000000097048597300000ec400000ec401952b0e1b000020004944415478daed9d07781455d7c7cf26014213d1d05103365e7a5510104293127a28d2114191bc802f200aa2a0225511e90a0a128af4121005247e80740582101121428050449010422099ef9ebbb3c926d9be339b4df6ff7b9ef3ececcc9d3b776766e77fcfbd77ce250200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002fc6805300aca1284ae0dcb99f871f3870a8574cccefcf1e3f1e1d9894948413e3a5f8fbfb2bc1c1a5ff2e5932e8607cfc8de97ffef9d72e9c150000c41e5865d1a22f5e8f8858f6c9b973b105060c78851a34a84f75eb3e4f8181818e54136c7cb7b7ecca762df675343f2df3d0367fae881d3d1a437bf6fc420b17ae4dbe7dfbcea94b97aef6129b4ee08e0600620f4006162efc62c3bbefbed77ef4e851141efe060504043870bb2876d67983c86b21ae7a0bba76e5993d7b398d1bf7f9dde4e4e49713139337e2ce06c077f1c7290099857ef2e429edbffd7605858575263f3f7f55e4edd50b0d16d239b2eccaf6cceb1cadb33a9aafdef5698347caf8dc73552834b4519ee5cbbf6b939898142d569dc61d0e00c41ef838dc742f3cfa112cf4dc649f5580ed993322efa8506b217e5aa4376898bfdea497a778f147a875eb86f9162fded0fac183942d62d555dce90040ec818fc283f1468c18b173c08057f2b0476f5d988d1619b985c68e1d47f3e6cda7b56bd751810205a842850a5644dc1dcf5b0b4fda5bbc7cbd5b0c2cc3829f2f5f9ec45dbb0ed54c4d4d5d82bb1d00883df05184200cdfb2e5bb3611114bd4a67b4b1ebdf1fbf8f11368fbf61d74e1c2053a76ec18fdfbefbf74e4c8113a7ffe02356912e284276f705278bdd783f6aebcb2f2c20bd5f3cf9c1991e7eedd7bfbc4d738dcf10040ec810f1214546c6eb3664d4b366edcc88208a77f464646d2860d1b68ebd6ad52ec939393e9d6ad5b74f9f26521f6e7a954a95254b972652f115e8c3f35e7e2c5aba70f1e8c2e2016b7e36c00e05bf8e11400262626e6597ebdce9e982e59b2447af30f1e3cc892222e2e8efaf6ede761c1f55641f7be728585352f233e1ae36e07c0f708c029000c07cc310ecab38622052c3e3e9e2e5dba44254a94907df457e2af5060fe405252150a6d1b2a2b0359f7d313c54bcfa8f795ebb9e72a97121fc570b70300b1073e0a0764c91a3047c9e4a12a46917fb6022d5fbe9cca972f9f251fa3d86787d0290eaef35d0203f3e13f0f808f82667c604724153323ead7afafac1414295224cb5e3b76eea05ab56adac8c791753949bc152fcd0b000020f6c06191cf2acaa1a16da852e58ad4a469134aba97314efea851a368f1e2afece4a5b7e0b9732c25875e2b000080d8038d04ffe6cd7f68d2a4c9f4db6f2769d1c24514982f63b3ff638f3d26b64f91a3f49da940e82fca5aa4577290f0a222000080d803a7055fa1afbf5e4c9d3b77a5a79fad209bf04b972e9d65af4a952ad1134f94a36edd7bd2a2af169363b1f15dd9ee6c85213bbd792d2a0e106f00807b60b00eb0202a86b4e58484041a3c389cca3ff934addbb0514e8a53a64c591a306000b56bd78eaa54a922d39d3d7b965fdfa3916f8da69ebd7bd3d831efd0ec390b287cc86b1e107d47f7d55ba8b3c3034745000000cf1eb82c200ac5c6fe45a1a11da857ef7ef4d6e8b7d366bfab5ab52aad59bf9e4a942e45878f1ca1fd070f5029e1e9472c5f2147eb73ba2953a7d191c3bfd0ca6fd73820c6ee88be56dd005a36f5eb9d3f0000c0b3076e897cfaab76ad5a854a6ffef1c79fc892929bf2bb76ed6633b7cf3eff9cda86b6a1eedd3a3928e28e4e59eb8a57aff53a6ff3ce5139000040ec810ba251b97225f2f777fd1631b504d8167647055dcfc17dd9e1fd7bb27200d107c0d741333ec8240ae9c250ad5a153a74f060daf788a54b1dca256b3ac5ea315cf7f45ded12d04288f51a74971d6f1e000020f6c0a745bf76ed9a141d7d3c6dedb265110eed6d399de2a4776f4fd41d6d217067c09f5622ae85e78e8a000000620f34f5ec8da250bb762dfae5c82f3a8857663177c44b77d7bb7746383dd9848ffe7a0080fea0cf1e581590a0a047e8e4c9dfa875ab97e49aab57aea42ddbc23cddd9b37fda107c67bd746b42af97a7efe8887b2dc2feea355810a20f0080d8039bc260a0b8b83f34c8cf1d81553448a395a7af75d85ff4e5030020f6205bc4dea08340280eae57b261d9ddc17d8ac6e9f4aa1c000020f6de20338a12b87dfbf6be5bb76eed71faf4e9eaa74e9d2a70eddab5008ee0962f5f3e252828e87e9932652e162b56ece79494940fb76ddbf63b2e9f27bc7bca540170d78374d5b3f7a4d07bc388fe9c100a38c753565807618d84551756525821613cc353bcb0a3c2f60a5b292c0ea70b40ecdd14f90f3ef8e08b264d9abc7ce1c28580c68d1b53fffefda972e5ca54b66c592a54a810876c355cbf7e3def891327caeddcb9b3dce6cd9b7b3cf3cc33e76fdcb8f19158bf1097516ba137682c1a8e0891a322afa5e8db2bab56a2af65643d57f681e86782057e889f9fdf8ba9a9a9792d6ce7199e8255e3b4d38445095b242c02a70f40ec9d64cd9a35af346bd66cee952b57f24d9a34895ab66c9929108b11167cb6e0e0600a0d0da5193366188467ffc4d8b163e78bf423e2e3e3db8a64677039f5f4eeed79f98a8bf92a6e7cd763d9d996003d2b07eee4034fdf02c1068361be7030e4e85121f4ceecdb58359eeca13f9e370062ef98371f3075ead41fc2c3c343468c1841c3870fb728f2b6e08a8130ffd9b3675718376edc71b1ff5078f95a8bbcc14dc1509c58ef0d9ebed6fdf8ae8835e9900f1074f7f7f79f9b92925234ede1279e39c2d9a0ce9d3b53ddba75a964c99214141444376fde24e140d0d1a34769eddab514191949494949a6dd1a08fb55d86078f900626f47e8172f5efcf3bc79f3eaac5fbf5efec9dc415418a8418306f95bb56af579d1a245f3fdf3cf3f737059dd117b3d06e8b9235cd9d9bc9f1da2af678b81cf122a3cfa0821f4fe2691670763c89021b2b530330f3ffcb0b40a152a50f7eedda5f07ff2c927f4d9679fd183070f3809f7eb7398486eee8783017204fe9e3e60810205764c9f3ebdfeae5dbb64bfbc16708d3c2c2c2ccfa2458b5e4c4c4cbc20561dc7a5759af1e3c7bf632789bd817aae46a3d352f4b5aa0078ea7d7d4f5498d2d74d98305f7ef892472f847e957032e4b38e057ce7ce9dd4ab572f29e88ec05d882d5ab4a04e9d3ad1eeddbbe9ead5aba64ded84fd89e70dc8097834821ef7d1cf98312364c58a15166bd4eec0f9fdf0c30f85f2e7cf3f8bffd3b8b4ae7adf19a3e8d9de6e2bbd33db2dad77e6bbb56557a3f4e9358a1f5ebd8709e6a67b93d03768d0408ab5ab4e06efc7fb73d3bf19f3f0bc01107bf3c78ea204ce9a356b1ef7d1bbdb746f8dead5abd3c71f7f9c2f4f9e3c5fe3d2ba2af6ce88bba3c26faf22a1b828f2ae88b927845ecfd6013dc606e44e8447bfd0d447cf1e3d771b729fbc3b706bc0ead5abcd2b0cdca4ff259e1d0062aff2d1471f2dfafbefbff3721fbb9e0c1f3e3c7ff1e2c5cb89c55eb8bc5a78f7b6045c2bafdf5dd177c49376a4a2a085c7ee8a77efaed7aed5a43fb98a0ec2c168ca0bdc47cf02edaed09b0b3eb74e9a0d2a6e80e70d80d8ab5efd8f3ffed8955faf0b0c0cd4fd785f7df55551e1dd0ff1b16bf92e19df097663d0a53d51d7aa22e0a857ef094fdf9565ad07fc79e2353ec5d7eee721660e8066e3834c707e23478e345ff51ae40478331e198dcf91f1ce9d3b17c0afcb7982162d5ae4cd9f3f7fb9fbf7ef078bafb13e722d3f543fef0afb41188fc4da232cc135d1d7b3e5c0f5f5bb76eda68a159fa512258a3920907a8cd6f7f4287f9fedb337ddcf89c236095be2c4fd5cd66030840827437adfc3860dd3a5809c2f8fd0575fcb63efde979e3700629f150e816b2d608e5ebcf4d24bf1ab57af0e138bd37dec9ae617d65eb53bc2be2363e4af283286017542886d8fbe1f3870182524dc49bf99c4f55dba743ebdf1c648eadfbf07d5a9534343e137aeebd5eb0d9a33670a75e8d0521c67b438cecbe238d549bf57f4bc2544afcff6d91710d65db57f854592f1b5375bf77307d3a03c7eee70244e3de0b78038c8d79a356b4cab7cf1790372081e69c6e758f74d9b36f5e80febdcb933bf57d3c8c7af6f41f501c4827f4bd86ab2d934eadc00bd0d1bb6d2534f95a3debdbb4aebd9334caeaf5fff392a5e3cc881bc326e9f3dfb4b3a70e0b0957db296d3789c47c9b941788a9de5ec167afb623d7bf672719e8efb9ae8330f09eba1decfff08fbc6cafddcc8ec39a0f773c6e27101f049cf9e27b5e191f29ea476eddaec1154c7254e23af2afc61aac7ff93b059593d24e704a156ad6ad4ba75b30c8252b87021e1e5fbcbe54d9bb6c934d1d127c9cfcf8f5ab408a1bfffbe41dbb6ed149fffc86d2cda870efd4a5f7db59cce9c3947b1b1e7a95bb70e762b22850b17548f43eab1be97f95dba142fc4f017e1f157a3e79faf99b63d3272875cdfb2656371cc3a568596cbb56d5b945abe2a226d2db97eddba6d72b94409634566c386ef45fed5a954a9e2e2d8db65da53a7ced0c9937f88e5caea7ec63c376dda29d65512dbff14dbcfc8e5faf56ba66ddfbdfbb03847a7a9489142d4be7d532a5428bfd9efda25d25794dbcf9c392fced37af9191b7b519ca7975cf0fe73053cf8a7b76ab7856d27e3a8f828f3ffbd780ee85a884ccf353c6f806f8b3dcf5ec74d5e9ee4debd7bdca9cbe1aec6e3325bf4f85babc6c466150683cb990f1e3c92e6cc994a65ca9492cbe5cb3f2104b104b569d35c1e2324a4bd10b456b2effdf4e93352787976c3e4e464ba7d3b418aacf59686f4cfc183478be34c12c729a97e7f9baa55ab48f7efdfa7e79eab410d1b76a413277ea4679e294fe1e163e9ead5ebd4b1634bead36718cd98319edab56b6e51144342ba89f23517e57b5a94ef6c9ad8f7eb374208fe0255ec151a38f01d5ab2e413f1db8a8963bf474f3df584d8f628952c598cde7df753fae69b69d4a14373b56ca6ed41627b90d83e436ce7ee8866347cf8c7a2b2132dcad8938e1d8b11db66d2e1c3abe9d1471f56f7fd409cc3b2f238fc999c7c5f9ca73be23cdd74c2935744e5e092e94b6efb4f1416d64935262de8bddecf9d4cf907e1d1027c5aecf941ce51a83cc9aa55ab4cbfef7d5c66bb04db160a6b28f4ca2b4369c890b7e4b779f3a609016d69b6bf318f264d1ad28409a3d3d69f3c799a162cf884ead5ab6d26b00d2838f871e1f93716de6a7b72be6fda783cae58cc9e3d512e4745fd2cc4f3a4f4fe172e5c4e89896764eb02f3cd376bccc43e6325823df3050b2689f2d5b02a9c96963b766c2e84bbbf5c2e56ec119a356ba92af68ad9f6beeaf6a2627b0455aefc8c28ef32ba7cf9ffe43e2fbfdc5a1cff4ffafcf30871ced25f2869d2e479f5bb222a307f88f3f4829957efd8b95abc78b369456eff4fa4754f6af5ba9d353245e10bc4a304f8b4d8172c5850e1696a3d29f89d3a75ba3e61c204fe274ef4916be9e8033c95b28ed5382bacbc7d81cfeaedb368b76f6f147853d37d6691a951a34a86f573e74e11e2de4136ff4f9efcaef0bc9f74b0a2612b588f9166cd1aa47d2f5ab408a5a6a608718ca17bf79285575d5d6df54996deb735919c3bf743e9ddb76e1d22ca375a94af9c43650b0e2e9bb65ca9d2d33463c6d719d2070797c9b47db1ac583cf4504129f4a6b4152a94a3df7efb2343ee356a54207747f1f7eb172a2a0c0b7871422eb99f53550bb0768f5fbf7e5d57c1e74973cc4882a4009f167bf167bb1f1f1f9ff7a9a79ef2d80f0b0c0cbca1fef9c643ec2985d2e741e087203fa176085b266c9b7a9e94ac13e1d817db3c7902286fde3c0eb502981834a8b7ac204c99328bead66d4d717147a9408140b23518cfb2c03b36e29ecb57a44861ba76ed9803a2a888f2f510e56b21ca374f94afa328df3e51befc59f6494949b59a1f77253cfe7829abe7c1b8bdb47c83e1c183940c79dcba755b9cd73c0eb6b0382efac1c1a54d8be373f0fd9caadecf79d47bd9d2fd1c2d4c3e6c78121b3dc59ef337e33a2405782b1e198d5faa54a9f33c5da427d9b163074f5071d487af6db2d9320b3dbf9fccef087511564efddc90d51b713624aebdf5190587e710e76e1deebb66af9e5fdd3b7f3ece7833faf9a9fdf58ec6cd27b21f6cc7e8ed172c5880962c594df646ea1bcb7747f6bdb3576f2cdf45b98df3f8f7dfdb32f5a449f3c47242863c7efffd6c5a5e2b564452dbb64d321c277d3b89ed5bc4f610d93ccf2d227bf7fe62740d939268f7ee23141adac8aa90fbf919c479ba45eebfda97634831bb4ffd54a1b7753fa7fdef0f1f3eac6bc1323dd77cf97903e0d913152f5efca79d3b773e151616e6b11fb67cf9727ebafde4c3d736afd903710b19df4f76f23d7b13ce0cd6b3fd6a1b37ab972b5747be1b1f1b7b81c2c35fa10a159e94dbb9af9e07ddedd8f113ad5bf795039ebd7daf5edee4c27bdeb4e92bead97328cd9f1f41850a1510dede2342706759ac8c942bd7408ee48f8d8d13e5eba3968f68f4e8d7a8478fe1d2cb1f336630152dfa5086fdf7ee3d42f5ea7591797017c2e8d18332e4cd825eaf5e37b15d91fb8e1efd2a0506e6a555ab6650af5ea3a95ab567e9d8b1dfa973e7e6a2ac6dac9edb6edd5a8af3f491384ffbc4799a41b9388a9e7965d5df89fb99fff7f261c3f3d1f7ebd74fb78271fe998e0b805762f0c4416ad5aaf5e4b56bd74efff9e79f7e1e0aac93e4efef7f493c74f9e5fe581fb996a627393769469131e25894fadda1fd1525de4345244a4cbc2b45387317008fc89735952c5d03ae4c839b55f4321ed77a85213131d1623a1e09cfdfd3cb67dc56a64c7d9a3367bcf0c843e49ce72ce2e6799729f3a2d8fe9ed8de58dd9ecf42d992e47eecb9dbf3d88de5e0f314e084c02b6430d4f6d8ff3e1bef671e3c71ce58cf0ba073e7cee91258879bf0838383957bf7ee99ce673942043de0cb9efd912347fe7ce69967ce6ddbb6ed498e38a53773e7ce5d2b84fe091ffbe38d537fef1a7279a090e73c3f631f78d626f78c22af757c786bc7cd5a6948efa3cf98cebab89a5a11fc85f9d96865f0b73a90317ddc826dc14e3f4fae07e6c9e5f7739c5a3168c615ab993367d2b469d3342f20e76b26f47b20f4c09bf1d8ac7757ae5c79e7adb7de7ac07f3e9db9396cd8b08ae273818f5dcb8f8445905b23821d99d4c6d53c9d9d09cfd189716cadd373329d8ce92222a653bd7ad5adee13113155dd4ea4df443a8e78f73e733fcf312d70fcfa13274e685a38ce4f5420cc4facaf3d6f00c4de32b76edd5a7de3c68d53fcc7d393f6eddbaf15150a8e10b71297570f8176775e7b226da7c07557d49d1176ebc21a1252570eeab3b64f48c8f3ea766745daddd0bd8aafdec41b54ef5e769b74e9d245be86a7893771f32675edda354560eed5e3790320f666de7dbb891327deddbf7fbf2ef96fdfbe7d938047360d2463f43ca0a9c86b554970c5a3b73735aebbd3e23aefcd5bdfe65c4541bfb8fc8aafdfd01ce1482a7c4c4c0c75ecd8d16dc167a10f0b0b534e9d3a657a953501cf1b00b1cf4a6c5252d2c00e1d3a24c6c6c66a9af1c99327f7b66cd992db4947f17f1b97d655b1d7ab32e08af0dbdbe66cf3be2bdf9d19f9ef4d13f028b89d8d7de8ff3509f19e3d7ba861c3862e37e9f37e2fbcf042cace9d3bcd07380ec6f306e404fc3d7dc0070f1e44272727c72f5dbab4a9f8e3e5d562942c7bf4f5ebd77f363535759ef83a1797d525c68f1fff3f2fa954d84aa3e5fceece7cd76b0a5d3d96ad9fdf0913be901f3e745fb3b25f10c62383fdd8b3fff2cb2fe9f6eddb54b56a5587c278f3a8fb891327529f3e7d94ab57af9a3b48efe0790320f63610a2fc6b6262e23921f82d0202021ed4ab572faf2966b993dcecdcb9f3ca3163c6345214e55df17d362ea93b62ffa603c90c6e08b856e2ee6e6520378bbeedebe08362cf70b01b8e3fccd33306721c849f7ffe598ea63f74e8907cdd935fd1e3675081020564533db73ceed8b1438afc9021435277edda6510cf18d3cdcf4df7afe17903721201d978ec95e24fb67fdcb8718bc49faed2a2458b1e6ad3a64d7e07f74d9a3f7ffe86a143873e75fffe7d0e8b1942684af322af5c0f8f5e6b81f794e87bb23280a67b5bcf1b613c58e84b55f4e5c0bdc8c848697630f7447830de403c6f00c4de39625352529a5eb97225ac7dfbf683f3e7cf5fe5c5175fbcd6a3478f42b56ad5e226fe92dccc76fbf6ed2b972f5fbe151515f547444484bfa8953f2bf6e3f67f7ebd865fcfc1e0986c17724f0abfd64dfc5a89bc2b42af55050042efc8f346184f4318a67ae68d9d7806b2c82fc2f30640ecdd638d10ef3509090965b76edd1a26acbe58c7a1bef81d5b8e345244d87df589b6938c83626271f93c29c00637f777775ff4e143e8b57bdea85656157ed3f3a6a4fabce1e70e0fdbe7e6ff9fd4b478de0088bd8670e4abcf5403b9ceeb57344ae74c84386f69ced74bf421f478de0090f3c41ee47841f7a4f8e7f43e7cad2b00000060193f9c0290513c9c0da4e3683e5a44d77326c88ebd7564639dbbefe1bbf3ee3d84de0be9aba3635446586f9c6200b1075e58017037d21e913e417688dc8fa3af65585d57c4dc9910bac043f05cc8813ae5fd1f619fe21403bd41333ef0026f518f57f23cd587efc9a67e883c0000620f34135d830e796ab98faff7e1fb0c9b847d4ec601743c8bd06bea3a86df959f4ec637756285f52163a43cd37e4bd5edbccf1b648c74c7df8b0aeb2eacbdb05785fd4cc6e87aa9c2be165647583132061e72243a5e4b35df82c266a8e5b557f6d6aa379f4c785f1f40ec41eef7f0f50ab2e38cb7ef494fdf956d3eedcd3716f68fb0bac2da0a1ba40a268bf13a615584fd25ac8bb08dc26a9aedc7158027c9f84efc2a328ebcafa9e6b15115fc91c28e0b6b216c9bb0f7d40ac313c2a21d107b2ec702b51c89c24e0a5bafe661adec2cfccb8555127651ad8884e0990320f620178abcd61ebdbb02ef8a17ef8c90c39b7783e1640c4f7b4d583e755d133206b9f94bfdbe56d80a610554d165dea58cc16fde523d69ce274ad80feafaf3943e76e996b04ec28284e575a06c4dd416818fd5ef1c7ebc86590b83a5b23752cb7e51fd7e1a971840ec810f5726bc75b21cbd441edebc15ee5b599f6cb69caa7efa5958e728e555cffb4361ffe7c47ef1c2b6aacbfcf9ab9db2e72344e003107be07b9ebd168176f4eac337505cdc1ddab0218ab66efd9176eedc45f7efdf274531a6e5c9536ad7ae4e9d3bbf44ddbb8750d9b2c534a80440e81de0081963dc17523de77aaaa79ce0469e0dc9d874ff2d195f8773e44da59fd572449b79f3f6382bec45b3b237c4e504107be025c26bd0200f2d2b007a4f9663a077de59400b17aea022458a50484808f5eedd97060f1e42cf3df71c952851822e5ebc48e7ce9d939ffbf7ef17695ea7a4a4440a0d6d40f3e68d8137af2f67c8d8dfce62cb03dc2a0aebe1669e7b854d2563dffd35f518e3544fdf1a2cf0fdc818c29b43eb9650d3efb0b1cf0132763bfca11e671f2e27f004069c0260521b45f164f7a19ea1735d17fd9f7efa8dc2c286506262228d1c395288fe3b1418e8d82bd693264d9253a2fafb1b68f5eaa9d4a2453d173c7b9dfff086dab9e97fcfde375f9c440df3e3befa24d511e2efc90eee671a2fe068f70197fb01a1491fc0b307dee3d97bcbb1f59c2cc7404387cea43973160aef3c94befdf65b29f23c0dea279f7c425f7cf1059d3f7f9eeeddbb279bf11f7ef8612a59b22455a952858a172f4ee3c78f971503b6eeddbb53ab56e134685098f0f2dff60a91cfa5a46a28f4a6fc92d4e5074eeee76c1742122e1f80d8032f105c830e797a4afc15a7f38c8cfc8d962c59490b172ea4fefdfb4b919f3e7d3a2d58b0801e7ae821aa56ad1abdfbeebb42c45b51505090dc27262686b66cd9223dfa79f3e651fdfaf569d3a64db472e54aead3a70f75ebd695aa567d8a060f0e83c80300b2157f9c02a0229cd3702f6e495034de96be7ee5ca033462c438b5ef3d8476eedc49b56ad5a2fcf9f3d3d75f7f2d05feead5abb476ed5a1a356a148d1b374e36d7efdbb74f0aff471f7d445dba74a1a54b974a0fbf75ebd6d4a85123ead1a387f0eeff27d21416a2ffb45788fc84095fc80fdcee0040ec810f922f5fdef7478eec6f0808c8ee5b42af403b969bf2f7ecf95d78e1c369ddba7554b972659a356b16f5ead58bba76ed4a63c78ea5f6eddb4b117ffef9e7a95fbf7e347bf66c29f477eedca19a356bd28d1b37e8fdf7dfa7ad5bb7d2c68d1be9f1c71fa7fffef7bf54bd7a75b9bd71631edcf70655aa548e9e7efaf16c3db377efdefb6be2c4af7814f887b8e301f02d30110e90942f5ff6eafefdc73c20e4ce4ca2a3e5643996d6198498bf460d1b36a4ba75ebd2860d1b68f8f0e152e47bf7ee4dcd9a351395a07cb2f99ead71e3c66983f5f893f7e1417c4f3df5946c0968debc39fde73fff919503deffd8b16352f45bb468492fbf3c36dbaff10f3fec3b41c651e30000883df04582821edeb367cf11726d963bada7b455c8faa03aad66c2237ae79d2f282929498a33f7d1bff1c61bf4eaabaf4af11f3c7830ad5fbf9ede7aeb2df9690e7bf2090909b2f93e222242eefbcd37dfd0f6eddba557cf798e1933465606ae5fbf2ef28fa094945491e7a46cbdc68b166dfc978cd1e30000107be08b9c3b7769ea8205dfde67e1d256b0b5ac00382afc8e89fefcf94ba5675ea85021faecb3cf643ffb9b6fbe29bd72ae00b058f3c87c1e78670ef7cbefd8b183befffe7b29e65f7ef9a50cb0c3dd009b376fa6810307cabe7f1ea5dfae5d3bb9cf7befbd272a06df65e7258eddb2656f3532bee30d0080d8035f242e2efe606a6aeaf1d9b397d949e9eafcf5ce540cb4f2e8ad7bf53b77464bef9c5f95e30ace9c3973e8c30f3f94e2ccafd5f148fb9b376fca656ec2cf0c0bfd4b2fbd249bfdcb962d2bd771faa3478f4a91efd8b1a3ac041c3870405608de7a6b34ddbb974ccb96658fe0b76dfbe676717d2f89c5fdb8db0180d8031fe6d2a56bbdc68f9f93b87fff51f26c533e917bfdf88e087fc6f5df7db7477aeedcf73e79f26439f29ec59fdfa3e711f73cf27efefcf9564b1b191929bd7e7378f0deb265cb64537e9e3c79e42b7b8f3efaa86c0960ead6ad4ddbb71ff0f8758d8afa656364e46e9e79ed4ddce500f826188d0fccb92ebccf839b3747b56fd8b06660d9b225ddcc4ed1795fd783ec7cf9e5161a30602055ac58517c0ea01a356ad0952b57643840bdd5250000200049444154dc61c386c9d7e61a346860716ff6fab999ffe38f3f263fbff4faf28b2fbe2847f2f328fcbb77efd2a14387a865cb9674faf469f96a5eb1628fd0eedd3f89bc5b7a54e89b367dbd8aa2283c95ea1edce200c0b30780d971f5ea8db0468dfafd3b69d2c21bf6fbf0b5f6e2b56acab7dd877ff4e87139529e898b8ba3366dda08618cb22af099bd7a1671eea7b706e7c3f971bed1d1d1725de5ca55c5717ff7d4758c6ddbf6cd2f4342063d9f9a9a3a8c8b8d5b1b00df0511f48045c14f4ebefffcb871b3667efcf117357af4681dd7a953b3528d1ad52a1918984fc7c3ea1d2f3f7ddb850b7132dc2dc34df76ddbb6a5418306c9a67d7b707f3db706d8822b12dc7f5fa142058a8f8f97eb82824ad2d5abffe876f6f83d7a7ebd8e47ddf3603c21f2e5c4eae6c24ee0960600620f8025625252525e4a4848acfec5176b3a0b6b2cd63d4cc6093c72053c0a5fcabf1aeb9e5f99e3be7b865faf33f5b59bc36978243edbcb2fbf9c252d7f4e989031401d0fdc331d4f54a24c93d1e8014fcdca33a99d12f63961301e0000620f1ce428e5c2402c068341e13e7a9eae9643de7277050fd6fbe79f7f6cce72c7db4cf3d95b82c59e8d2b05850b17969f262e5fbe7c557c1427cc360900f030e8b3073e499e3c799413278caddbdc9ccf4deeb56bd796f1f135a92189fcb8299f03ede4cd9b57ae13c7bb233eeee3ec030020f600788042850adde1be77e699679ea1356bd6c870b87bf61807ac73643c0eb4e30c9c7ef1e2c57299f3e1fc385e3eb71e30cb972fbf2e3eaee3ec030020f6007880c2850bc7fcf8e38f7299e3d9f3d4b69d3b7796f3d6f3fbf3fcbe7c5858985379f23cf6fc7e3ecf9267ca8f8fc19fcc77df7df70861b01c0000620f806730180c03af5cb992ca7df56fbffdb61c4477e9d2252a58b0a01c48c7616f4d91f11c85bb03783f8ea0979a9a2ac702dcbf7f5f0ee013245dbd7ab5b4f89c8eb30f0080d803e0016263638f162850e0dcb66ddba4b8f37bf1afbffeba6cceffe9a79fe8f0e1c3321d570278c21b6b70d33dbfa76f82c701fcf0c30f72ca5c9ef77ec8902172a4ffdcb973d72a8ac2330dfd80b30f0080d803e0218467ffced0a1435378c43c4f6fcb23f177eedc9936452d0fd6e3003a7bf7eecdb09ff92b79ecbdf3c437dc42c0426f8a89cfb3e0715c7c9e6887eb0cc3860dab283e17e0ac030020f60078905bb76ead165e7912bf2fcfde3787b79d366d9a7c5d6edebc7932d0ced4a953a5809b63fe1e3d87c7e5487a7dfaf491f3d9cf9831837efffd77faf4d34fe5beea6c78bf8aca00ffd756e2ac0300b203c4c6073e4d6a6aea5e21ce7d9f7efa69034f4bcbb1f1fbf7ef2fdf919f3973a61c95cf83eceedcb923fbe1b95f7ee2c489b29f9f9bfa57ae5c295b03b8bf9f5b0178601f4facc34dffafbdf61acd9a35eb47e1e53716877a55d8ef38e30080ec00c13d80cf23bcef998aa2fc372a2acac07df72cde3c22bf58b16272eadbc71e7b4c8eb2e758f72cf0ecf9b3c7ceefd1f3eb753cda9e9bf3478f1e4d3c068005bf43870eb465cb96c3221f0ec0cfcdf7e138d30000883d00d9889f9fdf32f1d15d08b41f4f72c303f3786e7beeafe7696adf7bef3d19379f059e859e059f3dfe152b56f0603f693c188ffbe879fbfcf9f3770e1e3cb891c873a7b09638c30000883d00dec1fff2e6cdfbfef8f1e3fd478d1a55d024eadc7f7ffcf871e9d55fbc78510ee46338325e993265e8d5575fa5a143879a62eddf149efe8675ebd67511cbab84bd82d30a0080d803e05d04fbfbfb2f2a58b060edf0f0f0c0891327e67570bfa4d1a347ff3863c68ce2f7efdfe780f80385c5e074020020f600782fd30d06030faa2b5cba74e95b1d3b767cd0a54b17ee9b2fb66ad52a6adfbefdf59b376ffe1b1111717dcb962dc5ae5cb9c2117858e44708fb5ad8039c420000c41e809c014f703f5a582d167e61dc56cfb345a60ae3e9ef38d6fd213246c6fb09a70b0000b10720e7335e18c7bf9da02e030080d783a03a00000000c41e00000000107b0000000040ec0100000000b10700000000c41e00000000107b0000000040ec01000000883d0000000020f60000000080d80300000000620f00000000883d0000000020f60000000080d803000000107b0000000040ec0100000000b10700000000c41e00000000107b0000000040ec0100000000b10700000000c41e00000080d80300000000620f00000000883d0000000020f60000000080d80300000000620f00000000883d00000000b10700000000c41e00000000107b0000000078090138050000138aa204ce9dfb79f88103877ac5c4fcfeecf1e3d18149494938315e8abfbfbf121c5cfaef9225830ec6c7df98fee79f7fedc259019630e01400e014e385bd2f6c82ba9c6b58b4e88bd72322967d72ee5c6c8101035ea1060dea53ddbacf536060a023d5041bdfed2dbbb25d8b7d1dcd4fcb3cb4cd9f2b62478fc6d09e3dbfd0c2856b936fdfbe73ead2a5abbdc4a613f8ab02883d0010fb0c2c5cf8c58677df7daffde8d1a3283cfc0d0a080870e011a1d859e70d22af85b8ea2de8da9567f6ece5346edce7779393935f4e4c4cde88bf2b30e18f530080533456ed276151b945e8274f9ed2fedb6f5750585867f2f3f35745de9e2f60b090ce916557b6675ee7a89fe268be7afb50068f94f1b9e7aa506868a33ccb977fd7263131295aac3a8dbf2c6030400f001f869beed9a35fba74896cb2cf2ac0f6cc19917754a8b5103f2dd21b34cc5f6fd2cb53b9f253b46bd75785f3e7cfb794bfe22e07f0ec01f061cf9e07e38d183162e78001afe4618fdeba301b2d32720b8d1d3b8ee6cd9b4f6bd7aea302050a50850a15ac88b83b9eb7169eb4b778f97ab71858a678f147285fbe3c89bb761daa999a9aba047f5b00b107c047c55e08c2f02d5bbe6b1311b1446dbab7e4d11bbf8f1f3f81b66fdf41172e5ca063c78ed1bffffe4b478e1ca1f3e72f509326214e78f2062785d77b3d68efca2b2b2fbc503dffcc991179eedebdb74f7c8dc35f17620f00f041b10f0a2a36b759b3a6251b376e644184d33f23232369c3860db475eb5629f6c9c9c974ebd62dba7cf9b210fbf354aa5429aa5c393b5a8b73baa7ae3f172f5e3d7df0607401b1b81d67c3b7419f3d003e4a4c4cccb3fc7a9d3d315db26489f4e61f3c789025455c5c1cf5eddbcfc382ebad82ee7de50a0b6b5e46ad9c021f07417500f05138608e71509e35142960f1f1f174e9d2252a51a284eca3bf127f8502f3079292aa5068db505919c8ba9f9e285e7a46bdaf5ccf3d57b994f82886bb1d40ec01f05138204bd680394a260f55318afcb31568f9f2e554be7cf92cf918c53e3b844e71709def1218980fcf792041333e0080b2066c51d2d6f5ebd757560a8a14299265af1d3b7750ad5a356de4e3c8ba9c24de8a97e60500c41e00e0b0c86715e5d0d03654a972456ad2b40925ddcb18277fd4a851b478f15776f2d25bf0dc39969243af1500107b008046827ff3e63f3469d264faedb793b468e1220acc97b1d9ffb1c71e13dba7c851face5420f417652dd22b394878511100107b0080d382afd0d75f2fa6ce9dbbd2d3cf56904df8a54b97ceb257a54a95e88927ca51b7ee3d69d1578bc9b1d8f8ae6c77b6c2909ddebc1615078837d0160cdc0000224fc64179c6e58484041a3c389cca3ff934addbb0514e8a53a64c591a306000b56bd78eaa54a922d39d3d7b965fdfa3916f8da69ebd7bd3d831efd0ec390b287cc86b1e107d47f7d55ba8b3c303474500c0b30700b82c200ac5c6fe45a1a11da857ef7ef4d6e8b7d366bfab5ab52aad59bf9e4a942e45878f1ca1fd070f5029e1e9472c5f2147eb73ba2953a7d191c3bfd0ca6fd73820c6ee88be56dd005a36f5eb9d3f00f0ec01006e897cfaab76ad5a854a6ffef1c79fc892929bf2bb76ed6633b7cf3eff9cda86b6a1eedd3a3928e28e4e59eb8a57aff53a6ff3ce513900107b00800ba251b97225f2f777fdb1606a09b02dec8e0aba9e83fbb2c3fbf764e500a20f3282667c007c5ee8d385a15ab52a74e8e0c1b4ef114b973a944bd6748ad563b8eee9bbda25a08510eb35e82e3bde3c00107b00804f8b7eedda35293afa78dada65cb221cdadb723ac549efde9ea83bda42e0ce803fad445c0bcf1d150100b1070068ead91b45a176ed5af4cb915f7410afcc62ee8897eeae77ef8c707ab2091ffdf5c0f3a0cf1e0090261641418fd0c993bf51eb562fc93557af5c495bb68579bab367ffb421f8ce7ae9d6845e2f4fdfd111f75a84fdd56bb020441f40ec01003685c14071717f68909f3b02ab6890462b4f5febb0bfe8cb07107b0040b688bd410781501c5caf64c3b2bb83fb148dd3e955390000620f00b02914060d3d48573d7b4f0abd378ce8cf09a180731465857510d64858756125851512c6b339c50b3b2a6cafb095c2e220f600001f107a83c6a2e18810392af25a8abebdb26a25fa5a46d673651f9f167d16f8217e7e7e2fa6a6a6e6b5b09d67730a568dd34e1316256c91b088dc7a5220f600003be260704350dc157dbd3d7d67c45aab6e00bd2a193eefe9071b0c86f98aa2c891a242e89dd9b7b16a3cb1437f616720f600805c2cf2063705437162bd3778fa5af7e3bb22d6a4433e3e47777f7fffb929292945d3c42d20809a356b469d3b77a6ba75eb52c99225292828886edebc49f1f1f174f4e8515abb762d4546465252529269b706c27e153638b779f9107b007c5eecf518a0e78e7019bf1f3af42b952e5d92ca942929bfefdab5872a567c864a9428e661efde7ef977edda27caf6b428dba36e54146c1ffbd0a168713e8a89f3510215818c840a8f3e4208bdbf49e4870f1f4e43860ca1e0e0e02c891f7ef86169152a54a0eeddbb4be1ffe4934fe8b3cf3ea3070f1e7012eed7e79090dcdcbf30b79c2404d50100826fc3323270e07f85e8fc9261dfafbf5e4a9f7e3acbcabed6f2b3b5cec8840953e8c71fff2fed7baf5eafd1be7d872ca47527488f23626b5f8c7bf57a5394ed880e226c7e3ee68af37100de7f268f5e08fd064551a4d0b380fffaebaf346dda348b426f09f6f8393def57b97265f34d5ff2a585d8030072a1d0dbdebe6143245dbc783143fa23478ed29e3dfb1da82cd85befcc776bcbae5600f41ac59f71fbecd94be9c081a34e7bf510788b0473d3bd49e81b346840bb77efce2cd80ec3fbf1fedcf46fc63cae43e4869385667c007c5eec5d69c6b7de877ee6cc59216887e9d6ad7fa9468daa54af5e9db46d9b367d47b56a55a74b972ecb3475ead4a4e79faf9596c7a64ddb2836f63cbdf8623db21d5b5fa1c8c81f441ebf50cb964da87efd3a36c5363272bb9a36242deddf7fdfa06ddb7689cf7f4499aaa8eb8de977ef3e48870e1da5a2458b886d95a96ad5ffa8bfed9c14eb5bb76e8bdf5651fcb69a16cb77e6cc5f22ddaf225d829aaebac8ef387df5d51ab92d36f62275ebd62a6dafc8c82891fe98285f03518e9a66e76397481b27ce476d27ae856f88bef0e8179afae8d9a35fbf7ebdec9377076ede5fbd7a35356cd8904e9c38c1ab0aa91e7e4378f600805ce6dddbf2f46d79eac6e531633ea03b77ee5040803f356fde416df6376e1b3cf87f3470e05099e6f2e52be2a1da9a4e9f3e23b70d1dfa36cd9831974a9408a2993317d09123c7ac7ae9e1e16fd337dfac927df87dfa0c11a2f8bd55a10f0f1f23d2ae56d30e55d32a14121246313167a858b1474419cea6a51f3e7c3cf5e8114e050ae49723ba8f1d3b9596df9831d3c46f4b547f5b6f29e096ce9331dd5d355d1f992e2121919293efd3eddb776405c34478f807a27c1b44f99e12e57b5b94ef47f57c4c14e763891c073073e652713e7ed3a8452057d04178f44da5c71a102005da5da13717fc152b56984fd7cc83f6727c733e3c7b00722eef0a63f72352d803d7859ec899d7eb7af4189061defaa4a47b141a9a1e3f7fd5aaafd3f6dbba75bb14f33a756aa46d2f5ffe099a3d7baa5c8e8ada23c4f404152c989fe6cefd4a54004e0af17d5478bd1da975eb6e168f7ff6ec5fb47061042526fe457e7e467f8585bf5dbb1659ca6d4cbb4ca43daba65544da3532edc9937fd082055384d75dcbcc238f15c2ba880e1edc2cca5c2d8ba8ae5a35c7ecb7ed9295843a75aa6429e3aa55b3d2f6dbba354aa48ba59e3ddb527070196ad1a2419a577ff6ec7951bed5a27c4745f90c6af93652ad5a15c5f95829ce4794ac8c70fad6ad5f7750d49d0dce9323efdf21a6051e8ce76ad3bd3538bf912347d2e4c9934dabf895bc1c3d3a1f620f40cee543f5f38eb00deac3688fb004d745df3ecb977f491d3ab431f34cdfa24b97e2d3f2387efc379a336721fdf3cf4dd99fdfb973db0cf9376bd638ed98dc4c9e9a9a22bdf8871e2a2c85de94d624e499cb76e2c429ba772f5978bc95e4775e2e59b2b895b4316adaaa66698bc97473e77e2cbcfb2e42449b8887fa3bf4cc33e565fa3c79022c0abdf1b79d12bfed1bf1db6e8932478bdfd6d2e2b93c7e3c46a48b50d39d10e95a583cd7274efca196afbe59f982c43e27c5f9282885deb48fb13260ef9a2939f1febd2d6ca3b0650edebf650d064388f0ec65a573d8b061ba148ef3e511faea6b79ecdd070b8b85d80300b28b82c27aaa764bd826d6643246054b724ee40d6e1443a198983fa879f38ef4fdf76ba87af52ad4a9531f2bc7ccda176f7cedc97ed741debc79a9489187e8dab59376bddbbc79f3a869a3b36c1b34a827b56fdf82a64c994b75ebb6a3b8b883327d6aaa222b20a6960013dce4dfbc792ff1dbbe11bfed3fe2b70db678dc98983f45babe22ddd76aba376cfc162e5f6151be9f33e4c57df50f1ea4d8f0da7395e817266333391bf76f6c16b6c2c6fddbc13428af65cb9654b66c595d0ac5a3f443434369cd9a35a65561c2a6e7d48704faec01c85d1411d65bd877c26e08e336f50ed62bf6b646ccdbeac3b7bc2d3afa24952a55520a3d7b44172f5e16a2759f6c0fb623d9cc9f987897f6ee35be5ab663c74f74e0c0118b958366cd1a52c1820568c99255562a0fe6691bc82e82254b566748c7629e909020c707b0579f907087ce9fbf442d5a3494eb3efcf0f3b4b4dc4dc1cbd1d1bf8bdf565c0a38afbb7831def45e7686e346479f16e98aa9e9f81c5c51855b911588bfffbe9996b659b317d4f26dc87066ead4a924ce4792381fbfcaef3b76ec13e7233ab78b3ec303eefaa8f7efdf56eedf46a6050e98a32799f26f94931f0cf0ec01c8bde417d64f35f6f8b7095b9cd5637225eeba656169d2a4018d1dfb1155ac588f8a167d98ead77f9e3ef8603a55ad5a896ad5aa6a559c59443ffdf4030a09e948850a15a456ad9aaaa3f4b35610b8e976d3a66fa867cfc1347ffe12993e28e8115ab162ae95b48b45da7091f61b356d515aba7426952bf7826cae8f8dbd40e1e1fda84285f272af75eb1650d7ae6fd0faf5dba497dfb2e58b3475ea3be2b7d513bf6d9af86d2dc46f7b48fcb65ae2b7cd12bfad42867236695257a4fb44a46b29bb298ce9668b74cf52b76ead69f0e0f78578ff2c8e334b94cf4f946fae28df2851be95a27c0564f956ac9826cec75be27cf493eb5ab56a28ce47151b9ebe337301e4180a98ddbf37d5fb7789b0b40120b56bd7d6b500d5ab57cff035279f4c039e870038c57861efabcb13b2b92cefbbb1ef9fc29e54946b3a3c0e14e9a5f3687693671c1898cf21314a4e4e9623e0d3d3dbf656f9383ce29d9bc32de76f9e36518a7f7a5a45dd9fd70564d987b70506e6cd3276c0f8db02cd7e5b5eabc74b3f0749ea6f52e4887c26f331d99337fe9680b4759cd6783ef2da1175cba21f1b7b49546a42bde15ed5fafe955cbb764db351f896e0d0ba458ba645e04d522bd0f0ec01f031decfc1657fd29688baed9215487f261a85cab198f9e6426cbf7c4a9ae85adb9e316dfe2cdb32ee9f711f6b799bafb726f4198fa7a4097dfa6f54ac9425a368674d4b0e7af2c6758b176fce0df7aa55f4147a865fc3332330279f2b883d00ceb138875536eeab9f7932ade717cbcbdb17787bdebe5653af7aeb043aaeece36a043e7763f567dddeaf5f284d98b020277bf6f7d49bd0d254b574fdfa75dd3d7b339220f600f80eb1646ccaf7e687250b3ccfef99cf4ce4f9a9b5838caf376d531f5c4ad6087a5a7afb8a8bdb1d1b68f6c61b6f53fffedda84e9dea6e08b6a3dbdca900787a829ef4e5e0e0d2a6c5f15ef85fb276fffeab8a7ba07a0f67be7f7944bc6c99e2496cf4147bcedfbc6e01b1070064377755812f6826f009aab07fab3e286f6a2fe8d927fc1cdeb678f120378452af6973b5127a3de2f67b2d3c80945fa7e3f0b40fd9b97f7b9ac4fef0e1c39a07d43187a7c135ff0ab107006437f9cd1e90fc62f01632462673f23d7b13ce0cd6736f3637d73c7b850a172e2807b431c638f75159e2dcf3f78ceb8da3b7d7adfb4e2ef36b76c6097e7ea0e79faf2edf0a488fa7ffa38c6fdfb2652339a2de3b859e9cd8dfab29e2c4fdfb1319df7997f3d1f7ebd74fb74271fe998e9b63c17bf600e47cd8e3e117b53b0a7b4c587ff581e9461fa3e284b9928fad3496d6675e473478f03b72b21a639cfbae6a9cfb4733c4b90f09e96621febd220462044547c7a4a51b38f06dfaf5d7df283d9efefbf4cd37ebe41cf57dfa8ca04d9b763828d09e16fa5cf16ebdb3f72fa795010eb66ddb46717171ba148a9bf0376fde6c7e32d7c0b307006407e3c83886c00d61f7b430b8d29c6f7f9d31cefd2435ce7dfaf6f4f5351c2ea1315efdb79498f89b59bcfaf5d4ae5d53d2aea9dfd3fdfcb9eafe65758f12d68c831acd9c3953ce47af359cefbd7bf74c4d5c7b280787ca85d80390b3f9483bf1d532e486a2413a67449fe3dc4f945e7cebd6213479f2db32ce3d3377ee8799d607dbc8d398d78913bfabf1ea9f936bcde3e95b2e871ea2af65652157debf3c23919c789ee3d7f7eddb57d3be7b9ede565420cc47af2ec8e90f0b883d00c003e2a0e500bdaceb070d7a99dab76f4e53a6cca3ba753b505cdc7ef99efba0413dd4f8f7a6f5fb32bcff6e222525356d393d5efd21070459eb0a80d6ad02b9960daa77df98bdfb2e5dbad0eeddbb351999cfafdb75edda3545e06fe6d5afcce9270c7df600f8bcc8bbda1fefc8fe8ef4d1db8ab96f6dbff475c638f777d438f7a3d3e2dc73e439e3fa47cdd65f94fb706cfd7fff4d90cb9326cd55978df9356b565f8d57bf3693803ada3f0fa1f710dcb72f5f878b8989a18e1d3bcaf7eedd15fab0b030e5d4a95326a1e71b6320b93c85343c7b0080d7887d76bd676f2f8d634df92cf6e5ca35a03a75aa526c6c1c8587f79571ee79f219e3fa6aeafa3e62bd3170e0e8d1af518f1ec3a4973f66cc6019ebde94b7315efd02ead9f37f347ffe0ab378f53334146508bd06c40afbafb0a57cd9f6ecd9430d1b36a4d5ab57bbd4a4cf4df7ecd19b093dc3531bc6e4869385d8f800f8b0d22b4a9ca70ee5461ac7443f6bec7b63baf4f8f71943cf1a63d42b36e3ea5bdbd733fdf6da08bdc1503bb73febfb09fbd2e4bcf2f51a3e7c388d1831424e536b0f1e75af0ef253525252cccfd33bc226e7969304cf1e009ff7ec5df509149d8eedda7a4bb1efd3d7676d5eb734f98de53c1d6d9af73ea1f71116937134ff3c610f731ffef4e9d3e5c03d9eef9ea7a9e5d9f158f8b94f9f9bea59e03960cec68d1b69d3a64da9a2a2e86776a327a82d068b73d34982d8030034a810e8e1d1bbebedbb1b575f6b6187d0eb080fa0dbaf7af872943e8b7e6464a4343b988f5de3c178dc471f93db4e10c41e0008b9171d4b8f8972f4147957845e8f91fb808c7df8cdc9185def35618d9dd03816f945c22228170cc683d803009c1060839bfbbbbbafd602ef29cf5e4b0f1e42ef026b542bab0a7f7d613c70813bf079721d6ef2e761fb1c7ef127356d6c6e3f29107b00808e5ebfa2513a6722c4794b73be5ea20fa177101e7dfa996a3e0fc41e0008ba171ecf13f3de7b4af4f5ac0000e01808aa0380cf8bbdb381741ccdc7d1bcb50db2633b008eb575ce7c7724adb565c5857d20f436e8aba3d35a4658ef1c9837c41e00a0a5703b5b417067063c22d766c7b3b5ce918a813d51d642cc1d198807a1b7c22c32f6c3ebc17f847d9a03f386d80300b41076574d2fe1b7b5ce1101d7dbb37747f421f21ac171921ff5e513803e7b007c5eec99ec98f5ce997d7cbd0f3f47d352d87461058571cce1cfd5f51384f5529dce3ec276abeb9ba9e979aa411e39cf318ebf1656475dc7fbcdb5722c4be9fea77ee777f177089b62a34cad558f3b996cbf6b6f6dff4deaf2676ae5e235759d337943ec01007a8bbe371c47d1709b27445feb6db9ca9b6791e5e961ab084b147652d87a61d7848d12562053fa52aa38b611b6cb6cfd7bc22e087b4258b40db1b7948e0576bcb0eec2feb651265e5e2eac92da12f086b010277e131fb7b1b07f84d515d656d820f5f73cea60de107b00404e1679ad3d7a7705de152fde1921f7796fde4413613c7ff0c7ea779e64a6862a802cc65b857d286c9fbafd45616732093d734b5827613c876d5e1bc773249db532b11eee51c59839ede4fe17d4efc3c91872972b34f9d4758d1ccc1b620f00c8ed9509fd27cbd1c6d3d723fa5eaeee9b8f57459dd4cf5fd5e586c25e2563f3fa4c4a1fb07637d3fee5d5ca01570afecfc6711c4d67ad4cec953f70f33731f72da4cf47d91c990f03f400f07931f6d4a03c7bc774249db56d96d65bcacbd63a7b69dc19b94f647bc05faee56732365d9bbc78b6cbea36eebbe666f691aa474faaf7cb5e722db33c1aaafb7f2becb60dddb295ee9eb0603b653aab96a390597ecefe266b389a373c7b0080273d6f83067968d902905326cb81379f096edaee276c2719c3d396503d6f9eb4e6b0b0e3c2aa93b10f9be1666e7eff7c9bb0bdc29e12f6b2b0a9ea3a6e1ae766fe716a3ee6ecb5916eb6b025c2169271f09ca532f1e0bdb5c2fe50f7dfe7e46fda61e33c1c70306fddc07cf600f8b0d22b8a27bb0ef50c9debaee87b52e43d2bf45e329f3d7bd93c188f07b4a59aad2f64619d297da0bacdf49dfbe0935427d54f6d19b0741c6be902d5e5543b65e2740fc87eb3bbb5fd6de168def0ec0100d921c0d975ec9c36598ef788bc97c1629860617d828df48999be27a9cb0fec1cc75aba2407cb94e4e66fb24552765d00883d00107b930f98cd15084f4d81eb884043e441ee02620f00f0a02069353a5f8b3efcec98161700883d00c083e4cb9757494a4a320406e6cb01950cbd06e8e9e5e97b87c8dfbd7bef2f324eba027c1cbc7a07808f52be7cd9abfbf71ff380907b7bcc7c475ea773356e7ef6f2c30ffb4e9071c43880d803007c91a0a087f7ecd97384bce73d7b67dfb5b725fc9e9e16d73b67a65bb468e3bfe2230a773b80d803e0a39c3b7769ea8205dfde7ff0e081c682ad57a01d7783ec68312d6ece107995d82d5bf6118e7668000001ac494441545623e3fbdd00620f00f045e2e2e20fa6a6a61e9f3d7b999d94aece5fef4cc5402b8f5e4bafded63aef9f63be6ddb37b78beb7b898c016c00c41e00e0ab5cba74add7f8f17312f7ef3f4a9e6dca2772af1fdf11e1f754485def232aea978d9191bb79d6b537719703c61fa700009fe6fabd7bc907376f8e6adfb061cdc0b2654bba999da2f3bede32efbd770b7dd3a6af5751148543d0eec12d0e20f60000e6ec9d3b770f2f5dbab9434040c09d7af5aae6f7f3d33abaaaa2c33e5abd8e97f3055e25b66ddb37578f1d3ba7892af491b8b58109c4c6070098a8e0efef3f337ffe7c357af4681dd7a953b3528d1ad52aa9ef7bf87ac7cbcfdd02cfefd1f3eb753cea9e07e3a97df4dc747f02b73380d803006cc1b3907526e3fcde3c8b4a204e89d7c2af52f0808b28328ebac7603c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b992ff078734f7f331a56faa0000000049454e44ae426082', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71274340-1737-11ea-ac1a-7c7a916bf543', 1, 'reviewSalesLead.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c220a2020786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e220a09786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f444922200a09786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f4443220a09786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f444922200a09786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e636522200a097461726765744e616d6573706163653d224578616d706c6573220a097873693a736368656d614c6f636174696f6e3d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c20687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f322e302f32303130303530312f42504d4e32302e787364223e0a090a093c6572726f722069643d226e6f74456e6f756768496e666f4572726f7222206572726f72436f64653d226e6f745f656e6f7567685f696e666f22202f3e0a090a2020203c70726f636573732069643d2272657669657753616c65644c65616422206e616d653d225265766965772073616c6573206c656164223e0a2020200a2020202020203c73746172744576656e742069643d227468655374617274222061637469766974693a696e69746961746f723d22696e69746961746f7222202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d22746865537461727422207461726765745265663d2270726f766964654e657753616c65734c656164222f3e0a2020202020200a2020202020203c757365725461736b2069643d2270726f766964654e657753616c65734c65616422206e616d653d2250726f76696465206e65772073616c6573206c656164222061637469766974693a61737369676e65653d22247b696e69746961746f727d223e0a20202020202020203c657874656e73696f6e456c656d656e74733e0a202020202020202020203c61637469766974693a666f726d50726f70657274792069643d22637573746f6d65724e616d6522206e616d653d22437573746f6d6572206e616d652220747970653d22737472696e67222072657175697265643d2274727565222f3e0a202020202020202020203c61637469766974693a666f726d50726f70657274792069643d22706f74656e7469616c50726f66697422206e616d653d22506f74656e7469616c2070726f6669742220747970653d226c6f6e6722202f3e0a202020202020202020203c61637469766974693a666f726d50726f70657274792069643d2264657461696c7322206e616d653d2244657461696c732220747970653d22737472696e67222f3e0a20202020202020203c2f657874656e73696f6e456c656d656e74733e0a2020202020203c2f757365725461736b3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d2270726f766964654e657753616c65734c65616422207461726765745265663d2272657669657753616c65734c65616453756250726f63657373222f3e0a2020202020200a2020202020203c73756250726f636573732069643d2272657669657753616c65734c65616453756250726f6365737322206e616d653d225265766965772073616c6573206c656164223e0a2020202020202020200a2020202020202020203c73746172744576656e742069643d2273756250726f63657373537461727422202f3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77332220736f757263655265663d2273756250726f63657373537461727422207461726765745265663d22666f726b222f3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d22666f726b22207461726765745265663d2272657669657750726f6669746162696c697479222f3e0a2020202020202020200a2020202020202020203c706172616c6c656c476174657761792069643d22666f726b22202f3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77352220736f757263655265663d22666f726b22207461726765745265663d22726576696577437573746f6d6572526174696e67222f3e0a2020202020202020200a2020202020202020203c757365725461736b2069643d22726576696577437573746f6d6572526174696e6722206e616d653d2252657669657720637573746f6d657220726174696e67222061637469766974693a63616e64696461746547726f7570733d226163636f756e74616e637922202f3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77362220736f757263655265663d22726576696577437573746f6d6572526174696e6722207461726765745265663d2273756250726f63657373456e6431222f3e0a2020202020202020200a2020202020202020203c656e644576656e742069643d2273756250726f63657373456e643122202f3e0a2020202020202020200a2020202020202020203c757365725461736b2069643d2272657669657750726f6669746162696c69747922206e616d653d225265766965772070726f6669746162696c697479222061637469766974693a63616e64696461746547726f7570733d226d616e6167656d656e74223e0a20202020202020202020203c646f63756d656e746174696f6e3e0a20202020202020202020202020247b696e69746961746f727d20686173207075626c69736865642061206e65772073616c6573206c6561643a20247b637573746f6d65724e616d657d2e2044657461696c733a20247b64657461696c737d0a20202020202020202020203c2f646f63756d656e746174696f6e3e200a2020202020202020202020203c657874656e73696f6e456c656d656e74733e0a09090920202020202020203c61637469766974693a666f726d50726f70657274792069643d226e6f74456e6f756768496e666f726d6174696f6e22206e616d653d22446f20796f752062656c69657665207468697320637573746f6d65722069732070726f66697461626c653f2220747970653d22656e756d222072657175697265643d2274727565223e0a090909202020202020202020203c61637469766974693a76616c75652069643d2266616c736522206e616d653d2259657322202f3e0a090909202020202020202020203c61637469766974693a76616c75652069643d227472756522206e616d653d224e6f20283d2072657175657374206d6f726520696e666f2922202f3e0a09090920202020202020203c2f61637469766974693a666f726d50726f70657274793e0a0909092020202020203c2f657874656e73696f6e456c656d656e74733e0a2020202020202020203c2f757365725461736b3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77372220736f757263655265663d2272657669657750726f6669746162696c69747922207461726765745265663d22656e6f756768496e666f726d6174696f6e436865636b222f3e0a2020202020202020200a2020202020202020203c6578636c7573697665476174657761792069643d22656e6f756768496e666f726d6174696f6e436865636b22206e616d653d22456e6f75676820696e666f726d6174696f6e3f22202f3e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77382220736f757263655265663d22656e6f756768496e666f726d6174696f6e436865636b22207461726765745265663d226e6f74456e6f756768496e666f726d6174696f6e456e64223e0a20202020202020202020203c636f6e646974696f6e45787072657373696f6e3e247b6e6f74456e6f756768496e666f726d6174696f6e203d3d202774727565277d3c2f636f6e646974696f6e45787072657373696f6e3e0a2020202020202020203c2f73657175656e6365466c6f773e0a2020202020202020203c73657175656e6365466c6f772069643d22666c6f77392220736f757263655265663d22656e6f756768496e666f726d6174696f6e436865636b22207461726765745265663d2273756250726f63657373456e6432223e0a20202020202020202020203c636f6e646974696f6e45787072657373696f6e3e247b6e6f74456e6f756768496e666f726d6174696f6e203d3d202766616c7365277d3c2f636f6e646974696f6e45787072657373696f6e3e0a2020202020202020203c2f73657175656e6365466c6f773e0a2020202020202020200a2020202020202020203c656e644576656e742069643d2273756250726f63657373456e643222202f3e0a2020202020202020203c656e644576656e742069643d226e6f74456e6f756768496e666f726d6174696f6e456e64223e0a2020202020202020202020203c6572726f724576656e74446566696e6974696f6e206572726f725265663d226e6f74456e6f756768496e666f4572726f7222202f3e0a2020202020202020203c2f656e644576656e743e0a2020202020202020200a2020202020203c2f73756250726f636573733e0a2020202020203c73657175656e6365466c6f772069643d22666c6f7731302220736f757263655265663d2272657669657753616c65734c65616453756250726f6365737322207461726765745265663d2273746f72654c656164496e43726d53797374656d222f3e0a2020202020200a2020202020203c626f756e646172794576656e74206174746163686564546f5265663d2272657669657753616c65734c65616453756250726f63657373222063616e63656c41637469766974793d2274727565222069643d2263617463684e6f74456e6f756768496e666f726d6174696f6e4572726f7222203e0a2020202020202020203c6572726f724576656e74446566696e6974696f6e206572726f725265663d226e6f74456e6f756768496e666f4572726f7222202f3e0a2020202020203c2f626f756e646172794576656e743e0a2020202020203c73657175656e6365466c6f772069643d22666c6f7731312220736f757263655265663d2263617463684e6f74456e6f756768496e666f726d6174696f6e4572726f7222207461726765745265663d2270726f766964654164646974696f6e616c44657461696c73222f3e0a2020202020200a2020202020203c757365725461736b2069643d2270726f766964654164646974696f6e616c44657461696c7322206e616d653d2250726f76696465206164646974696f6e616c2064657461696c73222061637469766974693a61737369676e65653d22247b696e69746961746f727d223e0a20202020202020203c646f63756d656e746174696f6e3e50726f76696465206164646974696f6e616c2064657461696c7320666f7220247b637573746f6d65724e616d657d2e3c2f646f63756d656e746174696f6e3e0a20202020202020203c657874656e73696f6e456c656d656e74733e0a202020202020202020203c61637469766974693a666f726d50726f70657274792069643d2264657461696c7322206e616d653d224164646974696f6e616c2064657461696c732220747970653d22737472696e67222072657175697265643d2274727565222f3e0a20202020202020203c2f657874656e73696f6e456c656d656e74733e0a2020202020203c2f757365725461736b3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f7731322220736f757263655265663d2270726f766964654164646974696f6e616c44657461696c7322207461726765745265663d2272657669657753616c65734c65616453756250726f63657373222f3e0a2020202020200a2020202020203c7461736b2069643d2273746f72654c656164496e43726d53797374656d22206e616d653d2253746f7265206c65616420696e2043524d2073797374656d22202f3e0a2020202020203c73657175656e6365466c6f772069643d22666c6f7731332220736f757263655265663d2273746f72654c656164496e43726d53797374656d22207461726765745265663d2270726f63657373456e64222f3e0a2020202020200a2020202020203c656e644576656e742069643d2270726f63657373456e6422202f3e0a2020202020200a2020203c2f70726f636573733e0a2020200a2020203c62706d6e64693a42504d4e4469616772616d2069643d227369642d36323861386432632d303030392d346461302d396332612d343132636637363031356138223e0a2020202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d2272657669657753616c65644c656164222069643d227369642d35636232663863332d333838392d346131322d386135622d623866393035353136393565223e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227468655374617274222069643d2274686553746172745f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d2237352e302220793d223330302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2270726f766964654e657753616c65734c656164222069643d2270726f766964654e657753616c65734c6561645f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223136352e302220793d223237352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2272657669657753616c65734c65616453756250726f63657373222069643d2272657669657753616c65734c65616453756250726f636573735f67756922206973457870616e6465643d2274727565223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d223332302e30222077696474683d223534342e302220783d223331352e302220793d223136302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273756250726f636573735374617274222069643d2273756250726f6365737353746172745f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223336302e302220793d223330302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22666f726b222069643d22666f726b5f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223433352e302220793d223239352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22726576696577437573746f6d6572526174696e67222069643d22726576696577437573746f6d6572526174696e675f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223531372e302220793d223231302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273756250726f63657373456e6431222069643d2273756250726f63657373456e64315f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223637302e302220793d223233362e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2272657669657750726f6669746162696c697479222069643d2272657669657750726f6669746162696c6974795f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223531372e302220793d223336302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22656e6f756768496e666f726d6174696f6e436865636b222069643d22656e6f756768496e666f726d6174696f6e436865636b5f677569222069734d61726b657256697369626c653d2274727565223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223636342e302220793d223338302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273756250726f63657373456e6432222069643d2273756250726f63657373456e64325f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223736352e302220793d223338362e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d226e6f74456e6f756768496e666f726d6174696f6e456e64222069643d226e6f74456e6f756768496e666f726d6174696f6e456e645f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223736352e302220793d223334352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2270726f766964654164646974696f6e616c44657461696c73222069643d2270726f766964654164646974696f6e616c44657461696c735f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223636302e302220793d223532352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2263617463684e6f74456e6f756768496e666f726d6174696f6e4572726f72222069643d2263617463684e6f74456e6f756768496e666f726d6174696f6e4572726f725f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223738332e383632303638393636303331312220793d223436352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273746f72654c656164496e43726d53797374656d222069643d2273746f72654c656164496e43726d53797374656d5f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223931302e302220793d223237352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2270726f63657373456e64222069643d2270726f63657373456e645f677569223e0a2020202020202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d22313035302e302220793d223330312e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f773132222069643d22666c6f7731325f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223636302e302220793d223536352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223538372e302220793d223536352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223538372e302220793d223438302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7739222069643d22666c6f77395f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223730342e302220793d223430302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223736352e302220793d223430302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7737222069643d22666c6f77375f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223631372e302220793d223430302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223636342e302220793d223430302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7738222069643d22666c6f77385f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223638342e302220793d223338302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223638342e352220793d223335392e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223736352e302220793d223335392e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7733222069643d22666c6f77335f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223339302e302220793d223331352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223433352e302220793d223331352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7734222069643d22666c6f77345f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223435352e302220793d223333352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223435352e352220793d223430302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223531372e302220793d223430302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7736222069643d22666c6f77365f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223631372e302220793d223235302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223637302e302220793d223235302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7731222069643d22666c6f77315f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223130352e302220793d223331352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223136352e302220793d223331352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f773130222069643d22666c6f7731305f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223835392e302220793d223331372e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223931302e302220793d223331352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f773131222069643d22666c6f7731315f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223739382e302220793d223439352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223739382e383632303638393636303331312220793d223536352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223736302e302220793d223536352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7732222069643d22666c6f77325f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223236352e302220793d223331352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223239302e302220793d223331352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223331352e302220793d223331362e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f773133222069643d22666c6f7731335f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d22313031302e302220793d223331352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d22313035302e302220793d223331352e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7735222069643d22666c6f77355f677569223e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223435352e302220793d223239352e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223435352e352220793d223235302e30222f3e0a2020202020202020202020203c6f6d6764693a776179706f696e7420783d223531372e302220793d223235302e30222f3e0a2020202020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c2f62706d6e64693a42504d4e506c616e653e0a2020203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e0a', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71274341-1737-11ea-ac1a-7c7a916bf543', 1, 'FixSystemFailureProcess.png', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x89504e470d0a1a0a0000000d49484452000002d3000001a0080600000068aaebc3000000206348524d00007a26000080840000fa00000080e8000075300000ea6000003a98000017709cba513c0000000467414d410000b18e7cfb5193000000017352474200aece1ce900000006624b474400ff00ff00ffa0bda793000000097048597300000ec400000ec401952b0e1b000020004944415478daec9d077814e5f687cf9200a18b86ae94a818213443952010420f354850fac5f8bf4044b9d204225d100b88414108103a4a09101104042fe8a56a2842448108095254403152b3ffef7cd9dd6cdaeeccee6ccdef7d9e797677765a26b333ef9c39dff988000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c800ebbc0bdd1ebf57e1f7df451f4c18307fb2527273f75fcf871bfdbb76f63c700008087e1e3e3a3af5ebdfaef152b563c74f9f2e577cf9e3dbb077b0500c8347020717171ff5eb972e57be7cf9f2f3e64c8100a0909a1a64d9b929f9f1f760e000078181c08494a4aa2fdfbf7d3e2c58beffef5d75fa72f5dbad44f7c75127b0700c834d01871a24d98387162b7b163c752747434f9fafa62a700008017111b1b4b313131ffdcbd7bf785f4f4f4cdd8230078263ed805ee29d2b366cdeab66edd3aead5ab17152a54083b050000bc8cc68d1b53787878e1d5ab577716327d428c3a83bd0200641ad809a7764c9c38f17516694ee9000000e0bd942f5f9e3a75ea5474d9b2659deedfbfffb91875157b0500c834b0116e6cf8faebafef1e326448618e480300002818425db468d1f43d7bf63c939191118f3d02806781fc013782ab76706343ce91060000507018356ad4c3a54b977e52bcc523490020d3c056b8fc1d57ed40634300002878f4eddbf7b27889c09e0000320d6c84eb4873f93b000000058f5ebd7a55112fadb02700f02c10027523b84316343a0400808249e3c68d2b899772d813007816884cbb115cd01f1db2000040c1c470fe47900b00c834000000000000906900000000000000641a000000000000c8340000000000006e031a3a0000f22529e93bdab06123edddbb978e1c392a1bc9023b4fbabe3e54bf7e10b56af51c4544f4a1a64d9fc54e010000c83400c09b484e3e4d23478ee4dae73464c8bf68dab42942fa9a58a836a3cfe3bda571b64ce31daf7c439294944cfbf71fa5a8a84154b1e2a33467ce3c0a0a0ac28107000090690080a7b36bd797d4bfff401a3b76346ddd9a40bebe852d4c6d14455d1eef75396439afeff29ac6bbf1f32b2a6e4cea89a12e8d1a359862635751dbb66d68d1a2c5141ede050720000040a601009e2cd243870ea34d9bd693b20e847466526d49a89548b3d6829ddf72dc4be0a3a35fa456ad1a51972ec3e5b6858787e3400400000f020d100100124eede088f48a15f139445a6761c829d53a0bc29ddfb43a2ba2ae747ea5cb2385d33b8fa0a02769ebd6791415f5129d3c7912072300007810884c0300249c23cda91d798b7476121313293e7e39fdf6db352a59b2a4ccabeedebd1b598e46db1b11b6757eb5f3b926721d14f4044d98f0b2f83fbc463b77eec2010900001e0222d3000059b5831b1b46470fcb47a4b3a2d193274f91227df1e24559e1e3f8f113347dfa0c9a38f14d0fdf0bae8f504747f7a6cb972fd181030770500200808780c834004096bfe3e872de8d0db3249323d2870e1da29d3b77d2fdfbf7e5b85bb76ed1850b17e8b7df7ea33a75822832f2792a880d0bb562e0c008f1ffd8a030671d000080ab41641a0020eb48878434cf53a0cd898f8fa763c78e9944da9cd4d434218283f359830e3b5921212175e4ff030000806780c8340040a66b701de92cf4790af0e5cb97e9d2a54b54a142050a0c0ca42b97af905f313fd267e829bc4bb894edbc41945a29f5eb07505252127604000040a601009e02772492d9214b5e129d354e4af45381b47af56a0a0808c8b59c2c99863cdb0ad7a1ce2bf20f0000c03d419a0700201ff494bdf73e3d0d1a34504a77993265724dbd6bf72e0a0e7ec6c3ff5e00000000320d00b04b26f5790875e6101ede996a07d5a2d036a174fbceed6c738f1e3d9a962d8bcb67395ac8aade49f341aa01000040a601001a0bf58d1bd769e6cc59f4c30fa7286e711cf915f5cb36e7638f3d26be9f4d172fa65a9153bd857559db164bf32b5d1e299c1e000000804c0300ec12eaccf74b97c65344446f7af2a94099e251b972e55c73d5ae5d9baa55ab41917dfa51dc92781b84556bb9d5ab1cef4efb1e000080a780068800003391d3657bcf35a4870e1d4e018f3f491b133693afaf2f55a9f2280d193284ba76ed4a75ead491539f3b774e76fa326acc58eadbbf3f4d18ff06c5ce5f48d1c35fb622cc7aec730000001e0d22d300801c72972978292929141ede8dfaf51f4463c68e9322cdd4ad5b97d66fda44152a57a223478fd2814307a952e5cab472f51a59ed83a77b7bf63b74f4c8f7b476dd4685e2ac57f9ea6ae9559a32a2f4ef8054030080a782c83400c04ce8b222d31d3b86cb6874d5aad5724dc9a91ebd7b475a5cdadc79f3a84b7867ea13d98372e760db2b905acbb75a39b626c190630000282820320d00c8218199221814549b7c7c6cbfdf3646b2ad8bb433a2d18810030000804c03009c24d2fc5aaf5e1d3a7ce890e9db952b56285a4afed32911692d8418000000804c03005c2cd50d1b3e43274e1c378d5db56aa5a2b9734fa7b722d25a09b3adf3aa2ddd077907000000990600e423d1461a360ca6ef8e7ea7f1f22dbd5722c1f644a5ed95645beb5ddbfa0a0000c01340034400409e92e8efff309d3af50375ead85e7ebe7ae58ae9bd25cca73b77eeac1569b545a06d116500000000320d00708244679259d52335f5271be7b7f6596da3445bc5596d1418520e000000320d00b059a6751a48a4deca385b44da5929205a4bb956eb070000009906007888509ba3b34304d546a6d5c8b51692ed888685b6e65543aa010000320d00f00291d6692077b6f416a8955cab99462b0106000000990600008ba2a85331ad12a9d652a4b5884edb73d300e9060000c8340000e4d10051b9385b93586be2ac954893c2ef6c15647bf62b4ae3010000641a00e0e532ed8c068896a45aeb28b53d52ab468c4983fd060000c01341a72d00801c32987350377d54d4083a7cf8bb7c96a177824867316cd838b12d49e4984e5e94dc2ca82dc507000000320d00f00291b626d8f94f97909048696997ac2c376717e34ade5b16e9d8d82574f0e077d9be6fdebc11952fff888265e42fb5b1b1cbc572931408b016a5f820d50000e06920cd0300e000a9cb12e12d5bbea0e0e0fa74e9d2af424a8f50a346cf509326c1f4e5975f51edda8154a54a25d33cebd66da2e79fef46850a65a69b24267e29e6394a1d3a840a316e2ca7f9fdf7ebb47dfb6ef91a1c5c570a33479f972c59433fff7c9e52522e52646417397fa95225c8d737eb34b76ddb57629a147aeeb9c6f4d75fb7a86ad52a54ad5a65f91d8f3f78f07bba79f32f6ad0a016356bf68c58ee31b1dccfc477bf88e5a68ae576362d2b31718f98fe98d8b616621b9eb149d4010000783e884c03007208b0d2540f65d30e1dfa1f99fa317efc54faf5d72bd4a245273a73e66721b63be99d773e34cdf7f5d7dfd2dcb90b4d221d1d3d8e962f5f47b56ad5a40103860b29df2ec7b76edd8392937fa672e51e11cb392bc7ddbaf537ddbd7b4f0af2efbfff61b6ee374c691e51516368c68c7962be8769f1e235d4bbf730faef7f0f9aa61d3f7e36fdfdf73f42be7da86ddb0152a46fdd4a372cf76fb1dc1ba6bf2f3a7ab2d8b604b16d8f8b6d1b23b66db70d372a906e0000f006109906c00b983e7d3a05050551787878b648ac7a99d6591140b5629e494040758a8d7d5bbedfbb773f1d3b7692fef5af17a94d9b9ef4fefbd3844017a24f3e89a7975eea27a739772e4508ef0a4a4fbf6092ebe5cb3fa5ae5ddbd1a9536768e1c277a859b360d3f25bb77e96aa577f8cdab56b4991915d736d33479d972efd54c8fc1129e12fbcd055ace3423681fdf4d3f9a6f7dbb6ed15a27e9efaf6ed2696fba8586e88586e27c3b65d10dbf699d8b6e366db9620b62d14820c00009069008027121313235f8b172f2ea4ae2b0d1c3890424242a864c9923648b056642d2b2caca5e97dd9b2652823e301d5ad5b9baa54a94889893b640ac7d6ad3b282e6eae9cefe4c9d374e7ce5daa50a1969c87df57ac585ebeffe8a359429e7b52a74e6d68d6ac8954b3668d3cb63dfbdf71f2e48f54ba744929d2c6ef58e0cda73d7e3c99e6cf5f4ed7afdfa4a3474f504444fb3cf7c7c993670cdbd6cc6cdbfc55ee134837000040a601006e477a7a3aad5dbb560ea54b979691eafefdfb53ab56adc8cfcf4fa548eb54ac5969d58fece3060d7a81962c594de7cefd420306f416db58547e53a448612a53a6345dbb763a9724bffc723fead6ad3dbdfd762c356dda895253bf1337117e16849597e72bd335ccbf630936929c7c96dab6ed473b76c453fdfa4f53cf9e43f395e0cc6d2b25b6ed00041900000072a601f056fefcf34f5abd7a3575ecd891ca962d2b647500252424d0fdfbf75508b2d2c1d2bcf94b77dfbe11b231e18205cb0c291e99f384853d47254a14a7f8f875d9e6cdc8c890f9d1152af8d3ac5913644ef3850ba99927b34285ccf2a5b30b7858580b2a56cc8fa64d9b2773a8274c784746ab8d691a274e2453a54ae5a548dfbe7d87d2d2ae98f6134f639e2f1d16d65c6c5b31b16d9b489b1ad5906e0000f064109906a00070fbf66d5ab162851c4a952a456ddbb6a5a8a8a81c116b47ca5cdea5f138eda25dbbd6949a7a49886cedac1393af0f6dd9b25cc8f65021daf154b26409f2f77f586cff8754a346636ad4a8beacda111d3d8802039f90cbe25c696e70b86bd73edab87151b6b573647adbb6651413f32e6dd8b08d468e7c898283eb88f145e4bca1a1cd8460bf4bb56ab517371ea565758ea95363a96edda764058fa143df14cbfd462c77bed8b64262db16886d7b5d6cdb1ac3b63d446bd6bca7429caded2b0000009e820ebbc0add00bb0173c8c9494145ab66c994bb761ca942936cffbf8e38fd3d9b367c5c1774d83d3825ee5777aab9fd3d3ff918d2a59888d703a4be6b8c2d9e6b97bf7ae419e0b5b14598e3a57a9d244c8f10221cec1d9d6654c19e108b59f5f911ccbf5cdb16db7a55c5b5b9f9aa8744a4a9ab86108a7499326b9f4981a34681055af5e1d3f70675f94753a5c9b01f030109906c04e58a4ed915957c322ad5c881d25d6f97fce9e0f9df95df1e2c5f294d12ca9cd2dab3131efc9efab56ad4c8b17afa5060d6a6713e99ceb328ab4314f3aaff5152f5e54c5dfaa2c1564d9b2ad76df2069c5e4c993f103070000c83400cec355d14425e2c539c53ce4cc990e0808a073e7ce59903c9d8dc29cc59e3dfb65bde80a15ca5999d79264e7fd9e73a02b57ae202b83588a0a73393cce8de6868831312364b9bbfc25574d7499accca74eb2070dea22fe9f0bddfa58020000009906c02122edaa485e7e02c4f2ece3e343f7eedd938df77878e8a187282c2c8cfaf6ed4b1d3a749039d38647cb7609b3a579faf51b46f3e7cfa2eedd3b285cbe5eb1604f993247f678d8bf7f4f8bf3d6aaf5841c6c136235d3db96de61a47af5cc1e215d19158650030000641a80020bcb73e1c28565a343a34073bd6916e7c8c84829d22cd4da48b31aa9569edaa144a295bfb7655a4744a9d5a482000000804c03005cc283070fe4c002ddab572feadcb9b3ac37adbece34a3a41d9472013c7cf87b3a78f03b598da34993674cf3730f853cfee6cd3fa94183a06cbd1b6ed9b2838283ebca140d2e53d7aedd7362dc4e59cde3b9e71a9b6d835e8e6fd4a8ae2c73c77cf6d9e71412d2d0f099bfdf25f645a8ecc5f0e0c124b1bebfc4fa6a89f53530fd1ddc357870706db1be1f0deb0b91df2526ee15f31c13372521b2da87ed020d710600006f0275a601f02238e2dcbd7b77dab469135dbc7891962e5d2a85daba485b1265b535a6f39a97e8934f56d0f8f133e9d75faf528b16dde9cc99b3a6ef78fcdf7fff2d4be2b56ddb47e6411be7e572777dfa0ca5254bd68a79afd088116fd29c398b64ade90f3e58227b2b34b266cd66f1b7ef90efcf9c3947bd7b0fa755ab36cbe5f07a5f7d75aa14e4f1e3df15eb4b37ac6f8058df31d332b80c5e9f3eaf89f5ad17f3645638898e9e26bb0caf55eb711a30609c10eeaf54cab12da9200000003c0144a601f002a64d9b26cb98d92fce8e424f0101d528367686fcb477ef3774ecd80fa6aec03ffd748169ca6ddbbe9222dca8513dd336858636a729535ea7b4b45f69c890d142728f50b9720f5364643875ea34d0b48e0e1d5ac93ad2c386f5a3c4c4ddb283951d3bbea651a35ea2cd9b77528f1eed0ceb9b67b6bebd627d29627d754ce342439b8af58d90ef398abd78f167949efebda90bf2e5cb3753d7aead3590638834000040a601002e67e2c4899a08af36e56df31642ee85d0f87dd9b265642eb791e3c74fd1fcf9cbe8faf59b74f4e8718a88e8986d395cc68e3f7314ba74e99252a48d640a6ee6b41d3a3c47515163e9fefd07b475eb6e8a8b9b4541411d64059375eb1269d6ac3172dae3c793c5fa561ad67752acaf5db66de5d40fe3b69e3cf993ec7abc4285ccea1ffcbe62457f1b441ae20c00009069008097a377e0f2f2ee053139f9676adbf605dab16315d5af5f8b7af68cb2b03d7ab3d27eb9bfe3d48fa0a0a784386f95a21c105055d6926691fef9e75fa849937a627d67c5fa068af52d95dd87f7ec39ccc2f66676d452a64c29ba76ed5bb23d171a39d40000e0ad20671a0090437695e6445b9a474f7957e3c83dfec489d3b281208b34f73a989676d920ccb9c59b533fb8d7c16fbe392cc7eedab59f0e1efc3edb741d3bb6a471e3dea66eddc2e4e7f6ed5b88cfb32922a283617d3f8af5959322cd154fd2d2aec848767e51e4b0b067a9448962141fbf295fe146941a00000a2e884c0300cc844e97cf78b5cb51fabd5ee6434f98309b6ad56a2dd33f9a376f4853a7cea5ba75032938b84eb6695982df7f7f22b56edd874a962c21c4b9153569d220db72dbb56b416fbdf591acdac170def4e8d1b3844cb737acaf9958dffb627d1d0ceb0b16eb8b15eb7b4aacaf56aeede4468a5bb6cca7be7dc7d08205ebc47a8b93bf7f595ab366b60a59b6b47f20d20000009906007891506bbfbcb4b423d93e27262e337d7ee49187e8cc99af293dfd1f5377de6fbd3586fcfc8a1ae63d986d8923460ca27fffbbafccb9ce9c26bbc4b66cd998f47a63a510bd8c40ebf53f99a678e49132627d5fe658df4853f7e16969ffcdb54c2e95979c9c28a3e22cd79cfa615d96d5d4bc0600000099060078b1486b11b1b62c9f46b16532c536ff086e912285297bca88fa0e5e72afcfbaf866ce636f0f89d6a6070000009906001420d1b6651ebdc2f1f675356e7d3a2d7b52b447ae01000040a601000550989d25d56a245aad243b43a4d1e010000020d30080022ad33a0d055cad58ebedf86c8f603b52ae21d200000099060040b2ed9ecfd6a8b423251a220d000000320d0070aa343b4aacb5946aad04db1eb98648030000641a005080645a67c7bcb64eef4ca97666941a220d00009069004001976b472c47cb540f4b72eb2c798648030000641a00007976c9f21d1195b6459ced95678834000040a601000558a6751a2cc39e691d9dea618b60dbdb1011000000641a0050c0a4da99cbd3ab98cf11916935920c9106000000990600385ca26d598f563d23da22d11069000000906900804789b9333b71b157b06dc9bd0600000099060040809db27c4775e262ab54231a0d000000320d00b04b767536ce678f5c3b4baab54a038148030000641a000034156535cbb037d5c31e89b645b091d601000000320d007088383b4aac5dd5894b7edf41a201000040a60100794aa3b3ea4c5b9bded99db828156c8834000000c83400403321d66a99eed8898bf9674834000000c83400200ffcfc8ad2eddbb7e5abeb85dd55a91e96a6759e48dfbead275f5f9c9a8117dea6ebf57e1f7d342ffae0c1c3fd92937f7ceaf8f1137e7cde01f6e1e3e3a3af5ebdf2ef152bfa1fba7cf98f77cf9efd650ff60a641a00e0641a36ac47070e1ca356ad1a3b4196ed91675ba5dafd25da4852d245aa5fbf3e0e4ae055c4c57df2efd0d056ef9d3f9f527cc8907fd1e0c183a869d326e206de4fc1ef5caf609c2dd378c7abb821d1252525fbefdf7fb4d3e2c51bc22a572e7ffad2a5abfdc4572771e441a601004ea255ab96244ec4e2b59103d7e26e553d2c7d765d4ac7fefd27c4ffa1150e4ae0352c5efc49c284096f761b3b763445470f235fdfc20a7eebba3cdeebf2f86de6fc4e47052d258b9f28366d5a4f0c7569d4a8c145626357d58b899977e8eeddbb2fa4a7dfdd8c23d0f114c22e00004444bc4071711be8fefdfb860b51ce21bf8b9e9ac1dabc96becf6bbc9271b67c76e585b808c5c77f26fe1f11382881d788f4ac596f77dbb4693dbdf6daab5644da28c73ab3f794e37d5edf595a96d26949c5f2948e770dd1d12fd2be7d2b8a152f5e6285f8188ea310320d007002f5eb37a0c0c0a7293676950a71b68652b1562acf6aa55aad642bfdbb1c476cec76aa58b122356dda140725f07838b563e2c437bbad58119fe398d659189488b0ce8a345b935ea5f32b5d9ea3e4dd7682829ea43d7b96942a56ac280b75108e46c83400c009cc99f321bdfdf6523a702089d4479ded8d665b9367a5024d56e6754f89664e9efc9d66cc785ffc1fe6e060041e0f37365cb972d57b9cdaa144a413133fa7e79f8fa4d6addb50972edd282161b302a9b5575a754e9acf35721d14f4044d9d1a9de1ebeb3b0f4724641a00e00402030369c58a55d4bfff04d918d186cb27b967aa87deca67d7c322dda3c7705ab46891b8002288043c1faedac18d0d39473ab7486797eac993a7507cfc72ba78f1221d3972948e1f3f41d3a7cfa08913dff4f0bde0fa08f5a851831e2e5dbac493e22d1e7741a60100ce202c2c8c3efe781175e93282e6ce5d6d21875a8bbc6a6bd39206024da42c72ed2a8a506cec57d4b6ed4019910e0f477a23f00e0e1e3cd28fab76e49d239d259989898974e8d0214a484810f31ca45bb76ed1850b17e8e8d1ef68e5ca95b46edd676e23a69e4adfbe9d2f8b1734c47020a8e60100c825d4fbf6eda7912347d2071faca42143222924a40e356dfab44675a8b5eec085487d7d69d7c175a4b9fc1d57ede0c6869c23bd73e74e44a48157919c9cfcd4e0c103f3146873e2e3e3e9d8b163861bf7eca4a6a6d1c081832932f2f97c841c1d2929a157afb6553efc70752bec09c83400c08970cac7175f7c21a42f89366cd84031319fd0912347081d2c6870d2f5f59575a4b9fc1da775a0b121f046b84316ae239dfd8636b7505fbe7c992e5dba44152a5490e79d2b97af905f313fd267e829bc4bb8946ddb6fca01d3b8715025f1520e7b02320d0070012c7de840c47b99356b16bdf1c61b797e3765ca1439983369d2249a3c7932761cb04a668faa7ef94874d63829d14f05d2ead5ab29202020d772b2641af26c2b86278af03d07829c69000028c0374b6a78e28927b0d3801de46e003c68d04029dd65ca94c935f5aeddbb2838f8190fff7b01641a000080d7d2a14307f2f7f75734ed430f3d44bd7af5c24e0336c864fee52fc3c33b53eda05a14da26946edfc99e46367af4685ab62c8ef2ef5049afd1f6397a3e4835641a000080d7d2bd7b7745d3718e77e6637b00b411ea1b37aed3cc99b3e8871f4e51dce238f22b9afdf87aecb1c7c4f7b3e9e2c5542b72aab7b02e6bdb62697ea5cb2385d303c834000000af23323252d17443860cc1ce021a0875e6fba54be32922a2373df954a04cf1a85cb972aeb96ad7ae4dd5aad5a0c83efd286e49bc0dc2aab5dcaaad32e44efb1e381224a4030040012624244496e7e3aa0af951b26449391d00ea454e97ed3dd7911e3a7438053cfe246d4cd82cabdb54a9f2a8bc59ebdab52bd5a953474e7deedc392eaf47a3c68ca5befdfbd384f16f50ecfc85143dfc652bc2acc73e074e079169000028c070ea06e74e5b8273a539671a00dbe42e53f0525252283cbc1bf5eb3f88c68c1d27459aa95bb72eaddfb4892a54ae44478e1ea503870e52a5ca9569e5ea35b2da074ff7f6ec77e8e891ef69edba8d0ac559aff2d5d5d2ab346544e9df01a97626884c0300400167e0c081b46cd9b27cbfefdcb9337612b05118b322d31d3b86cb6874d5aad5724dc9a91ebd7b5b4e399a3b6f1e7509ef4c7d227b50de9d32e9eddc562de55bad1c5b9360c8b13b83c83400001470388523bfc833a778a09b73609fa4668a6050506df2f1b13d86678c645b17696744a311210690690000006692d2af5fbf3cbfe3141054f100f68a34bfd6ab57870e1f3a64fa76e58a158a9692ff744a445a0b210600320d0000c00aeddbb7cf73bcd26a1f005893ea860d9fa113278e9bc6ae5ab552d1dcb9a7d35b1169ad84d9d679d596ee83bc43a6010000783c1c817ef4d147b38de3d48fb0b030ec1c6097441b69d83098be3bfa9dc6cbb7f45e8904db1395b657926dad776deb2b7014688008000040a67ab0389b3744e4cfa8e201b4925e7fff87e9d4a91fa853c7cca72057af5c31bdb784f974e7ce9db522adb608b42da20c00641a0000400e7256f5e8dbb72f760ab05ba233c9acea919afa938df35bfbacb651a2ade2ac360a0c29874c0300002830346dda34db676bf5a701b02ec33a0d24526f659c2d22edac1410ada55cabf503af9469bd5eefb773e7ce81dbb66d7bf1cc9933f54f9f3e5dfcdab56bbedc5b52d1a245f5fefefef7aa54a99256ae5cb96f1f3c78306dfbf6ed3fe2df070000dac1553b02030365cf73d5ab5747150fa091509ba3b34304d546a6d5c8b51692ed888685b6e6557bbc5473038eee62682986fa62a828869262b82d06eeae35490cdf8861ad18520bbc4cb3444f9d3af593d0d0d0172e5ebce8dbaa552b1a3c7830050505c9c6305ce35408b5eeb7df7e2b72f2e4c91abb77efaeb175ebd6176bd6ac79e18f3ffe982ec62fc6c90a0000b461e8d0a1f4eaabaf527474347606d04004751ac89d2dbd056a25d76aa6d14a800b342cd0c30b152af45c46464691bceef9c550dd30f0b4ef8861af18e2c4b0d2551bed52995ebf7efdbfc2c2c23eba72e54ad1993367ca478a5945d9b360a1e6812325dc79c09c397374dbb76faf3661c2840562fad72f5fbedc454cf6338e41e00a6ad4a891ed15004f65d7ae5d3469d2247aedb5d768faf4e9f4d4534fa1c316a08150e7854ec5b44aa45a4b91d6223a6dcf4d438194eeea3a9d6e815eaf972d4d8548ab99b79561f83f310c76850fba44a6c5cef29d3d7bf697d1d1d1ad5f7ffd7579e2ce4ba2e0ce04aa00002000494441542dc1e22d069fd8d8d8c0989898e362fe1188520357c8071fbfc6e191471e817c008f3d969f7ffe795ab162853c86b9ee74fffefd69e9d2a538a68106226d4b845aaf609c5ee5775aa6806821c8f6ec57af298dd7c7c7c7e7a3070f1e9435c9a9a1ba504444846ccb51b16245f2f7f7a71b376ed0e5cb9729292989366cd84089898974fbf66de36c2162f85e0c43c9c9516aa7cb348bf4b265cbbefdf8e38f1b6ddab429578317b5f0a3c8909090621d3b769c57b66cd9a2d7af5f9f8f1318807c0060fbb16c0c58ac59b326d77800d4499f331a205a926aada3d4f648ad1a31260df69b4710aed3e9560a91f6314a3407a6860f1f2eb31172c2a53a79e0b61d7dfaf49162fdde7befd1dcb973e9fefdfb3c09e7557397999c0ee2b400ab8fb3f75af1e2c577bdfbeebbcdf7ecd923f3a2b580ef587af5ea55382e2eeeb9f4f4f48b62d4710f3da8260b70fef550f978e28927e899679ea1175e78411edb356bd6c48e026ecff6eddb652f87790973404000d5af5f5f96c8e3573ec681639932658a7cf1823f455ccedec8e72b9d4a717694542b1da7467e95dc14e86df85b6d2dc5673cae16b8e371d54788f4a77abd5eba280bf2eeddbba95fbf7e8aebdb730a70bb76eda867cf9eb46fdf3eba7af5aaf1abae6238eb2c1f74aa4c738ef49b6fbef9ea679f7da699489bdfadb46ddbb6c8f2e5cb43c5ddc96631ea37c8b4b6a4a6a692d8bff4ce3befd08409134cc3db6fbf4de24686befefa6b394dd5aa55a974e9d2900fc807f08063996ffe3802dda953a73ca7e163b861c386f298c74d22645addf56c9c4281562bd6b694cab355ae958aac96dd96938a7995ed2b3794e9ea3e3e3e5b3232328af387909010dab163479ed16825942f5f9e5e7cf1453a7af4289d3b77ce38ba9d183639c3079d26d35cb563d8b061fb070d1ae4d3bb776f87ac8323d4254a94d07ff5d5574dc53f280e32ad0d090909f4ca2bafd0071f7c40c58a15a36eddbac9c73053a74ea5b7de7a4bbee7ff29575f3976ec98146c4ee1e1c73575ebd6857c403e801bc24f57f818e563d95a3d69be49e4639a8f7ddc2442a66d9369bb2d42c138ada3d44ae558eb9ad5b646a52d1d57ee25d33a9d6ebdf0b45afc9e23d22cd29c136d0f5ccab36bd7aef4f9e79f1b23d45c0d84cbea2d75f4dfe3b49ce9e9d3a7c7fdfefbef451c5d6e49885db177df7db7465a5a5a3f726199146f2025254596c9e268b3ca6a2b523a63626268e1c2853287d81b2ebe2c1f4691b6261fdc70829fc0702a8892e90170f6b16c4c53527a6c1a8fe91e3d7ac8576f3ea6f99cc741047edac60d9d382f93fb3ce08b35076df886a279f3e63267938308408d009b744ae5f4b64ab49622ed0881d6a2d1a0c73540ecaed7ebdb4809154ec1e7137b45da086729f035b7418306c61c6a6e94e8701f744a649aa3d2e216759590ab42b56ad572f8fa8282828aac5bb7ee311744a7278ae161ca2ccb9261c3fc6e13995ebb76adbcd872ba02772fcc778e850a15523c3fcbf3cb2fbf4ce9e9e9b26e385f803c394a6d2e1ff945a473628ce6716b64cea546340fb8dbb1acb651211fd38d1b37f6daa72ec6a770a3478fa6ad5bb7d2a953a7e88f3ffea0bb77efcaeff9e2ccd504b8539b9d3b77cac0010bb7964fe1dc2832adc1f56c2cd996dea154b2b58c4cab116d7beb516bd97db9d2e36aa196c795bdc7c6877c3ae137fff9cf7f648eb49670cac73ffffc43fbf7ef378d220747a79d1299e69e0dcf9f3fefebac4846bb76ed8a142b56acc6bd7bf7aa8b8f294e3cf94c33bcdee2f3b218568961bfe1b3c7c0a566de78e30dd2b0da8a8c6671f99a975e7aa940c90747f3783fa2220270078c694af61c8b7c4c73e4c7dee5b813c6a770bc7fd4b277ef5e3978d353b81cd7b37fc4f0851816d9763dd3322a6a6fcf885a8bb43db9d4b68ab85ad9d6bbdbb1f1a84ea76badd7ebe54d287710e50878b95ce1c350368fa3d30ef541a744a61f79e491f7ab57af5e8d73599cc5f7df7f7ff6d4a9531ce3ffd689279fc98657ced3e13005df6e0d130387e3f93fca5d5edeb77c273fd9a5674f8e4873ed6fadabad74efde9d860c19221fe5785284da526343a598374a440e3570b5485bcaf7578ab15d803754aee1731edfec1f3f9ed5e89f2ff25c2160ecd8b1b25d08b70f993d7bb66c1f3268d02019201042201b3a191e25d3850b17a44c73036c7bce716e1499365e8c0a8be169c3f56c84181a88e12f65d7b3313946298f524745bd2af6651571fd282f3f6fdbb6933ef860a13876db9a2471dcb8a954bb7620952a553297380e1b3686ca977f84aa54a9648344db23d24ae5d87951e9cce34ad3c8b43dc7c6003174e6377c1efaf7bfffed908397534fb90d173f5d3290e6481f748a4c3ffcf0c31ff4ecd9b3a833523c8c646464dc59bf7e7d31f1768d0b4e3ee670adc37a8683ed75be0e19ce28793d1e71a94c73748623a88eaab6c25dc50f1c38504aa956f951900f00aca3a6b1219f838cd156fecd5aba49f4f44689fc148ef70be7431b259a1f3bf3cd333f55e3f42c7e645cbc78f1cc93b99f9f3c77f16f981b5df3933696ea43870ec91edb381d849f44711e35cfeb25326d0e078a6a1bae67a30def1fe47f3d1b6bf3ca57aefc946edcf8935ab67c567e7ef3cd99b47cf93a1a33e615f17ff2a13ffffc4becffd728b7b0678ae68d1b37e9e9a79f12d79e52141b1b477a31fad1472b91e31b256af75d6cec2a4e9315db5dc146d9d63b5aa66d3936f83b2983fc049ccf1d0ef440d9b18b81bb8ef441a7a4799c3e7dbab82377585e88933c9ffdea937bc1723fc830dc645f13c332caec57feb6ab372e2a2a4a46a5ed4dedc80f3e06b8d207af87eb41babb7c286d6c687e0364e966088d1281ab8e65358d0d0d3267f578f6f4639a23d2dcc99231b2cced42d40612f8a91b970ae520019f2f4e9e3c693a97b2786b9d0bea661415431fc3c077235f89e1e3ecd733db530cc2c25a8affc766d332fefbdfff51850ae5c4f1fc358587b7a52fbed845eddab596df6dd9b29d8283ebd28913a765db9e76ed5ac968b5af6f213a7c3889962c59433fff7c9e52522e889ba76ea6652626eea48307bf13c76d6b6adebc519e22ba65cb9762d975c4b2930dcb6e6198779798f77b316f4b316f43d33c5bb6ec12d3d716de73964e9dfa49bc0f12df079b96b76fdf61b1ac1fa94c9952d4ad5b1b2a59b2b8d9ba76cb794f9c3823b6f717b1dd1be46b4a4a9ad8ee0e0a849cac48b75b1c1bf5cd3ccda11b91c33b1dea834e91e96bd7aef9f249c799dcb973a71c653e6698eca627a2326288340ccc59576e0c37bce116eb8eaeb6c2cbe79ad42b57ae74db0b0de40378a3483b2ab7d91373a8f9291c3734348a34a76d7044d9d627662ce01c20e07dcdfb9ce11c6c9605967435db653c9578d8a1c679165d0d03733ebbc4a96f84f8dc73cdc4f562acf81fdda30b17d2e889276a50e5ca15851c7f27657adbb65dd4a9531bb98ea1434753404035aa54a90275ee1c66183786e6cf9f25a5959f18fcf5d72dfafdf7eba66d8a8e1e4f57affe463d7a74a4010346d09c3993a96bd776b9e473e8d037c4b2ab1a961d6a9877a298f777316f7b31ef7fc4bc3162de30c3f413c5b65613e2ef2f6eb6fc69e2c4f768f9f277a97bf7b6f4da6bd3c5f61f17f3f7a763c74e8befdea7234736d2238f3c649877b258d763625de5e4ebddbbf7c476ff6dd86e6b529cbf64a7a45c72e57195f3d8c830bf1975243996efd0c7e14e91697e84c6f92bcee4d34f3f35fe7d933ce464f4b82b573e7ffe7c59fe8ea3298e8623392ca0f6ca345f786c2df00ef900de8e168d0d95c23785c69b444f38a63972fcdb6f99fd38b0ecda23d24638958df7418b162d64849aaf7b6a9fc271e52403933cfcf0ab91b7e8292730f009219965e9abaff649996cd224580a7342c236b9bc2fbfdc4373e74e334d1f1a1a22ae2bb9533e5ab76e2eae138f51bb762d0d5169a273e75268f1e255949e7ece50a54a2f8477bd41a673cb68686873b1ecff18e6fd45ccbb56cc9b6caa70b57cf946934c333d7ab413e23c58be2f57ee61faf0c3e5e286ab26c5c6aea05f7ffd568c2b2b7e9b9de9d4a99f69debce562d9234ceb0b0d6d223ebf223f9f3c79466c7773b3a8b47571ce4bb2972ddbea4ec795a92c98a3d33d73f4a2e850b9718a4c73472ae2c4a273a650f7ecd9f337216cbc276738f1205172a0de35bc16c9319ebbec0970c591cd35557ffef967a745495926396a63af0cd7a85143366ce447acfc0af90020fbb1eccca71fce7aea327dfa741909e6df4c5e75efadc14fe18cd16347d7b8e5d25c6a9ec271e34637ca9956723d638be348a34fded7b3fc244f5977e2a1a12da44cfffaeb15715c7595d1e1d75e9b40870f7f2fc5ba6cd932a6e91b34a8434a3b763979f247ba73e72e55a890d95094df57ac582e5f396dd0a0b6695cd6bc0d0df3de31cc9b355ff5ea8f9a3ed7aefd24cd99b354a67c942e5d528a74d60d4300fdf0c3cfd9d6d7a0412d2be24c0af65df6d74183ba689d336dcfb19161146abea175a45073194b331c9a4aeb1499163bebdee5cb978b38b3818a9f9fdf1f869d37d90d4e3eff180e9ea26612cdff653ea373f9bced866d75496575beb8e4d7218ba360f95dbf7e3d8d1a35caee6de7a14a952ab29ef5fffddfffd9d4898237cb072858a8c9f777d431cdebe7ca168eb849e4cea08ce2cacbe72a399ca6a13458c34fe18c70750ead1b5bf3f2f8bc366bd62cf9994be6299569b3e0c2643738942c09d3038324e90caf2aaf67ca2e759cc6f1d1474b65647ae1c277a94891c272fc8c1973c4b1f69c05d9b45c42af48115f99fe71edda092bf3e65e366f43e6bcdf295ae7bd7bf7a96ad54ab2d1a431adc838fdcd9b7f51e1c2be8a6e00ac09b325e9ae5ebd92d6c7953dc706ef7429839c5aea4899e6e59be1d02ec50b39e31759a952a50bdc8b94932f289c839ce4c2131127ddff6d785fcc20d23c6ebd189ea7ccc760fc9a402e6e7cc89d0eb469d3c6a9eb6cd9b2a55caf56a4a5a5c988155f8c3a77ee2c05db505fd223e4831b4271650100ec1569b53d1b3ae298e6f53bfa98e6a813477d3b76ec289f52f1cd34df145bfaddf35338ae522223490eae716b4c99e3e8b4592eb42773c7ecbd8fb2eb99deaea155ab6765034116583fbfa232ad82d339366fde2e1b0de62d9dfa5c9f0b15d20921ffc3f4392cac059528519ce2e33fcd21a1fa7c9693b5bcb0b0e68679d7e7331fd18f3f9e33bd5fb3662b75e9122ab6bba93ce6bef92653c26fdfbe43fbf61d113784adf295e2ccedbea140a42dddb0e8ddedd83079d99123471cba5139bcd3a13ee8945064f9f2e5bfdebd7bf713bd7af572daaf7ef5ead57c047dedc2134f4933a9e683ea733124921b54edc8eb80e37c6967c2d11b47dc603d78f080b66ddb26072e69c5bd30727debfcd249dc493e90430db41269571f43ce4e63e2c7c59c6fcc0347a8f95ad3ad5bb75ca9207c936d8c0ef2363aaa2b706ef8c4ebe6a76f8c164fe1dc80a2eaaf6779899c92c68899f355a95291aa557b9442429a98c6356ad480fefbdf03d4ac5943b21c81cefa2e32b2ab6c48b86bd73edab871b18c126fd9b294faf67d85162c58218e9912e4ef5f5688ef7c0b12aa37dc84f1bc8bc4bcaf897957c96a1cfefe0f8b79e79aa6fbe69b2362fbbe94a5d9381565ecd8ff9337039f7efa01f5ebf73ad5ab1748c78e255344443bb19c2ef9fe1d91911dc5764f15dbfd3fb1dd732dec5397771baee6d8602f9332c865eb38b5c9519895c52347fba053643a2d2d6da610a7c1e22456c849a904b7fff7bfff7113eae12e3ab0f85692c31ff186d71bee7c86e44721ceaeb6c25df4f27ab9fa05afdb18c5e1e3833f1b8f13be309a3f06e2f74a1fe75ebd7a5546abb9d3056e14c48f74cd2fae05593e8077a126df9f7f73e615682cc135942d3169d2a47c2bd8f04de2fbefbf2f8fe988880859a62ae723dd9c37b9e6e702865339723422b20a37fc338a35af8fb783db5570cd6cf3a761bc4d8e84976f94695eaf07cbb4c6d73375c277f6ecc16cf34e99324a0ee6cb494bfb3e97409b8febdbb7a7380ebb649b86cbdd2527efa5f4f47fe43581533ff292d2b4b483b9b63d73de5d39e6cdfafe5fff7a5efc0e5bcb1b379668e3f8b0b06674fefc57723e3fbf22a6c68f59ebda9b6d397dfb7616dbddceca7eb4b7d745a71f1b1ca19ec3977b3e6ff1d32247dcd4b25f6cddba556f76f7b6dee365fae8d1a3676bd6ac795eecb8c79d21091f7df4d1067147588d9cdb9538136358e77a72c308b4a58b8fb3abad6cd9b2459e68945ed4ed81a3037c31335e48b9f320beb87234dedde40339d440f5d5ecc60d99ea60bc5974277ef9e5179976b16ad52a39381b8e58733d691e98c2850b9bbe73668d5b67a739bacff5cc919152bd8af1fa5cc26ba478713f0bf35a8e52e73faf5e46b0b9ce755ecbc89acfba0067e689db93dea177b76323d520de61ec001f7cf081acf0a535bcdc3b77ee182fc8fb1ded834e6b7176e5ca9537c68c19b35a0882af83a3d3375e7df5556e0efbbe0b4e3ed33df18cc922ed6ca1e6aee567cc98213b7111c78629cf917f5c7c47697c14cbdb652c6165bc381a7b2bb315ee5e94bb097647f960a1e6c75e2c47d7af5f571d9503050f3e46bef8e20b19996edfbebd5bdd8455ab564d469a394a5ba952a56cbf6526672e31fff6cd739ef94621478b7cbbb877ef9ee9bd336bdce6fcbb3d040dae67e681414788b3658156fe59e977d6dfaf5cf91ed5aaf50469d735b95b44a0b53e36389f46d6129c3b77ae0c6e69d910984b530a41373ff8163a7a87384da66fdebcf99938a9c6881d57c7918fbbba75ebb64188d853e2ed5a5c66959ff4f922e6cc6a2b0f3ffcb05caf3ddda75b8b02f3f7dc156b4ef847dba74f1f7af7dd77dd4e3e38f5841f4fb31c41a481528c69423d7af4904f352cdd24f26fced2efcefc7795d7ef47cdb1cc5d73f3766979d3ca8fc6edd92e23ceac71abb431b477a277e2f2b4946adb04bb75eba6768a3439f83bb780533df68aa11507cef8692cd763d7e237c937dfbd7bf77e203096e4dbef0c1ff475e6debb72e54ad71933669c0a090929e6882eab77eedcb945d059bce566bef7718955063f8ee4c790ce9469be73747417f37cc16561e75c4996668efa9ae7663569d2c4ede4c3d58d2181e7c2c737773ee20e69428eacd9ce4f36cd23cc96e01b67de2f5c3e8fcf3765cb96353dd972668d5b677486e55922adb3611e35d35a936a2d045bcd7baf8e52db0af76a7398ef6b939393e5b5d8dece93f837d7ab572ffde9d3a78d22cd3ff62867f8a0af93775e8ab8438feadebdfb27070e1c28ae65ef75a74e9dfa465c3cd8ce468b21199756e57099baddbb779333abad70fe32af576b3855856fd48cf2cc17d3fcd28a0a8a7c808225d4ae6ec8cae5aeb82c9ea3d6cf157bac0507589e795fe4bc61e79b6beea08a71668d5b4747c1dd5ba675760ab392e9954ab53d9fdd4da4d5fc1d6e498a18b8abc715eca25c42920b05f0f9cb96940f0ed07144da4ca499a1cef24167cb343fee5a254e86451b376efcc1962d5b4a6a11a1e688348b744646c6c7e2e34a5c52d5c11da8bcf7de7b324fd9591db770892af17fb37b393e3e3eb2b731ae2dcd11683e9ed444810a827c808227d4aeeaae9e9fae7084c991ebe506c5d92e62e29cc537c25c2b9f3b47b124ae2cd74699e6df9dd61db69863dee8d0d14fe1dc5fa89db93c2562e9ecc8b42d224d364caff7b48383d32ff882bd887fca1ca1e6eb39b7677afdf5d715b56be09b56432346bd596a07f386337dd0d7157befdebd7b4bae5dbb96deb265cb8593274ff6193d7a74091b25ee46444444c2c68d1b3b1876dc325c4ad5c3a90f9ce2c1d151675c78f982cb3f127b9f4cb004b338d89b5becedf2010a1eae28b5689ea6c437e88e847ff37cf3cc11687e551af9e5a761c67275ceac71eb88a7709e2fd25a44ac95cab22d52ed6e516ab2637ab786bd8d1b157030f4210eea717b266e98c8e7316ebccc9577d819f877cea91c2cd07cb3ba79f366ae0c96919e9e5ec8ec80e2d48e579ced83be2edc816befdebd7b202626264edc55d48e8b8b2bddb973e7620ae7bdbd60c182841123463c21c49c137d39471aa91d76307cf8707ae38d379cd2ad38af478b9ec7b44c4bf176f900050fe34d223ff57054d7de469c99a6c4a959393b63510affce468e1c299fc239bac6ad79ef8fce4ca1f30ed1b6651e5b533db4906835c2ec2cb9f62838427d803223d4b2ca07ff46f937a4a01755f39ebcb9b161942b7cd0d7c53b30e5c183076dae5cb9d2ab5bb76e438b152b56e7b9e79ebbf6e28b2f960c0e0e2e224e72153907f6afbffebaf2ebafbfdedcbb77ef4f2b57aef4f9f6db6f9f12f3f11990cbab70181f8d0ded842f32fca884ef061d596d25363656a66170350dc80772a48163e19b4463ef9a8e6a17c037858e5c7e5ee72a5b6171e648366fb3a36bdc1a2b788484849096ed83bc5f989d25d56a245aad243b43a43daec1a1551f14435bcaec1df1ffc4d04a85a3b244c7b9d2077ddd6427ae1772bcfed6ad5b8f6edbb6ad97189a8b715c519fcf469c4f53460cf70c47cb6eca4c2a4fc1a5525b58209b356b264ffe8ea8b6c28f65b8b6f49e3d7b9c969b0df900106ac73d7531de147ad2b1cc4fe1f837c838aac62d3fa636f27ffff77f05f8e87374350f5bc45aab4688ce90e70223d2d97cd0303c6a106ba30f5634f8207b21176ee746095f1ba675b90fba9bd170cf38730d0370321c3d9933678ebc38b2f06a194de1ce19383798a340818181900f883470226a1ada722f9d4a8f6563c3594f3a9639b2cdd1e9bd7bf792236adcf2efdbd8e9140726dcf1299cfb4ab6bdf3d91a9576a44443a40b820ffae047ed564cb6a713132de0080d37ee193c78b08c4e6b914fc81169eed18f2334c3860df3887f444040806cf4c01746de27356bd6b4383d5f9c8d8335f9888f8fa74e9d3ae168076e794c2b399639b21b1919298f654f4c53e2bf8dbb374f4f4f97f5a6fff7bfffc95e598b172f6e9748b3981f3870407ee614c5ad5bb752f9f2e5552d67ca9429f2c53bae67afb950c8b56884a8548ab51669a5f3e8551c579f78cb71059906ee2fd30c9771e296b32c7edcdb58e3c68de5ab2d708e344bf4b469d3283a3a1af2e1a1f201bc47a88d7598f9d5968e9af8a6908f657ebae2a937851c30a85ab5aaac06c0a5f62e5cb820c5977fc36ae597e1d40e2ecf691469262e2e8e424343552fcbbb643a674373355d8b6b95eee14ca97666945aaff2b8824c43a621d34e87e5b177efde32ed836b50f34558cd8597e5912fd8a74f9f9625a2f83133e4630d22d2c0e5f031ccc7b2d2a72e79dd147a439a12ffed2cd49f7ffeb9146a8e502f5ab4881bbc53ddba756564d91a5cb583db8170deb579272d3367ceb4f9291c22d3f68ab696a91e96e4d659f26cbf4843a621d3906917c2d19b010306c848cd871f7e2873297ffcf14753e72e458a14910377cf7be9d225199559b870a16ce073f4e8518a8a8aa2f7df7fdfa6480fe40300c71ed36ad2988cc7b231e7da5b6e0af977cd7f3bf700cbd53758aabffdf65b598de3f0e1c374f7ee5d79aee327739c02c2a91cdcfe83f7054bf42bafbc425f7df595a9231916703e07daf314cebb23d3ce946aa502ad44aaed95687be5d93e91864c3b1e5fec02600dae91ca03d764e50e0f38d7907b0fe3480c5f80b8d41d37dee10b13774ec03d1b7a5b29285b1a259acb07441ab81b6a1a25f2efdd5b3b17e20682dc3e846ffe8d553e54d4b835c18d0d39b2edee0dac9d8b51fc741a2cc39e691d9dea618b60dbdb101140a68147c28d11b99b4f1e201f05573e80771dd3fcd4848f693eb6f3bae933afdae1ad9d0bf1cd3f07013858c0916563a50fa5123d64c810d995b9bb96fc741fa976e6f2f42ae67344645a8d2443a421d300403e0a9c7c00ef818f61ee5530af9b44634df482725398f329dc37df7c63f1291c4f5b703b64718544dbb21ead7a46b445a221d29069004081978fa4a4ef68c3868d325277e4c85153af6ec08e93aeaf8f90b1206ad5ea398a88e0148367dde22631e75317f334a582f674a5a03f85f36c317766272ef60ab62db9d700320d8097e0edf2919c7c9a468e1c295e9369c8907fd1b4695384f435919139eb1729351d0da899c63b5ef98624292999f6efe746ba83a862c54769ce9c799af6c267cf31ddb3674fd9f8f8faf5ebf2290cd29480e305d851cb7754272eb64a35a2d1906900409ef211111141b56ad5a253a74ec9c6999e2e1fbb767d49fdfb0fa4b16347d3d6ad09e4eb5b58c1c54a97c77b5d1e17849cdfe90adc45c3cfafa8b831a92786ba346ad4608a8d5d456ddbb6a1458b168b63a78bcb8fe93265cad0c58b17a972e5ca1069e000d9d5d9389f3d72ed2ca9d62a0d04220d9906a0800975972e5da444732d6a6f10e9a14387d1a64deb658503ebe8cc4efe96845a89346b2dd83a0b1773f7b9584547bf48ad5a3512c7d170b96dae3c86386acef9c20c97bb34e60903e058c1d67a19f6a67ad823d1b60836d23a3c9d42d80500d887b123175b3a74712738b58323d22b56c4e710699d8521a754eb2c08777ed3eaac88bad2f9952e8f144eef3c82829ea4ad5be75154d44bb2373d5761de831fc3b9f200d827bd8e18acadc3d2f7798dcf6f9ca56948c5777a52168d86487b2a884c0300249c23cda91d798b7476b8fe6e7cfc72faedb76bb2a30aceabeedebd1b598e46db1b11b6757eb5f3b926721d14f4044d98f0b2f83fbc463b77ee72c931306fdebc6c9fb94b6cd44807f6c9b4bd37ac7a0da77776272e448846170c10990600c8aa1ddcd8303a7a583e229d158d9e3c798a1469ceabe50a1fc78f9fa0e9d367d0c4896f7af85e707d843a3aba375dbe7c295784d859ecd9b327db678e4c730fa700d82fd55a44a1952cd3d234798d57324ec967b5df11211a0d99060078115cfe8ea3cb793736cc924c8e481f3a7488121212e8e0c18352b42e5cb840478f7e472b57aea475eb3e731b31f554060e8c10ff8f0d4e5f2fd747e7eeb24d17874285e8b7df7e93e301504bd1a245f499a5349d91ea4156a67155aa075999cf39fcf3cf9d5fc4cb7d1c959069008003e108644848f33c05da9cf8f8783a76ec589ebdc3a5a6a609111c9ccf1a20d74a0909a9e3925c65ae4c634e4646867cddbc7933fe29403501018f5e3d70e098864bb4278fda1ea9b626d9a4e0b3a5f91ccf975ffe8f1b6224e1a8741cc8990600c8740dae239dfd42905b80b92738aef250a142050a0c0ca42b97af905f313fd267e829bc4bb894edfc2f844009f5eb0750529273af7b7c73b47af5ea3cbfe3a710a8ea01d4e2efffd0fefdfb8f4670a51ac7e16e553d2c7d76dd39302e6ef39fe2e5348e4ac83400c08164c9525e129d354e4af4538152bc020202722d274ba6fead5a8d000020004944415421cfb6c275a8f38afc3b12ced1ceab774b4ef5e0541e4ef5e8debd3bfe394031e7cf5f9abd70e1baaee3c6bd54987bfdcc8d4ee39b6e4776e062af54bbf47c98f2f9e7dfd413aff370543a0ea47900002c5c64b23f9a1c3468a0946eeed82327bb76efa2e0e0673cfcef2d98cc993327cff148f500b6929a7af990387e8e73a74496cf2f4a1a1b5a9a47690eb59af1f98d53db48d1f50d0cbb7419b953fc1f2ef13d338e4ac83400c0693299ff85273cbc33d50eaa45a16d42e9f69dec91ccd1a347d3b2657194ff634dbd46dbe7e8f90a965473147cf7eedd16a7e1540ff3c6890028e1d2a56bfd264f9e9f7ee0401239a6d121299856696eb59271e43112cdecddfbdde6c4c47ddcadea481c8d906900801b08f58d1bd769e6cc59f4c30fa7286e711cf915cd9e43fbd8638f89ef67d3c58ba956e4546f615dd6b6c5d2fc4a97470aa72f187063c79b376fe6fb7de1c285a548efdfbf1f3f0fa096e49b376f75ebd6ed959bb6354674a70e5cf21a67ad51a26b45ba4d9b7fd7116fa3c470128722641a00e032a1ce7cbf74693c4544f4a6279f0a94291e952b57ce3557eddab5a95ab51a14d9a71fc52d89b74158b5965bbdcaf1eeb4ef9dc7b265cb2c7e7fefde3df99a7fe352002cb2ebead53f7ab56c39e8cf993317ff91d91ec011916835a91ef6083491b2c8b5cb48e9d265e4a2d6ad5f6e929191f1aaf89c8843d0f1a0012200c0ec82a0cbf69e1b9f0d1d3a9c021e7f9236266c265f5f5faa52e5511a32640875edda95ead4a923a73e77ee9cecf465d498b1d4b77f7f9a30fe0d8a9dbf90a287bf6c4598f5d8e72e8653381419d1ae5d3225848f0100d40af5ddbbf79ac4c47cf8c15b6f7dd2e0c5173ba5f6ec1956a965cbe08adce0d639bf23bd06e3ddb3d742ae23cde5efb86a07373614125d438c6e4b884843a60100ae943b1da5a4a4d0a04143e88df11329a4450bd31475ebd6a5f59b36d18e1ddbe9c8d1a374ffc17daa57b71ead5cbdc6d430f1edd9ef50f4b061b476dd46ea13d943c1c547aff2d5d5d2ab346544e9dfe19abf8b05f9efbfff56342da77aac5fbf9efaf4e9839f09b085e4070f1eb4bf752bbdfe279fac8f10432b31ee2131a0e6a2fd5411c335ca2c7fc7553bd0d810320d00709d306645a63b760c97d1e8aa55abe59a92a5b977ef488b4b9b3b6f1e7509ef6c9069bd02f1b4456eb5926fb5726c4d823d23e27ee4c8117536949c8c9f09b0972442072200320d00f06ea12629d54141b5c9c7c7f65344563a803591764634dabd23c4ae62dcb871723067f2e4c93465ca149a3469927c0f0000c032688008003013c92cc9ac57af0e1d3e74c8f4edca152b142d25ffe99488b416420c00000040a601002e96ea860d9fa113278e9bc6ae5ab552d1dcb9a7d35b1169ad84d9d679d596ee83bc030000804c0300f29168230d1b06d37747bfd378f996de2b91607ba2d2f64ab2adf5ae6d7d050000e00920671a0090a724fafb3f4ca74efd409d3ab6979faf5eb9627a6f09f3e9ce9d3b6b455a6d11685b4419000000804c03009c20d1996456f5484dfdc9c6f9ad7d56db28d15671561b058694030000804c03006c96699d0612a9a6b303bd8de31c9502a2b5946bb57e000000906900808708b5393a3b44506d645a8d5c6b21d98e6858686b5e35a41a000020d300002f10699d0672674b6f815ac9b59a69b4126000000090690000b0288a3a15d32a916a2d455a8be8b43d370d906e0000804c0300401e0d10958bb33589b526ce5a893429fcce5641b667bfa2341e000040a601005e2ed3ce68806849aab58e52db23b56ac49834d86f0000003c1174da0200c82183390775d347458da0c387bfcb67197a27887416c3868d13db92448ee9e445c9cd82da527c00000020d300002f10696b829dff74090989949676c9ca72737631aee4bd65918e8d5d42070f7e97edfbe6cd1b51f9f28f285846fe521b1bbb5c2c374981006b518a0f520d00009e06d23c00000e90ba2c11deb2e50b0a0eae4f972efd2aa4f408356af40c3569124c5f7ef915d5ae1d4855aa5432cdb36edd267afef96e54a85066ba4962e297629ea3d4a143a810e3c6729adf7fbf4edbb7ef96afc1c175a53073f479c99235f4f3cfe72925e52245467691f3972a55827c7db34e73dbb67d25a649a1e79e6b4c7ffd758baa56ad42d5aa5596dff1f88307bfa79b37ffa2060d6a51b366cf88e51e13cbfd4c7cf78b586eaa586e67d3b21213f788e98f896d6b21b6e1199b441d000080e783c834002087002b4df55036edd0a1ff91a91fe3c74fa55f7fbd422d5a74a233677e1662bb93de79e743d37c5f7ffd2dcd9dbbd024d2d1d1e368f9f27554ab564d1a3060b890f2ed727cebd63d2839f9672a57ee11b19cb372dcad5b7fd3ddbbf7a420fffefb1f66eb7ec394e61115358666cc9827e67b98162f5e43bd7b0fa3fffef7a069daf1e367d3df7fff23e4db87dab61d2045fad6ad74c372ff16cbbd61fafba2a3278b6d4b10dbf6b8d8b63162db76db70a302e90600006f00916900bc80e9d3a753505010858787678bc4aa97699d1501542be699040454a7d8d8b7e5fbbd7bf7d3b16327e95fff7a91dab4e949efbf3f4d087421fae493787ae9a57e729a73e75284f0aea0f4f40b26b95ebefc53eadab51d9d3a7586162e7c879a350b362dbf75eb67a97af5c7a85dbb961419d935d73673d479e9d24f85cc1f9112fec20b5dc53a2e6413d84f3f9d6f7abf6ddb5e21eae7a96fdf6e62b98f8ae58688e576326cdb05b16d9f896d3b6eb66d0962db4221c80000009906007822313131f2b578f1e242eabad2c08103292424844a962c6983046b45d6b2c2c25a9ade972d5b8632321e50ddbab5a94a958a9498b843a6706cddba83e2e2e6caf94e9e3c4d77eedca50a156ac979f87dc58ae5e5fb8f3e9a25e4b92775ead48666cd9a48356bd6c863dbb3ff1d274ffe48a54b9794226dfc8e05de7cdae3c79369fefce574fdfa4d3a7af4044544b4cf737f9c3c79c6b06dcdccb6cd5fe53e8174030000641a00e076a4a7a7d3dab56be550ba746919a9eedfbf3fb56ad58afcfcfc548ab44ec59a9556fdc83e6ed0a01768c992d574eedc2f3460406fb18d45e537458a14a632654ad3b56ba77349f2cb2ff7a36edddad3db6fc752d3a69d2835f53b7113e16741587979be325dc3fc3b966023c9c967a96ddb7eb463473cd5afff34f5ec39345f09cedcb65262db0e409001000020671a006fe5cf3fffa4d5ab5753c78e1da96cd9b242560750424202ddbf7f5f85202b1d2ccd9bbf74f7ed1b211b132e58b0cc90e291394f58d87354a244718a8f5f976dde8c8c0c991f5da1823fcd9a3541e6345fb8909a79322b54c82c5f3abb808785b5a062c5fc68dab47932877ac2847764b4da98a671e2443255aa545e8af4eddb77282ded8a693ff134e6f9d26161cdc5b61513dbb689b4a9510de90600004f069169000a00b76fdfa6152b56c8a154a952d4b66d5b8a8a8aca11b176a4cce55d1a8fd32edab56b4da9a99784c8d6ce3a31f9fad0962dcb856c0f15a21d4f254b96207fff87c5f67f48356a34a6468deacbaa1dd1d1832830f009b92cce95e60687bb76eda38d1b17655b3b47a6b76d5b463131efd2860ddb68e4c8972838b88e185f44ce1b1ada4c08f6bb54ab567b71e3515a56e7983a3596ead67d4a56f0183af44db1dc6fc472e78b6d2b24b66d81d8b6d7c5b6ad316cdb43b466cd7b2ac4d9dabe020000e029e8b00bdc0abd007bc1c3983c79324d993245be9f3469924bb6c1b87e5b78fcf1c7e9ecd9b3e2e0bba6c16941aff23bbdd5cfe9e9ffc846952cc446389d25735ce16cf3dcbd7bd720cf852d8a2c479dab546922e4788110e7e06ceb32a68c7084dacfaf488ee5fae6d8b6db52aeadad4f4d543a25254ddc3084bbfc58e2f5f3b10d9c7c51d6e9706d06c0c340641a0037915a57c122ad5c881d25d6f97fce9e0f9df95df1e2c5f294d12ca9cd2dab3131efc9efab56ad4c8b17afa5060d6a6713e99ceb328ab4314f3aaff5152f5e54c5dfaa2c1564d9b2ad1e7b2c010000641a00a09a4183067984c4734e310f3973a6030202e8dcb97316244f67a3305b9b4e5da4fae8d16374e6cc39b1bdd5a84993faf9cc937f5498cbe1716e3437448c891921cbdd599b47597499accca74eb2070dea22fe9f0b5d169976a7e31a000020d3001400aa57afeef2c7e1f9c934cbb38f8f0fddbb774f36dee3e1a1871ea2b0b030eadbb72f75e8d041e64c1b1e2ddb29cc4ae6b145aaf5320f7ac890d7e9d5575fa22b57ae99c9b4520126aa55eb0939d826c46aa6b72dbd23eb78caec11122916000000990600b80096e7c2850bcb46874681e67ad32cce91919152a459a8b591665ba53aafeff2ffbc6ad546eadcb90dfde73f51f2736cec526ad4a89e90ea06947f7d69cb72ad3ceaac55945a4d2a08000000c83400c0253c78f0400e2cd0bd7af51212da59d69b565f679a51d20e4a5daac7efbf5fa7eddbf7c83276c1c1f5a879f386a629f6ed3b48274e9c96759cb9963457cae0f40eae43cda5edd6addb42d5aa55a1254bd6c95e0db9a247646417dab2e54b29d75cde8ed7f3d9679f53484823f1b99c5cee962dbbc43e682d9673910e1e4ca29b37ff9439d3cd9a65a58bf034c1c14162fd9925f332d340f49498b847cc734cdc8cb490553eec1768883300007813a8330d8017c111e7eeddbbd3a64d9be8e2c58bb474e95229d4d645da9200abad319ddfbc99b46e1d41c9c93fc9b27867ce64357e7cedb53769dcb819b28744ce6dae53a78d146eae25cd79cedcc90a8b38d799e6ea1a7ffd754b7ee665af59b345fccddbe57bee06bc77efe1b46a55825ceeafbf5ea5575f9d22535ec68f7f87fefe3bb31248dbb6fde9f0e1e3a66de5f2777dfabc26447dbd98e79a1c171d3d557615cee92103068c15c2bddb4639b62515040000802780c834005ec0b469d364eeb6fde2ec28b2967dead4195ab87036356b166c126d8e3273eac6afbf7e2f24fb617ae1856e72ba79f3e268ca94d7a966cd002a55aa040d1bd65f2ea37af547a95dbb16322acd74e8d092366cf8427e9f98b84b76acb263c7d7346a54146ddefc25f5e8d14eaee7d34f3f346dcfb66d7ba478376a54c7b46da1a14dc5fa46c8ef398abd78f167949e9e64e87a5c2fc47a3375ed1aaaa11c43a4010000320d00703913274ed44878751a2d277f3efae82d199deed4a90dcd9a355e8af2a9533f52e9d225a5481b971118f838fdf0c3190bb29af599653a2a6aacac54b275eb6e8a8b7b9b8282dacbcfebd67d2ed6335a4e79fc7832cd9fbf82ae5fbf49478f9ea48888f6d996d9a0412dd3fb93277f92d1f00a159acbcffcbe62457f3b441ae20c00009069008097a377f8f25e7eb99fcc877efbedf9d4b46938a5a61e916917f7ef3fc836fdcd9b7f51e1c2be56459aa950e11121cf4f0971de2a453920e03159437addba4419f5e6ea1fc9c967a96ddb01b463c732aa5f3f907af61c6e51d4b98316ceddbe76ed5b0b424c0efe0e000080bb839c69008099cca9c989b6348f3e4ff1cdc87840b76edd12f2eb2fa3d29cff7ce1422a85863e2bbb10ffe69bc3724aae44c28d11c3c3db505e115d4ebbc8cc97ce1adfb1632b1a37ee6d21ea6de5e7f6ed5bc8cf11111de434dcb0901b28b24873ef8669699773d5dc36ff9bc2c29ea512258a517c7c8205e945941a00000a3a884c0300cc844e97cf78b5cbc91b2ed357a346335979832b7144470fa6c0c0ccdacf9f7efa31f5eb3782ead5ab45c78e9d1212dc91faf6ed9ee7b22323c369e8d009b46bd77ed92538c3d537de7a6bbe10f050830c37a7d1a36799523942439bd18409ef51ad5a1d6423478e5c4f9d1a4b75eb3e45c1c1b5736d3b7713be65cb47621b46d382056ba964c9e2e4ef5f96d6ac79c70659b6b47f20d20000e0c9e8b00bdccb6604d80bc0f927029d4e1c7ca90e12f4dca4a7ff23533b389522e7f4fc9d9f5f5143a3bffce5932b7c30d99761bda6747a7abaa93b728e80f3baaccd9b9e7e5bca757edd8adb26d7f90bb74ed790702e28b8bf455c9b01f02c109906005814dffcefbb6def19b17871bf7c979329ba7ab216c1cd5fa22d8bb151a4f9bd6591d69b6d53519bc558fdf400000020d300800224dab6cca3b4bb71eb5d8d2b9568e582ab447c6d8f3a43a4010000320d0080303b59aad548b45a49768648a3c121000040a601000554a6751a0ab85ab1d6dbf1d91ec176a45c43a4010000320d008064db3d9fad5169474a34441a000000641a00e054697694586b29d55a09b63d720d91060000c83400a000c9b4ce8e796d9dde9952edcc2835441a000020d30080022ed78e588e96a91e96e4d659f20c91060000c8340000f2ec92e53b222a6d8b38db2bcf10690000804c03000ab04ceb3458863dd33a3ad5c316c1b6b72122000000c83400a08049b53397a757319f2322d36a2419220d000000320d0070b844dbb21ead7a46b445a221d200000020d300008f92736776e262af60db927b0d000000320d0080fc3a65f98eeac4c556a946341a000000641a006097ecea6c9ccf1eb97696546b95060291060000c8340000682aca6a96616faa873d126d8b6023ad03000000641a00e01071769458bbaa1397fcbe8344030000804c0300f2944667d599b636bdb33b71512ad81069000000906900806642acd532ddb11317f3cf9068000000906900401ef8f915a5dbb76fcb57d70bbbab523d2c4deb3c91be7d5b4fbebe3835030080a75008bb0000d0b0613d3a70e098c6b26c69b034ad9af139c7e5378dd2e9c9ca7c8e2729e922d5af5f1f0725000040a601009e42ab562d69fffea30a2458e9a046b0adc93391fd52ade6b36b24dac8fefd27c4ffa3150e4a0000804c03003c85888817282e6e03ddbf7f5f0339b6251a6d4bb4da5152edcadce822141fff99f87f44e0a0040000c83400c053a85fbf0105063e4db1b1ab5488b335d444aeb54cf5d0db28d9ae8b461b898ddd4e152b56a4a64d9be2a0040000c83400c0939833e7437afbeda574e040127957aa87fb4b3473f2e4ef3463c6fbe2ff30070723000040a601009e46606020ad58b18afaf79f60636344774df5d05bf9ec7a58a47bf4184e8b162da2a0a0201c8c0000009906007822616161f4f1c78ba84b97113477ee6a0b39d45ae4555b9b963410682265916b5751846263bfa2b66d07ca88747878380e420000f03050cc1400904ba8f7eddb4f23478ea40f3e58494386445248481d6adaf4698dea506bdd810b91fafad2ae83eb4873f93baedac18d0d39477ae7ce9d8848030000641a00e02d70cac7175f7c21a42f89366cd84031319fd091234764c72ec0ce93aeafafac23cde5ef38ad038d0d010000320d00f05258fad08108000000903fc89906000000000000320d000000000000641a000000000000c8340000000000009069000000000000402e50cd0300e07052535329212181b66ddb46bb77efa67bf7ee915e9f59fb994bc5356cd890222222a84f9f3ef4e8a38f6287010000804c0300c01b6fbc418b172fa63265ca50ebd6ada97ffffe3474e8506adcb83155a85081d2d2d2e8fcf9f3f2f5c08103721aae65cd3d017efcf1c7d88100000020d3008082c7d75f7f4dbd7af5a2f4f4741a356a94946a3f3fbf5cd355a952450e4c6464a4ec527be6cc993463c60c5abd7a357df6d967d4ae5d3bec5000000090690040c160c48811347ffe7c195d5eb76e9d94e8fbf7efd37befbd479f7cf2095db87081eedcb923d33c1e7ae821d99d769d3a75a87cf9f23479f26429de3c70ca47c78e1de9e5975f46941a000000641a00e0fd242626527c7cbc4ced183c78b094e877df7d97162e5c48a54b97a67af5ead1c48913a524fbfbfbcb79929393e9f3cf3f97116996e6e6cd9bd3962d5b68eddab53460c00019b1ae5bb7ae4c0f0100000020d30000af84e59723cac78e1da3ead5abcb86863d7bf6a4f6eddbd3175f7c41b76edda20d1b36c8e834479b39379a1b1f7277e5ad5ab59222fee79f7f52545494cca7fef6db6fa953a74e74e2c409994b5daa5429ead7af1f7634000000b7c207bbc07d285ab4e8a451a346e9583000f024f6efdf2fa3c81b376ea4a0a020faf0c30fa5f8f6eedd9b264c9840ddba75a3152b565093264d68d0a041141b1b2bf3a2fffefb6f7ae69967e88f3ffea0499326c96a1f9b376fa6aa55abd22bafbc22459bbf67d9e6c68bb56bd7a6279f7c123b1c7825fffcf3cf2fe2775152bc9d86bd0180e7803ad36e444040c055ae680080a7c1b2dca2450b6adab4a92c81f7da6baf498966010e0b0be31b4599dec1038bb1b13122bff23cdc48f189279ea0e0e0606adbb62d3dfdf4d352be797e8e74b3547343c4175e78013b1b782d5f7ef9e549f192843d0100641ad888bfbfff7e8ef001e049706a07a76cb0fc728ef4b061c3e8a5975e9272cd79ce9b366da23163c6c857733812cda91fd3a74fa7952b57ca79972f5f4e3b77ee9451695ee6f8f1e3a56cfff6db6f72f90f1e3c40ee34f05ae2e2e2fe142f7bb12700804c031b397ffefcec850b17de63a900c05358b060818c2c972c5992e6ce9d4b2d5bb6a4912347caa8320b30cb3057f6e08685e670e58e5dbb76d18e1d3ba42c2f5ab448e650739ac8d6ad5b65ee34e74a73958fae5dbbca79de7cf34d29de007821299f7ffe793df1ba01bb0200c834b091d4d4d443191919c7399f14004f801b19727499a3d37c13c825f1a64d9b463d7af49022cc22cd70093c4ef1c8098b343750e4b410f39e0f59a839ad837b4564c93e78f0a0146e8e707359bd55ab5661e703afa24b972e3bc5f9ff92788b5c3f0020d3c01e2e5dbad46ff2e4c9e9c89d069e0057e96061e6dce759b36651b162c5a45c73c342aeccc125f0b82bf1fce00a1e1cb536e7f2e5cb2c1674f5ea55d2e974b2a4de238f3c2223d90caf8f534100f016f6eeddbb59fc16ba88b723b13700f03c50cdc3fdf8edce9d3b87b66edddaad458b167ee6d13a00dc0d8e1a0f1932846ad5aa255f1b34684057ae5c91553b38fd83e11bc3679f7d36d7bc5c5f9ad340de7aeb2d2a5428ebbe9e6b54735de9d9b367d3ddbb77e9f0e1c3d4a143073a73e60c3dfffcf354ae5c39dab76f1fbdf8e28bf80700af10e9366ddad4d1ebf5c3c447349a01c0034164da3dd975f5ead55e2d5bb6fc73e6cc997f20871ab82b494949b2d206c311e8ce9d3bb31c504848881cc7e5f1389f3a2f382acd929cb31424a77c7003461ecfcbe1e5f172b9de34c32920bc5e003c9c942e5dba2c6addba75938c8c8c57f927815d0280678282c66e2cd477efde6d121313f3c15b6fbdd5e0c5175f4cedd9b3672521d8158d65c5007035172f5e94dd81339ccbcce919dc218b3157da129c2fcdd16c4bb0a8b338070606caf40f867b4ee41410003c0dae23cde5efb86a07373614125d438c6e2b8693d83b0040a68163487ef0e041fb5bb76ed5ffe4934f22c4d04a8c7b480cb069e03670150f46afd7cb86865cd28e73a7192e7f67cc753687a7e14a1e3c186b479b4fcbaf53a64cc936cf8d1b374cebe3f40fcea706c0c3a822866b62382d867984c6860040a681d3482214f207ee899e73a4b9fb6f8e18734a123f39b97efd3a597a82c2dfb17ce707cb340f2cdddc8d38bf1ae1f519804d0300007039c8990600d87e37eeeb7bffe4c9cc27d49ceec129190d1b3624adaad11873b2b97a47912245e4b89f7efa89a3d2684800000000320d00f06c8a162d7a93739f999a356bd2faf5eb6577e15af5e4c9cbe1e56ddebc5946bf19ae6d5da850a13fb0f701000040a601001ecd83070f8e7cf5d557f2fdd34f3f2dcbda193b5a898f8f979db770fd693570f7e25c9f7ad9b265b464c912b93c5e07bf32090909ff88f51ec3de070000009906007834b76fdffecfe5cb97ef71aef4b871e36423c14b972e71c45a4a3497b4e332776a888e8ea6c8c8487aefbdf7e8debd7b32179b5fb9812273ead4a9c2e2e55dec7d00000090690080a773aa70e1c23f6fdfbe5d56d9e0bad0fffef7bf69d3a64d52acb92634cb30bfe788737ecc9d3bd7d453225704e1bc6bee3e9c9713131343c3870f97e3b9fa879f9f1f179cfe12bb1e000000641a00e0f15cb97225e695575eb9c7153712121264250fce6be6de0dfbf7ef2f1b2372072ddf7cf34db6f9cc4be6b170474545c96a20dca091d343385564f9f2e574f0e04153c72fd1d1d137fffcf3cff7b1d701000040a601005ec13ffffcb3212d2ded6e9f3e7df41c3de6eebfdf79e71d59ceeee38f3f961db970d7e02cc8e698d791fefff6ee042caaaaff03f86f580411b7dcd3fea2a999b9e10a822908884ab8a0b946d8ab1946e65b968abd2999db6bb9e2bea569b8818664ea6b8ae12e26981a9ab99b4b96b821c872ffe79c591864963bc30c0cfafd3ccf7998b9f7dc3b87eb80df399c7b0e5f2991af78181a1a4afefefe347bf66c3a7bf62ccd9a354b1ccbf7858585e5b1d7e1abb5acc7550700005b618f4b00004595979777e0dcb973610d1b3654f8f8f850bb76ed68e8d0a1628ee8b973e7d2dab56bc54d848f1e3de275c5347a53a64c11e3ac93939369fdfaf5a2379b8fb7e6bdd8ebd6ad1363aef9d090112346881eefc8c848be584b287bb9b3b8e20000602bb0e801005884ababebc2c78f1fbf979898a8e063a779380e0a0aa26ad5aad182050be8a5975ea2d8d85862fb4580e63dd7bcc799cf23cda7bfe3b375f0e11e63c78e253e069b07ea5ebd7aa9a7c7cb632fb12437377724ae340000204c03c033a96cd9b21b9e3c79d22f212141111818286e3c0c0e0e16e3a5ab54a9429f7ffe397978788800cd83340fd4bcc73a2626862e5dba240abfd9908f91e6fbb76ddbc603759e2449bb59e98a2b0c000008d300f04c6321788cb3b3f3e48913273a8f1e3d5a139af9f8e993274f8a5ee9ebd7af8b1b1539beb261eddab5c5147aa3468d12b38270f3e7cfcffbf8e38f7372737363f2f2f2c27065010000611a009e176e356bd68c9324a9d98811231cb46f363466d5aa557c9cf5a3cb972f9f4f4f4f1fc036a5e172020000c234003c8fbe7274747c2f2f2fcf852f37deb3674f051ff6d1ac5933d103cd8781a4a5a589f9a3b76edd9a9b9292c27f2765e6e6e68ee6b99a951c5c42000040980680e79d8742a118e7e4e4e4c982b52b0bcb4eacd8dbd9d9e54a92a470707048cfc9c939c41ecf6475f7e172010000c23400807e9358e1eb8347a91e030000944a58b4050000000000611a0000000000611a0000000000611a0000000000611a000000000010a6010000000010a6010000000010a6010000000010a6010000000010a6010000000000611a0000000000611a0000000000611a0000000000611a0000000000611a000000000010a6010000000010a601000000006c9e032e0100807c1f7c30b2efe5cb57c3af5cb9d23a2ded6cc5cccc4c5c94d2f09f9d833d356ce8f6a07efddabf8bf640310000200049444154bef8628dc5cb966dfa165705002c41814b00002560122b135989523db6794141419ed7ae5d597ff76efa4bc386fd4be1eded451e1eedc9d9d959e6192403cf4d796ccefee23e8f64e5f39abe8d7fe8494949a3fdfb7fa1d5abbf278582aebdfc72ddb7b66edd9d881f47004098060084692bead3a7e7b0fdfb0f2e193f7e9c5d44c44872707090f96b5432b2cd5642b4a503b8ed07ece8e8ef68f2e4c5791d3bb619131bbb6b367e2401c05cf6b8040050023aabca3e56126d3d489f3891ba78f3e68df67dfb86909d9d9d2a402b64f447e8aa67ea6373f61b6b9325b799fa1a8a126a5341edda35a36eddbc153367aef2f7f26af9f7efbf5f39861f4b00409806008469cb6a7cfbf69d84d8d84d0e7c4887ee506bac94448856142968967ef2beefead55f207f7f4fc59429cbfc9d9cece33333b36fe147130010a6010061da42ead7afb7f7934f3eaec57ba4e504e984841f68c284ffd0b265cbe9d0a1c354b56a55aa53a78e0542747186cee2ef252eb980ad1081dac5a5ac7d6aea399fbb77ef47e34713004c85a9f10000746b9995f5a4111f23ad3f48e73f8e8c9c40932645d1f1e3c7293939994e9e3cc9b645525adad9620cd10a33f7d97ae8b5ae888881e4e8e8508f3df4c0db1e0010a601002ca04e9d17fff5de7bef9651de6c68284813c5c5c5d1ca952b4590be78f122a5a7a7d3c18307e9e79f93e8bdf7c2c9f0900f7303e6b33084c376be8761c3fa94a955abea3b78e70300c2340080054892a22b9ffe4e8ea953a7d2ad5b8587dbe6e6e6525252122e6629e0eddd8af2f2f2fc712500c05458b405004007168eebe5df7468b42eb9b8b8508d1a35c4d79cec1c7229e7221edfbb770f17b31468d9f215faebaff4ffc3950000846900000bc8c9c971c85f9085cf51acd07a4caae7caedd9d9d9627cf4b061c3c8d9a9e0222e5d03bbaaeae99ba3590e49e6b6d2c676be07676727de338dbfd60280c9f08b03004056d87bfa71fe6220818181f4c71f7f143afa58f2312a57ae1cc95b9cc51201532a15c1b5b4046c000084690000ab076a89bef966253dce784c3e3e3e949995a9a9317cf870f2f3eb22f35c25112aa562d866cb211dc11d008a0ec33c000064053145a1c70f1f3ea0d973e6d20f09dba9c1cb0d68e992a50586791c3e7c983c3c3dc5b8e9888870ad39a7cd0dd5a6865ae939fef70200281ee89906009015ca0a3e4e4c4ca4a0a0606ad5aa2dedfcdf6ebafee775aa52a54a81a36fdfba4d0d1a34a0ce3e5da87fffc1b46ad51a9941da52a15a6ed0b474cfb3a901bfa47bc311be01c07ce8990600301ab40ade7cb87bf71e5ab67c256ddc144be55c5dc5b62fa74ca591ef8fa4e0e0606ad4b09108d7df7efb2d2d59ba8ceabab9d1f61d3be9b3c848cacccca0f0f011c51caaad39c4a1b48dd346700600cb42cf340080ac00a60c61fbf71fa0f9f317b2b24013a4b996eeeeb461c346aa56ad3aa5a4a690a393136d8e8d13419ae38bbf4cffef7fe9e8b15f68130be1a605694946fb2c11a04bcb78e967610c37003c2bd0330d006034b4e5f74c8f1b3781e2b67c5f2048ab952b5f9e7a8784183ce39cb9f3a8e71b3da85fbfde06425f517bad4b228823100300c234000018097ef60e0e3a83b4ec5fba0e0e3283b3a9a1da942121960aad96b821b2384235423a00580f86790000180c6192c1e0b5f6db6f659da9703d89e4cd636de9506cce986c4b8dd3b6de871c84640040980600b0c930ad2fe02aad5bb756d69974d7932c1caa2d7923a3a5826c69dc0600201f86790000c80e8d0a2b9dd7d87339fb2c3d3b88a57ba5116e0100611a00e0390cd28a02cf2ffcf10775efd655b3e5f6ad5b059eeba35def8266e971396152b2f263b9fb2d15824b532f380000c23400800502b59a82ae5efddd42e733b5c757f9fcd8b15fe8c5176b50edda2f5a29549b12b0cd19736da973234003806dc098690000836152d718e6c265f8f0912ce82617d8c6573c9c356b2ee91f1b2de909cdfac64d4b1415358df6ecf999ccbb49b138c65f1725bc22f00240e9839e69000059a1fa6905c74f6fddba8d7af408a4b66d5b6bb61d3f7e82fefcf3067df4d10716089172c36d7105694b85eafcc7d1d16bd8f56b4eeddbb790798cadad0659a2eab0d28b954eacb464a5262b7c0ec74c566eb292c2ca0156d6b3720d3fd30008d30000c518a215268432dd01effcf90b74e4c831ba77ef3eb9bb37274fcf769a7df1f1dba975eb9622781f3992cc02652b1628db68cec1f75fba74855e7fbd83acc09d9474887efdf53455ac58817af6ec4eaeae2eb46bd75e7aedb5c654bb764d4ded0d1bb650bf7ec1646767470909bbd86b1fa7c0405ff2f26aabd5b69dac6d2dd8f9ce887a01019d0a7d8f7fff7d9776ecd82bbeb66edd8c1ddf86bddecff4ca2bf5a96eddda9a7a9b36fdc0da13400f1e3c60f5f7b1fae9ac7e5356bf351d3b964a2b576e62d7e932fb5eaf51fffe3d34af9390b097b52d85b5ed7556b795aa5d7bd8b14d58ddeb74e2c46fecdab4a6e6cd5fa1eddbf789e7fdfb77a3060d5e7ad60334a902f4fbecdfe6f5bcbcbc323af63bb3e2a62abcee4c56125959c1ca5afc8c03141d86790000c80ad5fa8abc63232327d2a3478fc8c1c19efcfddf60e1f1b8667f78f8681a3e3c82d589a21b376e52c78e5de9dcb9dfc5be51a33ea5d9b317508d1ad568eedc4574fc788a8e3098df96d1a3c7d3b8715154b9722516807fa366cdbc5968fd8785ccdd3473e67ccd11fbf61da039739688801c11318ed6acd9484d9abc42a1a1112240e7b76d1c0d18308205ddf5ac6db7747e58f0f1e9476969e7a95ab52aacdd17c4b61d3b12d9f7334353f3d0a15f282a6a2e9529e3c0ea0f64f5ff60f55f60f52f8af33c7c98414f9e64b3a0fd48846cb5888828d6b62dac6d0d58db3e616dfb496c0f0f9f486161e369e1c2efe8dab51be4ed3d98468c98c83e20fc48172e5c65d77008b17029f30350a9e4a6502876b0af5b58f1d313a4f5e9cc0a9ff83c899506f8f906281af44c0300180cc2da0cf7500f1af48e08cb6a999959141414281e6fdcb846537ffbf69d2c449e173dd06af5ebbb5174f457e271626212a5a69ea272e55c58585cce42ec59163cab52fffebda97bf77e7adbc77bbfa3a379fd3322d80e1cd887ce9c49a379f396d13bef0ca22e5d7ad3ac5993598056d0d2a5dfd2b0614358f0bc44cb97afa58c8ccb623b3fe79a359b28383840735e5f5f6f1684c73cf59af9af7de6ccefb464c974f2f46cadd93e6cd8006ad93290162d9a4a152a9463afb19eb5a19faafe79567f0aabdf4a732e1f1f0f7273ab430101de9a5e691e8a972fdfc8da7652847e6ecd9aadac6dbee2b1bbfbabf4dfff7e22ea4647afa3860debd2983143292727971c1d9bb1e332c9d5b5accc005daa42f5007b7bfb85b9b9b99535ff993b38909f9f1f85848490878707d5ac5993aa56ad4ae9e9e974f3e64d4a4949a1d8d8584a484860efcb4cf561deac9ce09f4d08bdd40008d30000d609d30ad981ebbbef5650af5e419ae7111163c4d00d7edcc993a768c1826574f76ebae85d0e09e959e07c7e7e9d35afc17b95f3f27245bd0a15ca8b60acaeab0e95ba7a88cf9c39ab555fa971e38674faf46f2c0c7f4ab56bd762616a277979b5a76ddb76d28a15b369d7ae44caca7a42356abc26eaf3c7356b562f706e77f7a67a83347fbc70e1141686df6441df97a64f1f478d1ad5a3264d1ab20f0b2d68edda3816ea832926269e85ba63e288850b27b3fa83587d1f56ff13515f9753a7cea9dae6a9d5b6aa9ad7efd0c1bdc07569d9b2b12a58da99f0ef5bea0429148ab52c48dbab43f4e8d1a3e9fdf7df671f46dc0a55ae54a992288d1b37a60103068860fdf5d75fd39c3973d8878e1c5e858fabe6bdd47c38c872fccc03204c0300582150eb236f1197b4b4b3e4efdf9376eedcc2025f33ead36708c9bba14e52071e23f554bfd01dec0bd5e763b41d1d1dc5e3b0b001b472e57774e1c2650a0d7d939c9d9dc4b00b3eb6faafbfce183cb7a1d77ef7ddc1622cf48c190bc9c3a3275dbb76845c5ccad2db6f87d0d2a53162f846fffe412ce8bbaaea0f60f5fd58fdc5ac7e08ab7f80d5772e74de32651c59dbcab3b61d21f3566c943b4d5fa9318007694992ec951f941ad3a64d9ba869d3a6b24fc07bac67ce9cc9fe6dde661f7206b20f2ca7d4bb9691f26645f45003980863a601000c86314363a49fdeaebb3ebf79af56ad1a2c4837a5ccccc774fdfa9faad06b78ba3c3e0c2423e3311d3870586cdbbd7b9fb849b060ddfcc7bebe1d454fe58103caf0c9879924251da6a0207f516bf0e0beb463c71e5abc78350d1b3658d4f1f37b5d0c2759bd7a23993373071f97fcf0e143aa51a32a4d9f3e9e3d7e4457aefc29f60d19d25b0c01993d7b397bbdfeaafab9627cb4b2fea705eaf36126fc2646353fbf0eac6d6559dbb69810a48b36a3880d73e3433bd441dadbdb9bfddb269914a4b5f1e3f8f17c688896453ca3e3e71ec034e89906003018cc14328299a1fdca903b61c217d4a4497b3184830fb3f8e28b19d4bc7913318b87bef3d6aa559d66cdfa927c7c82c9d5b51c75ebe647eddbb7d6fb5acece6568e3c6e52cc4be472d5a3415e3ae4342de10219ae337fc0504741637ecb56ca91cd6c1c3777cfc6a5667a408d9fc75aa56ad4c31318b64854f1e8eebd5f312433a2e5dba4a111161d4b8f1cba20eef9d1e3cb8a7988983cff0c1b7e5e549ac7e4731051e9f8923222294d5af2fcec5c74a87877fce3e341ca4b8b868d1d31e1fbf989de363d6b618312b89b26d5f9bf86f52aa42b34e0a8562b97a8c34ef91deb2658b18135d147cf807efd9eed8b1a3ba879affe980f75077c4cf3e80093f9fb80400500226b132919528d5639b4cd29274b788bf460b8637decbcc0326c77b8df9300b3961efc9932c1142f3eb1bef69e5afc5eb2bc758cb9b973a232343846b3ebcc2d4b9a6f51d3b78f087ec03404b1a352a8cb47bd279fb94f51d0a9c8f0f09e15f95e7c97f0d657dfb42dbcd9b335bf73685c2dd56ff5fe453da6d517ff83971e284d93dd2baf020edeeeeae3d44e82dc2700f00d930cc03009e659fa98288997f859333fd9dfc69f3d4419ae3bdc8faeb17dc5ea64c19559096b38aa2a4792d5382b4ba27d99c20adefd8ab57ffa4d8d81f292cac6fa120abacef50e87cfc1cf98159fbda39eb08d224a36da66eb3c5f721bdaf7ec06f36b46490e6f8f9c68c19a3bd69047e7500c887611e00f02c9bacfafa8895ada4ec6ddbcfca43d343b569f84c1ce7cefd21a6bc2b383443fff9f7eedd2fe67ae6734a9b16024d0d97d65835b1f0633e063a296993981acf9c73ecdd7b985d8f97d9f5a86266682eca4a8956791f66b092c0ca2a13de8775140a858f2449a257fac30f3fb44a03f979f90c1faa69f3f894796eac5cc2af1000e3d0330d00cf039ee6f81d773f927229653ee9339f00dad978c83575911612370af6e9132a16393974e8a8c1f38d1c39868e1d3b21f60e19324255df586ff5d3db48cf3663f58dd5d5fd78f8f0b162c54263f5f96a8b6ddb36333b8c0f1932865d8f149dfbd7addb46fefeffa26ad5bc2828289c5252d24c0cc825327eda85953755ef433e67628c8cf7612ff54d8781818154a74e1dab348ccff2111414a4bda92f7e6d00c8839e690078de5424e598505e1eb3b28195ef49d96398533870997a03220f7a1ba9478f00fae8a37023c748e4e5d58eaa57af42451b9a607a4f7574f42a71d360fbf6ad48fe2c1ecae75bb7ee64df9f8fb889505e38b6546f77fe363ecbc79a35d3a956adaa346fde5af2f51d4ab76f27155834c7f4f6142b7eb3df0055c9622596954d3ade879dd40ff8822cd6c4cfbf79f366edd7fd0abf2e008c43cf34003ccff820e63052dedc758795f554a8a75032a9f0e11d7c55415e366c88a39c9c6cb132e1ba759b68e1c2154ff53c13952fef2afe7cafebf5e2e212e8d6adbf34cfb76eddae5ad29b283e7e8798626fc78e9fc4c22bea63131276d17ffe33830e1c38fad4f9f2cf7fec580aad5c194331315b591bbfd7ece1d3e82d5cb89ab5758b98eeae709b7405d1c23ddb09097b581bbe666d382eb6edda95c4da7aabc085dfb021416bb96fdeeebdec9839aa63c8e807865ebdba8820cd8d1c3990eedebdcfbeaf532686669b991e8f0f881fa47a1ffea3faaa7e1faaa77ba1366dda58b5112d5bb62cf014bf1e00e441cf340094a48936d416de63dd5f5584c3878f9187873ac0c89be481cf9bcc67a4e037ffa9e74c8e8cfc92fcfc3a89d0ecef1f427bf76ea5b66dc5cc11141e3e86162c9841b56b772f14f4c2c23e6081fa1baa51e375b165f8f07fd3ead5f35988f463c77d4af5ebd715f357f7e8e127ea47448ca7dbb7ef50efdedd2934f4039a3d3b8a8283bb160a8bea363e78f050d54689468f9e28866ef0a9ed5253cfd0679fcda0e4e4ed54a54a251981337f7b44c444551bbab2367cc4daf019edd97388b66f4fa439733e1375f6ed3bc21e7fa359363c22228a1df30f3bc68f1df3293b2692b5db4776e84d4a4aa68a155dd9356d6a89d03ca984df87e54979b3622fd573f5270e3114c39a9e3a7f55fc7a024098060004ea2219376e3225267e2f3784099d3a7952a3462f8b1ee79123878a6d7cee67b5eddbff276e4c54876979814ff76bfbfa7a5354d427e2315fd570f9f27594917151338bc79a359b58280d28742e1f9f0ee4e6568702025e67813698ce9fbf44d1d1dfd08d1bc7c552e40307f6148badcc9bb7929dff2323df7bfe3e651bd6b3369c11371f2adbb0853eff3c82ba74798b66cd8a14db972e5d4fc386bd29f65fb870951db3891d93aa592a9d1f53304cebbf46b76edd61e7fa9c1d33eda965c44d09d5922dbf1f35df5451e7953686cf3badc519bf9a0010a601c0767d6343413d5bf5b5d07c6c5f7e399e8abe9cb844274f9ea1050b56d2ddbbe974fc782a858404c90ea88642a1bb7b53cdf353a77ea3acac2754a386f2863ffeb8664d63b382289d39734e2cf5cd83b4ba2e5f78e5f4e97364cad47aa74e9d53b5a16d8136346fde58dc8cc8877f7879b5a66ddbf6d08a1553459dfc633a681d5355d635397ffe0af5e9338ae6ce1d4f41419dc842c33ba24ae87d98a72a0e3ab68b407de7ce1dab06eaf4f474eda799f8350580300d00b6eb1215cf9fd3271a08d03ca4386985689e2476b3b28e951dac3cf6f66e673428ebdfae2c6969bf93bf7f5fdab973a3584ebc4f9f301dc7eb1b935c705f6e6eaede36f0b9a82b56ac407ffd75ca481b0b3fe737ede5e4e416d877efde7d727474301040251d6d70646d28cfda905ce898b0b03eb472e566d1131d1ada4bb3004dfe3187c9941b126fddfa9bba747987d6ae9d4e1d3bb6a6a22de252e0f1a4627c1f7239aaff8bed54e5e9f7e1afac34e0156fdebc69d530cdcfafe50e7e4d01c8831b1001e079c167ee78a47aeca80ad2fc2e3b3e7d413f56eaa9bef2f9a833750563f925ffd85f7f3d23c635f3e5bbf91cbed7afdf103725ea0fb9f9e72957ce85eedf7f20b64e9b36973d7e48faa6b7f3f3f316335cac5ebd51475b0a3fd71ed3edebdb4104ea0307942198b73329e92805057521e353e6e59fd3cfcf4bb479f5eab842f5060f0ea61d3b7ea6c58bbf530df1501fd341d5ee2db28334f7f6dbe369e0c0ee260669533f145905ff1097a5f5dcc1c8fb503337607272b2551b96929252e0297e6500c8839e6900785ea8971f5407971f48390d59a679214bde0d89bebe1d69c28469d4a4893755ae5c494c85f7c5175f53f3e64da875ebe6065e47a2b1632368d0a070b15a6064e487ecf88a7ac23189301c1fff0d0bad112cb0ae2157d77254b5ea0b1413b340e7f7d3bfff1b141e1e49bb7727515cdc52dab871110d19328a5ab468226e400c09e9c6ced553efb51834e8c302d3d06ddebc8002023ab2362c61c77dc4dab04ed586caac0db3a95ab517d87e6fba76ed26fb60f1aae67cca762f62c78c61c7c4b0635c54c77c6de0df42a29d3b0f883263c60acdd63b777e56dd3069ee947bc5c2eea90f72c6de87fb4835e7736c6c2c85858559ad61fcfc4fbd2e00c8a0c025008067983a31f13f9d27b2b25af5355dceb19274d3620dc9c878ac594e3c33334b33ccc158a8e3b36e289714779419f625f15a7ce610fdcb6f4b5ae7a602cb7af363f952e7ea9b018d8750ddfb3232320cb441df318f45b836774973d3eb163c4ea16863adff178bf23ee4abb45c149f3bd8f5bc78f1a255166ee1433cdcdcdca4acac2cf5f7cf7bc82fe157088071e899068067d97f548180f7009a714395e57a2f5d5c9c35e7e36155ce34734f075dc36d92b45eab2ce95f1dd1f0b995ed342d38ebdaa7fee060cad2e5f9af5dfc41da86df87d754c1db2f272787e6ce9d4b3367ceb47803f979b582f47e046900f930661a009e655fb2b296cc9e9940fe12e2e69fdbd872e5fac7631b1f1badeffb28ca733975f53d96cc38a6d407690bbc0f49335667ce9c3974ead4298b368e9f8f0574ed0bb104bf3a0010a601008a21f816a5981aaee56c2703db250b856a7303b7dc739812824b4590b6047e3362227fc07ba7fbf5eb27a6c9b3043e1dde9b6fbe99cb68f74aafc7cf3c00c23400403184684b067163c79119019a64866f4b87ea7cd1d1dfd29123a926846a39a1dc52bddaa50a5f014824e8b4b434eaddbb779103350fd27dfbf6957efbed37f59da4fca6c8e1a49cae0f0064b2c7250000d069d2a4497cf53f6bdea72d15a90e9fda6ecb961f2931f190e8b1fcbfff7b516c8f8bfb915e78a192981983dbba75a798cbb97cf972e2797cfcffc4bea347532921e127ad6325b66fb7d6be3d05ceab6e4b52d231fae187443a77ee22d5afff92e686c1f8f89fc40c1e070ffe42172e5ca17ffeb94793272f14cb96dfbbf7809a366d68e1306cd9501d15b5547cb1d1f723bf59f12a299719b7bb72e50a6ddbb68d3a77ee4cd5ab5737f9647c6847606060eed1a347b53bd5fec5ca1efce803204c030058304c1717c9e47a1e1ec162fa3b37b7da74ebd65fe4eefe9ad8debe7d30f9f8788aa0cb75ecd88fd575a7860deb89e37d7d07d1debd87e8ecd93fc48c1e9f7c32955e7df565b1eaa1afef60b6ef30db7781ed7bc2f64d53edab2fce357af49762b9ef4e9ddad1c99369f4fefb93e8adb77a8a9b077d7d43e9a79f0ed1f9f397a956adea54b6acb308e47c5abc4a952a50dbb64d0d7ccf251ba44b419816195815a8f9129a76bc677ad9b265ecc3ca036adebc39fb20e36af4047cd68e2953a6506868a874fbf66ded20cd97fb5c881f7b00d361360f008022055c850502b239c74b74e6ccefb464c934f2f46ca5e318c3433b7af7eeca82f150f19887ddf9f35753af5efeaa7d01aa7d926adf1ab1effcf94b62d8c68d1b07c5f681037bb0369ca779f3d6b0203a4a1cebebeba17aac7c2d37b73a1410e045fdfb7793196c4b26489722df90f246c645ac54e27f39f8eaabafc48d89818181141212426ddab4a19a356b8ad512f9500e1ea0f9822cdf7fff3dc5c7c7e7656464d869bd71f9d08e0f54e70500846900005b0cdc453d5e779d850bbf241f9ffed4bdbb0f4d9f3e8e1a35aa27e33875c8adad79feda6b0d69f6ec959a1aca7dca7aca7dab54e1fd3c55a8e0ca827465cd7ede637dfaf4ef9ae7eeeeaf5a202c23481bc16f10e4ebaf2f63c58f6fe0a13a2121411423b47ba3f9cd867c8c741a7e8e01cc871b1001000c86586b1739afa7bbcebbef0ea4cb970f8ade5f0f8f5e62a1145d81313737cf6060cdcece1f33fd74f8cccece66fb6a89677c41151edab4f7f3b1d08e8e0e323e0414750a3d4bcdfcf1ccb8c40aff53025f7a7c379976d3200fd1fc4f0f3e08d20045879e6900008361da108505ce61deb179797962c5c01a35aad0f4e963293a7a355db9f2a718f75cae9c0bddbfff401c3f6dda22f6f861a1f3f131d1ea6d3131f1f4c61bbe4fed53d68d894950ed93c4100ebe0adf8103c7c9cbab9558c931292999264c784f6fa0e52b29f21b258d075f5303b2dce3a567fd4dba5955f8b2887cd9712f56f8528e3559e1abe0f021217cda8f14522e11be99b0200b00c2340040e908db963c8754284cd7abe74d6ddbb6a04b97ae514444a8ea264189c68e1d4183067d2856218c8c0ca7ca952b140a9a070e2493a7e72e761e49ec1f3bf65d4d1d1e963d3dfb89d7a85cb9a26a9f72e5c68d1be7d0902163a8458bc6949a9a462121013478f01b7adbccc74a878747d1eedd87282e6eae8502b2dc63a4e7e9cdc8574a9ca32a00508c14b8040000ba93a0245db2e190aeacc37ba7796fb1727abafc7d7c960e2e7f7bfe396bd7ee400b16445150902fe5e464b390eca4b5cf8bed9bc4f6f988211dca7d85c36a4646a608d7bce7d9d8b2e57c5690fcb694c4186a99ff212adae0ff450030197aa601004c0eb50a0b9eab68c7f2de675d6382f383aba4f79c0e0e76ac38e97c0d3e3e9aefd71750f95478c6166c513fd7dd96e2ba49110000611a00a09484ece238af64e6fefced6bd77e4d4d9a34d05977eddaafd8be974d08b1457d6e4e58d6b70f211a0010a601009e83d05c1cc15a7fa8f6f169afb77efe3e49c6392d15a22db10f411a0010a601006c384c2bac745e4b1d635eb0363d305b33449b1baa11a40100611a00a014056b5b781dc982fbccdd56123dd3dacf11a20100611a000001bac86db056af7449876a437511a40100611a00004c0e8545bf01d13a01bab84235423400204c03003ca341b7245ed752bdd2b61ea211a40100611a00e0190ad30a0b9dc752e7b0648fb52502b3254336423400204c03003c4741dbdae72cca386a5b1fee81200d0008d3000008cc3613ae4b6a660f846800409806004098d628e979a6e51e67cd31d4c531fc03211a0010a601009ef1606d2baf632b337b20440300c234000068b1b7b7cfcecccc747476762a2541deda37209a1b984b4788cecc7c42767676790cdefc0060123b5c020080c29c9ccaa41e3e9c5a4c41d95891738cb9fb0d6d3356d7d4f3693f97c8967aa35352ceb27f73c7d378e70300c23400800564643cdeb16347d22d7961b728c59c906d4a702603fb8b1ab60d1dabef38db0ad16abb761dbef3f871d64ebcf30100611a00c03262172d5aef909393636620b674c8b644af7551b6173568db6688568b8ede98cdffcdf1b6070053d9e3120000e874332beb898f8383bd53a74e6d2b5af7a5242b1c531263a8894ae34d8553a7aeb89290b0ff2c7f88b73d00980a3dd30000fafd7bf2e44565f7ef3f9efe7c0cf5b0d41010dbee85d676f2e4f98c891397ba4892341a6f770030077aa60100f4bb9397279d8889d9dead53a7363975ebbee852f4534ac570ac64e17de64e8567db5253cfddf5f40cbbffe449f670f6743fdeee0080300d006079177272727f5dbd3abedf9d3bff24070474a86b67a7b0c2cb48563ac69a8bb894ce10cd8d1933e7e0d0a15195b203f327700000010449444154b373de654f13f03607007329700900006469ccca6c27a732cd83833b9f1e3cb847b5ae5d3b3476767672b6eecb16c7222ecf7e80cecccccafcf9e71367626276febd61c3ae7a8f1f675d629bffcdca29bcb50100611a00a0f8b464258495ceacb461c51997a454e0d3b2a4b09248ca593b0ee3920000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000058dfff037f1ad8dff2f5cee20000000049454e44ae426082', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71274342-1737-11ea-ac1a-7c7a916bf543', 1, 'Helpdesk.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e732069643d22646566696e6974696f6e73220a09786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c22200a09786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e22200a097461726765744e616d6573706163653d224578616d706c6573223e0a0a093c70726f636573732069643d22657363616c6174696f6e4578616d706c6522206e616d653d2248656c706465736b2070726f63657373223e0a0a09093c73746172744576656e742069643d22746865537461727422202f3e0a09093c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d22746865537461727422207461726765745265663d2266697273744c696e65537570706f727422202f3e0a0a09093c757365725461736b2069643d2266697273744c696e65537570706f727422206e616d653d224669727374206c696e6520737570706f7274222061637469766974693a61737369676e65653d226b65726d6974223e0a090920203c646f63756d656e746174696f6e3e4669782069737375652072616973656420627920637573746f6d65723c2f646f63756d656e746174696f6e3e0a09093c2f757365725461736b3e0a09093c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d2266697273744c696e65537570706f727422207461726765745265663d226e6f726d616c456e6422202f3e0a0a09093c656e644576656e742069643d226e6f726d616c456e6422202f3e0a0a09093c626f756e646172794576656e742069643d22657363616c6174696f6e54696d6572222063616e63656c41637469766974793d227472756522206174746163686564546f5265663d2266697273744c696e65537570706f7274223e0a0909093c74696d65724576656e74446566696e6974696f6e3e0a090909093c74696d654475726174696f6e3e5054354d3c2f74696d654475726174696f6e3e0a0909093c2f74696d65724576656e74446566696e6974696f6e3e0a09093c2f626f756e646172794576656e743e0a09093c73657175656e6365466c6f772069643d22666c6f77332220736f757263655265663d22657363616c6174696f6e54696d657222207461726765745265663d2268616e646c65457363616c6174696f6e22202f3e0a0a09093c757365725461736b2069643d2268616e646c65457363616c6174696f6e22206e616d653d2248616e646c6520657363616c61746564206973737565222061637469766974693a63616e64696461746547726f7570733d226d616e6167656d656e74223e0a090920203c646f63756d656e746174696f6e3e457363616c6174696f6e3a20697373756520776173206e6f7420666978656420696e2074696d65206279206669727374206c6576656c20737570706f72743c2f646f63756d656e746174696f6e3e0a09093c2f757365725461736b3e0a09093c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d2268616e646c65457363616c6174696f6e22207461726765745265663d22657363616c61746564456e6422202f3e0a0a09093c656e644576656e742069643d22657363616c61746564456e6422202f3e0a0a093c2f70726f636573733e0a0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71274343-1737-11ea-ac1a-7c7a916bf543', 1, 'oneTaskProcess.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e730a2020786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c220a2020786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e220a20207461726765744e616d6573706163653d224578616d706c6573223e0a0a20203c70726f636573732069643d226f6e655461736b50726f6365737322206e616d653d2246616d6f7573204f6e65205461736b2050726f63657373223e0a20200a202020203c73746172744576656e742069643d227468655374617274222061637469766974693a696e69746961746f723d22696e69746961746f7222202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d22746865537461727422207461726765745265663d227468655461736b22202f3e0a202020203c757365725461736b2069643d227468655461736b22206e616d653d226d79207461736b222061637469766974693a61737369676e65653d22247b696e69746961746f727d22202f3e202020200a202020203c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d227468655461736b22207461726765745265663d22746865456e6422202f3e0a202020203c656e644576656e742069643d22746865456e6422202f3e0a202020200a20203c2f70726f636573733e0a0a3c2f646566696e6974696f6e733e0a', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71274344-1737-11ea-ac1a-7c7a916bf543', 1, 'createTimersProcess.bpmn20.xml', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e220a2020786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20207461726765744e616d6573706163653d224578616d706c6573223e0a0a20203c70726f636573732069643d2263726561746554696d65727350726f6365737322206e616d653d224372656174652074696d6572732070726f63657373223e0a202020203c646f63756d656e746174696f6e3e546573742070726f6365737320746f206372656174652061206e756d626572206f662074696d6572732e3c2f646f63756d656e746174696f6e3e0a202020203c73746172744576656e742069643d227468655374617274223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d227468726f77457863657074696f6e22206e616d653d225468726f7720657863657074696f6e207768656e20657865637574696e672074696d6572220a20202020202020202020747970653d22656e756d222072657175697265643d2274727565223e0a202020202020202020203c61637469766974693a76616c75652069643d227472756522206e616d653d225965732c20706c6561736522202f3e0a202020202020202020203c61637469766974693a76616c75652069643d2266616c736522206e616d653d224e6f207468616e6b7322202f3e0a20202020202020203c2f61637469766974693a666f726d50726f70657274793e0a20202020202020203c61637469766974693a666f726d50726f70657274792069643d226475726174696f6e22206e616d653d2254696d6572206475726174696f6e2220747970653d22656e756d222072657175697265643d2274727565223e0a202020202020202020203c61637469766974693a76616c75652069643d226c6f6e6722206e616d653d224f6e6520686f757222202f3e0a202020202020202020203c61637469766974693a76616c75652069643d2273686f727422206e616d653d223130207365636f6e647322202f3e0a20202020202020203c2f61637469766974693a666f726d50726f70657274793e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f73746172744576656e743e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d22746865537461727422207461726765745265663d226578636c7573697665477722202f3e0a0a202020203c6578636c7573697665476174657761792069643d226578636c7573697665477722206e616d653d224578636c75736976652054696d6572206475726174696f6e206761746577617922202f3e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d226578636c7573697665477722207461726765745265663d226c6f6e6754696d65725461736b223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b6475726174696f6e203d3d20276c6f6e67277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77332220736f757263655265663d226578636c7573697665477722207461726765745265663d2273686f727454696d65725461736b223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e247b6475726174696f6e203d3d202773686f7274277d3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a0a202020203c757365725461736b2069643d226c6f6e6754696d65725461736b22206e616d653d225461736b20776974682074696d6572206f6e206974223e0a2020202020203c646f63756d656e746174696f6e3e54686973207461736b2068617320612074696d6572206f6e2069743c2f646f63756d656e746174696f6e3e0a202020203c2f757365725461736b3e0a202020203c626f756e646172794576656e742069643d226c6f6e6754696d6572222063616e63656c41637469766974793d227472756522206174746163686564546f5265663d226c6f6e6754696d65725461736b223e0a2020202020203c74696d65724576656e74446566696e6974696f6e3e0a20202020202020203c74696d654475726174696f6e3e505431483c2f74696d654475726174696f6e3e0a2020202020203c2f74696d65724576656e74446566696e6974696f6e3e0a202020203c2f626f756e646172794576656e743e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d226c6f6e6754696d65725461736b22207461726765745265663d22746865456e6422202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77352220736f757263655265663d226c6f6e6754696d657222207461726765745265663d226c6f6e6754696d657245787069726522202f3e0a0a202020203c7363726970745461736b2069643d226c6f6e6754696d657245787069726522206e616d653d2245786563757465207363726970742220736372697074466f726d61743d2267726f6f7679223e0a2020202020203c7363726970743e0a20202020202020206966287468726f77457863657074696f6e203d3d2027747275652729207b0a202020202020202020207468726f77206e6577206a6176612e6c616e672e52756e74696d65457863657074696f6e2827466c6f7761626c6520456e67696e6520526f636b732127293b0a20202020202020207d0a2020202020203c2f7363726970743e0a202020203c2f7363726970745461736b3e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77362220736f757263655265663d226c6f6e6754696d657245787069726522207461726765745265663d22746865456e6422202f3e0a0a202020203c757365725461736b2069643d2273686f727454696d65725461736b22206e616d653d226d79207461736b223e0a20202020200a202020203c2f757365725461736b3e0a202020203c626f756e646172794576656e742069643d2273686f727454696d6572222063616e63656c41637469766974793d227472756522206174746163686564546f5265663d2273686f727454696d65725461736b223e0a2020202020203c74696d65724576656e74446566696e6974696f6e3e0a20202020202020203c74696d654475726174696f6e3e50543130533c2f74696d654475726174696f6e3e0a2020202020203c2f74696d65724576656e74446566696e6974696f6e3e0a202020203c2f626f756e646172794576656e743e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77372220736f757263655265663d2273686f727454696d65725461736b22207461726765745265663d22746865456e6422202f3e0a202020203c73657175656e6365466c6f772069643d22666c6f77382220736f757263655265663d2273686f727454696d657222207461726765745265663d2273686f727454696d657245787069726522202f3e0a202020200a202020203c7363726970745461736b2069643d2273686f727454696d657245787069726522206e616d653d2245786563757465207363726970742220736372697074466f726d61743d226a73223e0a2020202020203c7363726970743e0a20202020202020206966287468726f77457863657074696f6e203d3d2027747275652729207b0a202020202020202020207468726f77206e6577206a6176612e6c616e672e52756e74696d65457863657074696f6e2827466c6f7761626c6520456e67696e6520526f636b732127293b0a20202020202020207d0a2020202020203c2f7363726970743e0a202020203c2f7363726970745461736b3e0a0a202020203c73657175656e6365466c6f772069643d22666c6f77392220736f757263655265663d2273686f727454696d657245787069726522207461726765745265663d22746865456e6422202f3e0a0a202020203c656e644576656e742069643d22746865456e6422202f3e0a0a20203c2f70726f636573733e0a0a3c2f646566696e6974696f6e733e0a', false);
INSERT INTO act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('71d361c5-1737-11ea-ac1a-7c7a916bf543', 1, 'reviewSalesLead.reviewSaledLead.png', '7127433b-1737-11ea-ac1a-7c7a916bf543', '\x89504e470d0a1a0a0000000d4948445200000440000002670806000000978626fb000057a04944415478daecdd0b9055d59d3f7aa2e3df788de5389594c96846cddf7288e3389aba8e53d7687953c935569c31c6f8e887808040108d41fd8b3a8af12dc622d1607c21a80422c4610c63121f3c8420061510211a488b3c1a104208a262445df7fcf6787acee9eed37dfafdfa7caa56f5de673fcee1f4398bb5bfbdd6dafdfa0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000074b2c58b17ff3f23478e5cfdc52f7e71776e35298aa2288aa2b47739f8e083df3de2882326e5963fa5f505007449f891f3c169a79d965e78e185b46bd7ae0400d09e76efde9d5e79e59574e699677eb4df7efbad128200009deec20b2fac89f00300a0337ced6b5fdb9a6b82dca215060074aa18f6123d3f00003ac3ca952bdfca3541566b8501009dcdb01700a0d3c470987eff3d2f080040e7062000009d490002000840000001080040570520fd0a6e63b7d75e7ba5bffffbbf4ff3e7cf6f6bc3a7bb35c4faccf9004000020008409ab900afa9a9c996bff8c52ff6b686980004000420008000a45fd17af404093b76ec4883060d4a7befbd77da679f7dd259679d95b66cd992a64f9f9eed3760c0806cbfd827d67ff6b39f159dafd4f1e1b39ffd6cface77be932d3ff0c003d93113264cc8d62fbcf0c2b4df7efb3578ad4f3cf144fac77ffcc7ecf5c5f94e3ef9e4b46eddba6cdb73cf3d97fee11ffe21db16e79e32654a837f5f53afa7a973977abf9a3a5fa9d71321d3b1c71e9bed3f74e85001080002100080ce0e405e79e5956cf99ffee99fb2f5c1830767ebf1f8ca952bb3e5534f3d35fdf18f7fcc960f3df4d06cbf2f7ce10bd9fae6cd9b8bce57eaf870e69967a6bffddbbfcd96bffce52f67dbfee55ffe255b3ff8e083d319679cd1e0b5eebffffed97e1b366c484b972ecd96fff99fff39db1661433c967f0db16ffd7f5f53afa7a973977abf9a3a5fa9d7f395af7c255b9f356b5616ba08400010800000746200922fd13be1c5175fccb645cf86fadbe3b110bd2562fd37bff94df6332ef8eb07044d1d7fedb5d716f51ac90710f9f57cef9042f9a0247a557ce31bdf48f7de7b6fd60b23447071d5555765a145e16b28f7f53475ee52014853e72bf57af2c77cf8e1875911800020000100e8c400247cf7bbdf4dfbeebb6f7af2c9271b5cacd777d1451765dba2a746616051ea62bfbe99336766dba2b747fc9c3c7972d1fad4a9531b1c13e799376f5efadef7be97feeeeffe2edb2f266d0d316f49acffea57bf6a360069ecf53475eee60290c6ce57eaf5084000108000007471001217e471d17fc00107644337aaababb36d0f3ef860ddf098934e3aa928c0881e13f1f3b1c71e6b70bea68edfb8716351af9350d85ba2b13bd1c41099d8163d54f2c3702230290c16f2cfd35800d2d4eb69eadca5deafa6ce57eaf5c410997e1f0f81c9bf87021000042000009d188084b8308ff573cf3d37fde94f7fcae6b988093be3823e2ede23b808bb76ed4a7beeb967b66ffccc0f17293c5f53c787e86d12fbfee4273fc9d663d849fef8ddbb773778ad716ccc1d12e78be0250293986c347f6c3c47fd8945cb7d3d4d9dbbd4fbd5d4f94abd9e985835e65889e718366c980004000108004067042000000210004000020020000100042000000210004000020008400000042000800004004000020008400000042000800004001080000008400000010800800004001080000008400000010800800004001080000002100000010800200001001080000002100000010800200001000420000002100040000200200001000420000002100040000200084000000420008000040040000200084000000420008000040040000200084000000108008000040010800000084000000108008000040010800000021000000108002000010010800000021000000108002000010010800000021000400002002000010004200000021000400002002000010004200080000400400002ddc2ba75ebd2a2458bd2ecd9b3d3d34f3fad747279e69967d2fcf9f3d3ead5ab7d18410002002000818e0a3f162c5890b66cd992fef297bf285d54b66edd9ae6cd9b9756ad5ae54309021000000108b4b7e8f921fce83e2148f4c201042000000210686771c12d7ce83e2586c400021000000108b4b3b8e0163c0840000108002000010148aebcfde74de9f51726a595cf5c9f95588ec784160210400002000840a05704203bb7d7a6154f5e935e7ee2f2a2128fc536c1850004108000000210e8f101c8fa95bf68107ee4cb8695b304170210400002000840a0e70720afcebdad640012db04170210400002000840a0c707202b9ebeae640012db041702104000020008404000a2084040000200200081ee1e80c45d5f4a0520b14d702100010420008000047a7c00b27ae18f4b0620b14d702100010420008000047a7c00b2ad76795af1d4d886c35f728fc536c1850004108000000210e8f1014894352f3edc200089c784160210400002000840a0770420efbd97563ff79386c35f728fc536c1850004108000000210e8d101c8ceedb569d5c2bb4ace0112db621fe1850004108000000210e87901c87befa54dabe7a4577e7d55c9f0235f629fd8576f100108200001000420d0630290e67a7de80d2200010420008000047a7c00524eaf8fa67a830832042020000100108040b70f405a1b7ee48b2043000202100000010874fb004411800002100040000202104500020840000001080840140108084000000420200051042020000100108080004400d2b7d4d4d4a4f1e3c7a7912347a6eaeaea54515191ce3df7dcac545555a5112346a471e3c665fb81000400400002021001488f326ddab43474e8d0a2c0a3b93264c8903471e2445f5e04200000021010800840bab7d75e7b2d0d1b36acecd0a3b172fef9e7a7e5cb97fb1223000100108080004400d2fd4c9a34291bd6521866c4fa2db7dc92e6cc9993d6ad5b97de7aebad6cdf77de7927d5d6d6a6850b17664364ce3befbca2e3a2e788de2008400000042020001180742bd3a74f6f30bfc7942953d2962d5bca3a7efbf6edd9fef50394bbefbedb971901080020000104200290eed1f3a330fc183d7a74d6dba335e2b8cb2fbfbc2804d11304010800200001042002902e15737e14f6da183b766cdd3097d68ae13137dd7453d17098a54b97fa5223000100042080004400d2352eb8e082a29e1f6d0d3f0a4390c29e2031312a0840000001082000118074bab8d56de19c1fad1df6524a9cafb07789a1300840000001082000118074baa14387d6851331816947872c7a81200001000420d087c445e7534f3d2500118074e967aca6a6a66ee2d3e8a5b16ddbb60e792d717798c25be4c69c23200001000420d007e42f04e32275f6ecd9dd3200f9f822212b7bedb5573ae28823b2d7dad6f30940bacf676cfcf8f175fb8d1b37ae435f4f673e1708400000010874b38bd37c8949281bfb6b7d7708406239fe621fcbfdfbf7d703a4177dc6468e1c59b77ddebc791dfa7a162e5c58f75cc3870f5709200001000420d0170390c2bfd6175ea476970024bf1e3d416279ebd6ad69c0800169efbdf74efbecb34f3af3cc33d3860d1bd2d4a953b3fdaaababb3fd629f588fb9250acf57eaf8d876e081076617c8b17ccf3df764c7fce8473fcad6478c1891f6db6f3f01483b7dc6e2f7947fbcbd273fadafb6b6b6eeb92a2b2b5502084000000108f4e500a4f0aff5316ca1bb04204b962cc9968f3efae86c7dd0a041d97a3cbe6cd9b26cf994534e491b376ecc960f39e4906cbfc30e3b2c5b5fbf7e7dd1f94a1d1fdbce38e38cf4b9cf7d2e5b3ee18413b26dc71f7f7cb67ed04107a5d34f3f5d00d24e9fb1c2f5f6baf56d29714bdcc2e703010800200081565cccf5d6d25de6008972cc31c7a4458b1665dba2e746fdedf1586c3beaa8a3b2f5b973e7663f8f3cf2c806814a53c75f7df5d545bd46f6df7fffa2f57cef90ae28bdf9b3d6d9df631080000002102871e1d417029d810307a6e9d3a76717dba1bbf40019356a54da77df7dd3134f3c511460ecdab5abc17131af446c8b9e1a85814563014863c7cf983123db16bd3de2e7030f3c50b4fef0c30feb01d24e9fb1fc1d60f4004100020020004100d22917a7f5838fbcee1280445011778139e08003b2e12c3187436cbbefbefbea86c79c78e289450146cc17123f1f7df4d106e76beaf8b56bd716f53a89c78e3beeb8bac7da72279abe1c8034f61933070802100000010802904eb9388db930a64d9bd620f8e86e01489499336766eb679f7d76dabc7973f6da6302d3e8cd11f377447011fbedd8b123edb9e79ed9bef133263cad7fbea68e8f12bd4d62dfbbeeba2b5b9f306142ddf1d1934000d23e9f3177814100020020004100d2a14af5f8e84e0188d2b30390723e63e3c78faf0b25c68d1bd7a1afa7339f0b04200080000401480f2300118074a49a9a9aba50a2aaaa2a6ddbb6ad439e67fbf6ed45c36d5e7bed35951a0210004000020210018800a4f30c1d3ab42e98883bed74841882937f8ef3cf3f5f85860004001080800044002200e95c85e144f40269efc950e37c71defc734c9c385185860004001080800044002200e97c43860ca90b28468f1edd6eb7c48d096b2fbdf4d2a2de1fcdcd7b03021000400082004400d261e5d9679f4d279d74528f0d26eabffe7ef5ee602300695accc95151515117548c1d3bb6cd2148841f37de7863dd39e3fc4b972e55992100010004202000e9ba00a4a30283aeba65af1e202d3769d2a4bab022df13a4b5c361e2b8c29e1f86be2000010004202000695500b276edda74f2c927a7bdf6da2bf5efdf3f2d5ab4a8d120a070fdf1c71f4f471d755476cc3efbec93f59888bb80ecbdf7de75fbe5f78dbb810c1f3e3cdb2fb68f183122edd8b1a3e89c5ffad297b273edb7df7e598f8133ce3823dbf7c0030fcc26d38c7db76edd9a060c18903d1ee73af3cc33d3860d1b8ace13afe3b8e38e2b196a146e8f9e1e471e7964f6bcf13c93274f6ef4f537b67cd96597a57df7dd377de6339f49f7dd775fb62dfefd71ee38dfd9679fdd6c90d29b039070efbdf7168516317747fc2ee32e2ee588fd624e91c2393fa2dc7cf3cd2a3104200080000404202d0f404e3df5d4ac111fc147fc3cfae8a39b0d40f6df7fff6c79cd9a3569f1e2c5d9723e58a87f5c841fb13e75ead43463c68c6c394290c27d1f7becb1ec5cf9f5d86ff5ead5d9f201071c90ed3b68d0a06c7dc9922569d9b265d9f229a79c52749ed9b367a78d1b37960c400ab747f811af7dfdfaf5d9b6f83735f7efce2fcf9c3933ad58b1a2e8f5c56bc96fcbff3bfb7200d2584f907c10326edcb8346fdebcac77477e784c0c73a9adad4d0b172e4c77de79671a387060d17131ec2542151080000002101080b42a00c9f77a686e2848e1fa09279c902d476f870850264c9890f5d068ecb8fcf977edda9595588ec79a7b8efaebf57b6734769e387f53c35a0ab747e072c5155764c14dbf123d3e4a052085dbf6dc73cf92ffcebe1e80849813a4f0f6b8ad2931e1a9393f1080000008401080747a001217f871be8b2fbe387dfef39fcf1e3fe288231a3d2e86abd40f0662f8486b0390c6428ee6c286c6b6c7709f786cd6ac596d0a401a7b7d0290861e79e491160721117c44af0f777b4100020020004100d2e600243f0426861ef42b180213f35bc47a0cf578e289278a2ee88f3ffef8ba613331a424960f3ae8a06c5b841bb11ef37c4410901fba52380466e4c8912d0e402a2b2bb3e598732386c1c4f289279ed8ea00241f58e4cf95df5efff5971b809c7efae97543601e7df4510148093157ca1d77dc917d06eacfef11bfe31832154364a2e7080840000004200840da2d0089a1201168c4709698d834e6c588c76352d09817237a705c72c9254517f431716a4c541adbe2b8184612938ac6b6071f7c309b17238686c4a49731096afce53f02872871e15b7f12d4720290cd9b3767614a7e32d59873235e476b039018b613e7193c7870d1f6faafbfdc0024dec7638e39263b2efebdfd3e1e22240001010800800004014837084094f62971079b5b6fbd359bcc337a39f42be84d230001010800800004018800a4579418fa128147fe36bd31516cfe96c2021010800000084010800840fa641180800004004000820044002200010420000002100420021001082000010004202000118008400001080020004100220051042080000400108020001180280210400002409bae52ffeaf5d75f9ff1fcf3cf7f387bf6ecac01a8746e79e69967d2fcf9f3ff982bd50210042002104500020840b4d1b5d1810e1015eb82050bd2962d5b3480bbb06cddba353dfbecb33b7215edb70520084004208a0004e8db018836ba363ad001225556b1769b0af62fb906f8ab021004200210450002f4ed00441b5d1b1de800d1a54ec5d6ad1ae0bb0520084004208a0004e8db018836ba363ad00134c0bb5f035c0082004400a2084080be1d80f83f421b1de8c2caf5ed3f6f4aafbf3029ad7ce6faacc4723ca64254b90a401080084004208000a4eb0290f776bd93b6ae7d21fde1f9fbd2da977fae4ed74607da52b9eedc5e9b563c794d7af989cb8b4a3c16db548a2a5701080210018800041080746e1b7dfb9babd2da65d38bdae9bf5ff04375ba363ad096ca75fdca5f34083ff265c3ca592a4595ab000401880044000208403aa18dfeeeceeda9f6d55fa7dfcdb9a5b85dfecbff935e7f61727a7bc79bea746d74a02d01c8ab736f2b1980c43695a2ca55008200440022000104201ddb467fe7ad2d25dbe5d10b24b6d52fafcdbb3d6d5dbb583daf8d0e941b80ac78faba9201486c5329aa5c05200840042002104000d2b16df4d7e6df51b24dde54312f88363a200051b90a401080084014010808407a4c1bbd9cb0236e54b0e6c587ffa7bc34256dfcfdd369fbe6dfabebb5d181721ae071d79752956c6c5329aa5c05200840042002104000d2f50148c936fbd3daecdae8405901c8ea853f2e5999c63695a2ca55008200a4e566cf9eadde1380000290760d40562dbc2bd52c7eb0a8bcb1e4a769db8665ea7a6d74a09c00645bedf2b4e2a9b10d87bfe41e8b6d2a4595ab00040148cb2d58b0206dd9b245ddd70dcae6cd9bb3400a108074e736faf25f5dd9aade1fcb7f3526bdb56dadfa5e1b1d28b70b768c21ac5f99c6632a4495ab00040148ebd4d4d4a479f3e6a537df74cbc2ee107eac5ab5ca97110420ddba8dbee6a5479a0d3b7e37e7e6067782895e21efecfca33a5f1b1d282b0079efbdb4fab99f341cfe927b2cb6a91455ae02100420ad0f41e6cc99937df795ae29c20f1080f49436fa5bdbd665bd39ca0940e2f6b7db6a5fd6bed646075a1280ecdc5e9ba5c64d8d338c7d548c2a57010802100004201ddb468fe1e72b9fb9a18c612f57a6ed9b5fd5bed64607ca0a40de7b2f6d5a3d27bdf2ebab9aad60639fd8576f1095ab000401080002904eeaa5ad68a3036daf5c9bebf5a13788ca550082000400018800441b1de8f1956b39bd3e9aea0da29254b90a401080002000118068a303ddbe726d6df8912f2a4995ab008472dd70c30d5900123f0140002200d1460754ae2a570108bdce6db7dd963ef1894fa4638f3d36fb79edb5d77a5300108068a36ba3032a5795ab0084de177ee4438fe801b2c71e7b084100108068a36ba3032a5795ab0084de197e34f738000840146d7440e5aa721580d0a3444f8fa6428efc767382002000d136d64687e22bac4f2e5fbe7cf8430f3df4ecadb7debae3e28b2fde3d68d0a06c42bdeaeaea8fbef39deffce5eaabaf7efdb6db6e9b922b7fef1d53b9aa5c05206db56eddba346ddab4acb742aece4905754e1a397264bae69a6bd23df7dc935e7ffd752dd156861b7a82002000d146d7466f5f555555079f73ce39a372edd619b9b23a5776461b365776e5ca9adcb699b99f97c57eae92bb61f0f1d8638f3d9c6b44efbee4924bd2bdf7de9b9e7ffef9545b5b9b76edda955580f173cb962de9a5975e4a0f3df450faee77bffbd1f7bef7bd37860d1b36d43ba87255b90a405aead7bffe7576e1de823a275d7ae9a569d2a4495aa405a146b93d3b5aba3f000840146df4862a2a2abe992b4fe7ca5f3e0e3cca297373fb57bb5aee0672171d836fbcf1c6f72ebffcf2ec42e3830f3e28bb525cb66c591a3366cc07c3870f7ff5acb3ce3adcbba97255b90a409a5353539372754e6a439d932ebcf0c2b47cf9f23e1f7eb4b447871004000188a28dde3ae79e7beea1151515bf6e41e8d15859e0bab9ebaea6feeaf1c71f9f3362c488346bd6ac165d8434f697dcc18307bfab3788ca55e52a0069ca2f7ff9cbd45e75ce902143fa646f90b60e67311c06000188a28dde32e79c73ceb99595957f2a0c33aaaaaad22db7dc92e6cc99930de97eebadb7b2efcd3befbc93f56a5eb870611a3f7e7c3aefbcf3ea87203bf506e982f063debc798b2fbae8a2b46ad5aa76a920df78e38db8b07977e8d0a1170a40546a2a5701487df3e7cf4f1d50e764f383f415cd4d785ad0584d4d7d66ca390f000840146df42cfc38ada2a2e283c2e063ca9429d950ed726cdfbe3ddb3f8e2b0c4272e734954467899e1f712152ee2fad5c71be61c386f5e9444be5aa72158034143d3f3ab0ce4913274eec33e14773c357ca0940829e20000840146df4e67b7e14861fa3478fce7a7bb4461c1743c0eb85207a8274b498f323fe6ada5e7f85ad2ffe2a3b60c080edb95f667f0188a2721580c49c1f9d50e7a4a54b97f6da06684be6ee28370069e97901108068a32b7da98d1e737e140e7b193b766cdd3097d68ae13137dd7453fde1307df2bab9b3aea03e79fdf5d7ff25c6df77a4279e78e2ddaaaaaa45021045e52a00c9d539a9a3eb9ce861127382f4e6f0a3dc9e1a2d09408420000840146df4c65556563e53d8f3a3ade147610852af27c802494507993973e64fe3cd7efffdf73bbcc21c3972e4e6bed8a547e5aa721580fc8f98acb4b3ea9cb8334c6f1b0ad39a612a2d0d4082394100108028dae8ff236e755b38e7476b87bd9412e72b9c13c450980eeafd916be4ee8edb4e7686975f7ef92f7db11788ca55e52a0029beb0eec43aa757f502696d28d19a00a4b5610b0002106d74a59706204fe7c38998c0b4234c9b364d2f908eb47cf9f2e13109615b6e3dd95283070fde1c63a77ac3fb175f825cf9b2ca55e5da159fab9e188044b2ddd9754e0420afbdf65ab7790f860e1d9a9e7aeaa956871fad1996d2da00a43004311c06809e10809c75d6599fcd5d6bfc7beee7a7b4d1b5d1dbabed5d555575707ee2d3e8a5b16ddbb60ef97ec5dd61eadd22f750a9453b7ae8a1879e7de081073ab5d21c3f7efcb2dc2ff2b2def0fe15744f7afa9c73cef9978eac5c0b2f60f6de7bef74f4d147a7c58b17b76ba5933f7f4bb7a95cbbe673d513039048b53bbbceb9ebaebbd2b871e3bacd7b90fffd4610327bf6ec4e0921da1280e49f7f8f3df6d01304806e1f80c40563fc3f9b6b436dcf9531b9f6d4a73baa8d1e6df1134f3c316b9befb3cf3ee984134e480b172eccb63dfbecb3e9a4934eeaf0766d7bb7d14b9daf33ae05baaa8d5e4edb3bf7f8a8fc7e1dddaecc5d2f17062097492ddad1adb7debae3f9e79fefd44af3b9e79e7b23f78b9cd59b029082f2abc6d2c3f60c406279eedcb9d97284209d151a0840badfe7aa2706207121ddd975cea2458bd2f0e1c3bb5d00922f175c7041933d42da63184a5b0390604e10007a4200123d3feafd5fbb2b576ecf5dc01ed5de6df4238e38227b3f962f5f9e962c59922d7ffef39fefd4b673670520bdb98d5e4edb3bf7d88cfcf679f3e675e8772c42b482d7324b6ad18e2ebef8e2dd9b366dead44a73f3e6cd5b72bfc8f5bd3400a94b0f0bbf34ed1d80e4d7f7da6bafa26d91321f77dc71d963d12d2b2efa228d8e543a6e39ba63c78e3475ead46cdfeaeaea6cbfb85568acc738b6c2e7882103c71c734c76fce0c1838bb66dddba353b2e9f769f79e69969c3860d255ff365975d96f6dd77dff499cf7c26dd77df7dcd9ee3c0030fcc5e7b2cdf73cf3dd9397ef4a31f65ebf1efd86fbffdfa5a00d2e8e7aa270620b93a2775419d932a2b2bbb6d0052d823a47e10d25e7370b44700d29eaf0700014817b5a5a61506216d6da3471b36de8f6837173e1eeddbc2ff7b9b6a9b976acbb7b4bddddc31d123e5c8238fccae1fa2ad3d79f2e466dbfca59ea7a9367e2f09401ab4bd73ebabf38fb7f7e4a7f5d5d6d616be8ef5528b763468d0a0b46bd7ae4ead34e3f92289edcd0148617a18dda83aaa0748545685dba23bfdc68d1bb3c7a2828dc722f098316346b61c156d6c8fe5430e3924dbefb0c30ecbd6d7af5f5ff41c279f7c72b63c73e6ccf4f8e38f176d8bcf4d2c47d2bd6cd9b26cf994534e29f99ae31c2b56acc8960f38e08066cf71c61967a4cf7dee73d97274258c6dc71f7f7cb67ed04107a5d34f3fbd4f0620f53f573d3100e9c23aa7db0720853d42e2bb5c4e8f8bc2c6557b97e642107382000840fa7a1b3d8642c4fb1121c0c89123b39e20a5fe7859aa6d5eaa2ddfd2f67673c744f8114376f26dfefdf7dfbfd9367f730148636dfcde1480147e5e72e5ddfc7a7bddfab694b8256e610f26a9453bffb2bbe305406f2bed3d07c89e7bee9955620b162c28da16177af593e7782c4a7eee90d876d4514765ebf92025ce55bf626becf8fadbeacf4b524eaf9578edcd9de3eaabaf2eea95121574e17abe77486b4b6ff95cf5c400449d535ef9d6b7be95fd7e8f3df6d8721aa19d1a8084785db1cf1b6fbce14a00a00f0620c3860ddbeb5ffff55fffafb3ce3a6bff9863a3babafa73b9e5bf3be79c73fe776ebd7f5555d53fe696bf94fb3fedf8f80bfad9679ffdffe6d6ffbfdcfa37e256a2b9e5b372cb95b9e581b93234b7fe9ddcfac5b9e54b63de8edcf235b9727d6efd96dcfa0f72cb3fca95bb73cbf7e77e4ece959fe6b64dcfadcfcc2dff57ae3c952b7373e537b9f2db32feaffd30573e688f367a0c5788e0214290786f221469ac1ddc54dbbca9b67c4bdadb4d1db366cd9a74c51557643d4cca6df337178034d6c6ef0b6df4ce6ebb4a2ddad1c081033feaecbfc6befbeebb9bfb400f90177215f269279f7cf25f75d41098e6b6e5bbe41556665131c7b648a8633d7a5214060a2d0d400a2be97287ed94738e7c2a1ebd3de2674c9a59b8fef0c30ff7d51e20459fab9e1880e4ea9cd405754e8fe80112efcdf4e9d3b3cf6828e7ae2f7a8000d045ff8fbd9f2befe4ca9f73656bae6ccc95b5b9f2875c7935d75e599efbf952ae3c1fb7f2aca8a89893fbf9648415115a447811214684191f871a7747c8116147841e117e4408f2f124a69746381221498425119a447812214a842911aa44b812214bae9c505959f9cf4db4a556c579feeddffe6dbf684fb5e75d60f23d2bea871ae5b4cd1b6bcbb7a6bdddd431fdfbf7cfb6cd9a35ab430290f69837a41bf600a96b7be79677ea01d20b5c74d1457fe9ecf1f81b376efc7d2f9e03a4fe056abfae0a40f25de00abbd945f0511830c418c0f8f9e8a38f36384f7497cb776dcbef9fdf16f329c4728cf5cb4ff8143360b7240069ea1c6bd7aeaddb373fcca730ad8eee817d2c0069f473d513039051a34675fa1c20f17cdd790e90fac147636183394000e82e7ac81098ad85ffd7c61d61223cc9b58f3fd99e6df47ca810434b5e7cf1c56c3926468d6df91e2131cf47040b4db5cd1b6bcbb7a6bdddd431f9a023ff78396dfe3e1c8034687b9b03a497b8e69a6b5677f61d199e7cf2c95ff6c2bbc02c8a04ba910bd42e0b4062a2a59854312abb2851c1e6275a8a9fd14d2ddf5d2d264caa7f9e9a9a9aec2e331192c4790ab7c5a4925189e727718a8a33428b960420cd9d23ff9f46dcc234d6274c9850777ca4a27d240069f273d5130390ebaebbaed3ef021343bdbae35d60e2f31fb7056e2cf8682c74684b8f8b7eee020340df0a40d614dc01e6badcffb97fdd116df49867237f1bdc6853c7dc7571f7b9d8f6e0830f66f362c4e3318cbba9b679636df9d6b4b79b3a26dad2f158fd894e9b6af3f7c100a464dbdb5d607a89db6fbffd81185ed099c68e1dfb446fb99f71137f996ff70044e953b7c12deb73d5130390a86f3abbce89b1b81d7dbff69668aac7477321486bc387b6062031ec6c8f3df6107e00d05302901886333ee627d146d7466f8fb6776efba87c28d1d1edcaf1e3c717062097492ddad1bffffbbfffef51a3467df8c1071f74569db9abb2b2b226f78b3cb42fbdcf2a57956b07e9718da6d75f7f3d1b06d389754e3aefbcf3b25bbcf5746de981d19600241fbe8c193346ab1f801e118094eaf1a18dae8dde5a55555507e7ae61774728915bce7af47484eddbb7a7eaeaea8f0a029043fbd1be468f1efd87975e7aa9532acc279f7c724a4c84d4d7de6395abca5500f23fe29ef19d55e7cc9f3f3f9d7ffef9bda6d1d9da9e20ad0d40841f00f4c400441b5d1bbd235454543c9d0f266258534788e1d105e1479fbb6eee1443860c39ebd24b2fdddd097f91dd5e5959b924f7c1a91680282ad7be1b80c4a4bbb93aa7537a8144f83171e2c45ed5f08c9e202d1d8ed29a00c49c1f000840146df4a200e49bf970227a81b4f764a871bedcf5725def8fbe78dddc69860f1fbe3c6e89d49162be9148b1ca98d74000a208407a71001262184c47d73931d74804202d996ba32785202d9918b5a501885bdd02200051b4d11bca5dcfcecd0714a3478f6eb75be2c64d1e2ebdf4d20f0a7b7ff4c5ebe6cefc451e3a78f0e07757ad5ad52115e5f2e5cb1fcf3dc7a68a8a8afe7df1fded6e956bbf769aa9b9a79c4f00d2fdc49c1c310b7947d539bffbddefb25bc12d5dbab4d736405b321ca62501484bc3150004207db98d1e13621e76d861d95d54f6db6fbfacfd117756296cd34689ed718bdcd9b36737d896bf734cfc2c7cbca3af099e7df6d974d2492709405a78dd5c789be5b163c7b6390489f0e3a69b6e2a9cf763675fbd6eee54d5d5d555c3870f7f67cb962ded5a496ed8b0e137b98a606d5feec22300118008401a9a3c7972767bdaf6ae73e2dee9b9faacd70d7d694b08526e00d29ae135000840fa6a1b3d6e2d1befc7d7bef6b5b46bd7aef4f8e38f67eb715bd9fa6ddaf8e34f2cf7efdfbf4100f2831ffca02e4ce9cc00a4b39ea7b7b5d1cf39e79c73f313a2e67b82b476384c1c57afe787a12f9da9aaaa6af0b061c376b6d75f65a3e747841fb90fc998befcbe7664001215ed51471d95a5ca71cfef4871f3a973a4ba471e7964b6edc0030fcc2e38eb57765bb76e4d03060cc8ee0b1ec79f79e699115a357bee52956753e72bf57ae23f84638e3926dbbffebdc90520bd370009f7de7b6fcad539edd613247a7e44f871f3cd37f79986683921483901485b6fb50b8000a4afb5d1a3fd1aefc7cc9933cb0a18f23d410ab74520f28d6f7c237b2c7e465bb9545bb854dbfc84134ec8f6cf5d7b65fbc5cf583ffef8e34b1e136df5fa614b53edf8fc7e5ffad297ea7abb44ef8733ce3823db3fdaf63131685f69a39f7beeb9830a4390981324fefd71179772c47e31e169e19c1f51fafa757397255ab90b881dfff99ffff9761b2629dc7ec71d774c8a612ff1e1e8ebef69470620fbefbf7f5619ad59b3262d5ebc385b3eeeb8e3b26d5181c663ebd7afcf1e8f7deb57c683060dca96972c5992962d5b962d9f72ca29cd9ebb54e5ded4f94abd9e934f3eb9ee3f8f7c722e00e91b01489834695276abda5c9dd3a68951a3c747743b8d50a5af69ebb015c35e001080b4bc441010efc78e1d3b9a0d40a26ddc58ef909123476601420c8388f3c57aa9b670a9b6f9d4a953b3e5abafbe3adbefca2bafccd6efbbefbe26dbf3f59fa7a9767c7edfc71e7b2c3b577e7dc68c1969f5ead5d9f201071cd0a7dae871dd9c2bdb0b038c0842a227cfbc79f3b2de1df9e131f1fb8d5eca0b172e4c77de79671a3870e08785c7c5b017d7cd5d3cb6297721317bf8f0e19b735f80775b5027ee7aeaa9a7a6555757bf1013b718bbd4f101483ef18d0af3d4534fcdbae2457a1bdba272bae28a2bb24aaeb0822b5cae9ffe4689c79a3b77a9cabda9f3957a3df963a2eb60140148df0a4042f4028a9e20dff9ce775a3c6fc782050bb29e4331e1696f9ef3a3dc10a3a53d384c780a8000a47565cf3df7ccde8f6ddbb6351980e44bf418c9cff7511820c4cfe84d91ff8360a9b670a9b679b49f0f3ae8a074c8218764fbc59c241146ecdcb9b3c9f67cfde769aa1ddf586f96a6d6fb4a1b3dae9b0b6f8fdbcae2bab91bfd42bf1d41c8a04183b6dc7aebad2b7ff39bdfacadadaddd145fb2f0eebbef6edeb871e3ef9f79e699ffbaeebaeb7e555555f57afc0223bd326b6de70420f1bb88f35f7cf1c5e9f39fff7c56f1c4044bb12dbad4c57adc6da3b90024ced392733717803476be52af47002200c97be49147b22024c28c180f1b297974bd2ca873d2a64d9bd2fcf9f3b3743d7a8ec4bed1eba337deeda5a55a3a8cc5b017000420ad6f53466f8e7287c0c41df0f6dd77dff4c4134f146d8b9e0111a44480112145ac976a0b37d536cf0728d17e8a9f975c7249b3c7940a401a6bc70b409abf6efe3808d9dd92e0c37573375555557570ee177a49ee17342357d6e4caae8f7f69f1737daeccca95cb2201f36e756e001263fbfa7d3c7bf4c68d1bb3e5a8400b2bb17c97bbc60290183290ef2297dfefc4134f6cf6dca52ac4a6ce57eaf544d7bafc7f1ef9145c00d2370390bc189b7ac71d7764dd40a32b61e17f16f1198bc9532300899e23b42ed478f8e187b3fdc68c19e34d034000d28a72cf3df764ef47ccdd11a1410c0f89f5c30f3fbc411b39b647f0103d33f2c3c1f3db625e8e588e61e14d85094db5cde30f4611a0e487bcac58b1a2d9632290c90fe189d7d7543b5e00e2ba19ba4500b276edda6cf2a198a8282abd185e12938de667a68ed0a1fec4a285cb9b376fcec6fbc5f1b16f841171cee6ce5d2a0069ea7ca55e4f5cec46821ecf3174e85001880084366a6e4e8ffcdd5e841f000840dad6ae8cb02086b6144e325a7f984b7edffcf096b3cf3ebb68dbf7bffffd6cf9a69b6e6a324c68ae6d1e1398160629cd1df3e0830f66814cf44089093c9b6ac70b40806e1180280210684ca99e2086bd002000e95d6df4e8bd11f37ae47b92e403186d7440e5aa0840e8b32188f003000148ef6ba3c7b097e8b111436c264f9eac8d0ea85c1501087d3b0439f6d863851f000840b4d1b5d10195abca550042ef15737ec4045c6e750b8000441b5d1b1d50b9aa5c0520f46a1180008000441b5d1b1d50b9aa5c05200840004000a268a3032a5795ab000401080002100188a28d0ea85c55ae02100420000840b4d11501080840546a2a5701080210000420dae88a000404208aca550082000400018836ba363aa0725554ae02100420000840b4d1b5d10195ab22000101080002106d746d7440e5aa0840108000f41d35353569fcf8f169e4c891a9baba3a55545464f56194aaaaaa3462c488346edcb86c3f04208a363aa07255b90a40108000f428d3a64d4b43870e2d0a3c9a2b43860c4913274ef4e60940146d7440e5aa721580200001e8de5e7bedb5346cd8b0b2438fc6caf9e79f9f962f5feecd148028dae880ca55e52a00410002d0fd4c9a34291bd6521866c4fa2db7dc92e6cc9993d6ad5b97de7aebad6cdf77de7927d5d6d6a6850b17664364ce3befbca2e3a2e788de200210451b1d50b9aa5c0520084000ba95e9d3a73798df63ca942969cb962d651dbf7dfbf66cfffa01cadd77dfedcd158028dae880ca55e52a00410002d0f5a2e74761f8317af4e8acb7476bc471975f7e795108a227880044d1460754ae2a5701080210802e15737e14f6da183b766cdd3097d68ae13137dd7453d17098a54b977ab305208a363aa07255b90a40108000748d0b2eb8a0a8e7475bc38fc210a4b027484c8c8a0044d14607ca307bf66c955af729bb7295eb6e01080210809e2d6e755b38e74773c35e1e7ffcf1169d3fce57d8bbc45098de178068a36ba3031d60fefcf99b62122e155bd797dadada9fe52ad75705200840007ab6a14387d6851331816953b66edd9a0d65892133ad0d59f402e97d018836ba363ad001e6cc9973fabc79f3fefce69b6fbeab82ebba54392ad6679e79666dae7c5b00820004a0fb061b4f3df55493fbd4d4d4d44d7c1abd34b66ddbd6e4fef197fefc30990f3ef8a0d9d7f0d1471f653fe3ee3085b7c86d69802200d14657fa641b1dc87da14f7bfae9a75f88ae5d31be4de9f412effbabbdac62d54a460002f4cafa2a4a0421115c3466fcf8f175fb8d1b37aed973c6fef9c0e43ffee33f9add7fe1c285ad7e2e018836bad2e7dbe8000840108000941f80e44b4c745abf47c8c89123ebb6cf9b37afc9f37df8e187d9f095fcfed5d5d569d3a64d25f77ff9e597d3e4c9938bc290fcb1c3870f1780f4b20004001080200001e8160148618f907c10122146fef1e6263f5db56a55d179a227c80d37dcd0e8be7ffad39fd2b061c3d2f3cf3f5ff7586d6d6dddb195959502100108002000410002d0710148618f90c2f5e66e7dfbf39fffbc6ef84b61993f7f7ed17ed15364ecd8b1d9be3b76eca87b3c6e895b789c00440002000840108000ed7491af945f9a73cd35d7340840627dc8902169e7ce9d75fb4d9d3a35db76d9659735f9fb128008400000010802906e29bac72f5ab4289b4cd164739d5f9e79e699ec2fedab57aff645f49d6c53383470e0c0347dfaf4ecce11858146533d40a2f74663bd3ff221c83df7dc93edf7d24b2fd5ed3769d2a406e710800840000001082eb6ba7df8b160c182b465cb16b71aecc2b275ebd66ca2ca988b0101484b0390c2e023afdc39407efbdbdf16cddf11a5fef9e3b3593849eae2c58b8bce610e100108002000c1c556b7173d3f841fdd270429754b53df491a0b40060d1a94a64d9b56147ce4957b1798fbefbfbf2ef468ac2748feb1c29f85c36282bbc00840000001082eb6babdb8e0163e749f124362108034a7b11e1ff58d1f3fbe2e9418376e5cc9fd468d1a55b7dfcf7ef6b374c71d77343924e6f2cb2f6ff573094000000420b8d8ea3271c12d781080f84ef63e35353575a144555555dab66d5b837d366dda54b7cf95575e993ef8e083ecb1d8bf5400f2d0430f159d63fbf6ed45c36d5e7bed3501880004001080e062abe706206fff79537afd854969e533d7672596e331a18500c477b2fb1a3a74685d303165ca9406db9f7cf2c9ba394422f8c88b494e4bf50279f1c5178bce114370f2db629e10042000800004175b3d3600d9b9bd36ad78f29af4f213971795782cb6092e0420be93dd53613811bd3aea4f867afbedb767dbe6ce9d5bf478ccf111614663b7c68d3bbee4c5f90a7b8b4c9c38d19b2e0001000420b8d8eab901c8fa95bf68107ee4cb8695b304170210dfc96e6cc890217501c5e8d1a3eb6e891bc35d6212d598bfa331bff8c52f1a841f575c7145ddf608422ebdf4d2a2de1f4dcd49220001001080e062abdb0720afcebdad640012db04170210dfc9ee2be6e428ecc93176ecd82c0459b9726576a798b7df7ebbd1e3de7ffffd74e1851716ddfde591471ea90b3f6ebcf1c6a27064e9d2a5de6c0108002000c1c556cf0e40563c7d5dc90024b6092e0420be93dd5bcce951d89b237a82dc77df7d5908d294c2dbdb4659b2644936eca5b0e787a12f0210004000828b2d01882200f19dec36eebdf7dea2d0a2b2b2329b1835eee252ca471f7d94aebaeaaaa21e20f5ef1073f3cd377b73052000800004175bbd230089bbbe940a40629be04200e23bd9337b82e427471d376e5c9a376f5ed6bb233f47480c73a9adad4d3ffff9cfeb0290fa738244a8820004001080e062abd70420ab17feb8640012db04170210dfc99e23e60429bc3d6e6b4a4c786ace0f0108002000c1c556af0b40b6d52e4f2b9e1adb70f84beeb1d826b81080f84ef63c319ca5a54148041fd1ebc3dd5e042000800004175bbd320089b2e6c5871b0420f198d04200e23bd9b3d5d4d4a43beeb823bb234cfdf93d629e90e1c387674364a2e7080210004000828badde1d80bcf75e5afddc4f1a0e7fc93d16db04170210df491080000002105c6cf5e80064e7f6dab46ae15d25e700896db18ff04200e23b090210004000828bad9e1780bcf75edab47a4e7ae5d757950c3ff225f6897df5061180f84e820004001080e062abc70420cdf5fad01b4400e23b090210004000828bad1e1f8094d3eba3a9de20820c0188ef240210000001082eb6ba7d00d2daf0235f04190290b6bae1861bb2ef64fc0401080080000401488704208a00a42bdd76db6de9139ff8443af6d863b39fd75e7bad0a0a0108008000040188004400d2fbc28f7ce8113d40f6d8630f21080210000001080210018800a477861fcd3d0e0210000001080210018800a447899e1e4d851cf9ede604410002002000410022001180f4e8f0a3b970434f908e51535393c68f1f9f468e1c99aaabab53454545561f46a9aaaa4a23468c48e3c68dcbf6430002000840108008401401482be4438d727b76b4747f4a9b366d5a1a3a746851e0d15c193264489a3871a2374f0002000840108008401401484bc38f96f6e81082b4cd6bafbd96860d1b5676e8d15839fffcf3d3f2e5cbbd99021000400082004400a208403a22fc68afe3fbaa49932665c35a0ac38c58bfe5965bd29c3973d2ba75ebd25b6fbd95edfbce3befa4dadadab470e1c26c88cc79e79d57745cf41cd11b4400020008401080084014014809cd4d78dad9e7e92ba64f9fde607e8f2953a6a42d5bb69475fcf6eddbb3fdeb072877df7db7375700020008401080084014014863a1457b0d5fd113a4fc9e1f85e1c7e8d1a3b3de1ead11c75d7ef9e54521889e20021000400082004400a20840ea8515f9f0e3c30f3fcc26e18c9f2d51ff387382342de6fc28ecb53176ecd8ba612ead15c3636ebae9a6a2e1304b972ef5660b400000010802100188d2b70390fa3d3522bc38e28823b20bc5f8596e0852ea38214869175c704151cf8fb6861f852148614f9098181501080020004100220051fa6c00d2d83095e8c1f1f14562d9214861f8912f7137933c73823414b7ba2d9cf3a3b5c35e4a89f315f62e311446000200084010800840943e1980940a251a0b339a0a41cadddf9c20c52268ca871331816947872c7a8108400000010802902eb9f079eaa9a7042002904efb2c950a3f4a0d4b2937d4686958d21786c394f33ba9a9a9a99bf8347a696cdbb6ad435e4bdc1da6f016b931e78800440002000840108074eabf274a5c28cd9e3dbb5b06208517b47bedb55776511bafb5ade7138074cd67a935214473e1464bc38fc2e7df638f3d7a6d4f90727e27e3c78fafdb6fdcb8711dfa7a3af3b904200000021004208d5e20e54b4c84d8d85f8cbb430012cbf157e358eedfbfbf1e203df4b3543ffc28377c281572ecdebdbb55e147fd1e28bd310429e7773272e4c8baedf3e6cdebd0d7b370e1c2bae71a3e7cb800440002000840108074dd0552e15f8c0b2f94ba4b00925f8f9e20b1bc75ebd63460c080b4f7de7ba77df6d9279d79e69969c3860d69ead4a9d97ed5d5d5d97eb14facc7fc0685e72b757c6c3bf0c003b38bb458bee79e7bb2637ef4a31f65eb23468c48fbedb79f00a4159fa5d6841f4d8520ffeb7ffdaf56871f6d7d3dbde1fb1ddf91fce3ed3df9697db5b5b575cf555959290011800000021004205d7f8154f817e3e83adf5d0290254b9664cb471f7d74b63e68d0a06c3d1e5fb66c59b67cca29a7a48d1b3766cb871c7248b6df61871d96adaf5fbfbee87ca58e8f6d679c7146fadce73e972d9f70c209d9b6e38f3f3e5b3fe8a083d2e9a79f2e0069c567a9ad3d2e1a0b41da127ed40f417ad39c20e5fc4e0ad7dbebd6b7a5c42d710b9f4f00220001000420f4e00b8ade5abacb1c20518e39e698b468d1a26c5bf4dca8bf3d1e8b6d471d7554b63e77eedcece791471ed9205069eaf8abafbebaa8d7c8fefbef5fb49eef1dd215a5a77e8ebef5ad6f65efddb1c71edba6ef610c7ba9dff323d6e3f1b688d7d557bfe39d15480840042000800004ba55a03370e0c0347dfaf4ec623b74971e20a3468d4afbeebb6f7ae289278a028c5dbb7635382ee636886dd153a330b0682c0069ecf819336664dba2b747fc7ce081078ad61f7ef8613d405af1596aeeae2f7a8074eeef247f07183d40042000800004fa540052ff6235afbb04201154c445ee01071c900d6789790462db7df7dd57373ce6c4134f2c0a3062be90f8f9e8a38f36385f53c7af5dbbb6a8d7493c76dc71c7d53dd6963bd1f48500a4d467a9306c300748d7ff4ecc01220001000420d0a70290980b63dab4698d5eac76a70024cacc9933b3f5b3cf3e3b6ddebc397bed318169f4e688f93b22b888fd76ecd891f6dc73cf6cdff819139ed63f5f53c74789de26b1ef5d77dd95ad4f9830a1eef8f86bb600a4e59fa5d6f6b87017988ef99db80b8c0004001080409fd0d45fe9bb4b00a2f48c00a4dccf526b7a5e940a3ff2214773db4b89614c7becb147af0c3fcafd9d8c1f3fbe2e9418376e5c87be9ece7c2e0108008000045a45002200e928cdf5c02837dc686908920f5fc68c19d3a7bfdb35353575a144555555dab66d5b873ccff6eddb8b86dbbcf6da6b02100108002000010188d2770290a67a82b434d428777fe147b1a14387d605137197a38e104370f2cf71fef9e77bd305200080000404204adf0b40f23d41ea0f47890bf37e2d1cd6d25808326cd8b0b27b9cf44585e144f40269efc950e37c71defc734c9c38d19b2e0001000420200051fa660052184ee427462d0c335a32b169a9e37ae3ad6edbcb902143ea028ad1a347b7db2d7163b2e04b2fbdb4a8f7474be6891180000008404000922bd15dffc0030fcceef272d2492715dde1e5d9679fcd1e6be95d664a6d2bb55ceef30840ca537f384c8417d183a3a5b7b6ad7f5cfd7085623127474545455d503176ecd8368720117edc78e38d75e78cf32f5dbad49b2d000100042020006969d96bafbdb28b88b8e5edae5dbbca0e36da73bf728f1780b43e04698f9e25bdf96e2fed65d2a449756145be27486b87c3c471853d3f0c7d118000000210e87301483e3018346850da679f7dd2d1471f9dfdf5b9705bf4a838eeb8e3b2c7e2ae14c3870fcff6dd7befbdd3881123b2c02396fb15ccf350787c63dba2a7c691471e998526d16b64f2e4c945c7c47c13f11cc71c734c83d7536ab9fef39c70c209d9cfe5cb9767fbc5cf583ffef8e305205d1482b47798d2dbdd7befbd45a145ccdd113dade22e2ee588fd624e91c2393fa2dc7cf3cdde5c010800200081be19803cf6d863e9f1c71fcf96bff295af146d9b3d7b76dab87163f658841ff1d8d4a953d38c1933b2e508411aeb7d512ab08812e1c7e2c58bd3faf5ebb3c7f7df7fffa2fde2b5e45f4f7e484bbf3286c0142ec76b8ce5abafbe3a5bbff2ca2bb3f5fbeebb4f00d2ca9e1b6d19b662d84bfbf404c90721e3c68d4bf3e6cdcb7a77e487c7c43097dadadab470e1c274e79d77a6810307161d17c35e2254410002000840a0cf06203164254abf8f7b52d4df96df3fdfcba2a9fdcb0940d6ac5993aeb8e28aac674963fb3577fe7296e3f8830e3a281d72c821d9fa61871d960e38e080b473e74e01481b439096f6e030e169db442fa8c2dbe3b6a6c484a7e6fc108000000210108014040e31f4a4d47c1ab1adfefefbeebb6f8b0390fefdfb67ebb366cd6a360069ecf594b31c25268f8cf51ffce007d9cf4b2eb9c41c206dd4d2612c86bdb49f471e79a4c54148041fd1ebc3dd5e0420008000040420b9f2f0c30fd78511dff8c6374a0620315748bf7a4360468e1cd96c00122149bf820952f33d49962c59d2688011f31ce45fcfa9a79e5a76e851ff79366cd890cd3312436ce2f1152b5608403a310489cf55ec3766cc185fdc7654535393eeb8e38eecbb577f7e8fcacaca6ca85a0c91899e2308400000010808400ac28398c7236e5f1b435262784aa9002426418dbf40478011252ec0226c682e0079f0c107b3e127f11c116e4c9830213b7ef0e0c18d8619710117c1454ccaba7af5eab20390facf138f0d183020db7ef2c927bb0b4c3b6a6e4e8ffcdd5e841f084000000420d06d0290ee785bddb696e801b275ebd66c12d5f8372e5ab44800d2493d410c7b410002002000816e1580e47b72f4c6002486bdc4bfed88238ea8bbcdae00a4e34310e10702100000010874bb00441180b4670872ecb1c70a3f10800000084040002200e9bd62ce8fa8c3ddea16010800800004042002905eed8d37def02620000100108080004400020840000004202000118000021000400002084004208000040010808000441180000210004000020210450002084000000108084014010808400000042020005104202000010010808000440002084000000420200011800002100000ad30108008400001080020000101880044000208400000010808401401082000010004202000510420800004001080800044118080000400400002021045000202100000010874a0d9b3670b1e042080000400108040efb660c182b465cb16e14337289b376fce0229400002002000817656535393e6cd9b97de7cf34d214437083f56ad5ae543090210000001087454083267ce9c6cf885d23545f8010210000001080020000100108000000210004000020020000100042000000210004000020020000100042000000210004000020008400000042000800004004000020008400000042000800004001080000008400000010800800004001080000008400000010800200011800000021000400002002000010004200000021000400002002000010004200080000400400002000840000004200080000400400002000840000001080080000400108000000840000001080080000400ba9d9a9a9a346fdebcbaf5dadada74eeb9e7a6f3ce3b2f5d71c51569dab46902100000010800f44c2fbdf452bafefaebd3c89123d39429531a6cdfb56b57dab2654b5ab76e5ddd636fbcf1467afef9e7d3071f7c2000010010800040f777e79d776661c69ffffce7f4c8238f64bd3efaf7ef9ffefaafff3a0b033ef5a94fa5430f3d347dfdeb5f4f93264d4adbb76f4fab56ad4a575d7555bae69a6bb23044000200200001806ee79d77dea95bdeb469531a356a54167444c871fffdf7a7575e79256dddba35db1e81c7abafbe9a0d81f9f6b7bf9ded3762c488ecb85ffffad7e9820b2ec89605200000021000e83666cd9a95c68e1d9b2d8f1f3f3e7dfad39f4e975d76595ab3664df6d8cc99339b3c3ec28ed83f7a88dc72cb2de9adb7deea55ef8f000400108000400f17435d2ebae8a26c4e8f083162a84bf4f6c88b5e1f310466c58a15cd9e2b8e3beaa8a3b2de20bb77efce1e2bec592200010010800040a78bd023263a8dc94c23fcf8f297bf5c37cc256ff6ecd9590072c92597a4f7df7fbfd973fee94f7f4a5ffdea57b31024264b8de30a274b15800000084000a0d3c5ad6d63d84bf4fca81f7e84d83660c0802c04993e7d7ab3e75bb87061364748f40489e1304f3ffd7436316a4fbe3b8c000400108000400f17f377c49c1f85c35ef23efcf0c33478f0e074f7dd77a71ffef087a9baba3a0b4c4a79f9e597d3e4c993b3e5385fcc0912e78fbbc3bcf0c20b0210000001080074ae189612bd32e26e2f31fca531716bdbe8f991efd51161c8f7bffffdf4d1471f35d83786be0c1b362c9b53246fcc9831d95098952b57a6e5cb970b400000042000d0796a6a6ab25bd5466811b7b05dbf7e7da3fbfdfce73f4f15151569c78e1dd97a0c67894064eedcb945fb454f9108460af70dd1fb23cedfd8d01a010800403301484ca80600b45edcf6f681071e488f3cf2483aedb4d34aee77edb5d7a62bafbcb26e3d7a7ec46343870e2d0a3a1e7df4d12c18b9fcf2cb1b9ce3dbdffe76bafffefb7bec7bb57bf7eeed021000a0d37de10b5fd8d993c71003407770e79d77664355229c98346952a3fbc4ed6b2b2b2bd3cf7ef6b3f4873ffc21cd9933277b3c7a8b545555a509132664eb31b4257a7e4400d2d8b9a64d9b96befef5af67436e62b9a779e9a5975ecc3541566b8501009daa7ffffef79c7aeaa9bb355d01a0f566cc9891cde971f8e187373af969f8ed6f7f9b851a2fbdf452baf8e28bd3f0e1c3d3bbefbe9b6d8b5024b62d58b0209bf72326478df5c58b173738cfabafbe9a0e3df4d0ec96bb8df510e9e6767ff6b39f9d9d6b82dca215060074b64fe5ac3cf1c413b73efffcf3db77ef968500406bc55d5a4acdcf11c356ce3ffffcacb748f4f08812435dc2fbefbf9f2eb9e4922cf4887d7efce31f67db77eedcd9e03c11b4c43c203184f5bcf3ceeb19a9c7eedddba3e7c7c7e1c7d3b9f2494d3000a04b42905cb92e575eedf7df63721545519a2c7ff3377f935da8792f14e5bfcbc1071f9c5de8f76b6272f1e8f53160c080ecbb13435762c84bac6fdbb62ddb1e3d4762db73cf3d976eb8e18674c51557943c57fe797ad8f73086bddc2efc0000007a8cdc45d7acb8f03af9e493ffcabb01fdfa0d18306060dc02b7540f90b87b4b7c67a25c75d555d9ed72fff8c73f663d38eebefbeebafd62784cf40689c71f7ae8a146c38fc21e20d5d5d51f7af70100003ac039e79cf32fb98bb8dd7121575151f175ef0864a1e09a8d1b37be536a0e90279f7c320b3f060e1c98852179d1132486babcf1c61b758fad5cb932dbf7c5175f6c3400299c03e4e28b2f7ecbbb0f0000d001ce39e79c99f9bf64e7ca0bde11f8efefc582050b9e2f751798db6fbf3dfbcecc9d3bb7e8f1980435263dbdf1c61b8b26548d5024ee1ad398fc5d60962d5b96c68c19f38a771f0000a09de52ee0feef7cef8f7cc95df89de69dc177e3dccb6ebbedb6398f3cf2483aedb4d38a028b18ee12139b8e1f3fbed14023df3b64e9d2a5d9fad8b163d395575e5972fe8f08596242d5e83572d75d77fd1fef3e000040fb5fe4cd2a0c3ff2bd40cc05425f57595979ccc891237fb873e7cedd313fc7faf5eb8b86ace4b6a5b7df7ebbd140230292d1a347a7cb2ebb2ceb1112b7c08d20a531317c26cefff13c236b72c5770f0000a03d35d6fb235f2a2a2abee91d82ecd62cf78f1a352a0b330a87b434362f48a1175e7821fb2efdf0873fcc7e2e59b2a4d1fdc68c1993468c18915f1dea1d0700006867b98bb25f35167e7c5c167987200b400edeb871e37b9ffef4a7eb428f458b16a5727cfffbdfcfbe4f959595594f90fae27c719799e80572fdf5d7bf7dc10517fc83771c0000a01d35d5fbc35c20f03f72df833113264c981ef37df4efdf3f1baa12435cca515353934d7e7af5d557377aebdba38e3a2add72cb2d69ce9c3931a7c8ef0c3d030000686725e6fe68301788778abeeeacb3ce3a3cf75dd8f4fbdfff7ec125975c92befce52fe7e7eb28cb9d77de997efad39f36083fbefad5afa6a1438766bd3f060e1cf84ecc39e2dd060000e804117a7817a0d1efc6b72b2a2a6ad7ad5bb73c4290e809d2dc1c20796fbef9665ab16245d1b097e8f911e1c7ce9d3b633e918555555583bdcb0000009d7791270081d2df8f41d75d77dd9129a559311c26e6ee888951a307473962bf98f0348ebbe1861bf20fdfe2ae2f0000009d7f81270081326cdebcf9e275ebd6ed88bbc37cf2939f4ca79d765a9a346952d6bb233f3c2686b9c4ed72a74d9b960d298be0233fe4e597bffce59f6ebbedb65bbd930000005d400002657f57febdaaaaea778f3ffef87f6ddbb66d57841fdffce637d3e1871f9e051db95dd2a73ef5a974e8a18766737ddc7ffffd59f0b164c992b72fbcf0c2372a2a2a169af3030000a0eb2eea042050a68a8a8aeadc776641ae6c78f9e5972f4b294dca9557df7ffffdcdd10324f733ad5bb76ed3eeddbb97e556ef5abf7e7d556565e56f63288dbbbd00000074210108b45c454545ff4183067db2e07bb4bee04e4aababaaaa0ef62e010000fcffeddd7f6816f71dc0712193e08496165c29453aa174e2c4ca36e76851dc58b1818a2df6c9794974e2a43aa18582a5636cb4ac7f8c6dd03fbab951a19d1bc1b56410acec579f44abc1e96c27d96a51262a2e9aaa596843bba9b4e376dfc3a73c89498cf6b1cf7979bde08397e792e7797ae45b78dedc5d72440081da28954a0de97afac891000000c82101046aa3a9a9a9315d4f171c090000801c1240a03656ad5a353d5d4f1f3812000000392480406db4b6b6de94aea7214702000020870410a88d52a9746bba9e061d090000801c1240a03656ad5af5b9743d9d752400000072480081da686b6bbb3d5d4ffd8e040000400e092050b3b534339d7f3912000000f9fcd02680400d944aa559e97a3aee48000000e4900002b5512a95ee4ad7d3514702000020870410a88d388e67a7ebe9b02301000090430208d446144573d3f5f4962301000090430208d4461445f7a4eba9d791000000c82101046aa3a5a5e5cbe97a7ad391000000c82101046ab69616a6b3df91000000c8e7873601046ab396ee4d67af2301000090cf0f6d0208d4407373f3e2388e773b12000000392480406dc471fc8d743d753b12000000392480406dc4717c7fba9e5e732400000072480081da88a2a8295d4f7f702400000072480081da88e378591445af3a12000000392480406dc471fc5014459d8e040000400e092050b3b5f4483a1d8e040000403e3fb4092050035114ad8ce3f8b78e040000400e0920501b5114b5c671dcee48000000e4900002b511c7f1b7d2f5b4d591000000c82101046ab696be9dce8b8e040000403e3fb40920509bb5f4683a2f3812000000f9fcd02680400dc471bc318aa2cd8e040000400e0920579624c9678e1f3fdeb17ffffeff75777727e572d97ccad3d5d595ecd9b3e7dfe9b4e538803c1645d1f3560c0000800072430af1a3a7a7273977ee5c72f1e24553a71918184876efde3dd4d5d5f5484ed7d213e93c67c5000000082037a470e687f8919b0872b15c2e1fcee3ef4914454fc671fc132b0600004000b92185cb5ec487fc4cb95cfe30a701e4bb711cffc88a01000010406e48e11e14c243ae024892d3b5f4fd749eb56200000004904207900fde7b2739fec6af92b7bb7e984dd80e8f89169326803c93ced3560c0000800052d800f2febba793437ffe41f2f7df3f396cc263619f70312902c8b3e12c102b0600004000296c00e97bfbd5cbe247654ebdbd43b898040124dcff23dc07c48a01000010400a1b400eeffaf1980124ec132e26c519203f4d67931503000020801436801c2a3f33660009fb848b4911409e4be7092b060000400011404c6103481445cfc771fc9815030000208014368084bffa32560009fb848b497106c82fa228fa8e1503000020801436801cddfbf3310348d8275c4c8a00f2423a8f5a3100000002486103c8e0e97f24875e7bfaf2cb5fd2c7c23ee16252049017d3596bc50000000820850d20614ebcf99bcb0248784cb498347f06f7d75114adb6620000000490e206900b1792a37ff9e5e597bfa48f857dc2c5a40820ed5114b55a3100000002482103c8fbef9e4efeb9f76763de0324ec0bdf235e14fe129897d389ac1800000001a45801e4c285e49da33b93b7fef4bd31e34765c2f784ef753648a1ff0ceeefe2385e61c50000000820850920573aebc3d92093328074c671fc901503000020801426804ce4ac8ff1ce0611320a7909cc8e288a1eb4620000000490c204906b8d1f9511320a1940fe18c7f103560c0000800052980062049051d6d26b711cdf6fc50000000820028829f29fc1ddd9dcdcfc752b060000400011404c91cf00d993ce222b060000400011404c9103c8de74eeb562000000041001c4143980fcb5a5a5e5ab560c00008000228098220790bf4551f4252b060000400011404c9103486f1445f75831000000028800628a1c400ec571fc452b060000400011404c91ff0cee9152a9f4052b060000400011404c91cf00395a2a95eeb262000000041001c41439809c48e7f3560c00008000228098220790be74665a31000000028800628a1c40fadbdada6eb762000000041001c41439809c2b954a33ac1800000001440031d73d80a4bfd35f89a2a8b30e6b69b0542add6ac5000000082002c8554cfad21f4f636363326fdebce4c08103d7e535ae765f1e0348081fe9ec48e7c37afc5ea7af39d4dada7a931503000020800820d7182776edda956d8708528fd7cf730019193e2a5387b5f49f65cb967dd68a010000104004904f1020c2f6d4a95387ed5bbc7871b260c182ecb1c1c1c164fdfaf5c9b469d3b23346366cd8900c0d0d25dbb66dcbbeb7adad2dfbbed5ab57675fb7b7b70f7b8d23478e24f3e7cfcf7e7eeddab5c3f60d0c0c643f179e37ec5fb1624572ead4a9ba0690288abe162e7519193eea18402e343535355a31000000028800f209cf000981a27a5f777777d2dfdf9f3d16e247782c048f8e8e8e6c3b4490b03f6cdf79e79dd9f7cd9a352bfbbaafaf6fd86b2c59b224dbeeecec4cb66fdf3e6cdf9a356bb2ed83070f26bdbdbdd9f6d2a54beb1640463be3230701e4a352a9d460c5000000e43480982b4fbdef01d2d0d090cc993327e9e9e919b6effcf9f31f7f7f383ba3f258982997ee1d12f6cd9d3b37fbba1252c2738d8c2ca3fdfcc87d5346dc97a48e012497e3ff28000000dcb0f27209cc95f6854b5346068ce9d3a767fb366edc987dbd7cf9f2ecdf70b6c8b50490eae052ef7b803437377f73e5ca95fbc408000000984401a472994af52530217c847d95afc33d44c2bfafbcf2ca65cf132e699972e91298caf757f6b5b4b464db5bb66cc92e8309db8b162dcac54d50e3387e60e5ca953d02080000004c8200126e82ba6eddbaec6c8d30217e849ba0867de1df7019cd944b97d3849b9a8e7c9e63c78e657f65264492f03cd5fbce9c39930596ca0d56432c3979f264aefe0ceea533427a0410000000b8810288b9ba005271e98c907d7e730100004000296c0001000000041001040000001040041000000010408c000200000002c8d5fe1597eaedddbb77278b172f9ed0735ccfbf32732ddf37f2bd4fe4f9aee5bf4f00010000801b30805c4b6cc86300b996f72e80000000404e034838d361ce9c39c9d4a95393db6ebb2dd9ba756bf6f891234792f9f3e727d3a64d4bd6ae5d3becc3fd78fb2adb8d8d8d1f6f4f19e50c89c1c1c164fdfaf5d97384efddb0614332343434ecfb366dda944c9f3e3d99316346b265cb9671dfef58f161bcf73a303090ac5ebd3a7bfdb07fc58a15c9a953a7467def1379ddeaededdbb72773e7cecdbe3f3c77389be4d8b1630208000000d42380840ff5070e1c48fafafab20fef37df7c73f6f892254bb2af3b3b3bb30ff3d51feec7db37659c4b42aabf0ef1236c6fdbb62de9e8e8c8b64304a9febef0fc870e1dcab66fb9e59671dfef580164bcf7ba66cd9a6cfbe0c183496f6f6fb6bd74e9d2519f6f22af5bbd1df687ed13274e643f17b6172c582080000000403d0248f880fed4534f651fceab3fc057ce82387ffe7c3613dd37d10032da7384c7c6fab986868671dfef58016422ff1dd533d67b98c8eb566fdf77df7dd9763803a4a9a929d9bc797376c6890002000000750820b367cfce3ea8efd8b1e3530d20e1b29091cf112e77b9d2cf8df57e3f4900098f5fe97e1e1379ddeaedf09ce1583ffef8e3c9cc9933b3c7efbefb6e0104000000ea11402a11205c0652fd013e5c0a32e5d2a523954b5426b2af7a3b048db01deeed31323e542e3fa9be0466e3c68d133e7364e4fb1d2b808cf75e5b5a5ab2ed707f91caf32d5ab468d4f73e91d7adde5eb87061b6bd6fdfbea4bfbf3fdbbee38e3b0410000000a84700099766840ff7236f101a6ed8396fdebcec128e75ebd64d785ff5f64b2fbd94ddbb235cbed2dede7ed94d50c3cf86d70e13e2c7c89ba08e1640c67abf630590f1deeb993367b21053b9116b8825274f9e1cf5bd4fe475abb7c3f33cfcf0c3d97387d70e97ce841ba90a2000000050870062ea3b0208000000082002080000002080082000000080002280000000800062041000000010408c00020000000288114000000040003102080000000820020800000020800820000000800022800000000002880002000000028811400000004000310208000000082046000100000001c4082000000020800820000000800022800000000002880002000000082002080000004c0eddddddc2437ee67cb95cfed06f25000000d4d89e3d7bde3977ee9cf89083397dfaf4cbe572f9b0df4a000000a8b19d3b772e7ffdf5d7df3b7bf6ec7f4588fa9df911e2475757d7c9741ef15b09000000d741faa1fbc172b9fc46b8fc22dc83c27cea138efb61f10300000000000000000000000000000000000000000000000000000000000000000000000000009894fe0f379fc93e9920b9d80000000049454e44ae426082', true);


--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('common.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('next.dbid', '1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('identitylink.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('entitylink.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('eventsubscription.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('task.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('variable.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('job.schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('schema.version', '6.5.0.1', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('schema.history', 'create(6.5.0.1)', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO act_ge_property (name_, value_, rev_) VALUES ('cfg.task-related-entities-count', 'true', 1);


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_entitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_tsk_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_bytearray; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_priv; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_id_priv (id_, name_) VALUES ('4ef1a214-1737-11ea-af77-7c7a916bf543', 'access-idm');
INSERT INTO act_id_priv (id_, name_) VALUES ('4ef48846-1737-11ea-af77-7c7a916bf543', 'access-admin');
INSERT INTO act_id_priv (id_, name_) VALUES ('4ef5c0c8-1737-11ea-af77-7c7a916bf543', 'access-modeler');
INSERT INTO act_id_priv (id_, name_) VALUES ('4ef7205a-1737-11ea-af77-7c7a916bf543', 'access-task');
INSERT INTO act_id_priv (id_, name_) VALUES ('4ef858dc-1737-11ea-af77-7c7a916bf543', 'access-rest-api');


--
-- Data for Name: act_id_priv_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('4ef34fc5-1737-11ea-af77-7c7a916bf543', '4ef1a214-1737-11ea-af77-7c7a916bf543', 'admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('4ef54b97-1737-11ea-af77-7c7a916bf543', '4ef48846-1737-11ea-af77-7c7a916bf543', 'admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('4ef68419-1737-11ea-af77-7c7a916bf543', '4ef5c0c8-1737-11ea-af77-7c7a916bf543', 'admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('4ef7e3ab-1737-11ea-af77-7c7a916bf543', '4ef7205a-1737-11ea-af77-7c7a916bf543', 'admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('4ef96a4d-1737-11ea-af77-7c7a916bf543', '4ef858dc-1737-11ea-af77-7c7a916bf543', 'admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('71245d09-1737-11ea-ac1a-7c7a916bf543', '4ef858dc-1737-11ea-af77-7c7a916bf543', 'rest-admin', NULL);
INSERT INTO act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) VALUES ('7125476a-1737-11ea-ac1a-7c7a916bf543', '4ef48846-1737-11ea-af77-7c7a916bf543', 'rest-admin', NULL);


--
-- Data for Name: act_id_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_id_property (name_, value_, rev_) VALUES ('schema.version', '6.5.0.1', 1);


--
-- Data for Name: act_id_token; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_id_user (id_, rev_, first_, last_, display_name_, email_, pwd_, picture_id_, tenant_id_) VALUES ('admin', 1, 'Test', 'Administrator', NULL, 'admin@flowable.org', 'test', NULL, NULL);
INSERT INTO act_id_user (id_, rev_, first_, last_, display_name_, email_, pwd_, picture_id_, tenant_id_) VALUES ('rest-admin', 1, 'Rest', 'Admin', NULL, NULL, 'test', NULL, NULL);


--
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_re_deployment (id_, name_, category_, key_, tenant_id_, deploy_time_, derived_from_, derived_from_root_, parent_deployment_id_, engine_version_) VALUES ('7127433b-1737-11ea-ac1a-7c7a916bf543', 'Demo processes', NULL, NULL, '', '2019-12-05 16:15:47.726', NULL, NULL, NULL, NULL);


--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('vacationRequest:1:71d4c156-1737-11ea-ac1a-7c7a916bf543', 1, 'http://activiti.org/bpmn20', 'Vacation request', 'vacationRequest', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'VacationRequest.bpmn20.xml', 'VacationRequest.png', NULL, false, false, 1, '', NULL, NULL, 0, NULL);
INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('fixSystemFailure:1:71d50f77-1737-11ea-ac1a-7c7a916bf543', 1, 'Examples', 'Fix system failure', 'fixSystemFailure', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'FixSystemFailureProcess.bpmn20.xml', 'FixSystemFailureProcess.png', NULL, false, false, 1, '', NULL, NULL, 0, NULL);
INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('reviewSaledLead:1:71d50f78-1737-11ea-ac1a-7c7a916bf543', 1, 'Examples', 'Review sales lead', 'reviewSaledLead', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'reviewSalesLead.bpmn20.xml', 'reviewSalesLead.reviewSaledLead.png', NULL, false, true, 1, '', NULL, NULL, 0, NULL);
INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('escalationExample:1:71d50f79-1737-11ea-ac1a-7c7a916bf543', 1, 'Examples', 'Helpdesk process', 'escalationExample', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'Helpdesk.bpmn20.xml', 'Helpdesk.png', NULL, false, false, 1, '', NULL, NULL, 0, NULL);
INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('oneTaskProcess:1:71d50f7a-1737-11ea-ac1a-7c7a916bf543', 1, 'Examples', 'Famous One Task Process', 'oneTaskProcess', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'oneTaskProcess.bpmn20.xml', NULL, NULL, false, false, 1, '', NULL, NULL, 0, NULL);
INSERT INTO act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('createTimersProcess:1:71d50f7b-1737-11ea-ac1a-7c7a916bf543', 1, 'Examples', 'Create timers process', 'createTimersProcess', 1, '7127433b-1737-11ea-ac1a-7c7a916bf543', 'createTimersProcess.bpmn20.xml', NULL, 'Test process to create a number of timers.', false, false, 1, '', NULL, NULL, 0, NULL);


--
-- Data for Name: act_ru_actinst; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_deadletter_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_entitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_history_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_suspended_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_timer_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: UserExtention_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"UserExtention_id_seq"', 5, true);


--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('act_evt_log_log_nr__seq', 1, false);


--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('act_hi_tsk_log_id__seq', 1, false);


--
-- Name: userextention_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('userextention_id_seq', 3, false);


--
-- Name: CommunistPartyProcessCategory CommunistPartyProcessCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CommunistPartyProcessCategory"
    ADD CONSTRAINT "CommunistPartyProcessCategory_pkey" PRIMARY KEY (id);


--
-- Name: DictionaryItem DictionaryItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DictionaryItem"
    ADD CONSTRAINT "DictionaryItem_pkey" PRIMARY KEY (id);


--
-- Name: Dictionary Dictionary_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Dictionary"
    ADD CONSTRAINT "Dictionary_key_key" UNIQUE (key);


--
-- Name: Dictionary Dictionary_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Dictionary"
    ADD CONSTRAINT "Dictionary_name_key" UNIQUE (name);


--
-- Name: Dictionary Dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Dictionary"
    ADD CONSTRAINT "Dictionary_pkey" PRIMARY KEY (id);


--
-- Name: MenuPreDepends MenuPreDepends_menuId_dependMenuId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_menuId_dependMenuId_key" UNIQUE ("menuId", "dependMenuId");


--
-- Name: MenuPreDepends MenuPreDepends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_pkey" PRIMARY KEY (id);


--
-- Name: Menu Menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Menu"
    ADD CONSTRAINT "Menu_pkey" PRIMARY KEY (id);


--
-- Name: OperationPreDepends OperationPreDepends_operationId_dependOperationId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_operationId_dependOperationId_key" UNIQUE ("operationId", "dependOperationId");


--
-- Name: OperationPreDepends OperationPreDepends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_pkey" PRIMARY KEY (id);


--
-- Name: Operation Operation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Operation"
    ADD CONSTRAINT "Operation_pkey" PRIMARY KEY (id);


--
-- Name: OrganizationRole OrganizationRole_organizationId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_organizationId_roleId_key" UNIQUE ("organizationId", "roleId");


--
-- Name: OrganizationRole OrganizationRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_pkey" PRIMARY KEY (id);


--
-- Name: Organization Organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Organization"
    ADD CONSTRAINT "Organization_pkey" PRIMARY KEY (id);


--
-- Name: PositionRole PositionRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_pkey" PRIMARY KEY (id);


--
-- Name: PositionRole PositionRole_positionId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_positionId_roleId_key" UNIQUE ("positionId", "roleId");


--
-- Name: Position Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY (id);


--
-- Name: ProcessDef ProcessDef_flowableInstance_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ProcessDef"
    ADD CONSTRAINT "ProcessDef_flowableInstance_key" UNIQUE ("flowableInstance");


--
-- Name: ProcessDef ProcessDef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ProcessDef"
    ADD CONSTRAINT "ProcessDef_pkey" PRIMARY KEY (id);


--
-- Name: RoleMenu RoleMenu_menuId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_menuId_roleId_key" UNIQUE ("menuId", "roleId");


--
-- Name: RoleMenu RoleMenu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_pkey" PRIMARY KEY (id);


--
-- Name: RoleOperation RoleOperation_operationId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_operationId_roleId_key" UNIQUE ("operationId", "roleId");


--
-- Name: RoleOperation RoleOperation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_pkey" PRIMARY KEY (id);


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: SubUser SubUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_pkey" PRIMARY KEY ("userId");


--
-- Name: UserExtention UserExtention_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserExtention"
    ADD CONSTRAINT "UserExtention_pkey" PRIMARY KEY ("userId");


--
-- Name: UserOrganization UserOrganization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_pkey" PRIMARY KEY (id);


--
-- Name: UserOrganization UserOrganization_userId_organizationId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_userId_organizationId_key" UNIQUE ("userId", "organizationId");


--
-- Name: UserPosition UserPosition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_pkey" PRIMARY KEY (id);


--
-- Name: UserPosition UserPosition_userId_positionId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_userId_positionId_key" UNIQUE ("userId", "positionId");


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY (id);


--
-- Name: UserRole UserRole_userId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_userId_roleId_key" UNIQUE ("userId", "roleId");


--
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User User_mobile_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_mobile_key" UNIQUE (mobile);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: User User_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);


--
-- Name: act_adm_databasechangeloglock act_adm_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_adm_databasechangeloglock
    ADD CONSTRAINT act_adm_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_adm_server_config act_adm_server_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_adm_server_config
    ADD CONSTRAINT act_adm_server_config_pkey PRIMARY KEY (id_);


--
-- Name: act_app_appdef act_app_appdef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_appdef
    ADD CONSTRAINT act_app_appdef_pkey PRIMARY KEY (id_);


--
-- Name: act_app_databasechangeloglock act_app_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_databasechangeloglock
    ADD CONSTRAINT act_app_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_app_deployment act_app_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment
    ADD CONSTRAINT act_app_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_casedef act_cmmn_casedef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_casedef
    ADD CONSTRAINT act_cmmn_casedef_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_databasechangeloglock act_cmmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_databasechangeloglock
    ADD CONSTRAINT act_cmmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_cmmn_deployment act_cmmn_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment
    ADD CONSTRAINT act_cmmn_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_case_inst act_cmmn_hi_case_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_case_inst
    ADD CONSTRAINT act_cmmn_hi_case_inst_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_mil_inst act_cmmn_hi_mil_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_mil_inst
    ADD CONSTRAINT act_cmmn_hi_mil_inst_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_plan_item_inst act_cmmn_hi_plan_item_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_plan_item_inst
    ADD CONSTRAINT act_cmmn_hi_plan_item_inst_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_case_inst act_cmmn_ru_case_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_case_inst
    ADD CONSTRAINT act_cmmn_ru_case_inst_pkey PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_mil_inst act_cmmn_ru_mil_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_cmmn_ru_mil_inst_pkey PRIMARY KEY (id_);


--
-- Name: act_co_content_item act_co_content_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_co_content_item
    ADD CONSTRAINT act_co_content_item_pkey PRIMARY KEY (id_);


--
-- Name: act_co_databasechangeloglock act_co_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_co_databasechangeloglock
    ADD CONSTRAINT act_co_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_de_databasechangeloglock act_de_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_databasechangeloglock
    ADD CONSTRAINT act_de_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_de_model_history act_de_model_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_model_history
    ADD CONSTRAINT act_de_model_history_pkey PRIMARY KEY (id);


--
-- Name: act_de_model act_de_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_model
    ADD CONSTRAINT act_de_model_pkey PRIMARY KEY (id);


--
-- Name: act_de_model_relation act_de_model_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_model_relation
    ADD CONSTRAINT act_de_model_relation_pkey PRIMARY KEY (id);


--
-- Name: act_dmn_databasechangeloglock act_dmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_databasechangeloglock
    ADD CONSTRAINT act_dmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_dmn_decision_table act_dmn_decision_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_decision_table
    ADD CONSTRAINT act_dmn_decision_table_pkey PRIMARY KEY (id_);


--
-- Name: act_dmn_deployment act_dmn_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_deployment
    ADD CONSTRAINT act_dmn_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_dmn_deployment_resource act_dmn_deployment_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_deployment_resource
    ADD CONSTRAINT act_dmn_deployment_resource_pkey PRIMARY KEY (id_);


--
-- Name: act_dmn_hi_decision_execution act_dmn_hi_decision_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_hi_decision_execution
    ADD CONSTRAINT act_dmn_hi_decision_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_evt_log act_evt_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- Name: act_fo_databasechangeloglock act_fo_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_databasechangeloglock
    ADD CONSTRAINT act_fo_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_fo_form_definition act_fo_form_definition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_definition
    ADD CONSTRAINT act_fo_form_definition_pkey PRIMARY KEY (id_);


--
-- Name: act_fo_form_deployment act_fo_form_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_deployment
    ADD CONSTRAINT act_fo_form_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_fo_form_instance act_fo_form_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_instance
    ADD CONSTRAINT act_fo_form_instance_pkey PRIMARY KEY (id_);


--
-- Name: act_fo_form_resource act_fo_form_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_resource
    ADD CONSTRAINT act_fo_form_resource_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_entitylink act_hi_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_entitylink
    ADD CONSTRAINT act_hi_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_tsk_log act_hi_tsk_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_tsk_log
    ADD CONSTRAINT act_hi_tsk_log_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- Name: act_id_bytearray act_id_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_bytearray
    ADD CONSTRAINT act_id_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- Name: act_id_priv_mapping act_id_priv_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv_mapping
    ADD CONSTRAINT act_id_priv_mapping_pkey PRIMARY KEY (id_);


--
-- Name: act_id_priv act_id_priv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv
    ADD CONSTRAINT act_id_priv_pkey PRIMARY KEY (id_);


--
-- Name: act_id_property act_id_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_property
    ADD CONSTRAINT act_id_property_pkey PRIMARY KEY (name_);


--
-- Name: act_id_token act_id_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_token
    ADD CONSTRAINT act_id_token_pkey PRIMARY KEY (id_);


--
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_procdef_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_actinst act_ru_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_actinst
    ADD CONSTRAINT act_ru_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_deadletter_job act_ru_deadletter_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_ru_deadletter_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_entitylink act_ru_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_entitylink
    ADD CONSTRAINT act_ru_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_history_job act_ru_history_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_history_job
    ADD CONSTRAINT act_ru_history_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_suspended_job act_ru_suspended_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_ru_suspended_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_timer_job act_ru_timer_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_ru_timer_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_uniq_info_procdef; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- Name: act_id_priv act_uniq_priv_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv
    ADD CONSTRAINT act_uniq_priv_name UNIQUE (name_);


--
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, derived_version_, tenant_id_);


--
-- Name: act_app_deployment_resource pk_app_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment_resource
    ADD CONSTRAINT pk_app_deployment_resource PRIMARY KEY (id_);


--
-- Name: act_cmmn_deployment_resource pk_cmmn_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment_resource
    ADD CONSTRAINT pk_cmmn_deployment_resource PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_plan_item_inst pk_cmmn_plan_item_inst; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT pk_cmmn_plan_item_inst PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_sentry_part_inst pk_cmmn_sentry_part_inst; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT pk_cmmn_sentry_part_inst PRIMARY KEY (id_);


--
-- Name: act_idx_app_def_dply; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_app_def_dply ON act_app_appdef USING btree (deployment_id_);


--
-- Name: act_idx_app_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_app_def_uniq ON act_app_appdef USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_app_rsrc_dpl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_app_rsrc_dpl ON act_app_deployment_resource USING btree (deployment_id_);


--
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_athrz_procedef ON act_ru_identitylink USING btree (proc_def_id_);


--
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_bytear_depl ON act_ge_bytearray USING btree (deployment_id_);


--
-- Name: act_idx_case_def_dply; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_def_dply ON act_cmmn_casedef USING btree (deployment_id_);


--
-- Name: act_idx_case_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_case_def_uniq ON act_cmmn_casedef USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_case_inst_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_inst_case_def ON act_cmmn_ru_case_inst USING btree (case_def_id_);


--
-- Name: act_idx_case_inst_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_inst_parent ON act_cmmn_ru_case_inst USING btree (parent_id_);


--
-- Name: act_idx_cmmn_rsrc_dpl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_cmmn_rsrc_dpl ON act_cmmn_deployment_resource USING btree (deployment_id_);


--
-- Name: act_idx_deadletter_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_custom_values_id ON act_ru_deadletter_job USING btree (custom_values_id_);


--
-- Name: act_idx_deadletter_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_exception_stack_id ON act_ru_deadletter_job USING btree (exception_stack_id_);


--
-- Name: act_idx_deadletter_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_execution_id ON act_ru_deadletter_job USING btree (execution_id_);


--
-- Name: act_idx_deadletter_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_proc_def_id ON act_ru_deadletter_job USING btree (proc_def_id_);


--
-- Name: act_idx_deadletter_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_process_instance_id ON act_ru_deadletter_job USING btree (process_instance_id_);


--
-- Name: act_idx_dec_tbl_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_dec_tbl_uniq ON act_dmn_decision_table USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_djob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_scope ON act_ru_deadletter_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_djob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_scope_def ON act_ru_deadletter_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_djob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_sub_scope ON act_ru_deadletter_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ent_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ent_lnk_scope ON act_ru_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ent_lnk_scope_def ON act_ru_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_event_subscr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_event_subscr ON act_ru_event_subscr USING btree (execution_id_);


--
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_event_subscr_config_ ON act_ru_event_subscr USING btree (configuration_);


--
-- Name: act_idx_exe_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_parent ON act_ru_execution USING btree (parent_id_);


--
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_procdef ON act_ru_execution USING btree (proc_def_id_);


--
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_procinst ON act_ru_execution USING btree (proc_inst_id_);


--
-- Name: act_idx_exe_root; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_root ON act_ru_execution USING btree (root_proc_inst_id_);


--
-- Name: act_idx_exe_super; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_super ON act_ru_execution USING btree (super_exec_);


--
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exec_buskey ON act_ru_execution USING btree (business_key_);


--
-- Name: act_idx_form_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_form_def_uniq ON act_fo_form_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_end ON act_hi_actinst USING btree (end_time_);


--
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_exec ON act_hi_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_procinst ON act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_start ON act_hi_actinst USING btree (start_time_);


--
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_act_inst ON act_hi_detail USING btree (act_inst_id_);


--
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_name ON act_hi_detail USING btree (name_);


--
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_proc_inst ON act_hi_detail USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_task_id ON act_hi_detail USING btree (task_id_);


--
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_time ON act_hi_detail USING btree (time_);


--
-- Name: act_idx_hi_ent_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ent_lnk_scope ON act_hi_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ent_lnk_scope_def ON act_hi_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON act_hi_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_ident_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_scope ON act_hi_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_scope_def ON act_hi_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_task ON act_hi_identitylink USING btree (task_id_);


--
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_user ON act_hi_identitylink USING btree (user_id_);


--
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_pro_i_buskey ON act_hi_procinst USING btree (business_key_);


--
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_pro_inst_end ON act_hi_procinst USING btree (end_time_);


--
-- Name: act_idx_hi_procvar_exe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_exe ON act_hi_varinst USING btree (execution_id_);


--
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_name_type ON act_hi_varinst USING btree (name_, var_type_);


--
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON act_hi_varinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_task_id ON act_hi_varinst USING btree (task_id_);


--
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_inst_procinst ON act_hi_taskinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_task_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_scope ON act_hi_taskinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_task_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_scope_def ON act_hi_taskinst USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_task_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_sub_scope ON act_hi_taskinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_scope_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_var_scope_id_type ON act_hi_varinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_sub_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_var_sub_id_type ON act_hi_varinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_group ON act_ru_identitylink USING btree (group_id_);


--
-- Name: act_idx_ident_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_scope ON act_ru_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_scope_def ON act_ru_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_user ON act_ru_identitylink USING btree (user_id_);


--
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_idl_procinst ON act_ru_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_custom_values_id ON act_ru_job USING btree (custom_values_id_);


--
-- Name: act_idx_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_exception_stack_id ON act_ru_job USING btree (exception_stack_id_);


--
-- Name: act_idx_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_execution_id ON act_ru_job USING btree (execution_id_);


--
-- Name: act_idx_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_proc_def_id ON act_ru_job USING btree (proc_def_id_);


--
-- Name: act_idx_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_process_instance_id ON act_ru_job USING btree (process_instance_id_);


--
-- Name: act_idx_job_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_scope ON act_ru_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_job_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_scope_def ON act_ru_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_job_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_sub_scope ON act_ru_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_memb_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_memb_group ON act_id_membership USING btree (group_id_);


--
-- Name: act_idx_memb_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_memb_user ON act_id_membership USING btree (user_id_);


--
-- Name: act_idx_mil_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_mil_case_def ON act_cmmn_ru_mil_inst USING btree (case_def_id_);


--
-- Name: act_idx_mil_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_mil_case_inst ON act_cmmn_ru_mil_inst USING btree (case_inst_id_);


--
-- Name: act_idx_model_deployment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_deployment ON act_re_model USING btree (deployment_id_);


--
-- Name: act_idx_model_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_source ON act_re_model USING btree (editor_source_value_id_);


--
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_source_extra ON act_re_model USING btree (editor_source_extra_value_id_);


--
-- Name: act_idx_plan_item_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_case_def ON act_cmmn_ru_plan_item_inst USING btree (case_def_id_);


--
-- Name: act_idx_plan_item_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_case_inst ON act_cmmn_ru_plan_item_inst USING btree (case_inst_id_);


--
-- Name: act_idx_plan_item_stage_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_stage_inst ON act_cmmn_ru_plan_item_inst USING btree (stage_inst_id_);


--
-- Name: act_idx_priv_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_group ON act_id_priv_mapping USING btree (group_id_);


--
-- Name: act_idx_priv_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_mapping ON act_id_priv_mapping USING btree (priv_id_);


--
-- Name: act_idx_priv_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_user ON act_id_priv_mapping USING btree (user_id_);


--
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_procdef_info_json ON act_procdef_info USING btree (info_json_id_);


--
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_procdef_info_proc ON act_procdef_info USING btree (proc_def_id_);


--
-- Name: act_idx_ru_acti_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_end ON act_ru_actinst USING btree (end_time_);


--
-- Name: act_idx_ru_acti_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_exec ON act_ru_actinst USING btree (execution_id_);


--
-- Name: act_idx_ru_acti_exec_act; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_exec_act ON act_ru_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_ru_acti_proc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_proc ON act_ru_actinst USING btree (proc_inst_id_);


--
-- Name: act_idx_ru_acti_proc_act; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_proc_act ON act_ru_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_ru_acti_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_start ON act_ru_actinst USING btree (start_time_);


--
-- Name: act_idx_ru_var_scope_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_var_scope_id_type ON act_ru_variable USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ru_var_sub_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_var_sub_id_type ON act_ru_variable USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_sentry_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_case_def ON act_cmmn_ru_sentry_part_inst USING btree (case_def_id_);


--
-- Name: act_idx_sentry_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_case_inst ON act_cmmn_ru_sentry_part_inst USING btree (case_inst_id_);


--
-- Name: act_idx_sentry_plan_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_plan_item ON act_cmmn_ru_sentry_part_inst USING btree (plan_item_inst_id_);


--
-- Name: act_idx_sjob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_scope ON act_ru_suspended_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_sjob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_scope_def ON act_ru_suspended_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_sjob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_sub_scope ON act_ru_suspended_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_suspended_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_custom_values_id ON act_ru_suspended_job USING btree (custom_values_id_);


--
-- Name: act_idx_suspended_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_exception_stack_id ON act_ru_suspended_job USING btree (exception_stack_id_);


--
-- Name: act_idx_suspended_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_execution_id ON act_ru_suspended_job USING btree (execution_id_);


--
-- Name: act_idx_suspended_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_proc_def_id ON act_ru_suspended_job USING btree (proc_def_id_);


--
-- Name: act_idx_suspended_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_process_instance_id ON act_ru_suspended_job USING btree (process_instance_id_);


--
-- Name: act_idx_task_create; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_create ON act_ru_task USING btree (create_time_);


--
-- Name: act_idx_task_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_exec ON act_ru_task USING btree (execution_id_);


--
-- Name: act_idx_task_procdef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_procdef ON act_ru_task USING btree (proc_def_id_);


--
-- Name: act_idx_task_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_procinst ON act_ru_task USING btree (proc_inst_id_);


--
-- Name: act_idx_task_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_scope ON act_ru_task USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_task_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_scope_def ON act_ru_task USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_task_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_sub_scope ON act_ru_task USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_timer_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_custom_values_id ON act_ru_timer_job USING btree (custom_values_id_);


--
-- Name: act_idx_timer_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_exception_stack_id ON act_ru_timer_job USING btree (exception_stack_id_);


--
-- Name: act_idx_timer_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_execution_id ON act_ru_timer_job USING btree (execution_id_);


--
-- Name: act_idx_timer_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_proc_def_id ON act_ru_timer_job USING btree (proc_def_id_);


--
-- Name: act_idx_timer_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_process_instance_id ON act_ru_timer_job USING btree (process_instance_id_);


--
-- Name: act_idx_tjob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_scope ON act_ru_timer_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_tjob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_scope_def ON act_ru_timer_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_tjob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_sub_scope ON act_ru_timer_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_tskass_task; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tskass_task ON act_ru_identitylink USING btree (task_id_);


--
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_bytearray ON act_ru_variable USING btree (bytearray_id_);


--
-- Name: act_idx_var_exe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_exe ON act_ru_variable USING btree (execution_id_);


--
-- Name: act_idx_var_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_procinst ON act_ru_variable USING btree (proc_inst_id_);


--
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_variable_task_id ON act_ru_variable USING btree (task_id_);


--
-- Name: idx_contitem_procid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_procid ON act_co_content_item USING btree (proc_inst_id_);


--
-- Name: idx_contitem_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_scope ON act_co_content_item USING btree (scope_id_, scope_type_);


--
-- Name: idx_contitem_taskid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_taskid ON act_co_content_item USING btree (task_id_);


--
-- Name: idx_proc_mod_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proc_mod_created ON act_de_model USING btree (created_by);


--
-- Name: idx_proc_mod_history_proc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_proc_mod_history_proc ON act_de_model_history USING btree (model_id);


--
-- Name: CommunistPartyProcessCategory CommunistPartyProcessCategory_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "CommunistPartyProcessCategory"
    ADD CONSTRAINT "CommunistPartyProcessCategory_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "CommunistPartyProcessCategory"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DictionaryItem DictionaryItem_dictionaryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DictionaryItem"
    ADD CONSTRAINT "DictionaryItem_dictionaryId_fkey" FOREIGN KEY ("dictionaryId") REFERENCES "Dictionary"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MenuPreDepends MenuPreDepends_dependMenuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_dependMenuId_fkey" FOREIGN KEY ("dependMenuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MenuPreDepends MenuPreDepends_menuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Menu Menu_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Menu"
    ADD CONSTRAINT "Menu_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OperationPreDepends OperationPreDepends_dependOperationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_dependOperationId_fkey" FOREIGN KEY ("dependOperationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OperationPreDepends OperationPreDepends_operationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Operation Operation_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Operation"
    ADD CONSTRAINT "Operation_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrganizationRole OrganizationRole_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrganizationRole OrganizationRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Organization Organization_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Organization"
    ADD CONSTRAINT "Organization_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PositionRole PositionRole_positionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PositionRole PositionRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Position Position_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Position"
    ADD CONSTRAINT "Position_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RoleMenu RoleMenu_menuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RoleMenu RoleMenu_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RoleOperation RoleOperation_operationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RoleOperation RoleOperation_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SubUser SubUser_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SubUser SubUser_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserExtention UserExtention_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserExtention"
    ADD CONSTRAINT "UserExtention_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserOrganization UserOrganization_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserOrganization UserOrganization_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserPosition UserPosition_positionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserPosition UserPosition_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserRole UserRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserRole UserRole_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: act_app_appdef act_fk_app_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_appdef
    ADD CONSTRAINT act_fk_app_def_dply FOREIGN KEY (deployment_id_) REFERENCES act_app_deployment(id_);


--
-- Name: act_app_deployment_resource act_fk_app_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment_resource
    ADD CONSTRAINT act_fk_app_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES act_app_deployment(id_);


--
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_cmmn_casedef act_fk_case_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_casedef
    ADD CONSTRAINT act_fk_case_def_dply FOREIGN KEY (deployment_id_) REFERENCES act_cmmn_deployment(id_);


--
-- Name: act_cmmn_ru_case_inst act_fk_case_inst_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_case_inst
    ADD CONSTRAINT act_fk_case_inst_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- Name: act_cmmn_deployment_resource act_fk_cmmn_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment_resource
    ADD CONSTRAINT act_fk_cmmn_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES act_cmmn_deployment(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_procdef_info act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_procdef_info act_fk_info_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_job act_fk_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES act_id_group(id_);


--
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES act_id_user(id_);


--
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- Name: act_id_priv_mapping act_fk_priv_mapping; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv_mapping
    ADD CONSTRAINT act_fk_priv_mapping FOREIGN KEY (priv_id_) REFERENCES act_id_priv(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_plan_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_plan_item FOREIGN KEY (plan_item_inst_id_) REFERENCES act_cmmn_ru_plan_item_inst(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES act_ru_task(id_);


--
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_de_model_relation fk_relation_child; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_model_relation
    ADD CONSTRAINT fk_relation_child FOREIGN KEY (model_id) REFERENCES act_de_model(id);


--
-- Name: act_de_model_relation fk_relation_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_de_model_relation
    ADD CONSTRAINT fk_relation_parent FOREIGN KEY (parent_model_id) REFERENCES act_de_model(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

