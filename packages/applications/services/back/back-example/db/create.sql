--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

-- Started on 2019-11-18 09:03:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 951 (class 1247 OID 395706)
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
-- TOC entry 213 (class 1259 OID 395987)
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
-- TOC entry 214 (class 1259 OID 395995)
-- Name: DictionaryItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "DictionaryItem" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "dictionaryId" character varying(255) NOT NULL,
    index smallint
);


ALTER TABLE "DictionaryItem" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 395745)
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
-- TOC entry 200 (class 1259 OID 395758)
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
-- TOC entry 201 (class 1259 OID 395778)
-- Name: Operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Operation" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    method character varying(255) DEFAULT 'GET'::character varying,
    verify character varying(255) DEFAULT true,
    "desc" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255)
);


ALTER TABLE "Operation" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 395793)
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
-- TOC entry 206 (class 1259 OID 395861)
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
-- TOC entry 207 (class 1259 OID 395874)
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
-- TOC entry 208 (class 1259 OID 395894)
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
-- TOC entry 209 (class 1259 OID 395907)
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
-- TOC entry 215 (class 1259 OID 397383)
-- Name: ProcessDef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ProcessDef" (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "flowableInstance" character varying(255) NOT NULL,
    "formDef" text NOT NULL,
    "belongTo" character varying(255),
    "createdAt" timestamp(6) with time zone NOT NULL,
    "updatedAt" timestamp(6) with time zone NOT NULL
);


ALTER TABLE "ProcessDef" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 395813)
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
-- TOC entry 204 (class 1259 OID 395821)
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
-- TOC entry 205 (class 1259 OID 395841)
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
-- TOC entry 198 (class 1259 OID 395724)
-- Name: SubUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "SubUser" (
    id integer NOT NULL,
    dependent boolean DEFAULT true,
    enable boolean DEFAULT true,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "parentId" character varying(255),
    "userId" character varying(255)
);


ALTER TABLE "SubUser" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 395722)
-- Name: SubUser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "SubUser_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "SubUser_id_seq" OWNER TO postgres;

--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 197
-- Name: SubUser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "SubUser_id_seq" OWNED BY "SubUser".id;


--
-- TOC entry 196 (class 1259 OID 395711)
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
-- TOC entry 210 (class 1259 OID 395927)
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
-- TOC entry 211 (class 1259 OID 395947)
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
-- TOC entry 212 (class 1259 OID 395967)
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
-- TOC entry 287 (class 1259 OID 398366)
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
-- TOC entry 284 (class 1259 OID 398337)
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
-- TOC entry 283 (class 1259 OID 398332)
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
-- TOC entry 285 (class 1259 OID 398343)
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
-- TOC entry 286 (class 1259 OID 398352)
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
-- TOC entry 275 (class 1259 OID 398188)
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
-- TOC entry 272 (class 1259 OID 398159)
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
-- TOC entry 271 (class 1259 OID 398154)
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
-- TOC entry 273 (class 1259 OID 398165)
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
-- TOC entry 274 (class 1259 OID 398174)
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
-- TOC entry 280 (class 1259 OID 398286)
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
-- TOC entry 281 (class 1259 OID 398295)
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
-- TOC entry 282 (class 1259 OID 398304)
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
-- TOC entry 276 (class 1259 OID 398203)
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
-- TOC entry 279 (class 1259 OID 398266)
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
-- TOC entry 277 (class 1259 OID 398219)
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
-- TOC entry 278 (class 1259 OID 398240)
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
-- TOC entry 270 (class 1259 OID 398141)
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
-- TOC entry 269 (class 1259 OID 398135)
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
-- TOC entry 268 (class 1259 OID 398130)
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
-- TOC entry 257 (class 1259 OID 398046)
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
-- TOC entry 256 (class 1259 OID 398041)
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
-- TOC entry 260 (class 1259 OID 398068)
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
-- TOC entry 258 (class 1259 OID 398052)
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
-- TOC entry 259 (class 1259 OID 398060)
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
-- TOC entry 261 (class 1259 OID 398076)
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
-- TOC entry 239 (class 1259 OID 397669)
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
-- TOC entry 238 (class 1259 OID 397667)
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
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 238
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE act_evt_log_log_nr__seq OWNED BY act_evt_log.log_nr_;


--
-- TOC entry 263 (class 1259 OID 398091)
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
-- TOC entry 262 (class 1259 OID 398086)
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
-- TOC entry 266 (class 1259 OID 398113)
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
-- TOC entry 264 (class 1259 OID 398097)
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
-- TOC entry 267 (class 1259 OID 398121)
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
-- TOC entry 265 (class 1259 OID 398105)
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
-- TOC entry 217 (class 1259 OID 397397)
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
-- TOC entry 216 (class 1259 OID 397392)
-- Name: act_ge_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_ge_property OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 397904)
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
-- TOC entry 246 (class 1259 OID 397930)
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
-- TOC entry 245 (class 1259 OID 397922)
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
-- TOC entry 244 (class 1259 OID 397914)
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
-- TOC entry 221 (class 1259 OID 397438)
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
-- TOC entry 219 (class 1259 OID 397417)
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
-- TOC entry 242 (class 1259 OID 397892)
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
-- TOC entry 224 (class 1259 OID 397472)
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
-- TOC entry 226 (class 1259 OID 397484)
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
-- TOC entry 225 (class 1259 OID 397482)
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
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 225
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE act_hi_tsk_log_id__seq OWNED BY act_hi_tsk_log.id_;


--
-- TOC entry 228 (class 1259 OID 397513)
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
-- TOC entry 248 (class 1259 OID 397960)
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
-- TOC entry 249 (class 1259 OID 397968)
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
-- TOC entry 252 (class 1259 OID 397990)
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
-- TOC entry 250 (class 1259 OID 397976)
-- Name: act_id_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE act_id_membership OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 398006)
-- Name: act_id_priv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_priv (
    id_ character varying(64) NOT NULL,
    name_ character varying(255) NOT NULL
);


ALTER TABLE act_id_priv OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 398011)
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
-- TOC entry 247 (class 1259 OID 397955)
-- Name: act_id_property; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE act_id_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_id_property OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 397998)
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
-- TOC entry 251 (class 1259 OID 397981)
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
-- TOC entry 240 (class 1259 OID 397679)
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
-- TOC entry 234 (class 1259 OID 397630)
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
-- TOC entry 235 (class 1259 OID 397639)
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
-- TOC entry 237 (class 1259 OID 397657)
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
-- TOC entry 241 (class 1259 OID 397684)
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
-- TOC entry 232 (class 1259 OID 397552)
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
-- TOC entry 220 (class 1259 OID 397428)
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
-- TOC entry 222 (class 1259 OID 397448)
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
-- TOC entry 236 (class 1259 OID 397648)
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
-- TOC entry 233 (class 1259 OID 397561)
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
-- TOC entry 218 (class 1259 OID 397405)
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
-- TOC entry 229 (class 1259 OID 397525)
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
-- TOC entry 231 (class 1259 OID 397543)
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
-- TOC entry 223 (class 1259 OID 397459)
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
-- TOC entry 230 (class 1259 OID 397534)
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
-- TOC entry 227 (class 1259 OID 397497)
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
-- TOC entry 3111 (class 2604 OID 395727)
-- Name: SubUser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser" ALTER COLUMN id SET DEFAULT nextval('"SubUser_id_seq"'::regclass);


--
-- TOC entry 3133 (class 2604 OID 397672)
-- Name: act_evt_log log_nr_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('act_evt_log_log_nr__seq'::regclass);


--
-- TOC entry 3120 (class 2604 OID 397487)
-- Name: act_hi_tsk_log id_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_tsk_log ALTER COLUMN id_ SET DEFAULT nextval('act_hi_tsk_log_id__seq'::regclass);


--
-- TOC entry 3695 (class 0 OID 395987)
-- Dependencies: 213
-- Data for Name: Dictionary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Dictionary" (id, name, key, "belongTo", "createdAt", "updatedAt") FROM stdin;
dc252ce6-0686-4490-85b9-ece7f64d68af	asdfad	adf a	\N	2019-11-11 15:14:17.384+08	2019-11-11 15:14:17.384+08
e868ec55-0abb-4ec3-990a-15417b8e4342	d	d	\N	2019-11-12 14:11:07.522+08	2019-11-12 14:11:07.522+08
\.


--
-- TOC entry 3696 (class 0 OID 395995)
-- Dependencies: 214
-- Data for Name: DictionaryItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "DictionaryItem" (id, name, key, "createdAt", "updatedAt", "dictionaryId", index) FROM stdin;
e246449a-fd3f-4814-b37e-2573660d7673	asdf	asdf 	2019-11-11 15:14:31.114+08	2019-11-11 15:14:31.114+08	dc252ce6-0686-4490-85b9-ece7f64d68af	\N
\.


--
-- TOC entry 3681 (class 0 OID 395745)
-- Dependencies: 199
-- Data for Name: Menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Menu" (id, name, key, "linkTo", icon, "desc", "createdAt", "updatedAt", "parentId") FROM stdin;
0	管理控制台	iota.console	\N	\N		2018-05-15 19:26:27.598+08	2018-05-15 19:26:27.598+08	\N
1	总览	iota.console.overview	/console	overview		2018-05-15 19:26:27.603+08	2018-05-15 19:26:27.603+08	0
6	权限管理	iota.console.authorizations	\N	authorization		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	0
6.1	菜单与操作	iota.console.authorizations.current	/console/authorizations/overview	menu		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	6
6.2	角色	iota.console.authorizations.roles	/console/authorizations/roles	role		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	6
6.3	组织	iota.console.authorizations.organizations	/console/authorizations/organizations	organization		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	6
6.4	职位	iota.console.authorizations.positions	/console/authorizations/positions	user-position		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	6
6.5	用户	iota.console.authorizations.users	/console/authorizations/users	subuser		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	6
8	系统管理	iota.console.system	\N	system		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	0
8.1	字典管理	iota.console.system.dictionaries	/console/system/dictionaries	dictionary		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	8
9	账号管理	iota.console.account	\N	account-sec		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	0
9.1	账号安全	iota.console.account.profile	/console/account/profile	profile		2018-05-15 19:26:27.651+08	2018-05-15 19:26:27.651+08	9
4	项目管理	iota.console.flowable	\N	project	\N	2019-11-13 17:26:38+08	2019-11-13 17:26:41+08	0
4.1	Example	iota.console.flowable.example	/console/flowable/example	example	\N	2019-11-13 17:27:29+08	2019-11-13 17:27:31+08	4
\.


--
-- TOC entry 3682 (class 0 OID 395758)
-- Dependencies: 200
-- Data for Name: MenuPreDepends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "MenuPreDepends" (id, "createdAt", "updatedAt", "menuId", "dependMenuId") FROM stdin;
\.


--
-- TOC entry 3683 (class 0 OID 395778)
-- Dependencies: 201
-- Data for Name: Operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Operation" (id, name, key, method, verify, "desc", "createdAt", "updatedAt", "parentId") FROM stdin;
0	XXX	XXX	GET	true	\N	2019-03-29 14:01:30+08	2019-03-29 14:01:30+08	\N
\.


--
-- TOC entry 3684 (class 0 OID 395793)
-- Dependencies: 202
-- Data for Name: OperationPreDepends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "OperationPreDepends" (id, "createdAt", "updatedAt", "operationId", "dependOperationId") FROM stdin;
\.


--
-- TOC entry 3688 (class 0 OID 395861)
-- Dependencies: 206
-- Data for Name: Organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Organization" (id, name, "desc", "belongTo", "createdAt", "updatedAt", "parentId") FROM stdin;
66b315d4-2c5f-4851-a996-dac62675146e	党组织111	\N	581c1445-48de-4019-807d-8aa21329ecdd	2019-11-12 09:11:36.055+08	2019-11-12 11:08:25.458+08	\N
\.


--
-- TOC entry 3689 (class 0 OID 395874)
-- Dependencies: 207
-- Data for Name: OrganizationRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "OrganizationRole" (id, "createdAt", "updatedAt", "organizationId", "roleId") FROM stdin;
3ef2f44d-0821-4e7e-a1b9-1fa41c18d9fa	2019-11-12 11:11:36.636+08	2019-11-12 11:11:36.636+08	66b315d4-2c5f-4851-a996-dac62675146e	a7a20aad-fa8c-4b55-9fcc-b1814b82cb1a
\.


--
-- TOC entry 3690 (class 0 OID 395894)
-- Dependencies: 208
-- Data for Name: Position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Position" (id, name, "desc", "belongTo", "createdAt", "updatedAt", "parentId") FROM stdin;
30d9a45e-661f-4bd8-996e-408308831deb	党组织	\N	581c1445-48de-4019-807d-8aa21329ecdd	2019-11-12 11:11:08.333+08	2019-11-12 11:11:08.333+08	\N
\.


--
-- TOC entry 3691 (class 0 OID 395907)
-- Dependencies: 209
-- Data for Name: PositionRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PositionRole" (id, "createdAt", "updatedAt", "positionId", "roleId") FROM stdin;
\.


--
-- TOC entry 3697 (class 0 OID 397383)
-- Dependencies: 215
-- Data for Name: ProcessDef; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ProcessDef" (id, name, "flowableInstance", "formDef", "belongTo", "createdAt", "updatedAt") FROM stdin;
example	请假流程	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	{"type":"object","properties":{"initiatorName":{"type":"string","ui":{"columns":4,"label":"申请人","disabled":true}},"initiatorId":{"type":"string","ui":{"columns":4,"label":"申请人ID","hidden":true}},"numberOfDays":{"type":"number","ui":{"columns":3,"label":"申请天数"}},"startTime":{"type":"string","ui":{"columns":5,"widget":"date-picker","label":"开始时间"}},"motivation":{"type":"text","ui":{"label":"事由","widget":"textarea"}},"vacationApproved":{"type":"boolean","ui":{"label":"批准"}},"reason":{"type":"text","ui":{"label":"意见","widget":"textarea"}}},"ui":{"widgetConfig":{"layout":"h"}}}	\N	2019-11-13 17:24:17.938+08	2019-11-13 17:24:17.938+08
\.


--
-- TOC entry 3685 (class 0 OID 395813)
-- Dependencies: 203
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Role" (id, name, "desc", "belongTo", "createdAt", "updatedAt") FROM stdin;
a7a20aad-fa8c-4b55-9fcc-b1814b82cb1a	党组织		581c1445-48de-4019-807d-8aa21329ecdd	2019-11-12 11:11:25.48+08	2019-11-12 11:11:25.48+08
\.


--
-- TOC entry 3686 (class 0 OID 395821)
-- Dependencies: 204
-- Data for Name: RoleMenu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "RoleMenu" (id, "createdAt", "updatedAt", "menuId", "roleId") FROM stdin;
\.


--
-- TOC entry 3687 (class 0 OID 395841)
-- Dependencies: 205
-- Data for Name: RoleOperation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "RoleOperation" (id, "createdAt", "updatedAt", "operationId", "roleId") FROM stdin;
\.


--
-- TOC entry 3680 (class 0 OID 395724)
-- Dependencies: 198
-- Data for Name: SubUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "SubUser" (id, dependent, enable, "createdAt", "updatedAt", "parentId", "userId") FROM stdin;
1	t	t	2019-11-12 11:12:07.939+08	2019-11-12 11:12:07.939+08	admin	7b535306-c340-4bfc-b2b5-3f839ac7eeaa
\.


--
-- TOC entry 3678 (class 0 OID 395711)
-- Dependencies: 196
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "User" (id, username, password, type, email, mobile, "actEmail", gravatar, key, secret, "isAdmin", "createdAt", "updatedAt", "deletedAt") FROM stdin;
7b535306-c340-4bfc-b2b5-3f839ac7eeaa	admin11	35d4da11e2589bf03821ec777ddfe53761fa9b70	Sub	1@theiota.cn	\N	f	\N	470a736681a54e4a79463d7403743082e6c3be5e	618e754dab2de301cba412aa5c0bb30d0b81cf15	t	2019-11-12 11:12:07.927+08	2019-11-12 11:12:07.927+08	\N
admin	admin	35d4da11e2589bf03821ec777ddfe53761fa9b70	Master	\N	\N	f	\N	d2cac13dff027717e246c4ac62cc28a1d9b63a1d	2538dcad023ea8a33716f81dca59562d71b4cb2e	t	2019-11-11 00:13:18.448+08	2019-11-11 00:13:18.448+08	\N
\.


--
-- TOC entry 3692 (class 0 OID 395927)
-- Dependencies: 210
-- Data for Name: UserOrganization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "UserOrganization" (id, "createdAt", "updatedAt", "userId", "organizationId") FROM stdin;
f1d899e2-4a0d-4f26-aacf-36260ce7703a	2019-11-12 11:12:49.418+08	2019-11-12 11:12:49.418+08	7b535306-c340-4bfc-b2b5-3f839ac7eeaa	66b315d4-2c5f-4851-a996-dac62675146e
\.


