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
    type character varying(255)
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
    attributes json,
    icon character varying(255)
);


ALTER TABLE public.product OWNER TO postgres;

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
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name, "createdAt", "updatedAt", parent_category_id, icon, image, hru) FROM stdin;
32	Electronics	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
33	Computers & Accessories	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
34	Cameras & Photography	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
35	Home Appliances	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
36	Smartphones & Accessories	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
37	Tablets & Accessories	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
38	TVs & Video	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
39	Audio	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
40	Video Games & Consoles	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
41	Sports & Fitness	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	\N	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
42	Electronics - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	32	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
43	Electronics - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	32	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
44	Electronics - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	32	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
45	Electronics - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	32	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
46	Computers & Accessories - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	33	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
47	Computers & Accessories - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	33	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
52	Cameras & Photography - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
53	Cameras & Photography - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
54	Home Appliances - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	35	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
55	Home Appliances - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	35	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
56	Home Appliances - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	35	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
57	Home Appliances - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	35	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
58	Smartphones & Accessories - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	36	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
59	Smartphones & Accessories - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	36	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
60	Smartphones & Accessories - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	36	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
61	Smartphones & Accessories - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	36	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
48	Computers & Accessories - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	33	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
49	Computers & Accessories - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	33	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
50	Cameras & Photography - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
51	Cameras & Photography - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	34	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
62	Tablets & Accessories - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	37	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
63	Tablets & Accessories - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	37	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
64	Tablets & Accessories - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	37	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
65	Tablets & Accessories - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	37	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
66	TVs & Video - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	38	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
67	TVs & Video - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	38	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
68	TVs & Video - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	38	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
69	TVs & Video - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	38	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
70	Audio - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	39	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
71	Audio - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	39	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
72	Audio - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	39	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
73	Audio - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	39	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
74	Video Games & Consoles - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	40	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
75	Video Games & Consoles - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	40	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
76	Video Games & Consoles - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	40	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
77	Video Games & Consoles - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	40	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
78	Sports & Fitness - Subcategory 1	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	41	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
79	Sports & Fitness - Subcategory 2	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	41	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
80	Sports & Fitness - Subcategory 3	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	41	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
81	Sports & Fitness - Subcategory 4	2023-03-16 21:12:05.171037+01	2023-03-16 21:12:05.171037+01	41	https://www.svgrepo.com/show/500804/category.svg	https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQ052?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1495129815011	some-category
\.


