--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enum_category_filters_type; Type: TYPE; Schema: public; Owner: denys
--

CREATE TYPE public.enum_category_filters_type AS ENUM (
    'price_range',
    'attributes'
);


ALTER TYPE public.enum_category_filters_type OWNER TO denys;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: attribute_types; Type: TABLE; Schema: public; Owner: denys
--

CREATE TABLE public.attribute_types (
    id integer NOT NULL,
    name character varying(255),
    category_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.attribute_types OWNER TO denys;

--
-- Name: attribute_types_id_seq; Type: SEQUENCE; Schema: public; Owner: denys
--

CREATE SEQUENCE public.attribute_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attribute_types_id_seq OWNER TO denys;

--
-- Name: attribute_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: denys
--

ALTER SEQUENCE public.attribute_types_id_seq OWNED BY public.attribute_types.id;


--
-- Name: attribute_values; Type: TABLE; Schema: public; Owner: denys
--

CREATE TABLE public.attribute_values (
    id integer NOT NULL,
    name character varying(255),
    attribute_type_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.attribute_values OWNER TO denys;

--
-- Name: attribute_values_id_seq; Type: SEQUENCE; Schema: public; Owner: denys
--

CREATE SEQUENCE public.attribute_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attribute_values_id_seq OWNER TO denys;

--
-- Name: attribute_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: denys
--

ALTER SEQUENCE public.attribute_values_id_seq OWNED BY public.attribute_values.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    parent_category_id integer,
    icon character varying(255),
    image character varying(255),
    hru character varying(255)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_filters; Type: TABLE; Schema: public; Owner: denys
--

CREATE TABLE public.category_filters (
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    parent_category_id integer,
    info jsonb,
    name character varying(255),
    type public.enum_category_filters_type,
    value character varying(255)
);


ALTER TABLE public.category_filters OWNER TO denys;

--
-- Name: category_filters_id_seq; Type: SEQUENCE; Schema: public; Owner: denys
--

CREATE SEQUENCE public.category_filters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_filters_id_seq OWNER TO denys;

--
-- Name: category_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: denys
--

ALTER SEQUENCE public.category_filters_id_seq OWNED BY public.category_filters.id;


--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: denys
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    info jsonb NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.orders OWNER TO denys;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: denys
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO denys;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: denys
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    parent_category_id integer,
    is_new boolean DEFAULT false,
    is_top boolean DEFAULT false,
    description character varying(255),
    price integer,
    images character varying(255)[],
    icon character varying(255)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_attributes; Type: TABLE; Schema: public; Owner: denys
--

CREATE TABLE public.product_attributes (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_attribute_value_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.product_attributes OWNER TO denys;

--
-- Name: product_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: denys
--

CREATE SEQUENCE public.product_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_attributes_id_seq OWNER TO denys;

--
-- Name: product_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: denys
--

ALTER SEQUENCE public.product_attributes_id_seq OWNED BY public.product_attributes.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: attribute_types id; Type: DEFAULT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.attribute_types ALTER COLUMN id SET DEFAULT nextval('public.attribute_types_id_seq'::regclass);


--
-- Name: attribute_values id; Type: DEFAULT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.attribute_values ALTER COLUMN id SET DEFAULT nextval('public.attribute_values_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: category_filters id; Type: DEFAULT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.category_filters ALTER COLUMN id SET DEFAULT nextval('public.category_filters_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_attributes id; Type: DEFAULT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.product_attributes ALTER COLUMN id SET DEFAULT nextval('public.product_attributes_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20230312142948-create_product_table.js
20230314160848-create-category.js
20230315151824-change_product_table.js
20230317090344-add_columns_to_product_table.js
20230324104129-create_category_filters_table.js
20230324135911-create_orders_table.js
20230331145816-change_product_table.js
20230331162712-change_category_table.js
20230405093751-change_category_filters_tble.js
20230405121622-change_tables.js
20230405122030-create_product_attr_table.js
20230405122330-create_attribute_types_table.js
20230405122447-create_attribute_values_table.js
20230405124003-change_product_table.js
\.


--
-- Data for Name: attribute_types; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.attribute_types (id, name, category_id, "createdAt", "updatedAt") FROM stdin;
1	color	32	2023-04-05 14:49:17.228043+02	2023-04-05 14:49:17.228043+02
\.


--
-- Data for Name: attribute_values; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.attribute_values (id, name, attribute_type_id, "createdAt", "updatedAt") FROM stdin;
1	red	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
2	green	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
3	blue	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name, "createdAt", "updatedAt", parent_category_id, icon, image, hru) FROM stdin;
34	Main catgory	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
83	Sub category	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
\.


--
-- Data for Name: category_filters; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.category_filters (id, "createdAt", "updatedAt", parent_category_id, info, name, type, value) FROM stdin;
151	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	83	\N	some name with attributes	attributes	1
150	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	83	\N	some name with attributes	price_range	{"from": 0, "to": 6000}
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.orders (id, info, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, "createdAt", "updatedAt", parent_category_id, is_new, is_top, description, price, images, icon) FROM stdin;
21	Product 1	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	376	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
35	Product 2	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	100	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
\.


--
-- Data for Name: product_attributes; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.product_attributes (id, product_id, product_attribute_value_id, "createdAt", "updatedAt") FROM stdin;
1	21	1	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
2	21	2	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
3	35	3	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
\.


--
-- Name: attribute_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.attribute_types_id_seq', 2, true);


--
-- Name: attribute_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.attribute_values_id_seq', 3, true);


--
-- Name: category_filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.category_filters_id_seq', 151, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 83, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: product_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.product_attributes_id_seq', 3, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 35, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: attribute_types attribute_types_pkey; Type: CONSTRAINT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.attribute_types
    ADD CONSTRAINT attribute_types_pkey PRIMARY KEY (id);


--
-- Name: attribute_values attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_pkey PRIMARY KEY (id);


--
-- Name: category_filters category_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.category_filters
    ADD CONSTRAINT category_filters_pkey PRIMARY KEY (id);


--
-- Name: category category_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_attributes product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: denys
--

ALTER TABLE ONLY public.product_attributes
    ADD CONSTRAINT product_attributes_pkey PRIMARY KEY (id);


--
-- Name: product product_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_name_key UNIQUE (name);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