--
-- TOC entry 3693 (class 0 OID 395947)
-- Dependencies: 211
-- Data for Name: UserPosition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "UserPosition" (id, "createdAt", "updatedAt", "userId", "positionId") FROM stdin;
76a01267-02c1-4152-9fc4-88927909cc0d	2019-11-12 11:12:46.98+08	2019-11-12 11:12:46.98+08	7b535306-c340-4bfc-b2b5-3f839ac7eeaa	30d9a45e-661f-4bd8-996e-408308831deb
\.


--
-- TOC entry 3694 (class 0 OID 395967)
-- Dependencies: 212
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "UserRole" (id, "createdAt", "updatedAt", "userId", "roleId") FROM stdin;
\.


--
-- TOC entry 3769 (class 0 OID 398366)
-- Dependencies: 287
-- Data for Name: act_app_appdef; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_app_appdef (id_, rev_, name_, key_, version_, category_, deployment_id_, resource_name_, description_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3766 (class 0 OID 398337)
-- Dependencies: 284
-- Data for Name: act_app_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	flowable	org/flowable/app/db/liquibase/flowable-app-db-changelog.xml	2019-11-13 16:22:16.651529	1	EXECUTED	8:496fc778bdf2ab13f2e1926d0e63e0a2	createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...		\N	3.8.0	\N	\N	3633336532
3	flowable	org/flowable/app/db/liquibase/flowable-app-db-changelog.xml	2019-11-13 16:22:16.668634	2	EXECUTED	8:f1f8aff320aade831944ebad24355f3d	createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF		\N	3.8.0	\N	\N	3633336532
\.


--
-- TOC entry 3765 (class 0 OID 398332)
-- Dependencies: 283
-- Data for Name: act_app_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_app_databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3767 (class 0 OID 398343)
-- Dependencies: 285
-- Data for Name: act_app_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_app_deployment (id_, name_, category_, key_, deploy_time_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3768 (class 0 OID 398352)
-- Dependencies: 286
-- Data for Name: act_app_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_app_deployment_resource (id_, name_, deployment_id_, resource_bytes_) FROM stdin;
\.


--
-- TOC entry 3757 (class 0 OID 398188)
-- Dependencies: 275
-- Data for Name: act_cmmn_casedef; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_casedef (id_, rev_, name_, key_, version_, category_, deployment_id_, resource_name_, description_, has_graphical_notation_, tenant_id_, dgrm_resource_name_, has_start_form_key_) FROM stdin;
\.


--
-- TOC entry 3754 (class 0 OID 398159)
-- Dependencies: 272
-- Data for Name: act_cmmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.039702	1	EXECUTED	8:8b4b922d90b05ff27483abefc9597aa6	createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...		\N	3.8.0	\N	\N	3633334995
2	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.088066	2	EXECUTED	8:65e39b3d385706bb261cbeffe7533cbe	addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST		\N	3.8.0	\N	\N	3633334995
3	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.127681	3	EXECUTED	8:c01f6e802b49436b4489040da3012359	addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...		\N	3.8.0	\N	\N	3633334995
4	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.177297	4	EXECUTED	8:e40d29cb79345b7fb5afd38a7f0ba8fc	createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST		\N	3.8.0	\N	\N	3633334995
6	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.189483	5	EXECUTED	8:10e82e26a7fee94c32a92099c059c18c	createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF		\N	3.8.0	\N	\N	3633334995
7	flowable	org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml	2019-11-13 16:22:16.229001	6	EXECUTED	8:530bc81a1e30618ccf4a2da1f7c6c043	renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...		\N	3.8.0	\N	\N	3633334995
\.


--
-- TOC entry 3753 (class 0 OID 398154)
-- Dependencies: 271
-- Data for Name: act_cmmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3755 (class 0 OID 398165)
-- Dependencies: 273
-- Data for Name: act_cmmn_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_deployment (id_, name_, category_, key_, deploy_time_, parent_deployment_id_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3756 (class 0 OID 398174)
-- Dependencies: 274
-- Data for Name: act_cmmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_deployment_resource (id_, name_, deployment_id_, resource_bytes_, generated_) FROM stdin;
\.


--
-- TOC entry 3762 (class 0 OID 398286)
-- Dependencies: 280
-- Data for Name: act_cmmn_hi_case_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_hi_case_inst (id_, rev_, business_key_, name_, parent_id_, case_def_id_, state_, start_time_, end_time_, start_user_id_, callback_id_, callback_type_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3763 (class 0 OID 398295)
-- Dependencies: 281
-- Data for Name: act_cmmn_hi_mil_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_hi_mil_inst (id_, rev_, name_, time_stamp_, case_inst_id_, case_def_id_, element_id_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3764 (class 0 OID 398304)
-- Dependencies: 282
-- Data for Name: act_cmmn_hi_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_hi_plan_item_inst (id_, rev_, name_, state_, case_def_id_, case_inst_id_, stage_inst_id_, is_stage_, element_id_, item_definition_id_, item_definition_type_, create_time_, last_available_time_, last_enabled_time_, last_disabled_time_, last_started_time_, last_suspended_time_, completed_time_, occurred_time_, terminated_time_, exit_time_, ended_time_, last_updated_time_, start_user_id_, reference_id_, reference_type_, tenant_id_, entry_criterion_id_, exit_criterion_id_) FROM stdin;
\.


--
-- TOC entry 3758 (class 0 OID 398203)
-- Dependencies: 276
-- Data for Name: act_cmmn_ru_case_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_ru_case_inst (id_, rev_, business_key_, name_, parent_id_, case_def_id_, state_, start_time_, start_user_id_, callback_id_, callback_type_, tenant_id_, lock_time_, is_completeable_) FROM stdin;
\.


--
-- TOC entry 3761 (class 0 OID 398266)
-- Dependencies: 279
-- Data for Name: act_cmmn_ru_mil_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_ru_mil_inst (id_, name_, time_stamp_, case_inst_id_, case_def_id_, element_id_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3759 (class 0 OID 398219)
-- Dependencies: 277
-- Data for Name: act_cmmn_ru_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_ru_plan_item_inst (id_, rev_, case_def_id_, case_inst_id_, stage_inst_id_, is_stage_, element_id_, name_, state_, create_time_, start_user_id_, reference_id_, reference_type_, tenant_id_, item_definition_id_, item_definition_type_, is_completeable_, is_count_enabled_, var_count_, sentry_part_inst_count_, last_available_time_, last_enabled_time_, last_disabled_time_, last_started_time_, last_suspended_time_, completed_time_, occurred_time_, terminated_time_, exit_time_, ended_time_, entry_criterion_id_, exit_criterion_id_) FROM stdin;
\.


--
-- TOC entry 3760 (class 0 OID 398240)
-- Dependencies: 278
-- Data for Name: act_cmmn_ru_sentry_part_inst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_cmmn_ru_sentry_part_inst (id_, rev_, case_def_id_, case_inst_id_, plan_item_inst_id_, on_part_id_, if_part_id_, time_stamp_) FROM stdin;
\.


--
-- TOC entry 3752 (class 0 OID 398141)
-- Dependencies: 270
-- Data for Name: act_co_content_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_co_content_item (id_, name_, mime_type_, task_id_, proc_inst_id_, content_store_id_, content_store_name_, field_, content_available_, created_, created_by_, last_modified_, last_modified_by_, content_size_, tenant_id_, scope_id_, scope_type_) FROM stdin;
\.


--
-- TOC entry 3751 (class 0 OID 398135)
-- Dependencies: 269
-- Data for Name: act_co_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	activiti	org/flowable/content/db/liquibase/flowable-content-db-changelog.xml	2019-11-13 16:22:13.952463	1	EXECUTED	8:7644d7165cfe799200a2abdd3419e8b6	createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM		\N	3.8.0	\N	\N	3633333864
2	flowable	org/flowable/content/db/liquibase/flowable-content-db-changelog.xml	2019-11-13 16:22:14.012568	2	EXECUTED	8:fe7b11ac7dbbf9c43006b23bbab60bab	addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM		\N	3.8.0	\N	\N	3633333864
\.


--
-- TOC entry 3750 (class 0 OID 398130)
-- Dependencies: 268
-- Data for Name: act_co_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_co_databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3739 (class 0 OID 398046)
-- Dependencies: 257
-- Data for Name: act_dmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	activiti	org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml	2019-11-13 16:22:12.700173	1	EXECUTED	8:c8701f1c71018b55029f450b2e9a10a1	createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE		\N	3.8.0	\N	\N	3633332461
2	flowable	org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml	2019-11-13 16:22:12.764061	2	EXECUTED	8:47f94b27feb7df8a30d4e338c7bd5fb8	createTable tableName=ACT_DMN_HI_DECISION_EXECUTION		\N	3.8.0	\N	\N	3633332461
3	flowable	org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml	2019-11-13 16:22:12.781491	3	EXECUTED	8:ac17eae89fbdccb6e08daf3c7797b579	addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION		\N	3.8.0	\N	\N	3633332461
4	flowable	org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml	2019-11-13 16:22:12.79469	4	EXECUTED	8:f73aabc4529e7292c2942073d1cff6f9	dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE		\N	3.8.0	\N	\N	3633332461
6	flowable	org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml	2019-11-13 16:22:12.809305	5	EXECUTED	8:646c6a061e0b6e8a62e69844ff96abb0	createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE		\N	3.8.0	\N	\N	3633332461
\.


--
-- TOC entry 3738 (class 0 OID 398041)
-- Dependencies: 256
-- Data for Name: act_dmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3742 (class 0 OID 398068)
-- Dependencies: 260
-- Data for Name: act_dmn_decision_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_decision_table (id_, name_, version_, key_, category_, deployment_id_, tenant_id_, resource_name_, description_) FROM stdin;
\.


--
-- TOC entry 3740 (class 0 OID 398052)
-- Dependencies: 258
-- Data for Name: act_dmn_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_deployment (id_, name_, category_, deploy_time_, tenant_id_, parent_deployment_id_) FROM stdin;
\.


--
-- TOC entry 3741 (class 0 OID 398060)
-- Dependencies: 259
-- Data for Name: act_dmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_deployment_resource (id_, name_, deployment_id_, resource_bytes_) FROM stdin;
\.


--
-- TOC entry 3743 (class 0 OID 398076)
-- Dependencies: 261
-- Data for Name: act_dmn_hi_decision_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_dmn_hi_decision_execution (id_, decision_definition_id_, deployment_id_, start_time_, end_time_, instance_id_, execution_id_, activity_id_, failed_, tenant_id_, execution_json_, scope_type_) FROM stdin;
\.


--
-- TOC entry 3721 (class 0 OID 397669)
-- Dependencies: 239
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_evt_log (log_nr_, type_, proc_def_id_, proc_inst_id_, execution_id_, task_id_, time_stamp_, user_id_, data_, lock_owner_, lock_time_, is_processed_) FROM stdin;
\.


--
-- TOC entry 3745 (class 0 OID 398091)
-- Dependencies: 263
-- Data for Name: act_fo_databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	activiti	org/flowable/form/db/liquibase/flowable-form-db-changelog.xml	2019-11-13 16:22:13.107355	1	EXECUTED	8:033ebf9380889aed7c453927ecc3250d	createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE		\N	3.8.0	\N	\N	3633332963
2	flowable	org/flowable/form/db/liquibase/flowable-form-db-changelog.xml	2019-11-13 16:22:13.136558	2	EXECUTED	8:986365ceb40445ce3b27a8e6b40f159b	addColumn tableName=ACT_FO_FORM_INSTANCE		\N	3.8.0	\N	\N	3633332963
3	flowable	org/flowable/form/db/liquibase/flowable-form-db-changelog.xml	2019-11-13 16:22:13.149302	3	EXECUTED	8:abf482518ceb09830ef674e52c06bf15	dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION		\N	3.8.0	\N	\N	3633332963
5	flowable	org/flowable/form/db/liquibase/flowable-form-db-changelog.xml	2019-11-13 16:22:13.162534	4	EXECUTED	8:b4be732b89e5ca028bdd520c6ad4d446	createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION		\N	3.8.0	\N	\N	3633332963
\.


--
-- TOC entry 3744 (class 0 OID 398086)
-- Dependencies: 262
-- Data for Name: act_fo_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3748 (class 0 OID 398113)
-- Dependencies: 266
-- Data for Name: act_fo_form_definition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_form_definition (id_, name_, version_, key_, category_, deployment_id_, tenant_id_, resource_name_, description_) FROM stdin;
\.


--
-- TOC entry 3746 (class 0 OID 398097)
-- Dependencies: 264
-- Data for Name: act_fo_form_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_form_deployment (id_, name_, category_, deploy_time_, tenant_id_, parent_deployment_id_) FROM stdin;
\.


--
-- TOC entry 3749 (class 0 OID 398121)
-- Dependencies: 267
-- Data for Name: act_fo_form_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_form_instance (id_, form_definition_id_, task_id_, proc_inst_id_, proc_def_id_, submitted_date_, submitted_by_, form_values_id_, tenant_id_, scope_id_, scope_type_, scope_definition_id_) FROM stdin;
\.


--
-- TOC entry 3747 (class 0 OID 398105)
-- Dependencies: 265
-- Data for Name: act_fo_form_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_fo_form_resource (id_, name_, deployment_id_, resource_bytes_) FROM stdin;
\.


--
-- TOC entry 3699 (class 0 OID 397397)
-- Dependencies: 217
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) FROM stdin;
6dd70ae3-05f4-11ea-9d91-7c7a916bf543	1	VacationRequest.bpmn20.xml	6dd70ae2-05f4-11ea-9d91-7c7a916bf543	\\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e730a09786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c220a09786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a09786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a09786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e220a09786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4449220a09786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f4443220a09786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f4449220a09747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a0965787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f5850617468220a097461726765744e616d6573706163653d22687474703a2f2f61637469766974692e6f72672f62706d6e3230222069643d22646566696e6974696f6e73223e0a093c70726f636573732069643d227661636174696f6e5265717565737422206e616d653d22e8afb7e58187e6b581e7a88b220a0909697345786563757461626c653d2274727565223e0a09093c73746172744576656e742069643d2272657175657374223e0a09093c2f73746172744576656e743e0a09093c73657175656e6365466c6f772069643d22666c6f77312220736f757263655265663d2272657175657374220a0909097461726765745265663d2268616e646c6552657175657374223e3c2f73657175656e6365466c6f773e0a09093c757365725461736b2069643d2268616e646c655265717565737422206e616d653d22e8afb7e58187e794b3e8afb7220a09090961637469766974693a63616e64696461746547726f7570733d22687267726f7570223e0a09093c2f757365725461736b3e0a09093c73657175656e6365466c6f772069643d22666c6f77322220736f757263655265663d2268616e646c6552657175657374220a0909097461726765745265663d2272657175657374417070726f7665644465636973696f6e223e3c2f73657175656e6365466c6f773e0a09093c6578636c7573697665476174657761792069643d2272657175657374417070726f7665644465636973696f6e220a0909096e616d653d22e5be85e5aea1e6a0b8223e3c2f6578636c7573697665476174657761793e0a09093c73657175656e6365466c6f772069643d22666c6f7733220a090909736f757263655265663d2272657175657374417070726f7665644465636973696f6e22207461726765745265663d2273656e64417070726f76616c4d61696c223e0a0909093c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b7661636174696f6e417070726f766564203d3d202774727565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a09093c2f73657175656e6365466c6f773e0a09093c6d616e75616c5461736b2069643d2273656e64417070726f76616c4d61696c22206e616d653d22e982aee4bbb6e9809ae79fa5223e3c2f6d616e75616c5461736b3e0a09093c73657175656e6365466c6f772069643d22666c6f77342220736f757263655265663d2273656e64417070726f76616c4d61696c220a0909097461726765745265663d22746865456e64223e3c2f73657175656e6365466c6f773e0a09093c656e644576656e742069643d22746865456e64223e3c2f656e644576656e743e0a09093c73657175656e6365466c6f772069643d22666c6f7735220a090909736f757263655265663d2272657175657374417070726f7665644465636973696f6e220a0909097461726765745265663d2261646a7573745661636174696f6e526571756573745461736b223e0a0909093c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b7661636174696f6e417070726f766564203d3d202766616c7365277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a09093c2f73657175656e6365466c6f773e0a09093c757365725461736b2069643d2261646a7573745661636174696f6e526571756573745461736b22206e616d653d22e9878de696b0e5a1abe58699220a09090961637469766974693a61737369676e65653d22247b696e69746961746f7249647d223e0a09093c2f757365725461736b3e0a09093c73657175656e6365466c6f772069643d22666c6f7736220a090909736f757263655265663d2261646a7573745661636174696f6e526571756573745461736b220a0909097461726765745265663d22726573656e64526571756573744465636973696f6e223e3c2f73657175656e6365466c6f773e0a09093c6578636c7573697665476174657761792069643d22726573656e64526571756573744465636973696f6e220a0909096e616d653d22e9878de696b0e68f90e4baa43f223e3c2f6578636c7573697665476174657761793e0a09093c73657175656e6365466c6f772069643d22666c6f7737220a090909736f757263655265663d22726573656e64526571756573744465636973696f6e22207461726765745265663d2268616e646c6552657175657374223e0a0909093c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b726573656e6452657175657374203d3d202774727565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a09093c2f73657175656e6365466c6f773e0a09093c73657175656e6365466c6f772069643d22666c6f7738220a090909736f757263655265663d22726573656e64526571756573744465636973696f6e22207461726765745265663d2274686543616e63656c223e0a0909093c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b726573656e6452657175657374203d3d202766616c7365277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a09093c2f73657175656e6365466c6f773e0a09093c656e644576656e742069643d2274686543616e63656c223e3c2f656e644576656e743e0a093c2f70726f636573733e0a093c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f7661636174696f6e52657175657374223e0a09093c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d227661636174696f6e52657175657374220a09090969643d2242504d4e506c616e655f7661636174696f6e52657175657374223e0a0909093c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2272657175657374220a0909090969643d2242504d4e53686170655f72657175657374223e0a090909093c6f6d6764633a426f756e6473206865696768743d2233352e30222077696474683d2233352e302220783d22322e30220a0909090909793d223137352e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2268616e646c6552657175657374220a0909090969643d2242504d4e53686170655f68616e646c6552657175657374223e0a090909093c6f6d6764633a426f756e6473206865696768743d2236302e30222077696474683d223130302e302220783d2238302e30220a0909090909793d223136332e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170650a0909090962706d6e456c656d656e743d2272657175657374417070726f7665644465636973696f6e220a0909090969643d2242504d4e53686170655f72657175657374417070726f7665644465636973696f6e223e0a090909093c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223233302e30220a0909090909793d223131342e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273656e64417070726f76616c4d61696c220a0909090969643d2242504d4e53686170655f73656e64417070726f76616c4d61696c223e0a090909093c6f6d6764633a426f756e6473206865696768743d2236302e30222077696474683d223130302e302220783d223332302e30220a0909090909793d22302e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22746865456e64220a0909090969643d2242504d4e53686170655f746865456e64223e0a090909093c6f6d6764633a426f756e6473206865696768743d2233352e30222077696474683d2233352e302220783d223437352e30220a0909090909793d2231352e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170650a0909090962706d6e456c656d656e743d2261646a7573745661636174696f6e526571756573745461736b220a0909090969643d2242504d4e53686170655f61646a7573745661636174696f6e526571756573745461736b223e0a090909093c6f6d6764633a426f756e6473206865696768743d2236302e30222077696474683d223130302e302220783d223332302e30220a0909090909793d223136302e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170650a0909090962706d6e456c656d656e743d22726573656e64526571756573744465636973696f6e220a0909090969643d2242504d4e53686170655f726573656e64526571756573744465636973696f6e223e0a090909093c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223336302e30220a0909090909793d223333302e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2274686543616e63656c220a0909090969643d2242504d4e53686170655f74686543616e63656c223e0a090909093c6f6d6764633a426f756e6473206865696768743d2233352e30222077696474683d2233352e302220783d223536302e30220a0909090909793d223233382e30223e3c2f6f6d6764633a426f756e64733e0a0909093c2f62706d6e64693a42504d4e53686170653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7731220a0909090969643d2242504d4e456467655f666c6f7731223e0a090909093c6f6d6764693a776179706f696e7420783d2233372e302220793d223139322e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d2238302e302220793d223139332e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7732220a0909090969643d2242504d4e456467655f666c6f7732223e0a090909093c6f6d6764693a776179706f696e7420783d223138302e302220793d223139332e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223139322e302220793d223138302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223139322e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223233302e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7733220a0909090969643d2242504d4e456467655f666c6f7733223e0a090909093c6f6d6764693a776179706f696e7420783d223237302e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223238322e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223238322e302220793d2233302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223332302e302220793d2233302e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7734220a0909090969643d2242504d4e456467655f666c6f7734223e0a090909093c6f6d6764693a776179706f696e7420783d223432302e302220793d2233302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223433322e302220793d2233302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223433322e302220793d2233302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223437352e302220793d2233322e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7735220a0909090969643d2242504d4e456467655f666c6f7735223e0a090909093c6f6d6764693a776179706f696e7420783d223237302e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223238322e302220793d223133342e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223238322e302220793d223139302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223332302e302220793d223139302e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7736220a0909090969643d2242504d4e456467655f666c6f7736223e0a090909093c6f6d6764693a776179706f696e7420783d223432302e302220793d223139302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223433322e302220793d223139302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223433322e302220793d223235332e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223338302e302220793d223333302e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7737220a0909090969643d2242504d4e456467655f666c6f7737223e0a090909093c6f6d6764693a776179706f696e7420783d223338302e302220793d223333302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223236322e302220793d223330352e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223234362e302220793d223235332e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223133302e302220793d223232332e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a0909093c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d22666c6f7738220a0909090969643d2242504d4e456467655f666c6f7738223e0a090909093c6f6d6764693a776179706f696e7420783d223338302e302220793d223333302e30223e3c2f6f6d6764693a776179706f696e743e0a090909093c6f6d6764693a776179706f696e7420783d223537372e302220793d223237332e30223e3c2f6f6d6764693a776179706f696e743e0a0909093c2f62706d6e64693a42504d4e456467653e0a09093c2f62706d6e64693a42504d4e506c616e653e0a093c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e	f
6e0f31e4-05f4-11ea-9d91-7c7a916bf543	1	VacationRequest.vacationRequest.png	6dd70ae2-05f4-11ea-9d91-7c7a916bf543	\\x89504e470d0a1a0a0000000d494844520000025d0000017c0806000000f59a0e2500002a104944415478daeddd0d90dd657d2ff08d4540c529b5d46a4b7be9e88c2f7dd169bdc519ad4def4d6b3285342abbc7b32fb21d49066368b9d4005e49c900b9d182421b31a3a8f8822245630a63824d20213197608cbc684840c24be812b24b1a4d4c0349f07f7fcf7a36f7e4b06f67f79c3d6f9fcfcc6f76b32fd9b3cfffe57cf7799ef33c6d6d002d2acbb2131e7becb15b376fdefcc29d77de99ad59b3464d71ad5dbb36dbb061c3b351ddce4800685229706ddcb831ebefefcf9e7ffe7955a31a1818c8eebefbee9f45003bc75909004d28f570095c7513bc9e5fb366cd7667250034a134a428f0d44f45e83ae2ac04802694e614093b7515ba32672500b478e87aeed0c16ce0c92dd9a39b3f973df9c0378524a10b00a864e8dab7e791ecc9fbff35fbf17717650f7c67e1603dbcf13a2149e80200261bbafeebc0beac6ffb1dd943772d3d16b4066bd5c5d9635bbe94fdfc677b8424a10b00984ce83ab8bf3fdbbeee13c787ad42a5deaef4b9d2dab1feea6ce0c9ef0b4e42170030ded0b563c327870d5c6395795e4217005046e81a4fc07a6ccb8dd9e33ff8caffafad37654f3fbc26dbf7ccc3c293d00500542a748d54dbd65c213c095d0040a542d7239b96653bbfffc5e3ea891f7e2ddbfb1ff70b4f421700309ed0f5e0ea8f4ea897ebc1d59766fbf73e293c095d00c07842d7e35bbf3a66c07ae8aefff3a25730a6deaf83079e159e84ae49cbe7f3a7e572b9f787aba3d6453d159515d5eea87be26b6e88af3d2fde3f43ab01d070a16bffde5d83bd56e3095d69a988bd7d0f084c425745747474cc8820f5ed0851874a42d658752485b0a8dee9d3a79fe0ca06a0214257aabd7d0f66dbd65e398e21c58f66fb9ed92e30095d931261e96d515bca0c5a23d5f6d4fbe5ea06a021429712baa64a04a4a5859eaa63c1a9abab2b5bba746976ebadb766dbb66dcb76efde9d1d3a74284b0e1f3e9cf5f7f7678f3cf248b662c58ac1afebe9e9192e7cad8effe77457390042976ae9d0d5dede7e4a61bed6b1a0d4dbdb9bdd74d34d83a1aa1c070f1ecc56ae5c995d78e185c705af5c2eb72fde4e77a5032074a9960c5d85c0b5b138202d5ab468b0476b328e1e3d9aad5ab56ab0a7ace8ff3e10758eab1d00a14bb55ce82aede14ac3882930554a5f5f5fb670e1c2e2e0752897cb9de58a0740e8522d13ba0a73b88e05a2cd9b3767d590e680a5f95ec53d5ef1b3dfe8aa0740e8524d1fba0aaf523c52dcc3554d69d2fd92254b8e5bdf2bad01e6ca0740e812ba9a3a74e572b9fb8ae7705572487124fbf7efcfe6ce9d5b3cb9fe5a573e004297d0d5b4a12b2d7c5afc2ac5c94e9a2fc7d6ad5b4b27d69fe1ea07a022f2f9fc9aa8770a5d4257bd88a073fb50f049cb424cb56baeb9a638785ded2e0140a59ee0069f5c52f8cae5726f17ba84ae6a19edfc2afa23e0b4a1ad7dd2720ee5aec355093b77ee3c6efdaededede53dd2900a858e82a5e9d7bb89e2fa14be8aac0b9b6aeb0f9f459a304b3f70f9d8be91585b552bc786a5c0f73dc2900a846e83ad6f3551cbe842ea1ab02e7da4f8aceb11b879b2f9586f3a6ea158ba3b9e5965b4ca807606a425771cf571a1612ba1a3e744dab8373edf19273eb485a8b2bad3a5fd21b36f8f91d3b76d42c74a535c18aff0071a70068cd10549312baeaab26781c7f1ef54cd4a351f7477d2f02f51df1f65b112cbe1cef5f1ff589f8f7a2a8ff153537ff4b67777474fc457ceebf47407a73d4ef46bd2aeac432cfed81111e57faf847a64f9f7e42bc7d6ae8e353f9aac552bb76ed3a6ecd2e772680260d5d7512f2b6a4b937e989307d9dd0d5f83d5d3d3d3daf8800f59b715c5f17f5960852efe8ecec7c777cec7d51e7c631ff70bcbd38de5e11f5a9a8cf457d3dbef6b6f8f85df1fef7a31e8ada15f59f51cf471d2ebcbfabf0b9efa7af2d7ccfcdf1f686343c171fbf721ca1f0fee27fa795e26b252d965afc58dc990084ae6a84aee3c2d6907a0b5df19086ada9fabc395dbf346fdebc974670fbb5386f7e27ce9b37a5deb0d42b967ac7521759ea2d2bf49a5d368ed0f57cf1bf6b4de80210baaa15baee49afd22a0d5bf51cba46fb58b53f2f7495a7ababebf41182d681d413d6dedefefad23f02f47401d06ca16bd89e2da14be8aaf079764649d8da1de7dd82d235b0cce902a06943d778095d42d76444c0fa83a15702c6db73226c9d3cc2f9efd58b00085d4297d035999eaef1ac481f5fb7ac1ed6e94a3fbba8a76b993b1380d02574095d4d259fcf77d7c38af40b172e2c0e5de7b83301085d4297d0d5540a13ee8fedbdb87ffffe5acfe73a94f68374670210ba5a3a74b55932a259af8163f3ba56ac5831e5a16bf9f2e5c5a1eb46772500a1aba54397c5519b3774150f31ce9f3f7f4a978ee8ebeb1bec611bfaf99d9d9d6f75570210ba842ea1ab2915b603fad150f059b972e59485ae2baeb8a278a3eb6fbb2301085d4297d0d5d40b7616f776a59ea7279e78a2ea816bd5aa55c76dc69d96b970470210ba842ea12b6b816be1f6a11074d1451765070f1eac5ae0dab469d371c38a51e7bb1b01085d42976a89d0d5dedefe9ab81e068682d092254b06b7e7a946e0eaeded35791e40e812ba546b86ae242da81ab56f2810a539577bf7eeade89062490fd7ea087ba7b81301085d42976aa9d095a48dd887d6ee4a957aa5d2363d937d95e2e5975f5ebaf9b6c0052074095daa754357d2d1d13123ae8d03c52129ad585feefe8c69e1d3b40e5749efd6e090a2c0052074095daae54357a1c7eb8d717d3c551296b20b2eb820bbf9e69bb38d1b370ebeca7168de577a9b4256ea154b7b295e72c925a5416bf0558a26cd03085d429712ba4aa4dea8085f4b4b7bbd2652691d2ecb4200085d429712ba4651d8a3f1cae249f6e3ac3437ec462bcd03207429a1ab0cbdbdbd2717e67b5d9d26c20f33fcb83b9fcfaf89b7cb22a0bddfe6d500085d4ae80200a14be812ba0040e812ba842e0040e852421700085d4297d0050042573db9f3ce3b859dfaa94311ba8eb85a00a00943d7860d1b76f7f7f70b3c75507d7d7ddf88d0b5ddd502004d18baeebaebaebf59bf7efd4ff7ecd9f35f824fed7ab852e05abb76ed9351e7b85a00a0094357124ff467ad59b3664b1ada4a738ad494576af7ed0217003479e8020010ba000010ba0000842e0000a10b0000a10b0040e8020040e8020010ba0000842e0000842e0000a10b0000a10b0040e8020010ba000010ba0000842e0000a10b0000a10b0040e8020040e8020010ba0000842e0000842e0000a10b0040e812ba0000842e0000a10b0000a10b0040e8020010ba000010ba0000842e0000842e0000a10b0040e8020040e8020010ba0000842e0000842e0000a10b0000a10b0040e8020010ba000010ba0000842e0000842e0000a10b0040e8020040e8020010ba0000842e00802677aad00500505d33a3b2c25ba10b00a00a6644ed8bbab6f0f62ca10b00a03a816b2868a59eae815a042fa10b006895c035d6c7852e008032cd1c23580d7d7ecae678095d0040b306aeb102d594f678095d00403399d1565e0f56b95f2f7401000257dbc47aaed2f71da876f012ba0080560e5c95fa7ea10b00687a634d9a9feaff47e802009a3670556a68b06a3d5e421700d0a84a27c14f8b3ab7f0b61ca5df5795c9f5421700d0c881ebaca2e0f485b65feeaff8853282d748df57f1e0257401008d1eb892730bc1292b23781507aea1fa40d1e72b3ac74be802001ac9484168b800355af01aeeeb3f3fccd7576c8e97d005004ca97c3ebf26ea9d93085c33cb0852c305aff106aed2e035a9a146a10b009852297ca44ae12b97cbbd7d9cdf36dee03356f02a377015fffc81b649f478095d00404d425751ad1ea3e7abdc21be9182d74b2618b8864c6a8e97d00500d43a741debf91a267c4d744ed570c1ebe14904aec93e1ea10b00a88fd055dcf35518769cecab07870b5e93095ca5c16b66b9bfb7a30f0042505dd57bdffbdea17074ed247fbd34a458dac3f570e1e39371ed447e2f671b00b478e8aa9390b72597cb9d357dfaf4130a5f3ad92d7e46ebe92a6701d5527aba0080860c5da561ab34e01c68abce9cae89042f73ba0080860b5df7e4f3f9392384ade182ce787b96465a1662b8572f9613bcbc7a110068a8d0355acfd658c16bacc033d63a5ce5ae5c3fe46d6dd6e902001a29744dc2583d4de35df8b4dce03534c439a745da190068f1d0351480c6bbf7e268cb428c37780dfdbc392dd6ce00408b87ae24f578950ef59ddb56fe3a5cc305af0f94fc9c8a6c762d7401008d1a064a9793280e50e52c7c3ad2f75564936ba10b00688630503ad49802d307daca5f06a2f4fb26bb3e98d00500345d1898f0ba5923186ee8523b0300c240058357a5039cd00500345d1898ec9060558614852e00a019c3c0445f6d58f149f3421700d0ec61a0dc21c2aa0e290a5d0040338781f106a9b4b5cfa4579a17ba0080560e03330b816ae6289f1f98aac025740100cd1c0646eaf19ab22145a10b00689530501ab06a12b8842e00a015c2c050d0bab656814be802005a250ca4395c595b959785d0ce008030d0d676aa7606008401ed0c0008036867004018d0ce008030807606008481166fe72ccb4e78ecb1c76eddbc79f30b77de7967b666cd1a35c5b576edda6cc3860dcf4675bb520084019ab49d53e0dab87163d6dfdf9f3dfffcf3aa4635303090dd7df7dd3f8b00768eab054018a009db39f570095c7513bc9e5fb366cd76570b3022c3138d3d3c2174b576e84ad7acc0533f15d7f311570b3022c3138d3d3c2174b576e84aa1ddf55357a1cbf5088cccf044630f4f085d42d778cead9fff7477f6d8961bb36d6baf18acf47efa98eb4ee802a690e189c61e9e10ba84aeb1cea903fbfab21f7f7751f6c077161e57e963e973ae3ba10ba8b3bf94557ddeb4852ea16bac73eaa96db7bd28700dd57f6cbbdd75277401f516ba0c4f085d4257635ebfdbd77d62c4d0953ee7ba13ba803aba691b9e10ba84aec60d5d3f5eb378c4d0953ee7ba13ba803aba691b9e10ba842ea14b095dc014dcb40d4f085d4257e386ae341d60a4eb377dce75277401fe5276d316ba84ae0a5cbf3fd9f4e911afdff439d79dd005085d6eda4297d05581eb776fdf83d98ffffdf2175fbbf1b1f439d79dd005d4d14ddbf084d0257435f6e2a88fffe02b2fba76d3c75c73421754dde2c58b4fbdfefaebafbaf2ca2b7fb068d1a281f9f3e71feeeaeacad28d35d5bc79f38e5e7cf1c5fbaeb8e28afb3ff399cf7cf6b2cb2e7b5d2b872ec3134297d0d5c0a1ebb9e7b29ffcdfe52fbe76e363e973ae3ba10baa62c99225efbefcf2cbefebeeeefe4584ad6ce5ca95d9830f3e38b8efe0d1a347b3217bf7eecd76ecd891dd71c71dd935d75c93a5af8f10f6547ccfbce9d3a79fd06aa1cbf084d025743566e84a4bba3cb269d9887f34a5cf59f645e8828abaf0c20bcff8e8473f7aff79e79df78b5b6fbd75305495e3f0e1c3d9a64d9bb2cb2ebbec17f3e7cf7f66eedcb9b35b2974199e10ba84ae060b5dcf3d97edfec95dd98feef8df2306aea14a5f93be56af97d00593b668d1a2051ffce0078f7cf9cb5fce0e1e3c984dd6962d5bb2085d87cf3ffffc95edededa7b444e8323c2174095d0d13bac6eaddd2eb257441555c7ae9a59ffdf0873f7c74ebd6ad5925eddfbf3fbbfefaeb0ff7f6f63e1dc1eb35cd1cba0c4f085d3456e81a4fefd668bd5eae43a10b2614b8162c58f0429aaf552d5ffffad75fe8eeeefe5904afd7375de8323c519737edb3cf3efbe51d1d1d33f2f9fc551104be97c2409c7f27bae285aea19a68e01a2ad7a1d0056549438aa987ab9a816bc8bffddbbf3d17c1abaf517bbc0c4fd4f74d7b989075206a63d49551ff33cebb97b9e2852e2574414da449f3690ed7fdf7df9f4d95af7ded6b4f777676ded688af6c343c515fb57af5ea4cc812ba842ea10b1ac2a5975efaa334697eaafdfddffffdd3b95c6e4133842ec313b5a9f4428f73cf3d3713b2842ea14be882ba97d6e14acb4254e2558ae5eaebeb3bdad9d9f99ff97cfeb4460f5daa76f5ddef7ed74d5be872fd0a5d50ffd2c2a72b56acc86ae5e31ffff8b6085d4b852ee5a62d744d46dc47d644bdd3f5ebfa85ba94b6f6492bc797bbf069857bbbfae346f96c23cded72d376d3a6fe42d7d09664297ce572b9b7bb7e5dbf5057962f5fbe346ded536b1ffad0871e1ecf5fa8429772d316bac60a5d45b57ab8fb8aebd7f50b359136afbefdf6db6b1ebaaebbeeba4df530c46878c24d9ba60a5dc77abe8aaf6bd7afeb176a62d1a2450369f3ea5adbbc79f3fd71735c570f4f128627dcb469aed055dcf395ae6bd7afeb176a62fefcf987a76231d4b13cf3cc33bbe386b8bb5e4297e109376da62404d5a45cbff555133986ae2e1a5257575776f4e8d1ac1ed4c385647842e8a22943de965c2e77d6d08b755cbff64e859adda4ea453d872ec31342170d19ba8e0b5bf5fa47533ca4616baa3e2f74418bf674354a095d4217751dbaeec9e7f373465a86a61e43d7681fabf6e7852e9822f532a76b6060e0e93a9dd3657842e8a27142d7b03d5b4297d00575e1631ffbd8b3dbb66dab97572f6e343c617842e8a2da842ea10b6a22add3b56ad5aaba58a72b2ea4ab0d4fb8690b5d085dae5fa18ba674fdf5d75fb364c9929a87ae050b16fc382ea4e98627dcb4852e842ed7afd045535ab870e16bce3df7dc5f1c3c78b0966b74a5bd177fdedbdb7bb29bb69bb6d085ebd7f52b74d1b42eb9e49247d7af5f5fb3d0f5e94f7ffa07b95cee06376d376da18b56bd7edbccc914ba680d975e7a69fe231ff9c80bb5583ae2e0c183473a3b3bffb3ababeb74376da14be8a215af5faf3e16ba6831f3e7cf7f66e3c68d531ebaaebcf2ca07e3025ae6a62d74095d085d4297d0454b98376fde5fcd9d3bf7f0be7dfba62c70fdf0873ffc493e9f7fb4bdbdfd14376dc31342174297d02574d132ce3ffffc6f5e77dd7547a66298f1e9a79f3e9886153b3a3a66b8692ba10bd7afeb57e8a2a5a46512fef66ffff6f1af7ce52b87ab19b8fafbfb8ff6f6f63e9dcfe72f74d3564217ae5fd7afd0454b8a20745a4f4fcfde152b563c5fad1eae42e05aeaa6ad842e5cbf4ae8a2a5a55712767777f77df18b5f7ca6d273b8d2906223f770b9690b5d085d4ae8828af7784540ba2dbdaaf1c9279f7c6eb2cb42a45729a649f38d3a87cb4d5be842e852421754552e975b10e16bcf55575df5a39d3b773e53ee4af3d75f7ffd96d4bb1517c9f2467c95a29bb6d085d0a5842e9832292cc549be38eaa979f3e63dfc4ffff44ff7ac5bb7ee87bb76ed7ab23864edddbb77cfe6cd9bef4f9b57a7bd14d3d63e69a5f9465bf8d44d5be842e8524217d443cfd7db0b016c75d4e35147d20550a8dd51f7445d9d36af6ea4bd14ddb4852e842e2574016eda4ae8c2f5ebfa15bac04d5b095db87e95d005b869bb6983eb57e802dcb495d085ebd7f52b74016eda4217ae5f2574016eda4ae8c2f52b74016eda4ae8a26edd79e79dae9bfaa94371fd1e11ba00a1ab416af5ead56ec28cdb860d1b76f7f7f7bb76eaa0fafafabe11f7d3ed4217207435401d387020ebeeeece8a16e92d5eacf7f192da327dfaf4139cc1adedaebbeefa9bf5ebd7ff74cf9e3dffe51aaa5d0f570a5c6bd7ae7d32ea1ca10b1891e189faba79af5cb932ed8cf0d3618257697dc4d94b124ff467c51f4f5bd2d056fa234a4d79a576df5e6ee012baa005199ea8bfe189cececeb7c6cdf8e7a304aeddcdbc3515b40aa10b5a8ce189fa1c9ec8e5720b460a5df1b94b9db92074010dc8f0447d0e4fe4f3f99b4b03577cec85a88b66cd9a75923317842e002aa0b7b7f7d4c224fae2e0f5a95c2e775bbc7d326aaec9f420740150011d1d1d33e2c67ca810b81e1f9acb15ef9f19f5ef518f46f52c5ebcf8255a0b842e002677635e5c185abc709850f6aef8dc86a88772b95c7b7c689a1603a10b80098a4075c368af588ccfff55dcc0ef8dba3f6ab61603a10b802acae7f3671782d7bd2988691110ba00a89e6969a8310d39a6a1c73404a94940e802a04ad2e4fa34c9be30d93e4dba3f53ab80d0054095a46525d2f2128565266e4f2bde6b1510ba00a892b4a06a61a5fbbea85bdbdbdbdfac5540e802a04a226cbd2c6d981df54cd457e3dfafd72a20740150bdf0754adcf42f8b1a484b52c4bf7f57ab80d0054095a4ed86f2f9fc55f104f06cd4b2eeeeeed76a1510ba00a892085ea7c593c0d5517b73b9dc35e9df5a05842e00aa24f574a51eafd4f3957ac0524f985601a18bdafe511c7f0cbfbff087f1baa8a70a7bf20ed5eea87bd25491f8daf3e2fd33b41a349034c72b5dc069ce579afb357bf6ec576a1510ba983a1d1d1d33e23efced38570e9584acb1ea480a6151bd69d9202d090d222ef8d7a5573946ed49af7a4caf7ed42a207451d573e36d515bca0c5a23d5f6d4fba555a1b1c2d79bd2fa5e699dafb8802f48eb7e691510baa8acb8bf2e2df4541d0b4e5d5d5dd9d2a54bb35b6fbd35dbb66d5bb67bf7eeecd0a1435972f8f0e1acbfbf3f7be49147b2152b560c7e5d4f4fcf70e16b75fc3fa76b6168206945fb0860b71556b89fabeb1a842e26afb08ccfbae2a0d4dbdb9bdd74d34d83a1aa1c070f1ecc56ae5c995d78e185c705afb877ef8bb7d3b53634de13c699853d1dd3de8e3d69af47ad024217130e5c1b8b03d2a2458b067bb426e3e8d1a3d9aa55ab067bca8afeef0351e7687568401d1d1def8a0b7843d443f157547b7c689a5601a18bb2ce85e37ab8d230620a4c95d2d7d7972d5cb8b038781d8afbf5595a1e1a545cc07f1517f2bd51f747cdd622207431b6c21cae638168f3e6cd5935a4396069be57718f57fcec373a02d0d83790b30bc1ebde14c4b408085d8c780ebcad78d27ceae1aaa634e97ec99225c7adef65216c687cd3d250631a724c438f6908529380d0c5f1e23e795ff11cae4a0e298e64fffefdd9dcb9738b27d75feb4840134893ebd324fbc264fb34e9fe4cad024217bf5cf8b4f8558a939d345f8ead5bb7964eac3fc311812691969548cb4b149699b83d2d3ba15510ba84ae163ffeb70f059fb42cc454bbe69a6b8a83d7d58e083499b4a06a2e975b9016584d0badb6b7b7bf59ab2074d16ad23caaa1ad7dd2720ee5aec355093b77ee3c6efd2efbec42934a5b09a52d85a29e495b0cc5bf5faf5510ba681585cdab07034f7a4561ad142f9e1a41708e2303cd1dbed2828097a54db5d3e6da69936dad82d0450b1cfbaba7ea158ba3b9e5965b4ca8875693bab5e3afacabe2c27f366a596767e77fd32a085d34f1b13fb618ea8e1d3b6a16bad29a60453d5d6b1c19682185790e9f8a7aa1bdbdfd37b408cd2aceefdf4e4f7469a85d6bb464e87a6a28ec4ce5ab164beddab5ebb835bb1c1968cd1bd2bfdb1b8c263fc73f975622d7122d7bfc8f859db4527cada4c5528b1f8b2303ad79433a3f4db0d71234a3f6f6f637c4f9ddefd5624257aa5a13bac00de9b7d2fcaeb4be97d6a009cfef6fe572b9855a42e8d2d305d4cb4d694bd4742d4133e9ececfcd338af77f5f6f69eac355afafe664e17505737a5cbbc8499263cafd3abd63ea8259c075ebd08d48daeaeae3f8c1bc1635a8266114f6a33d326f0edededbfa2355a3e742dab8775bad2cf2eeae95ae6c8406bdf981e4be14b4bd004a6e572b9fbacfa4d218077d7c38af40b172e2c0e5d5e310ead2c0d2f467d4c4bd0047f407446dda32548e28fc9d38bf75edcbf7f7fade7731d4aeb243a32d0c23a3a3afe226e06dfd71234b279f3e6bd34cee39d713ebf4b6bb44cc83ea3b44a5f8d5d3caf6bc58a15531eba962f5f5e1cba6e74d4a0c5a59b54616ba0dfd21a34aa7c3e7f412e97fb8e9668a9d0b5bd782986b16afefcf953ba74445f5fdf600fdbd0cfefecec7caba306a49bd757d362a95a824654d8d47d7704af3fd21a2d15b4cf1b47d83a1a5ff7ecd0bf57ae5c3965a1eb8a2bae28dee8fadb8e183014bace895aa52568d0f3f772bb2bb4ecb11fadb7ebf9b4665bf184fad4f3f4c4134f543d70ad5ab5aaf8711c89d0f5078e163068f6ecd9af8c1bc3cf528f81d6a091a44ddb0bc3e367688dd6335a6f57049db38ac2d9ed431fbfe8a28bb283070f562d706ddab4e9b86145a308c0707f31aef672661af0bcfde778e2bd4e4bb46ce8fa1fa9476b98d0b5ac249cbf263e3630f4f9254b960c6ecf538dc0d5dbdb6bf23c30e693970db06928f144fa7ba9972bf576698d960b5b7f19c77e7dd4a3b95ceeb692c0b56eb83d65e3ebde1eb56fe8ebd29cabbd7bf7567448b1a4876bb5d10360a4d065036c1aed9cfd6a3c89fea3966819d3e298cf8eba3742d7b638f65d69e781dedede538b7ab176a7f5b946096b7386d6ee4a957aa5d2363d937d95e2e5975f5edad3267001633e89d9009b86104fb86f494fb09ed89adfe2c58b5f12c73a17f540d4d638f6ef4d01ace4de755961c2fadbc7faff3a3a3a66c4d71e280e4969c5fa72f7674c0b9fa675b84a7ab70687149d97c07842970db069947375559cab0bb444f32aac21d81bf570d4f7e278cf1ae96bd34aef6952fd78ffeff8da37c6fff954e95cb00b2eb820bbf9e69bb38d1b370ebeca7168de577a9b4256ea154b7b295e72c925c34dde3f62d23c306e36c0a611c413e69fa7d5e7d32af45aa3f9cc9a35eba408581f8a63fc441ceb35d5ea7d4fbd51f1ff2f2dedf59a48a575b82c0b014ca407c106d8d4fb397a4f3c59e6b54473e9e9e979451cd67f88e3db57981c7fe614fdb199f668bcb27892fd382bcd0dbbd14af3c084d9009b3a0f5cef89f3f3beb692393d34aef6f6f65f2dccc9da13754bad7616e8eded3db930dfebeac2123aa5c38fbb0b3d6fcbe21c7cbfcdab8149b3013675fce4fc2b6905f2cecece776b8dc697424b1ccf2585c56dbf14c7f70d5a05682936c0a65ec539f9c178a2be4b4b34fc714ccbd37c2a6a6fd467ec2600b4fa4dd106d8d49534f493867bd25e7a5aa361ef2b67442d4f612bc2f327bbbbbb5fab550037471b605367e249fae25c2ef74d2dd178d2b0611a3e4c3de8711caf32170aa0880db0a9278515c7fbcdf9692c85056c6f4913e4d38b73d28479ad02300c1b605347e7e2c7a33eab251ae6789d19757b61e9878bd252105a0560f41ba70db0a9b9f6f6f6dff6c28e86b9674c8f5a1bf5785adc342d72aa5500c67703b50136f5701e7e2ead1aae25ea57da9e278ed3a6384e3bd2b63dee1900137bc2b3013635539880dd9fe674698dba332d42d6fbd206d46923ea78bf236d4cad5900261eba6c804d2dcfbf6fc5f9b7504bd45510fe950858dd51dbe2f86c8eb767b7d91d0060f26c804dada4f5b8e2dcdb95d6e7d21a7511b64e8ce33137ead1a8f569bb1cad02506136c0a646e7ddbab402bd96a879d87a591c87bf2bec43b82ac2d63bb40a4095d8009ba996cfe767c613fc4369284b6bd44661adbe4bd226cf8561de3fd62a005566036ca6d8b47882bf2f82d71c4d31f522e8be2aaef7c55103710c6e8a7fbf59ab004c111b603395e23ceb8cba474b4cad0858bf1961f713695fc4787b43d4ebb40a406d9e086d804dd5cd9b37efa5719eedece8e87897d698b26bfb77a29615c2d6bf7475759dae55006a7b63b601365597cfe72f8827feef6889ea6b6f6f7f7d5cd39f4fbdd8a9872bf5746915803a60036ca620049c92266dc793ff1f698daa06dbdf8f76fe5a5a7436cdddeaececfc35ad0250676c804d95cfafcbedf5593d11aefe24da774521d85e9cfe90d22a00f5fba468036caaa2bdbdfd370a2fd638436b545604ac7716fe60da95866fd3ba5b5a05a0fe43970db0a9d6b9f5cf1108aed312150d5b7f99568e4f2bc8c7fbe7a515e5b50a40633d39da009b8a8a30f07b29cca7de2ead3169d3a22d6747dd9bf646cce5725d16980568dcd065036c2a7d4e7d35cea97fd41213b778f1e297443be6a21e88da1aedf9de369b500334361b605349110ede9226767b55ecc414162eee8d7a38ea7bd19eb3b40a4013b10136153c9756455058a025ca336bd6ac93a2dd3e14edf7443e9f5f63c81fa049d9009b4a88b0f0e769f5f9b40abdd6189f9e9e9e5744bbfd43b45b5f5c83b7c5db33b50a4013b301369590f6578c0091d712636b6f6fffd5349f326a4fd42d169005681136c0a60281eb3db95ceebe3693bd4715e1eab468ab2585ebed4b11bedea055005aef49d306d84c485ac220ce9ded9d9d9defd61a235e5f694dbc4fa54da8a33e63d15880d67e523827fe0abf434b308173e78371eedca525866d9b33a296a7b0156df4c9eeeeeed76a1580169716b28c278517a2fe356aa60518198fdedede9323503cd5d9d9f9a75ae3b8ebe90d69f8300d23c6f574551a56d42a001cd3d3d3f3eac27e8c9bd3aba9a23e9ecbe5dea4651849da6839ce916f6a895f2aac53764b9a209f5e119c26cc6b1500c67a327d630a5d85f09542d8f9bdbdbda76a1986a4f321ce8b7e93c1078711cf8cbabdb0f4c3456929086708006549c38c69b8319e4cbe114f26fbd25bc38f1482460ae59f6df136981eb536eaf1b4b8695ae4d49901c0a4157a360c3f92c2f86fb7f23223697b9ef8dd37c51f203bd2b63d69d9156705005561f8b1b5c5f1fe5c9c034b5becd79e16bff3fbd206d46923ea78bf236d4ced6c00604a187e6cc9639e5e99d7df2a21bb708e77476d4b7f60c4dbb3db2c020b402d197e6c0d715cbf15c775610b84ad13e3779d1bf568d4fa8e8e8e198e3e0075c7f063734aeb71c5b1dc95d6e76ae2b0f5b2f81dff2ead3f16b52ac2d63b1c79001ae109ccf0631389e3b72ead40df8cbfdbecd9b35f19bfdb2551bb0bbd797fec8803d0900c3f36b642787ea8d90273fc3eaf8adf6b71d440fc8e37c5bfdfec6803d04c4fe0861f1bcbb408c8f7c5719bd344e7e06fc6eff489b42f62bcbd21ea750e33004dcbf0636388e3d219754f93fc2ebf13b5ac10b6fea5ababeb744718809662f8b13ecd9b37efa5712c76767474bcabc103feebe3f7f87c5ad435f570a59e2e4717809667f8b1ae8ec5051152bed3c08ffff7e3fcf95a5a5b2ccdddeaececfc354715004a187eac79fb9f925ecd176dfe478df6d8235cfd493cf61585c77f717a75a2230a00e360f871ea451b5f1ef5d5467acc11b0de198f79755a4f2cf5d2a575b71c490098f813abe1c72a8bb0f21b854dadcf689073e22fd3caf16905f978ffbcb4a2bca30800950b06861fab24daf29fa32dafabf387392d1ee7eca87bd3de88710e7439f6005065861f2b1a667f2ff572a5deae7a7c7c8b172f7e493cbe5cd403515be338bfb7cd26d40030f50c3f8ecff4e9d34f18eee3691e5704997facc7c71b8fad37eae1a8efc5639ce52802401d30fc38ba688fe55157469b9c36f4b168a7b7a457fca5572ed6cbe39c356bd649f1b83e148feb8978ac6be2ed74470f00ea94e1c76143d7ad5159d481688b4b0b6db42ade5f500f8fafa7a7e71511b2fe211daf784cb7c5db339dc900d0400c3f1e0b5deb0aa16bb022d8a40544076abd80687b7bfbafc6e3b82c6a4fd42d8db84e180070fc937b2b0c3f9e3aded055544fa5b95323cdf9aa62183e2d7eee92c252155f8ae3f0066729003499261d7e9c199515de9613ba86eaf6689793abfd20e3e7fc56d4a7d226d4519f6994b5c10080496a92e1c71951fba2ae2dbc3d6b98b0b371b4c0553cc1be4a61eb8cc264febdf1b33ed9ddddfd5a671f00b4a0061e7e9c5112b4524fd74069f08adfe727c384ad43d51e5a4cc38669f8300d23467b5e55ed7007003490061a7e2c0d5c237e3c7e87c74b26d2dfd7d9d9f9d66a3db0c27214b7a409f2f1fec7d2847967160030a23a1e7e9c3942e02afdfcccd2d015bfd3d26af56ea5a51ed2706561e9878bd25210ce220060dcea6cf8f1b840358a633d5ef1787f1ef542544f95c2d6f4a8b529dca5c54dd322a7ce1a0060526a3cfc38639c81ebb8afffb33ffbb3a7d3963f957e30697b9ef87f374500dd518ba52700801631c5c38f23cde11ad549279df4d7279c70c22f4e3bedb4ae0a3d8e69f17bbf2f6d409d36a28ef73bd2c6d4ce0600a0eaa660f8714281ab38784de6fb8b7ec7eea86d2960c6dbb3530073f401809aa8c2f0e35893e6abfaff44d83a317e87b9518f46adefe8e898e128030075a502c38fe39d343f5ee3ee318bb0f5b278bc7f57d82a685584ad7738a200405d9be0f063e9a4f93494776e5bf9437aa5df37ea64fcd9b367bf321edf2551bba3be158ff78f1d4100a0e18c73f8b1b4472a05a62fb4fd727fc52f9411bc46fabe1705af0880af8ac7b2386a2002e14df1ef373b5a004053186ef8f1d77ffdd7e7b4bd7808f0dc4270caca085ec5816ba83e50f4f9c1a1cb57bffad5dd11fa3e91f6458cb73744bdce9101009ad2d0f0e3d9679f7df77bdef39e174e3cf1c4f78c23408d16bc86fbfacf977efdcb5ffef2bf9e3367ce0b3367cebcadababeb744702006805833d4f279d74d2d96504a9e182d7b8025771f06aabec647d0080ba35de95e6c70a5e6505ae929f3fd036f965290000ea3e708d37f08c14bc5e32c1c035a452eb810100347ce01a2d783d3c89c035d9c7030050b726dbb3345cf09a4ce02a0d5ee67801000defd44238ba7692ff4f1a522cede17ab8f0f1c9b8b6f07f9dea5001008d6eb25bfc8cd6d355ce02aaa5f47401004d27059c036dd599d33591e0654e1700d0d4c1ab9c9ea591968518eed58be5042faf5e04005a26788d1578c65a87abdc95eb87bcadcd3a5d00408b18aba769bc0b9f961bbc868638e738040040ab18a9c7abdc95e6c71bbc867e9ec00500b49cd4e3553ad4776e5bf9eb700d17bc3e50f273cce102005a3e78154fae2f0e50e52c7c3ad2f759160200a024189d5514a03ed056fe3210a5df37d9f5c100009a3e784dd6704397000054307859f81400600c931d1234a408005066702ab7a7caa47900800906a8b3aaf4f500009419a4d2d63e569a07009884998540357394cf0f085c00009337528f97214500802a072f810b00a0cac1eb5a810b00a0bad21caeaccdb21000005577aa2600000000000000000000000000000000000000a09efc3f75af8e308722ad7b0000000049454e44ae426082	t
\.


--
-- TOC entry 3698 (class 0 OID 397392)
-- Dependencies: 216
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ge_property (name_, value_, rev_) FROM stdin;
common.schema.version	6.5.0.1	1
next.dbid	1	1
identitylink.schema.version	6.5.0.1	1
entitylink.schema.version	6.5.0.1	1
eventsubscription.schema.version	6.5.0.1	1
task.schema.version	6.5.0.1	1
variable.schema.version	6.5.0.1	1
job.schema.version	6.5.0.1	1
schema.version	6.5.0.1	1
schema.history	create(6.5.0.1)	1
cfg.execution-related-entities-count	true	1
cfg.task-related-entities-count	true	1
\.


--
-- TOC entry 3725 (class 0 OID 397904)
-- Dependencies: 243
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, duration_, delete_reason_, tenant_id_) FROM stdin;
c18ff5fd-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	request	\N	\N	\N	startEvent	\N	2019-11-14 18:08:50.896	2019-11-14 18:08:50.926	30	\N	
c1965e9e-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	flow1	\N	\N	\N	sequenceFlow	\N	2019-11-14 18:08:50.937	2019-11-14 18:08:50.937	0	\N	
c196acbf-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	handleRequest	c1b2e750-06c6-11ea-a7f8-7c7a916bf543	\N	请假申请	userTask	\N	2019-11-14 18:08:50.939	\N	\N	\N	
\.


--
-- TOC entry 3728 (class 0 OID 397930)
-- Dependencies: 246
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_attachment (id_, rev_, user_id_, name_, description_, type_, task_id_, proc_inst_id_, url_, content_id_, time_) FROM stdin;
\.


--
-- TOC entry 3727 (class 0 OID 397922)
-- Dependencies: 245
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) FROM stdin;
\.


--
-- TOC entry 3726 (class 0 OID 397914)
-- Dependencies: 244
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_detail (id_, type_, proc_inst_id_, execution_id_, task_id_, act_inst_id_, name_, var_type_, rev_, time_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
\.


--
-- TOC entry 3703 (class 0 OID 397438)
-- Dependencies: 221
-- Data for Name: act_hi_entitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_entitylink (id_, link_type_, create_time_, scope_id_, scope_type_, scope_definition_id_, ref_scope_id_, ref_scope_type_, ref_scope_definition_id_, hierarchy_type_) FROM stdin;
\.


--
-- TOC entry 3701 (class 0 OID 397417)
-- Dependencies: 219
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, scope_type_, scope_definition_id_) FROM stdin;
c1b50a31-06c6-11ea-a7f8-7c7a916bf543	hrgroup	candidate	\N	c1b2e750-06c6-11ea-a7f8-7c7a916bf543	2019-11-14 18:08:51.157	\N	\N	\N	\N
\.


--
-- TOC entry 3724 (class 0 OID 397892)
-- Dependencies: 242
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_) FROM stdin;
c1876a76-06c6-11ea-a7f8-7c7a916bf543	1	c1876a76-06c6-11ea-a7f8-7c7a916bf543	example	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	2019-11-14 18:08:50.837	\N	\N	\N	request	\N	\N	\N		\N	\N	\N
\.


--
-- TOC entry 3706 (class 0 OID 397472)
-- Dependencies: 224
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) FROM stdin;
c3d4b356-0623-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-11-13 22:42:06.693	\N	\N	\N	\N	50	\N	\N	\N		2019-11-13 22:42:06.757
f2d13437-0623-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-11-13 22:43:25.555	\N	\N	\N	\N	50	\N	\N	\N		2019-11-13 22:43:25.565
06719e38-0624-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-11-13 22:43:58.481	\N	\N	\N	\N	50	\N	\N	\N		2019-11-13 22:43:58.492
12f7a469-0624-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-11-13 22:44:19.5	\N	\N	\N	\N	50	\N	\N	\N		2019-11-13 22:44:19.504
c1b2e750-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	\N	handleRequest	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	请假申请	\N	\N	\N	\N	2019-11-14 18:08:50.944	\N	\N	\N	\N	50	\N	\N	\N		2019-11-14 18:08:51.132
\.


--
-- TOC entry 3708 (class 0 OID 397484)
-- Dependencies: 226
-- Data for Name: act_hi_tsk_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_tsk_log (id_, type_, task_id_, time_stamp_, user_id_, data_, execution_id_, proc_inst_id_, proc_def_id_, scope_id_, scope_definition_id_, sub_scope_id_, scope_type_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3710 (class 0 OID 397513)
-- Dependencies: 228
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) FROM stdin;
c18bd747-06c6-11ea-a7f8-7c7a916bf543	0	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	initiatorName	string	\N	\N	\N	\N	\N	\N	admin	\N	2019-11-14 18:08:50.879	2019-11-14 18:08:50.879
c18f0b98-06c6-11ea-a7f8-7c7a916bf543	0	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	initiatorId	string	\N	\N	\N	\N	\N	\N	admin	\N	2019-11-14 18:08:50.889	2019-11-14 18:08:50.889
c18f32a9-06c6-11ea-a7f8-7c7a916bf543	0	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	startTime	string	\N	\N	\N	\N	\N	\N	2019-11-14 00:00:00	\N	2019-11-14 18:08:50.89	2019-11-14 18:08:50.89
c18f59ba-06c6-11ea-a7f8-7c7a916bf543	0	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	numberOfDays	integer	\N	\N	\N	\N	\N	3	3	\N	2019-11-14 18:08:50.892	2019-11-14 18:08:50.892
c18f80cb-06c6-11ea-a7f8-7c7a916bf543	0	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	motivation	string	\N	\N	\N	\N	\N	\N	请假	\N	2019-11-14 18:08:50.893	2019-11-14 18:08:50.893
\.


--
-- TOC entry 3730 (class 0 OID 397960)
-- Dependencies: 248
-- Data for Name: act_id_bytearray; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_bytearray (id_, rev_, name_, bytes_) FROM stdin;
\.


--
-- TOC entry 3731 (class 0 OID 397968)
-- Dependencies: 249
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_group (id_, rev_, name_, type_) FROM stdin;
\.


--
-- TOC entry 3734 (class 0 OID 397990)
-- Dependencies: 252
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_info (id_, rev_, user_id_, type_, key_, value_, password_, parent_id_) FROM stdin;
\.


--
-- TOC entry 3732 (class 0 OID 397976)
-- Dependencies: 250
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_membership (user_id_, group_id_) FROM stdin;
\.


--
-- TOC entry 3736 (class 0 OID 398006)
-- Dependencies: 254
-- Data for Name: act_id_priv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_priv (id_, name_) FROM stdin;
\.


--
-- TOC entry 3737 (class 0 OID 398011)
-- Dependencies: 255
-- Data for Name: act_id_priv_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_priv_mapping (id_, priv_id_, user_id_, group_id_) FROM stdin;
\.


--
-- TOC entry 3729 (class 0 OID 397955)
-- Dependencies: 247
-- Data for Name: act_id_property; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_property (name_, value_, rev_) FROM stdin;
schema.version	6.5.0.1	1
\.


--
-- TOC entry 3735 (class 0 OID 397998)
-- Dependencies: 253
-- Data for Name: act_id_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_token (id_, rev_, token_value_, token_date_, ip_address_, user_agent_, user_id_, token_data_) FROM stdin;
\.


--
-- TOC entry 3733 (class 0 OID 397981)
-- Dependencies: 251
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_id_user (id_, rev_, first_, last_, display_name_, email_, pwd_, picture_id_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3722 (class 0 OID 397679)
-- Dependencies: 240
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_procdef_info (id_, proc_def_id_, rev_, info_json_id_) FROM stdin;
\.


--
-- TOC entry 3716 (class 0 OID 397630)
-- Dependencies: 234
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_re_deployment (id_, name_, category_, key_, tenant_id_, deploy_time_, derived_from_, derived_from_root_, parent_deployment_id_, engine_version_) FROM stdin;
6dd70ae2-05f4-11ea-9d91-7c7a916bf543	VacationRequest	\N	\N		2019-11-13 17:03:16.119	\N	\N	\N	\N
\.


--
-- TOC entry 3717 (class 0 OID 397639)
-- Dependencies: 235
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_re_model (id_, rev_, name_, key_, category_, create_time_, last_update_time_, version_, meta_info_, deployment_id_, editor_source_value_id_, editor_source_extra_value_id_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3719 (class 0 OID 397657)
-- Dependencies: 237
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) FROM stdin;
vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	1	http://activiti.org/bpmn20	请假流程	vacationRequest	1	6dd70ae2-05f4-11ea-9d91-7c7a916bf543	VacationRequest.bpmn20.xml	VacationRequest.vacationRequest.png	\N	f	t	1		\N	\N	0	\N
\.


--
-- TOC entry 3723 (class 0 OID 397684)
-- Dependencies: 241
-- Data for Name: act_ru_actinst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, duration_, delete_reason_, tenant_id_) FROM stdin;
c18ff5fd-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	request	\N	\N	\N	startEvent	\N	2019-11-14 18:08:50.896	2019-11-14 18:08:50.926	30	\N	
c1965e9e-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	flow1	\N	\N	\N	sequenceFlow	\N	2019-11-14 18:08:50.937	2019-11-14 18:08:50.937	0	\N	
c196acbf-06c6-11ea-a7f8-7c7a916bf543	1	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c18fceec-06c6-11ea-a7f8-7c7a916bf543	handleRequest	c1b2e750-06c6-11ea-a7f8-7c7a916bf543	\N	请假申请	userTask	\N	2019-11-14 18:08:50.939	\N	\N	\N	
\.


--
-- TOC entry 3714 (class 0 OID 397552)
-- Dependencies: 232
-- Data for Name: act_ru_deadletter_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_deadletter_job (id_, rev_, type_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, element_id_, element_name_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, custom_values_id_, create_time_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3702 (class 0 OID 397428)
-- Dependencies: 220
-- Data for Name: act_ru_entitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_entitylink (id_, rev_, create_time_, link_type_, scope_id_, scope_type_, scope_definition_id_, ref_scope_id_, ref_scope_type_, ref_scope_definition_id_, hierarchy_type_) FROM stdin;
\.


--
-- TOC entry 3704 (class 0 OID 397448)
-- Dependencies: 222
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_event_subscr (id_, rev_, event_type_, event_name_, execution_id_, proc_inst_id_, activity_id_, configuration_, created_, proc_def_id_, sub_scope_id_, scope_id_, scope_definition_id_, scope_type_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3718 (class 0 OID 397648)
-- Dependencies: 236
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_execution (id_, rev_, proc_inst_id_, business_key_, parent_id_, proc_def_id_, super_exec_, root_proc_inst_id_, act_id_, is_active_, is_concurrent_, is_scope_, is_event_scope_, is_mi_root_, suspension_state_, cached_ent_state_, tenant_id_, name_, start_act_id_, start_time_, start_user_id_, lock_time_, is_count_enabled_, evt_subscr_count_, task_count_, job_count_, timer_job_count_, susp_job_count_, deadletter_job_count_, var_count_, id_link_count_, callback_id_, callback_type_) FROM stdin;
c1876a76-06c6-11ea-a7f8-7c7a916bf543	1	c1876a76-06c6-11ea-a7f8-7c7a916bf543	example	\N	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	\N	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	t	f	t	f	f	1	\N		\N	request	2019-11-14 18:08:50.837	\N	\N	t	0	0	0	0	0	0	0	0	\N	\N
c18fceec-06c6-11ea-a7f8-7c7a916bf543	1	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	c1876a76-06c6-11ea-a7f8-7c7a916bf543	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	\N	c1876a76-06c6-11ea-a7f8-7c7a916bf543	handleRequest	t	f	f	f	f	1	\N		\N	\N	2019-11-14 18:08:50.894	\N	\N	t	0	1	0	0	0	0	0	0	\N	\N
\.


--
-- TOC entry 3715 (class 0 OID 397561)
-- Dependencies: 233
-- Data for Name: act_ru_history_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_history_job (id_, rev_, lock_exp_time_, lock_owner_, retries_, exception_stack_id_, exception_msg_, handler_type_, handler_cfg_, custom_values_id_, adv_handler_cfg_id_, create_time_, scope_type_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3700 (class 0 OID 397405)
-- Dependencies: 218
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_identitylink (id_, rev_, group_id_, type_, user_id_, task_id_, proc_inst_id_, proc_def_id_, scope_id_, scope_type_, scope_definition_id_) FROM stdin;
c1b50a31-06c6-11ea-a7f8-7c7a916bf543	1	hrgroup	candidate	\N	c1b2e750-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3711 (class 0 OID 397525)
-- Dependencies: 229
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_job (id_, rev_, type_, lock_exp_time_, lock_owner_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, element_id_, element_name_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, retries_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, custom_values_id_, create_time_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3713 (class 0 OID 397543)
-- Dependencies: 231
-- Data for Name: act_ru_suspended_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_suspended_job (id_, rev_, type_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, element_id_, element_name_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, retries_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, custom_values_id_, create_time_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3705 (class 0 OID 397459)
-- Dependencies: 223
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_task (id_, rev_, execution_id_, proc_inst_id_, proc_def_id_, task_def_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, name_, parent_task_id_, description_, task_def_key_, owner_, assignee_, delegation_, priority_, create_time_, due_date_, category_, suspension_state_, tenant_id_, form_key_, claim_time_, is_count_enabled_, var_count_, id_link_count_, sub_task_count_) FROM stdin;
c3d4b356-0623-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50	2019-11-13 22:42:06.693	\N	\N	1		\N	\N	t	0	0	0
f2d13437-0623-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50	2019-11-13 22:43:25.555	\N	\N	1		\N	\N	t	0	0	0
06719e38-0624-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50	2019-11-13 22:43:58.481	\N	\N	1		\N	\N	t	0	0	0
12f7a469-0624-11ea-9d91-7c7a916bf543	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50	2019-11-13 22:44:19.5	\N	\N	1		\N	\N	t	0	0	0
c1b2e750-06c6-11ea-a7f8-7c7a916bf543	1	c18fceec-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	vacationRequest:1:6e112db5-05f4-11ea-9d91-7c7a916bf543	\N	\N	\N	\N	\N	请假申请	\N	\N	handleRequest	\N	u:admin:admin:管理员	\N	50	2019-11-14 18:08:50.944	\N	\N	1		\N	\N	t	0	1	0
\.


--
-- TOC entry 3712 (class 0 OID 397534)
-- Dependencies: 230
-- Data for Name: act_ru_timer_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_timer_job (id_, rev_, type_, lock_exp_time_, lock_owner_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, element_id_, element_name_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, retries_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, custom_values_id_, create_time_, tenant_id_) FROM stdin;
\.


--
-- TOC entry 3709 (class 0 OID 397497)
-- Dependencies: 227
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY act_ru_variable (id_, rev_, type_, name_, execution_id_, proc_inst_id_, task_id_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
c18bd747-06c6-11ea-a7f8-7c7a916bf543	1	string	initiatorName	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N	\N	\N	admin	\N
c18f0b98-06c6-11ea-a7f8-7c7a916bf543	1	string	initiatorId	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N	\N	\N	admin	\N
c18f32a9-06c6-11ea-a7f8-7c7a916bf543	1	string	startTime	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N	\N	\N	2019-11-14 00:00:00	\N
c18f59ba-06c6-11ea-a7f8-7c7a916bf543	1	integer	numberOfDays	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N	\N	3	3	\N
c18f80cb-06c6-11ea-a7f8-7c7a916bf543	1	string	motivation	c1876a76-06c6-11ea-a7f8-7c7a916bf543	c1876a76-06c6-11ea-a7f8-7c7a916bf543	\N	\N	\N	\N	\N	\N	\N	请假	\N
\.


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 197
-- Name: SubUser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"SubUser_id_seq"', 1, true);


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 238
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('act_evt_log_log_nr__seq', 1, false);


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 225
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('act_hi_tsk_log_id__seq', 1, false);


--
-- TOC entry 3208 (class 2606 OID 396002)
-- Name: DictionaryItem DictionaryItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DictionaryItem"
    ADD CONSTRAINT "DictionaryItem_pkey" PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 395994)
-- Name: Dictionary Dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Dictionary"
    ADD CONSTRAINT "Dictionary_pkey" PRIMARY KEY (id);


--
-- TOC entry 3162 (class 2606 OID 395767)
-- Name: MenuPreDepends MenuPreDepends_menuId_dependMenuId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_menuId_dependMenuId_key" UNIQUE ("menuId", "dependMenuId");


--
-- TOC entry 3164 (class 2606 OID 395765)
-- Name: MenuPreDepends MenuPreDepends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_pkey" PRIMARY KEY (id);


--
-- TOC entry 3160 (class 2606 OID 395752)
-- Name: Menu Menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Menu"
    ADD CONSTRAINT "Menu_pkey" PRIMARY KEY (id);


--
-- TOC entry 3168 (class 2606 OID 395802)
-- Name: OperationPreDepends OperationPreDepends_operationId_dependOperationId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_operationId_dependOperationId_key" UNIQUE ("operationId", "dependOperationId");


--
-- TOC entry 3170 (class 2606 OID 395800)
-- Name: OperationPreDepends OperationPreDepends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_pkey" PRIMARY KEY (id);


--
-- TOC entry 3166 (class 2606 OID 395787)
-- Name: Operation Operation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Operation"
    ADD CONSTRAINT "Operation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 395883)
-- Name: OrganizationRole OrganizationRole_organizationId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_organizationId_roleId_key" UNIQUE ("organizationId", "roleId");


--
-- TOC entry 3186 (class 2606 OID 395881)
-- Name: OrganizationRole OrganizationRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_pkey" PRIMARY KEY (id);


--
-- TOC entry 3182 (class 2606 OID 395868)
-- Name: Organization Organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Organization"
    ADD CONSTRAINT "Organization_pkey" PRIMARY KEY (id);


--
-- TOC entry 3190 (class 2606 OID 395914)
-- Name: PositionRole PositionRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_pkey" PRIMARY KEY (id);


--
-- TOC entry 3192 (class 2606 OID 395916)
-- Name: PositionRole PositionRole_positionId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_positionId_roleId_key" UNIQUE ("positionId", "roleId");


--
-- TOC entry 3188 (class 2606 OID 395901)
-- Name: Position Position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Position"
    ADD CONSTRAINT "Position_pkey" PRIMARY KEY (id);


--
-- TOC entry 3210 (class 2606 OID 397390)
-- Name: ProcessDef ProcessDef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ProcessDef"
    ADD CONSTRAINT "ProcessDef_pkey" PRIMARY KEY (id);


--
-- TOC entry 3174 (class 2606 OID 395830)
-- Name: RoleMenu RoleMenu_menuId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_menuId_roleId_key" UNIQUE ("menuId", "roleId");


--
-- TOC entry 3176 (class 2606 OID 395828)
-- Name: RoleMenu RoleMenu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_pkey" PRIMARY KEY (id);


--
-- TOC entry 3178 (class 2606 OID 395850)
-- Name: RoleOperation RoleOperation_operationId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_operationId_roleId_key" UNIQUE ("operationId", "roleId");


--
-- TOC entry 3180 (class 2606 OID 395848)
-- Name: RoleOperation RoleOperation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3172 (class 2606 OID 395820)
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- TOC entry 3158 (class 2606 OID 395734)
-- Name: SubUser SubUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_pkey" PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 395934)
-- Name: UserOrganization UserOrganization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_pkey" PRIMARY KEY (id);


--
-- TOC entry 3196 (class 2606 OID 395936)
-- Name: UserOrganization UserOrganization_userId_organizationId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_userId_organizationId_key" UNIQUE ("userId", "organizationId");


--
-- TOC entry 3198 (class 2606 OID 395954)
-- Name: UserPosition UserPosition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_pkey" PRIMARY KEY (id);


--
-- TOC entry 3200 (class 2606 OID 395956)
-- Name: UserPosition UserPosition_userId_positionId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_userId_positionId_key" UNIQUE ("userId", "positionId");


--
-- TOC entry 3202 (class 2606 OID 395974)
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY (id);


--
-- TOC entry 3204 (class 2606 OID 395976)
-- Name: UserRole UserRole_userId_roleId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_userId_roleId_key" UNIQUE ("userId", "roleId");


--
-- TOC entry 3156 (class 2606 OID 395721)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 398374)
-- Name: act_app_appdef act_app_appdef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_appdef
    ADD CONSTRAINT act_app_appdef_pkey PRIMARY KEY (id_);


--
-- TOC entry 3467 (class 2606 OID 398336)
-- Name: act_app_databasechangeloglock act_app_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_databasechangeloglock
    ADD CONSTRAINT act_app_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3469 (class 2606 OID 398351)
-- Name: act_app_deployment act_app_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment
    ADD CONSTRAINT act_app_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3439 (class 2606 OID 398196)
-- Name: act_cmmn_casedef act_cmmn_casedef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_casedef
    ADD CONSTRAINT act_cmmn_casedef_pkey PRIMARY KEY (id_);


--
-- TOC entry 3432 (class 2606 OID 398158)
-- Name: act_cmmn_databasechangeloglock act_cmmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_databasechangeloglock
    ADD CONSTRAINT act_cmmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 398173)
-- Name: act_cmmn_deployment act_cmmn_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment
    ADD CONSTRAINT act_cmmn_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3461 (class 2606 OID 398294)
-- Name: act_cmmn_hi_case_inst act_cmmn_hi_case_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_case_inst
    ADD CONSTRAINT act_cmmn_hi_case_inst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3463 (class 2606 OID 398302)
-- Name: act_cmmn_hi_mil_inst act_cmmn_hi_mil_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_mil_inst
    ADD CONSTRAINT act_cmmn_hi_mil_inst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3465 (class 2606 OID 398312)
-- Name: act_cmmn_hi_plan_item_inst act_cmmn_hi_plan_item_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_hi_plan_item_inst
    ADD CONSTRAINT act_cmmn_hi_plan_item_inst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3443 (class 2606 OID 398211)
-- Name: act_cmmn_ru_case_inst act_cmmn_ru_case_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_case_inst
    ADD CONSTRAINT act_cmmn_ru_case_inst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3457 (class 2606 OID 398273)
-- Name: act_cmmn_ru_mil_inst act_cmmn_ru_mil_inst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_cmmn_ru_mil_inst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3427 (class 2606 OID 398150)
-- Name: act_co_content_item act_co_content_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_co_content_item
    ADD CONSTRAINT act_co_content_item_pkey PRIMARY KEY (id_);


--
-- TOC entry 3425 (class 2606 OID 398134)
-- Name: act_co_databasechangeloglock act_co_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_co_databasechangeloglock
    ADD CONSTRAINT act_co_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3403 (class 2606 OID 398045)
-- Name: act_dmn_databasechangeloglock act_dmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_databasechangeloglock
    ADD CONSTRAINT act_dmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3409 (class 2606 OID 398075)
-- Name: act_dmn_decision_table act_dmn_decision_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_decision_table
    ADD CONSTRAINT act_dmn_decision_table_pkey PRIMARY KEY (id_);


--
-- TOC entry 3405 (class 2606 OID 398059)
-- Name: act_dmn_deployment act_dmn_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_deployment
    ADD CONSTRAINT act_dmn_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3407 (class 2606 OID 398067)
-- Name: act_dmn_deployment_resource act_dmn_deployment_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_deployment_resource
    ADD CONSTRAINT act_dmn_deployment_resource_pkey PRIMARY KEY (id_);


--
-- TOC entry 3412 (class 2606 OID 398084)
-- Name: act_dmn_hi_decision_execution act_dmn_hi_decision_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_dmn_hi_decision_execution
    ADD CONSTRAINT act_dmn_hi_decision_execution_pkey PRIMARY KEY (id_);


--
-- TOC entry 3339 (class 2606 OID 397678)
-- Name: act_evt_log act_evt_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- TOC entry 3414 (class 2606 OID 398090)
-- Name: act_fo_databasechangeloglock act_fo_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_databasechangeloglock
    ADD CONSTRAINT act_fo_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3420 (class 2606 OID 398120)
-- Name: act_fo_form_definition act_fo_form_definition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_definition
    ADD CONSTRAINT act_fo_form_definition_pkey PRIMARY KEY (id_);


--
-- TOC entry 3416 (class 2606 OID 398104)
-- Name: act_fo_form_deployment act_fo_form_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_deployment
    ADD CONSTRAINT act_fo_form_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3423 (class 2606 OID 398128)
-- Name: act_fo_form_instance act_fo_form_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_instance
    ADD CONSTRAINT act_fo_form_instance_pkey PRIMARY KEY (id_);


--
-- TOC entry 3418 (class 2606 OID 398112)
-- Name: act_fo_form_resource act_fo_form_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_fo_form_resource
    ADD CONSTRAINT act_fo_form_resource_pkey PRIMARY KEY (id_);


--
-- TOC entry 3214 (class 2606 OID 397404)
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- TOC entry 3212 (class 2606 OID 397396)
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- TOC entry 3361 (class 2606 OID 397913)
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3376 (class 2606 OID 397937)
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3374 (class 2606 OID 397929)
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3367 (class 2606 OID 397921)
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- TOC entry 3237 (class 2606 OID 397445)
-- Name: act_hi_entitylink act_hi_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_entitylink
    ADD CONSTRAINT act_hi_entitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 3226 (class 2606 OID 397424)
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 3355 (class 2606 OID 397901)
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3357 (class 2606 OID 397903)
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- TOC entry 3254 (class 2606 OID 397481)
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3260 (class 2606 OID 397493)
-- Name: act_hi_tsk_log act_hi_tsk_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_tsk_log
    ADD CONSTRAINT act_hi_tsk_log_pkey PRIMARY KEY (id_);


--
-- TOC entry 3270 (class 2606 OID 397521)
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3380 (class 2606 OID 397967)
-- Name: act_id_bytearray act_id_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_bytearray
    ADD CONSTRAINT act_id_bytearray_pkey PRIMARY KEY (id_);


--
-- TOC entry 3382 (class 2606 OID 397975)
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- TOC entry 3390 (class 2606 OID 397997)
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- TOC entry 3384 (class 2606 OID 397980)
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- TOC entry 3398 (class 2606 OID 398018)
-- Name: act_id_priv_mapping act_id_priv_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv_mapping
    ADD CONSTRAINT act_id_priv_mapping_pkey PRIMARY KEY (id_);


--
-- TOC entry 3394 (class 2606 OID 398010)
-- Name: act_id_priv act_id_priv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv
    ADD CONSTRAINT act_id_priv_pkey PRIMARY KEY (id_);


--
-- TOC entry 3378 (class 2606 OID 397959)
-- Name: act_id_property act_id_property_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_property
    ADD CONSTRAINT act_id_property_pkey PRIMARY KEY (name_);


--
-- TOC entry 3392 (class 2606 OID 398005)
-- Name: act_id_token act_id_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_token
    ADD CONSTRAINT act_id_token_pkey PRIMARY KEY (id_);


--
-- TOC entry 3388 (class 2606 OID 397989)
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- TOC entry 3343 (class 2606 OID 397683)
-- Name: act_procdef_info act_procdef_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- TOC entry 3320 (class 2606 OID 397638)
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 3325 (class 2606 OID 397647)
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- TOC entry 3335 (class 2606 OID 397666)
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- TOC entry 3353 (class 2606 OID 397693)
-- Name: act_ru_actinst act_ru_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_actinst
    ADD CONSTRAINT act_ru_actinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 3316 (class 2606 OID 397560)
-- Name: act_ru_deadletter_job act_ru_deadletter_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_ru_deadletter_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 3235 (class 2606 OID 397435)
-- Name: act_ru_entitylink act_ru_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_entitylink
    ADD CONSTRAINT act_ru_entitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 3243 (class 2606 OID 397456)
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- TOC entry 3333 (class 2606 OID 397656)
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- TOC entry 3318 (class 2606 OID 397569)
-- Name: act_ru_history_job act_ru_history_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_history_job
    ADD CONSTRAINT act_ru_history_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 3224 (class 2606 OID 397412)
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 3286 (class 2606 OID 397533)
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 3306 (class 2606 OID 397551)
-- Name: act_ru_suspended_job act_ru_suspended_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_ru_suspended_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 3252 (class 2606 OID 397467)
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- TOC entry 3296 (class 2606 OID 397542)
-- Name: act_ru_timer_job act_ru_timer_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_ru_timer_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 3268 (class 2606 OID 397504)
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- TOC entry 3345 (class 2606 OID 397891)
-- Name: act_procdef_info act_uniq_info_procdef; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- TOC entry 3396 (class 2606 OID 398040)
-- Name: act_id_priv act_uniq_priv_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv
    ADD CONSTRAINT act_uniq_priv_name UNIQUE (name_);


--
-- TOC entry 3337 (class 2606 OID 397710)
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, derived_version_, tenant_id_);


--
-- TOC entry 3472 (class 2606 OID 398359)
-- Name: act_app_deployment_resource pk_app_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment_resource
    ADD CONSTRAINT pk_app_deployment_resource PRIMARY KEY (id_);


--
-- TOC entry 3437 (class 2606 OID 398181)
-- Name: act_cmmn_deployment_resource pk_cmmn_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment_resource
    ADD CONSTRAINT pk_cmmn_deployment_resource PRIMARY KEY (id_);


--
-- TOC entry 3450 (class 2606 OID 398227)
-- Name: act_cmmn_ru_plan_item_inst pk_cmmn_plan_item_inst; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT pk_cmmn_plan_item_inst PRIMARY KEY (id_);


--
-- TOC entry 3455 (class 2606 OID 398247)
-- Name: act_cmmn_ru_sentry_part_inst pk_cmmn_sentry_part_inst; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT pk_cmmn_sentry_part_inst PRIMARY KEY (id_);


--
-- TOC entry 3475 (class 1259 OID 398380)
-- Name: act_idx_app_def_dply; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_app_def_dply ON act_app_appdef USING btree (deployment_id_);


--
-- TOC entry 3476 (class 1259 OID 398381)
-- Name: act_idx_app_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_app_def_uniq ON act_app_appdef USING btree (key_, version_, tenant_id_);


--
-- TOC entry 3470 (class 1259 OID 398365)
-- Name: act_idx_app_rsrc_dpl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_app_rsrc_dpl ON act_app_deployment_resource USING btree (deployment_id_);


--
-- TOC entry 3216 (class 1259 OID 397741)
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_athrz_procedef ON act_ru_identitylink USING btree (proc_def_id_);


--
-- TOC entry 3215 (class 1259 OID 397697)
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_bytear_depl ON act_ge_bytearray USING btree (deployment_id_);


--
-- TOC entry 3440 (class 1259 OID 398202)
-- Name: act_idx_case_def_dply; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_def_dply ON act_cmmn_casedef USING btree (deployment_id_);


--
-- TOC entry 3441 (class 1259 OID 398331)
-- Name: act_idx_case_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_case_def_uniq ON act_cmmn_casedef USING btree (key_, version_, tenant_id_);


--
-- TOC entry 3444 (class 1259 OID 398217)
-- Name: act_idx_case_inst_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_inst_case_def ON act_cmmn_ru_case_inst USING btree (case_def_id_);


--
-- TOC entry 3445 (class 1259 OID 398218)
-- Name: act_idx_case_inst_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_case_inst_parent ON act_cmmn_ru_case_inst USING btree (parent_id_);


--
-- TOC entry 3435 (class 1259 OID 398187)
-- Name: act_idx_cmmn_rsrc_dpl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_cmmn_rsrc_dpl ON act_cmmn_deployment_resource USING btree (deployment_id_);


--
-- TOC entry 3307 (class 1259 OID 397577)
-- Name: act_idx_deadletter_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_custom_values_id ON act_ru_deadletter_job USING btree (custom_values_id_);


--
-- TOC entry 3308 (class 1259 OID 397576)
-- Name: act_idx_deadletter_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_exception_stack_id ON act_ru_deadletter_job USING btree (exception_stack_id_);


--
-- TOC entry 3309 (class 1259 OID 397837)
-- Name: act_idx_deadletter_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_execution_id ON act_ru_deadletter_job USING btree (execution_id_);


--
-- TOC entry 3310 (class 1259 OID 397849)
-- Name: act_idx_deadletter_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_proc_def_id ON act_ru_deadletter_job USING btree (proc_def_id_);


--
-- TOC entry 3311 (class 1259 OID 397843)
-- Name: act_idx_deadletter_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_deadletter_job_process_instance_id ON act_ru_deadletter_job USING btree (process_instance_id_);


--
-- TOC entry 3410 (class 1259 OID 398085)
-- Name: act_idx_dec_tbl_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_dec_tbl_uniq ON act_dmn_decision_table USING btree (key_, version_, tenant_id_);


--
-- TOC entry 3312 (class 1259 OID 397627)
-- Name: act_idx_djob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_scope ON act_ru_deadletter_job USING btree (scope_id_, scope_type_);


--
-- TOC entry 3313 (class 1259 OID 397629)
-- Name: act_idx_djob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_scope_def ON act_ru_deadletter_job USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3314 (class 1259 OID 397628)
-- Name: act_idx_djob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_djob_sub_scope ON act_ru_deadletter_job USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3232 (class 1259 OID 397436)
-- Name: act_idx_ent_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ent_lnk_scope ON act_ru_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- TOC entry 3233 (class 1259 OID 397437)
-- Name: act_idx_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ent_lnk_scope_def ON act_ru_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- TOC entry 3240 (class 1259 OID 397458)
-- Name: act_idx_event_subscr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_event_subscr ON act_ru_event_subscr USING btree (execution_id_);


--
-- TOC entry 3241 (class 1259 OID 397457)
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_event_subscr_config_ ON act_ru_event_subscr USING btree (configuration_);


--
-- TOC entry 3326 (class 1259 OID 397717)
-- Name: act_idx_exe_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_parent ON act_ru_execution USING btree (parent_id_);


--
-- TOC entry 3327 (class 1259 OID 397729)
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_procdef ON act_ru_execution USING btree (proc_def_id_);


--
-- TOC entry 3328 (class 1259 OID 397711)
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_procinst ON act_ru_execution USING btree (proc_inst_id_);


--
-- TOC entry 3329 (class 1259 OID 397695)
-- Name: act_idx_exe_root; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_root ON act_ru_execution USING btree (root_proc_inst_id_);


--
-- TOC entry 3330 (class 1259 OID 397723)
-- Name: act_idx_exe_super; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exe_super ON act_ru_execution USING btree (super_exec_);


--
-- TOC entry 3331 (class 1259 OID 397694)
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_exec_buskey ON act_ru_execution USING btree (business_key_);


--
-- TOC entry 3421 (class 1259 OID 398129)
-- Name: act_idx_form_def_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX act_idx_form_def_uniq ON act_fo_form_definition USING btree (key_, version_, tenant_id_);


--
-- TOC entry 3362 (class 1259 OID 397941)
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_end ON act_hi_actinst USING btree (end_time_);


--
-- TOC entry 3363 (class 1259 OID 397951)
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_exec ON act_hi_actinst USING btree (execution_id_, act_id_);


--
-- TOC entry 3364 (class 1259 OID 397950)
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_procinst ON act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- TOC entry 3365 (class 1259 OID 397940)
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_act_inst_start ON act_hi_actinst USING btree (start_time_);


--
-- TOC entry 3368 (class 1259 OID 397943)
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_act_inst ON act_hi_detail USING btree (act_inst_id_);


--
-- TOC entry 3369 (class 1259 OID 397945)
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_name ON act_hi_detail USING btree (name_);


--
-- TOC entry 3370 (class 1259 OID 397942)
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_proc_inst ON act_hi_detail USING btree (proc_inst_id_);


--
-- TOC entry 3371 (class 1259 OID 397946)
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_task_id ON act_hi_detail USING btree (task_id_);


--
-- TOC entry 3372 (class 1259 OID 397944)
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_detail_time ON act_hi_detail USING btree (time_);


--
-- TOC entry 3238 (class 1259 OID 397446)
-- Name: act_idx_hi_ent_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ent_lnk_scope ON act_hi_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- TOC entry 3239 (class 1259 OID 397447)
-- Name: act_idx_hi_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ent_lnk_scope_def ON act_hi_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- TOC entry 3227 (class 1259 OID 397953)
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON act_hi_identitylink USING btree (proc_inst_id_);


--
-- TOC entry 3228 (class 1259 OID 397426)
-- Name: act_idx_hi_ident_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_scope ON act_hi_identitylink USING btree (scope_id_, scope_type_);


--
-- TOC entry 3229 (class 1259 OID 397427)
-- Name: act_idx_hi_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_scope_def ON act_hi_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3230 (class 1259 OID 397952)
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_task ON act_hi_identitylink USING btree (task_id_);


--
-- TOC entry 3231 (class 1259 OID 397425)
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_ident_lnk_user ON act_hi_identitylink USING btree (user_id_);


--
-- TOC entry 3358 (class 1259 OID 397939)
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_pro_i_buskey ON act_hi_procinst USING btree (business_key_);


--
-- TOC entry 3359 (class 1259 OID 397938)
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_pro_inst_end ON act_hi_procinst USING btree (end_time_);


--
-- TOC entry 3271 (class 1259 OID 397949)
-- Name: act_idx_hi_procvar_exe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_exe ON act_hi_varinst USING btree (execution_id_);


--
-- TOC entry 3272 (class 1259 OID 397522)
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_name_type ON act_hi_varinst USING btree (name_, var_type_);


--
-- TOC entry 3273 (class 1259 OID 397947)
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON act_hi_varinst USING btree (proc_inst_id_);


--
-- TOC entry 3274 (class 1259 OID 397948)
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_procvar_task_id ON act_hi_varinst USING btree (task_id_);


--
-- TOC entry 3255 (class 1259 OID 397954)
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_inst_procinst ON act_hi_taskinst USING btree (proc_inst_id_);


--
-- TOC entry 3256 (class 1259 OID 397494)
-- Name: act_idx_hi_task_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_scope ON act_hi_taskinst USING btree (scope_id_, scope_type_);


--
-- TOC entry 3257 (class 1259 OID 397496)
-- Name: act_idx_hi_task_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_scope_def ON act_hi_taskinst USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3258 (class 1259 OID 397495)
-- Name: act_idx_hi_task_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_task_sub_scope ON act_hi_taskinst USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3275 (class 1259 OID 397523)
-- Name: act_idx_hi_var_scope_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_var_scope_id_type ON act_hi_varinst USING btree (scope_id_, scope_type_);


--
-- TOC entry 3276 (class 1259 OID 397524)
-- Name: act_idx_hi_var_sub_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_hi_var_sub_id_type ON act_hi_varinst USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3217 (class 1259 OID 397414)
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_group ON act_ru_identitylink USING btree (group_id_);


--
-- TOC entry 3218 (class 1259 OID 397415)
-- Name: act_idx_ident_lnk_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_scope ON act_ru_identitylink USING btree (scope_id_, scope_type_);


--
-- TOC entry 3219 (class 1259 OID 397416)
-- Name: act_idx_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_scope_def ON act_ru_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3220 (class 1259 OID 397413)
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ident_lnk_user ON act_ru_identitylink USING btree (user_id_);


--
-- TOC entry 3221 (class 1259 OID 397747)
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_idl_procinst ON act_ru_identitylink USING btree (proc_inst_id_);


--
-- TOC entry 3277 (class 1259 OID 397571)
-- Name: act_idx_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_custom_values_id ON act_ru_job USING btree (custom_values_id_);


--
-- TOC entry 3278 (class 1259 OID 397570)
-- Name: act_idx_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_exception_stack_id ON act_ru_job USING btree (exception_stack_id_);


--
-- TOC entry 3279 (class 1259 OID 397783)
-- Name: act_idx_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_execution_id ON act_ru_job USING btree (execution_id_);


--
-- TOC entry 3280 (class 1259 OID 397795)
-- Name: act_idx_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_proc_def_id ON act_ru_job USING btree (proc_def_id_);


--
-- TOC entry 3281 (class 1259 OID 397789)
-- Name: act_idx_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_process_instance_id ON act_ru_job USING btree (process_instance_id_);


--
-- TOC entry 3282 (class 1259 OID 397618)
-- Name: act_idx_job_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_scope ON act_ru_job USING btree (scope_id_, scope_type_);


--
-- TOC entry 3283 (class 1259 OID 397620)
-- Name: act_idx_job_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_scope_def ON act_ru_job USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3284 (class 1259 OID 397619)
-- Name: act_idx_job_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_job_sub_scope ON act_ru_job USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3385 (class 1259 OID 398019)
-- Name: act_idx_memb_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_memb_group ON act_id_membership USING btree (group_id_);


--
-- TOC entry 3386 (class 1259 OID 398025)
-- Name: act_idx_memb_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_memb_user ON act_id_membership USING btree (user_id_);


--
-- TOC entry 3458 (class 1259 OID 398279)
-- Name: act_idx_mil_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_mil_case_def ON act_cmmn_ru_mil_inst USING btree (case_def_id_);


--
-- TOC entry 3459 (class 1259 OID 398285)
-- Name: act_idx_mil_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_mil_case_inst ON act_cmmn_ru_mil_inst USING btree (case_inst_id_);


--
-- TOC entry 3321 (class 1259 OID 397872)
-- Name: act_idx_model_deployment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_deployment ON act_re_model USING btree (deployment_id_);


--
-- TOC entry 3322 (class 1259 OID 397860)
-- Name: act_idx_model_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_source ON act_re_model USING btree (editor_source_value_id_);


--
-- TOC entry 3323 (class 1259 OID 397866)
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_model_source_extra ON act_re_model USING btree (editor_source_extra_value_id_);


--
-- TOC entry 3446 (class 1259 OID 398233)
-- Name: act_idx_plan_item_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_case_def ON act_cmmn_ru_plan_item_inst USING btree (case_def_id_);


--
-- TOC entry 3447 (class 1259 OID 398239)
-- Name: act_idx_plan_item_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_case_inst ON act_cmmn_ru_plan_item_inst USING btree (case_inst_id_);


--
-- TOC entry 3448 (class 1259 OID 398303)
-- Name: act_idx_plan_item_stage_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_plan_item_stage_inst ON act_cmmn_ru_plan_item_inst USING btree (stage_inst_id_);


--
-- TOC entry 3399 (class 1259 OID 398038)
-- Name: act_idx_priv_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_group ON act_id_priv_mapping USING btree (group_id_);


--
-- TOC entry 3400 (class 1259 OID 398031)
-- Name: act_idx_priv_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_mapping ON act_id_priv_mapping USING btree (priv_id_);


--
-- TOC entry 3401 (class 1259 OID 398037)
-- Name: act_idx_priv_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_priv_user ON act_id_priv_mapping USING btree (user_id_);


--
-- TOC entry 3340 (class 1259 OID 397878)
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_procdef_info_json ON act_procdef_info USING btree (info_json_id_);


--
-- TOC entry 3341 (class 1259 OID 397884)
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_procdef_info_proc ON act_procdef_info USING btree (proc_def_id_);


--
-- TOC entry 3346 (class 1259 OID 397699)
-- Name: act_idx_ru_acti_end; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_end ON act_ru_actinst USING btree (end_time_);


--
-- TOC entry 3347 (class 1259 OID 397702)
-- Name: act_idx_ru_acti_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_exec ON act_ru_actinst USING btree (execution_id_);


--
-- TOC entry 3348 (class 1259 OID 397703)
-- Name: act_idx_ru_acti_exec_act; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_exec_act ON act_ru_actinst USING btree (execution_id_, act_id_);


--
-- TOC entry 3349 (class 1259 OID 397700)
-- Name: act_idx_ru_acti_proc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_proc ON act_ru_actinst USING btree (proc_inst_id_);


--
-- TOC entry 3350 (class 1259 OID 397701)
-- Name: act_idx_ru_acti_proc_act; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_proc_act ON act_ru_actinst USING btree (proc_inst_id_, act_id_);


--
-- TOC entry 3351 (class 1259 OID 397698)
-- Name: act_idx_ru_acti_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_acti_start ON act_ru_actinst USING btree (start_time_);


--
-- TOC entry 3261 (class 1259 OID 397505)
-- Name: act_idx_ru_var_scope_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_var_scope_id_type ON act_ru_variable USING btree (scope_id_, scope_type_);


--
-- TOC entry 3262 (class 1259 OID 397506)
-- Name: act_idx_ru_var_sub_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_ru_var_sub_id_type ON act_ru_variable USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3451 (class 1259 OID 398253)
-- Name: act_idx_sentry_case_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_case_def ON act_cmmn_ru_sentry_part_inst USING btree (case_def_id_);


--
-- TOC entry 3452 (class 1259 OID 398259)
-- Name: act_idx_sentry_case_inst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_case_inst ON act_cmmn_ru_sentry_part_inst USING btree (case_inst_id_);


--
-- TOC entry 3453 (class 1259 OID 398265)
-- Name: act_idx_sentry_plan_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sentry_plan_item ON act_cmmn_ru_sentry_part_inst USING btree (plan_item_inst_id_);


--
-- TOC entry 3297 (class 1259 OID 397624)
-- Name: act_idx_sjob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_scope ON act_ru_suspended_job USING btree (scope_id_, scope_type_);


--
-- TOC entry 3298 (class 1259 OID 397626)
-- Name: act_idx_sjob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_scope_def ON act_ru_suspended_job USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3299 (class 1259 OID 397625)
-- Name: act_idx_sjob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_sjob_sub_scope ON act_ru_suspended_job USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3300 (class 1259 OID 397575)
-- Name: act_idx_suspended_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_custom_values_id ON act_ru_suspended_job USING btree (custom_values_id_);


--
-- TOC entry 3301 (class 1259 OID 397574)
-- Name: act_idx_suspended_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_exception_stack_id ON act_ru_suspended_job USING btree (exception_stack_id_);


--
-- TOC entry 3302 (class 1259 OID 397819)
-- Name: act_idx_suspended_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_execution_id ON act_ru_suspended_job USING btree (execution_id_);


--
-- TOC entry 3303 (class 1259 OID 397831)
-- Name: act_idx_suspended_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_proc_def_id ON act_ru_suspended_job USING btree (proc_def_id_);


--
-- TOC entry 3304 (class 1259 OID 397825)
-- Name: act_idx_suspended_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_suspended_job_process_instance_id ON act_ru_suspended_job USING btree (process_instance_id_);


--
-- TOC entry 3244 (class 1259 OID 397468)
-- Name: act_idx_task_create; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_create ON act_ru_task USING btree (create_time_);


--
-- TOC entry 3245 (class 1259 OID 397753)
-- Name: act_idx_task_exec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_exec ON act_ru_task USING btree (execution_id_);


--
-- TOC entry 3246 (class 1259 OID 397765)
-- Name: act_idx_task_procdef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_procdef ON act_ru_task USING btree (proc_def_id_);


--
-- TOC entry 3247 (class 1259 OID 397759)
-- Name: act_idx_task_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_procinst ON act_ru_task USING btree (proc_inst_id_);


--
-- TOC entry 3248 (class 1259 OID 397469)
-- Name: act_idx_task_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_scope ON act_ru_task USING btree (scope_id_, scope_type_);


--
-- TOC entry 3249 (class 1259 OID 397471)
-- Name: act_idx_task_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_scope_def ON act_ru_task USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3250 (class 1259 OID 397470)
-- Name: act_idx_task_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_task_sub_scope ON act_ru_task USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3287 (class 1259 OID 397573)
-- Name: act_idx_timer_job_custom_values_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_custom_values_id ON act_ru_timer_job USING btree (custom_values_id_);


--
-- TOC entry 3288 (class 1259 OID 397572)
-- Name: act_idx_timer_job_exception_stack_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_exception_stack_id ON act_ru_timer_job USING btree (exception_stack_id_);


--
-- TOC entry 3289 (class 1259 OID 397801)
-- Name: act_idx_timer_job_execution_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_execution_id ON act_ru_timer_job USING btree (execution_id_);


--
-- TOC entry 3290 (class 1259 OID 397813)
-- Name: act_idx_timer_job_proc_def_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_proc_def_id ON act_ru_timer_job USING btree (proc_def_id_);


--
-- TOC entry 3291 (class 1259 OID 397807)
-- Name: act_idx_timer_job_process_instance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_timer_job_process_instance_id ON act_ru_timer_job USING btree (process_instance_id_);


--
-- TOC entry 3292 (class 1259 OID 397621)
-- Name: act_idx_tjob_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_scope ON act_ru_timer_job USING btree (scope_id_, scope_type_);


--
-- TOC entry 3293 (class 1259 OID 397623)
-- Name: act_idx_tjob_scope_def; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_scope_def ON act_ru_timer_job USING btree (scope_definition_id_, scope_type_);


--
-- TOC entry 3294 (class 1259 OID 397622)
-- Name: act_idx_tjob_sub_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tjob_sub_scope ON act_ru_timer_job USING btree (sub_scope_id_, scope_type_);


--
-- TOC entry 3222 (class 1259 OID 397735)
-- Name: act_idx_tskass_task; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_tskass_task ON act_ru_identitylink USING btree (task_id_);


--
-- TOC entry 3263 (class 1259 OID 397507)
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_bytearray ON act_ru_variable USING btree (bytearray_id_);


--
-- TOC entry 3264 (class 1259 OID 397771)
-- Name: act_idx_var_exe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_exe ON act_ru_variable USING btree (execution_id_);


--
-- TOC entry 3265 (class 1259 OID 397777)
-- Name: act_idx_var_procinst; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_var_procinst ON act_ru_variable USING btree (proc_inst_id_);


--
-- TOC entry 3266 (class 1259 OID 397696)
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX act_idx_variable_task_id ON act_ru_variable USING btree (task_id_);


--
-- TOC entry 3428 (class 1259 OID 398152)
-- Name: idx_contitem_procid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_procid ON act_co_content_item USING btree (proc_inst_id_);


--
-- TOC entry 3429 (class 1259 OID 398153)
-- Name: idx_contitem_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_scope ON act_co_content_item USING btree (scope_id_, scope_type_);


--
-- TOC entry 3430 (class 1259 OID 398151)
-- Name: idx_contitem_taskid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contitem_taskid ON act_co_content_item USING btree (task_id_);


--
-- TOC entry 3501 (class 2606 OID 396003)
-- Name: DictionaryItem DictionaryItem_dictionaryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "DictionaryItem"
    ADD CONSTRAINT "DictionaryItem_dictionaryId_fkey" FOREIGN KEY ("dictionaryId") REFERENCES "Dictionary"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3481 (class 2606 OID 395773)
-- Name: MenuPreDepends MenuPreDepends_dependMenuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_dependMenuId_fkey" FOREIGN KEY ("dependMenuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3480 (class 2606 OID 395768)
-- Name: MenuPreDepends MenuPreDepends_menuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MenuPreDepends"
    ADD CONSTRAINT "MenuPreDepends_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3479 (class 2606 OID 395753)
-- Name: Menu Menu_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Menu"
    ADD CONSTRAINT "Menu_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3484 (class 2606 OID 395808)
-- Name: OperationPreDepends OperationPreDepends_dependOperationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_dependOperationId_fkey" FOREIGN KEY ("dependOperationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3483 (class 2606 OID 395803)
-- Name: OperationPreDepends OperationPreDepends_operationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OperationPreDepends"
    ADD CONSTRAINT "OperationPreDepends_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3482 (class 2606 OID 395788)
-- Name: Operation Operation_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Operation"
    ADD CONSTRAINT "Operation_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3490 (class 2606 OID 395884)
-- Name: OrganizationRole OrganizationRole_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3491 (class 2606 OID 395889)
-- Name: OrganizationRole OrganizationRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationRole"
    ADD CONSTRAINT "OrganizationRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3489 (class 2606 OID 395869)
-- Name: Organization Organization_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Organization"
    ADD CONSTRAINT "Organization_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3493 (class 2606 OID 395917)
-- Name: PositionRole PositionRole_positionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3494 (class 2606 OID 395922)
-- Name: PositionRole PositionRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PositionRole"
    ADD CONSTRAINT "PositionRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3492 (class 2606 OID 395902)
-- Name: Position Position_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Position"
    ADD CONSTRAINT "Position_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3485 (class 2606 OID 395831)
-- Name: RoleMenu RoleMenu_menuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3486 (class 2606 OID 395836)
-- Name: RoleMenu RoleMenu_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleMenu"
    ADD CONSTRAINT "RoleMenu_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3487 (class 2606 OID 395851)
-- Name: RoleOperation RoleOperation_operationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_operationId_fkey" FOREIGN KEY ("operationId") REFERENCES "Operation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3488 (class 2606 OID 395856)
-- Name: RoleOperation RoleOperation_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RoleOperation"
    ADD CONSTRAINT "RoleOperation_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3477 (class 2606 OID 395735)
-- Name: SubUser SubUser_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3478 (class 2606 OID 395740)
-- Name: SubUser SubUser_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SubUser"
    ADD CONSTRAINT "SubUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3496 (class 2606 OID 395942)
-- Name: UserOrganization UserOrganization_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3495 (class 2606 OID 395937)
-- Name: UserOrganization UserOrganization_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserOrganization"
    ADD CONSTRAINT "UserOrganization_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3498 (class 2606 OID 395962)
-- Name: UserPosition UserPosition_positionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3497 (class 2606 OID 395957)
-- Name: UserPosition UserPosition_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserPosition"
    ADD CONSTRAINT "UserPosition_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3500 (class 2606 OID 395982)
-- Name: UserRole UserRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3499 (class 2606 OID 395977)
-- Name: UserRole UserRole_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "UserRole"
    ADD CONSTRAINT "UserRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3556 (class 2606 OID 398375)
-- Name: act_app_appdef act_fk_app_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_appdef
    ADD CONSTRAINT act_fk_app_def_dply FOREIGN KEY (deployment_id_) REFERENCES act_app_deployment(id_);


--
-- TOC entry 3555 (class 2606 OID 398360)
-- Name: act_app_deployment_resource act_fk_app_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_app_deployment_resource
    ADD CONSTRAINT act_fk_app_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES act_app_deployment(id_);


--
-- TOC entry 3504 (class 2606 OID 397742)
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3502 (class 2606 OID 397704)
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- TOC entry 3546 (class 2606 OID 398197)
-- Name: act_cmmn_casedef act_fk_case_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_casedef
    ADD CONSTRAINT act_fk_case_def_dply FOREIGN KEY (deployment_id_) REFERENCES act_cmmn_deployment(id_);


--
-- TOC entry 3547 (class 2606 OID 398212)
-- Name: act_cmmn_ru_case_inst act_fk_case_inst_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_case_inst
    ADD CONSTRAINT act_fk_case_inst_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- TOC entry 3545 (class 2606 OID 398182)
-- Name: act_cmmn_deployment_resource act_fk_cmmn_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_deployment_resource
    ADD CONSTRAINT act_fk_cmmn_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES act_cmmn_deployment(id_);


--
-- TOC entry 3529 (class 2606 OID 397613)
-- Name: act_ru_deadletter_job act_fk_deadletter_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3528 (class 2606 OID 397608)
-- Name: act_ru_deadletter_job act_fk_deadletter_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3530 (class 2606 OID 397838)
-- Name: act_ru_deadletter_job act_fk_deadletter_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3532 (class 2606 OID 397850)
-- Name: act_ru_deadletter_job act_fk_deadletter_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3531 (class 2606 OID 397844)
-- Name: act_ru_deadletter_job act_fk_deadletter_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3506 (class 2606 OID 397855)
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3537 (class 2606 OID 397718)
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3539 (class 2606 OID 397730)
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3536 (class 2606 OID 397712)
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3538 (class 2606 OID 397724)
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3505 (class 2606 OID 397748)
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3540 (class 2606 OID 397879)
-- Name: act_procdef_info act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3541 (class 2606 OID 397885)
-- Name: act_procdef_info act_fk_info_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3514 (class 2606 OID 397583)
-- Name: act_ru_job act_fk_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3513 (class 2606 OID 397578)
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3515 (class 2606 OID 397784)
-- Name: act_ru_job act_fk_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3517 (class 2606 OID 397796)
-- Name: act_ru_job act_fk_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3516 (class 2606 OID 397790)
-- Name: act_ru_job act_fk_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3542 (class 2606 OID 398020)
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES act_id_group(id_);


--
-- TOC entry 3543 (class 2606 OID 398026)
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES act_id_user(id_);


--
-- TOC entry 3553 (class 2606 OID 398274)
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- TOC entry 3554 (class 2606 OID 398280)
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- TOC entry 3535 (class 2606 OID 397873)
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- TOC entry 3533 (class 2606 OID 397861)
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3534 (class 2606 OID 397867)
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3548 (class 2606 OID 398228)
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- TOC entry 3549 (class 2606 OID 398234)
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- TOC entry 3544 (class 2606 OID 398032)
-- Name: act_id_priv_mapping act_fk_priv_mapping; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_id_priv_mapping
    ADD CONSTRAINT act_fk_priv_mapping FOREIGN KEY (priv_id_) REFERENCES act_id_priv(id_);


--
-- TOC entry 3550 (class 2606 OID 398248)
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_def FOREIGN KEY (case_def_id_) REFERENCES act_cmmn_casedef(id_);


--
-- TOC entry 3551 (class 2606 OID 398254)
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_inst FOREIGN KEY (case_inst_id_) REFERENCES act_cmmn_ru_case_inst(id_);


--
-- TOC entry 3552 (class 2606 OID 398260)
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_plan_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_plan_item FOREIGN KEY (plan_item_inst_id_) REFERENCES act_cmmn_ru_plan_item_inst(id_);


--
-- TOC entry 3524 (class 2606 OID 397603)
-- Name: act_ru_suspended_job act_fk_suspended_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3523 (class 2606 OID 397598)
-- Name: act_ru_suspended_job act_fk_suspended_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3525 (class 2606 OID 397820)
-- Name: act_ru_suspended_job act_fk_suspended_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3527 (class 2606 OID 397832)
-- Name: act_ru_suspended_job act_fk_suspended_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3526 (class 2606 OID 397826)
-- Name: act_ru_suspended_job act_fk_suspended_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3507 (class 2606 OID 397754)
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3509 (class 2606 OID 397766)
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3508 (class 2606 OID 397760)
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3519 (class 2606 OID 397593)
-- Name: act_ru_timer_job act_fk_timer_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3518 (class 2606 OID 397588)
-- Name: act_ru_timer_job act_fk_timer_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3520 (class 2606 OID 397802)
-- Name: act_ru_timer_job act_fk_timer_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_execution FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3522 (class 2606 OID 397814)
-- Name: act_ru_timer_job act_fk_timer_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 3521 (class 2606 OID 397808)
-- Name: act_ru_timer_job act_fk_timer_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3503 (class 2606 OID 397736)
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES act_ru_task(id_);


--
-- TOC entry 3510 (class 2606 OID 397508)
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 3511 (class 2606 OID 397772)
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 3512 (class 2606 OID 397778)
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


-- Completed on 2019-11-18 09:03:11

--
-- PostgreSQL database dump complete
--