--
-- Data for Name: category_filters; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.category_filters (id, "createdAt", "updatedAt", parent_category_id, info, name, type) FROM stdin;
51	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	32	{"to": 6000, "from": 0}	some name	price_range
52	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	33	{"to": 6000, "from": 0}	some name	price_range
53	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	34	{"to": 6000, "from": 0}	some name	price_range
54	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	35	{"to": 6000, "from": 0}	some name	price_range
55	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	36	{"to": 6000, "from": 0}	some name	price_range
56	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	37	{"to": 6000, "from": 0}	some name	price_range
57	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	38	{"to": 6000, "from": 0}	some name	price_range
58	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	39	{"to": 6000, "from": 0}	some name	price_range
59	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	40	{"to": 6000, "from": 0}	some name	price_range
60	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	41	{"to": 6000, "from": 0}	some name	price_range
61	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	42	{"to": 6000, "from": 0}	some name	price_range
62	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	43	{"to": 6000, "from": 0}	some name	price_range
63	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	44	{"to": 6000, "from": 0}	some name	price_range
64	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	45	{"to": 6000, "from": 0}	some name	price_range
65	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	46	{"to": 6000, "from": 0}	some name	price_range
66	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	47	{"to": 6000, "from": 0}	some name	price_range
67	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	48	{"to": 6000, "from": 0}	some name	price_range
68	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	49	{"to": 6000, "from": 0}	some name	price_range
69	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	50	{"to": 6000, "from": 0}	some name	price_range
70	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	51	{"to": 6000, "from": 0}	some name	price_range
71	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	52	{"to": 6000, "from": 0}	some name	price_range
72	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	53	{"to": 6000, "from": 0}	some name	price_range
73	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	54	{"to": 6000, "from": 0}	some name	price_range
74	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	55	{"to": 6000, "from": 0}	some name	price_range
75	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	56	{"to": 6000, "from": 0}	some name	price_range
76	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	57	{"to": 6000, "from": 0}	some name	price_range
77	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	58	{"to": 6000, "from": 0}	some name	price_range
78	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	59	{"to": 6000, "from": 0}	some name	price_range
79	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	60	{"to": 6000, "from": 0}	some name	price_range
80	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	61	{"to": 6000, "from": 0}	some name	price_range
81	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	62	{"to": 6000, "from": 0}	some name	price_range
82	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	63	{"to": 6000, "from": 0}	some name	price_range
83	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	64	{"to": 6000, "from": 0}	some name	price_range
84	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	65	{"to": 6000, "from": 0}	some name	price_range
85	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	66	{"to": 6000, "from": 0}	some name	price_range
86	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	67	{"to": 6000, "from": 0}	some name	price_range
87	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	68	{"to": 6000, "from": 0}	some name	price_range
88	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	69	{"to": 6000, "from": 0}	some name	price_range
89	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	70	{"to": 6000, "from": 0}	some name	price_range
90	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	71	{"to": 6000, "from": 0}	some name	price_range
91	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	72	{"to": 6000, "from": 0}	some name	price_range
92	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	73	{"to": 6000, "from": 0}	some name	price_range
93	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	74	{"to": 6000, "from": 0}	some name	price_range
94	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	75	{"to": 6000, "from": 0}	some name	price_range
95	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	76	{"to": 6000, "from": 0}	some name	price_range
96	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	77	{"to": 6000, "from": 0}	some name	price_range
97	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	78	{"to": 6000, "from": 0}	some name	price_range
98	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	79	{"to": 6000, "from": 0}	some name	price_range
99	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	80	{"to": 6000, "from": 0}	some name	price_range
100	2023-04-05 11:46:15.308142+02	2023-04-05 11:46:15.308142+02	81	{"to": 6000, "from": 0}	some name	price_range
101	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	32	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
102	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	33	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
103	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	34	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
104	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	35	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
105	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	36	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
106	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	37	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
107	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	38	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
108	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	39	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
109	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	40	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
110	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	41	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
111	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	42	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
112	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	43	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
113	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	44	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
114	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	45	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
115	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	46	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
116	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	47	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
117	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	48	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
118	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	49	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
119	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	50	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
120	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	51	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
121	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	52	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
122	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	53	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
123	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	54	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
124	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	55	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
125	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	56	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
126	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	57	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
127	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	58	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
128	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	59	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
129	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	60	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
130	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	61	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
131	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	62	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
132	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	63	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
133	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	64	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
134	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	65	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
135	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	66	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
136	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	67	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
137	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	68	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
138	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	69	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
139	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	70	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
140	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	71	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
141	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	72	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
142	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	73	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
143	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	74	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
144	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	75	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
145	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	76	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
146	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	77	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
147	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	78	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
148	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	79	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
149	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	80	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
150	2023-04-05 11:47:53.390049+02	2023-04-05 11:47:53.390049+02	81	{"size": "big", "type": "some type", "color": "red"}	some name with attributes	attributes
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: denys
--

COPY public.orders (id, info, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, "createdAt", "updatedAt", parent_category_id, is_new, is_top, description, price, images, attributes, icon) FROM stdin;
5	Product 1	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	32	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	399	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
7	Product 3	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	34	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	318	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
8	Product 4	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	35	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	240	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
10	Product 6	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	37	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	116	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
12	Product 8	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	39	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	382	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
14	Product 10	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	32	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	404	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
15	Product 11	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	33	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	116	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
16	Product 12	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	34	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	20	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
17	Product 13	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	35	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	370	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
19	Product 15	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	37	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	48	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
21	Product 17	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	39	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	376	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
22	Product 18	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	40	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	399	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
24	Product 20	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	33	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	493	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
26	Product 22	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	35	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	409	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
27	Product 23	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	36	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	229	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
29	Product 25	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	38	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	70	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
31	Product 27	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	40	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	328	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
32	Product 28	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	32	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	73	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
33	Product 29	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	33	f	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	436	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
20	Product 16	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	38	t	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	430	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
25	Product 21	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	34	t	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	129	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
23	Product 19	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	32	f	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	301	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
28	Product 24	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	37	f	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	457	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
30	Product 26	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	39	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	140	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
18	Product 14	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	36	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	416	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
11	Product 7	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	38	t	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	209	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
6	Product 2	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	33	t	f	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	287	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
9	Product 5	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	36	t	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	379	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
13	Product 9	2023-03-17 10:57:13.522699+01	2023-03-17 10:57:13.522699+01	40	f	t	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make	136	{https://www.cnet.com/a/img/resize/c2fb79b15d18f335e85fc4acd72910059cc9758b/hub/2021/08/20/453e37bf-61cb-4e16-ad90-fd822bdc390a/keychron-k3-mechanical-keyboard.jpg?auto=webp&fit=crop&height=900&width=1200,https://sites.google.com/site/brightmeasurement/_/rsrc/1365450861347/Home/keyboard-for-english-around-the-word/kb000%20us%20std%20kb.JPG}	{"type": "aaaa", "color": "red", "size": ["big", "small"]}	\N
\.


--
-- Name: category_filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.category_filters_id_seq', 150, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 81, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: denys
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 33, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


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

