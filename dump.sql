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
-- Name: enum_category_filters_type; Type: TYPE; Schema: public; Owner: astramaster
--

CREATE TYPE public.enum_category_filters_type AS ENUM (
    'price_range',
    'attributes'
);


ALTER TYPE public.enum_category_filters_type OWNER TO astramaster;

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
-- Name: attribute_types; Type: TABLE; Schema: public; Owner: astramaster
--

CREATE TABLE public.attribute_types (
    id integer NOT NULL,
    name character varying(255),
    category_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.attribute_types OWNER TO astramaster;

--
-- Name: attribute_types_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.attribute_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attribute_types_id_seq OWNER TO astramaster;

--
-- Name: attribute_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
--

ALTER SEQUENCE public.attribute_types_id_seq OWNED BY public.attribute_types.id;


--
-- Name: attribute_values; Type: TABLE; Schema: public; Owner: astramaster
--

CREATE TABLE public.attribute_values (
    id integer NOT NULL,
    name character varying(255),
    attribute_type_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.attribute_values OWNER TO astramaster;

--
-- Name: attribute_values_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.attribute_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attribute_values_id_seq OWNER TO astramaster;

--
-- Name: attribute_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
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
-- Name: category_filters; Type: TABLE; Schema: public; Owner: astramaster
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


ALTER TABLE public.category_filters OWNER TO astramaster;

--
-- Name: category_filters_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.category_filters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_filters_id_seq OWNER TO astramaster;

--
-- Name: category_filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
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
-- Name: order_products; Type: TABLE; Schema: public; Owner: astramaster
--

CREATE TABLE public.order_products (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    quantity integer
);


ALTER TABLE public.order_products OWNER TO astramaster;

--
-- Name: order_products_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.order_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_products_id_seq OWNER TO astramaster;

--
-- Name: order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
--

ALTER SEQUENCE public.order_products_id_seq OWNED BY public.order_products.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: astramaster
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.orders OWNER TO astramaster;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO astramaster;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
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
-- Name: product_attributes; Type: TABLE; Schema: public; Owner: astramaster
--

CREATE TABLE public.product_attributes (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_attribute_value_id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.product_attributes OWNER TO astramaster;

--
-- Name: product_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: astramaster
--

CREATE SEQUENCE public.product_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_attributes_id_seq OWNER TO astramaster;

--
-- Name: product_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: astramaster
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
-- Name: attribute_types id; Type: DEFAULT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.attribute_types ALTER COLUMN id SET DEFAULT nextval('public.attribute_types_id_seq'::regclass);


--
-- Name: attribute_values id; Type: DEFAULT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.attribute_values ALTER COLUMN id SET DEFAULT nextval('public.attribute_values_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: category_filters id; Type: DEFAULT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.category_filters ALTER COLUMN id SET DEFAULT nextval('public.category_filters_id_seq'::regclass);


--
-- Name: order_products id; Type: DEFAULT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.order_products ALTER COLUMN id SET DEFAULT nextval('public.order_products_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_attributes id; Type: DEFAULT; Schema: public; Owner: astramaster
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
20230409171602-change_order_table.js
20230409171723-create_order_products_table.js
20230409180036-change_order_products_table.js
\.


--
-- Data for Name: attribute_types; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.attribute_types (id, name, category_id, "createdAt", "updatedAt") FROM stdin;
1	color	32	2023-04-05 14:49:17.228043+02	2023-04-05 14:49:17.228043+02
3	size	32	2023-04-05 14:49:17.228043+02	2023-04-05 14:49:17.228043+02
\.


--
-- Data for Name: attribute_values; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.attribute_values (id, name, attribute_type_id, "createdAt", "updatedAt") FROM stdin;
1	red	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
2	green	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
3	blue	1	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
4	big	3	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
5	small	3	2023-04-05 14:51:04.941444+02	2023-04-05 14:51:04.941444+02
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name, "createdAt", "updatedAt", parent_category_id, icon, image, hru) FROM stdin;
34	Main catgory	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
83	Sub category	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
\.


--
-- Data for Name: category_filters; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.category_filters (id, "createdAt", "updatedAt", parent_category_id, info, name, type, value) FROM stdin;
151	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	83	\N	some name with attributes	attributes	1
152	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	83	\N	some name with attributes	attributes	3
150	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	83	\N	some name with attributes	price_range	{"from": 0, "to": 6000}
\.


--
-- Data for Name: order_products; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.order_products (id, order_id, product_id, "createdAt", "updatedAt", quantity) FROM stdin;
9	9	21	2023-04-09 20:10:41.427+02	2023-04-09 20:10:41.427+02	2
10	9	35	2023-04-09 20:10:41.427+02	2023-04-09 20:10:41.427+02	1
11	10	21	2023-04-09 20:13:30.716+02	2023-04-09 20:13:30.716+02	2
12	10	35	2023-04-09 20:13:30.716+02	2023-04-09 20:13:30.716+02	1
13	11	21	2023-04-09 20:14:01.296+02	2023-04-09 20:14:01.296+02	2
14	11	35	2023-04-09 20:14:01.296+02	2023-04-09 20:14:01.296+02	1
15	12	21	2023-04-09 20:44:33.879+02	2023-04-09 20:44:33.879+02	2
16	12	35	2023-04-09 20:44:33.879+02	2023-04-09 20:44:33.879+02	1
17	13	21	2023-04-09 20:47:33.36+02	2023-04-09 20:47:33.36+02	2
18	13	35	2023-04-09 20:47:33.36+02	2023-04-09 20:47:33.36+02	1
19	14	21	2023-04-09 20:49:15.142+02	2023-04-09 20:49:15.142+02	2
20	14	35	2023-04-09 20:49:15.142+02	2023-04-09 20:49:15.142+02	1
21	15	21	2023-04-09 20:49:39.347+02	2023-04-09 20:49:39.347+02	2
22	15	35	2023-04-09 20:49:39.347+02	2023-04-09 20:49:39.347+02	20
23	16	21	2023-04-09 20:50:15.421+02	2023-04-09 20:50:15.421+02	2
24	16	2333	2023-04-09 20:50:15.421+02	2023-04-09 20:50:15.421+02	20
25	17	21	2023-04-09 20:50:30.502+02	2023-04-09 20:50:30.502+02	2
26	17	2333	2023-04-09 20:50:30.502+02	2023-04-09 20:50:30.502+02	20
27	18	21	2023-04-09 20:50:41.106+02	2023-04-09 20:50:41.106+02	2
28	18	35	2023-04-09 20:50:41.106+02	2023-04-09 20:50:41.106+02	20
29	19	21	2023-04-09 20:51:34.812+02	2023-04-09 20:51:34.812+02	2
30	19	35	2023-04-09 20:51:34.812+02	2023-04-09 20:51:34.812+02	20
31	20	21	2023-04-12 18:16:43.156+02	2023-04-12 18:16:43.156+02	2
32	20	35	2023-04-12 18:16:43.156+02	2023-04-12 18:16:43.156+02	20
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.orders (id, "createdAt", "updatedAt") FROM stdin;
9	2023-04-09 20:10:41.408+02	2023-04-09 20:10:41.408+02
10	2023-04-09 20:13:30.683+02	2023-04-09 20:13:30.683+02
11	2023-04-09 20:14:01.285+02	2023-04-09 20:14:01.285+02
12	2023-04-09 20:44:33.868+02	2023-04-09 20:44:33.868+02
13	2023-04-09 20:47:33.342+02	2023-04-09 20:47:33.342+02
14	2023-04-09 20:49:15.126+02	2023-04-09 20:49:15.126+02
15	2023-04-09 20:49:39.331+02	2023-04-09 20:49:39.331+02
16	2023-04-09 20:50:15.407+02	2023-04-09 20:50:15.407+02
17	2023-04-09 20:50:30.491+02	2023-04-09 20:50:30.491+02
18	2023-04-09 20:50:41.102+02	2023-04-09 20:50:41.102+02
19	2023-04-09 20:51:34.799+02	2023-04-09 20:51:34.799+02
20	2023-04-12 18:16:43.142+02	2023-04-12 18:16:43.142+02
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, "createdAt", "updatedAt", parent_category_id, is_new, is_top, description, price, images, icon) FROM stdin;
21	Product 1	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	376	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
35	Product 2	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	100	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
36	Product 3	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	200	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
39	Product 6	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	20	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
37	Product 4	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	300	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
40	Product 7	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	1000	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
38	Product 5	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	50	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
41	Product 8	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	228	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
43	Product 10	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	322	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
42	Product 9	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	666	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
44	Product 11	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	15	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
47	Product 14	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	100	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
49	Product 16	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	228	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
48	Product 15	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	322	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
46	Product 13	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	1488	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
45	Product 12	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	83	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	188	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	\N
\.


--
-- Data for Name: product_attributes; Type: TABLE DATA; Schema: public; Owner: astramaster
--

COPY public.product_attributes (id, product_id, product_attribute_value_id, "createdAt", "updatedAt") FROM stdin;
1	21	1	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
2	21	2	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
3	35	3	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
4	35	4	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
5	40	5	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
6	44	2	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
7	47	1	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
8	48	3	2023-04-05 14:52:34.255795+02	2023-04-05 14:52:34.255795+02
\.


--
-- Name: attribute_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.attribute_types_id_seq', 3, true);


--
-- Name: attribute_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.attribute_values_id_seq', 5, true);


--
-- Name: category_filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.category_filters_id_seq', 152, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 83, true);


--
-- Name: order_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.order_products_id_seq', 32, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.orders_id_seq', 20, true);


--
-- Name: product_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: astramaster
--

SELECT pg_catalog.setval('public.product_attributes_id_seq', 8, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 49, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: attribute_types attribute_types_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.attribute_types
    ADD CONSTRAINT attribute_types_pkey PRIMARY KEY (id);


--
-- Name: attribute_values attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.attribute_values
    ADD CONSTRAINT attribute_values_pkey PRIMARY KEY (id);


--
-- Name: category_filters category_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
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
-- Name: order_products order_products_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT order_products_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_attributes product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: astramaster
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
