--
-- PostgreSQL database dump
--

-- Dumped from database version 13.13 (Debian 13.13-0+deb11u1)
-- Dumped by pg_dump version 13.13 (Debian 13.13-0+deb11u1)

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO coke;

--
-- Name: item_categories; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.item_categories (
    id bigint NOT NULL,
    name character varying,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    photo character varying
);


ALTER TABLE public.item_categories OWNER TO coke;

--
-- Name: item_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.item_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_categories_id_seq OWNER TO coke;

--
-- Name: item_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.item_categories_id_seq OWNED BY public.item_categories.id;


--
-- Name: item_photos; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.item_photos (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    photo character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer
);


ALTER TABLE public.item_photos OWNER TO coke;

--
-- Name: item_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.item_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_photos_id_seq OWNER TO coke;

--
-- Name: item_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.item_photos_id_seq OWNED BY public.item_photos.id;


--
-- Name: item_scores; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.item_scores (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    score double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.item_scores OWNER TO coke;

--
-- Name: item_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.item_scores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_scores_id_seq OWNER TO coke;

--
-- Name: item_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.item_scores_id_seq OWNED BY public.item_scores.id;


--
-- Name: item_wishlists; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.item_wishlists (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.item_wishlists OWNER TO coke;

--
-- Name: item_wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.item_wishlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.item_wishlists_id_seq OWNER TO coke;

--
-- Name: item_wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.item_wishlists_id_seq OWNED BY public.item_wishlists.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.items (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    price integer,
    is_discount boolean,
    discount_price character varying,
    description text,
    item_category_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer,
    excerpt character varying,
    year integer,
    item_type integer
);


ALTER TABLE public.items OWNER TO coke;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO coke;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO coke;

--
-- Name: users; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    lastname character varying,
    password character varying,
    email character varying,
    phone character varying,
    avatar character varying,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO coke;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: coke
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO coke;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: item_categories id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_categories ALTER COLUMN id SET DEFAULT nextval('public.item_categories_id_seq'::regclass);


--
-- Name: item_photos id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_photos ALTER COLUMN id SET DEFAULT nextval('public.item_photos_id_seq'::regclass);


--
-- Name: item_scores id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_scores ALTER COLUMN id SET DEFAULT nextval('public.item_scores_id_seq'::regclass);


--
-- Name: item_wishlists id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_wishlists ALTER COLUMN id SET DEFAULT nextval('public.item_wishlists_id_seq'::regclass);


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-12-14 23:35:18.188822	2023-12-14 23:35:18.188822
\.


--
-- Data for Name: item_categories; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.item_categories (id, name, status, created_at, updated_at, photo) FROM stdin;
2	Clásicos	1	2023-12-15 00:13:58.766911	2023-12-15 00:13:58.766911	classic.webp
3	SUV	1	2023-12-22 03:43:46.465597	2023-12-22 03:43:46.465597	suv.webp
5	Electricos	1	2023-12-22 03:46:04.568759	2023-12-22 03:46:04.568759	electric.webp
6	Camiones	1	2023-12-22 03:46:31.744614	2023-12-22 03:46:31.744614	motor_truck.webp
1	Deportivos	1	2023-12-15 00:13:25.702032	2023-12-15 00:13:25.702032	sports.webp
4	Motos	1	2023-12-22 03:45:33.80083	2023-12-22 03:45:33.80083	moto.webp
\.


--
-- Data for Name: item_photos; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.item_photos (id, item_id, photo, created_at, updated_at, status) FROM stdin;
13	24	./public/uploads/items/24/item_photo_e9f6289d1ee46824756e694267eb678218d0648f.jpeg	2023-12-15 02:22:33.6	2023-12-15 02:22:33.6	0
14	24	./public/uploads/items/24/item_photo_fe0fae048f2ceb14bca1c9a397ea8b01a87c4461.jpeg	2023-12-15 02:22:33.6	2023-12-15 02:22:33.6	0
15	25	/uploads/items/25/item_photo_1287d083ed1437d05ca8f0256366821a2710a120.jpeg	2023-12-15 02:26:14.99	2023-12-15 02:26:14.99	0
16	25	/uploads/items/25/item_photo_ffe68ff41aa6f3ea259e8ffc32a59be6d850a28c.jpeg	2023-12-15 02:26:14.99	2023-12-15 02:26:14.99	0
17	26	/uploads/items/26/item_photo_7553a37145dacd654a2ccec8e5d474cb8e6224f7.jpeg	2023-12-15 22:05:16.044	2023-12-15 22:05:16.044	0
18	26	/uploads/items/26/item_photo_a50b7438d58c51be1c82ddd7ddc8fa5afa8b39db.jpeg	2023-12-15 22:05:16.044	2023-12-15 22:05:16.044	0
19	36	/uploads/items/36/item_photo_e5dee79caf5d397da936cef590141da380fa4f80.webp	2023-12-17 23:50:35.088	2023-12-17 23:50:35.088	0
20	37	/uploads/items/37/item_photo_98b87f7b9ae22e6fb060075a8bc417d985ab8c6f.jpeg	2023-12-17 23:51:49.939	2023-12-17 23:51:49.939	0
21	37	/uploads/items/37/item_photo_71741aefa2c1c702dcad95599b3992faa12ba346.jpeg	2023-12-17 23:51:49.939	2023-12-17 23:51:49.939	0
22	38	/uploads/items/38/item_photo_51e2db84788fa2d3efeb6b2d3d9f3667a6712d4d.jpeg	2023-12-18 15:28:06.963	2023-12-18 15:28:06.963	0
23	39	/uploads/items/39/item_photo_d3d80b34e88e86a474dec075a25ef4d7766073e6.jpeg	2023-12-18 15:31:43.463	2023-12-18 15:31:43.463	0
24	40	/uploads/items/40/item_photo_b798e026996e1ad79249bea4de0ff7a88d7c63fe.jpeg	2023-12-19 14:15:07.044	2023-12-19 14:15:07.044	0
25	41	/uploads/items/41/item_photo_3ade285b55d3911ff6cbfe9d06d25086f1b4e6c3.jpeg	2023-12-19 15:19:41.656	2023-12-19 15:19:41.656	0
26	42	/uploads/items/42/item_photo_62c9501d6ebd4f23d855eed164aced681b41e119.jpeg	2023-12-19 15:32:38.748	2023-12-19 15:32:38.748	0
27	43	/uploads/items/43/item_photo_2d1ffec651bd78b5cde72a3edff18ac083bc6098.jpeg	2023-12-20 01:45:26.789	2023-12-20 01:45:26.789	0
28	44	/uploads/items/44/item_photo_4b1e3e45aee83902d4443e3bcd8f482e25f2de48.webp	2023-12-21 04:21:37.01	2023-12-21 04:21:37.01	0
29	45	/uploads/items/45/item_photo_efc695085ccf82822875c1b515a0da55b3be0e2e.webp	2023-12-21 04:31:38.265	2023-12-21 04:31:38.265	0
30	45	/uploads/items/45/item_photo_9a5b3eb59f6bd2d43b176c088199a5095946a3f7.webp	2023-12-21 04:31:38.265	2023-12-21 04:31:38.265	0
31	45	/uploads/items/45/item_photo_05e6483ee4f0a132c3f6b5a0a1a59051dacadc72.webp	2023-12-21 04:31:38.265	2023-12-21 04:31:38.265	0
32	45	/uploads/items/45/item_photo_8ff28459346a8ffad3b947dc40278f64e1db3632.webp	2023-12-21 04:31:38.265	2023-12-21 04:31:38.265	0
33	46	/uploads/items/46/item_photo_e65ad422a2af16247c5cc5ec4c475368e125156b.webp	2023-12-21 22:01:22.829	2023-12-21 22:01:22.829	0
34	47	/uploads/items/47/item_photo_2d8167a9602b622a942be5b846d78c70eef67414.jpeg	2023-12-21 22:56:15.061	2023-12-21 22:56:15.061	0
35	48	/uploads/items/48/item_photo_ba385faa638639c3e294c7018c98f941c1fa822f.png	2023-12-21 22:59:37.489	2023-12-21 22:59:37.489	0
\.


--
-- Data for Name: item_scores; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.item_scores (id, item_id, score, created_at, updated_at, user_id) FROM stdin;
1	24	5	2023-12-15 02:50:18.704	2023-12-15 02:50:18.704	1
2	24	5	2023-12-15 02:50:27.834	2023-12-15 02:50:27.834	1
3	24	5	2023-12-15 02:50:28.693	2023-12-15 02:50:28.693	1
4	24	5	2023-12-15 02:50:29.371	2023-12-15 02:50:29.371	1
5	24	5	2023-12-15 02:50:29.913	2023-12-15 02:50:29.913	1
6	24	1	2023-12-15 02:50:36.227	2023-12-15 02:50:36.227	1
7	24	1	2023-12-15 02:50:36.628	2023-12-15 02:50:36.628	1
8	24	1	2023-12-15 02:50:37.105	2023-12-15 02:50:37.105	1
9	24	1	2023-12-15 02:50:37.662	2023-12-15 02:50:37.662	1
10	25	1	2023-12-15 03:09:55.581	2023-12-15 03:09:55.581	1
11	25	5	2023-12-15 03:10:17.696	2023-12-15 03:10:17.696	1
12	43	5	2023-12-20 15:58:38.378	2023-12-20 15:58:38.378	14
13	43	3	2023-12-20 16:01:08.957	2023-12-20 16:01:08.957	14
14	43	1	2023-12-20 16:02:20.888	2023-12-20 16:02:20.888	14
15	43	1	2023-12-20 16:02:25.928	2023-12-20 16:02:25.928	14
16	41	5	2023-12-20 16:19:56.545	2023-12-20 16:19:56.545	14
17	43	3	2023-12-20 16:23:39.225	2023-12-20 16:23:39.225	14
18	43	4	2023-12-20 16:32:45.159	2023-12-20 16:32:45.159	14
19	43	5	2023-12-20 16:32:48.961	2023-12-20 16:32:48.961	14
20	43	5	2023-12-20 16:32:58.382	2023-12-20 16:32:58.382	14
21	43	5	2023-12-20 16:32:59.649	2023-12-20 16:32:59.649	14
22	43	5	2023-12-20 16:33:00.079	2023-12-20 16:33:00.079	14
23	43	5	2023-12-20 16:33:00.403	2023-12-20 16:33:00.403	14
24	43	5	2023-12-20 16:33:00.639	2023-12-20 16:33:00.639	14
25	43	5	2023-12-20 16:33:01.359	2023-12-20 16:33:01.359	14
26	43	5	2023-12-20 16:33:01.601	2023-12-20 16:33:01.601	14
27	43	5	2023-12-20 16:33:01.928	2023-12-20 16:33:01.928	14
28	43	5	2023-12-20 16:33:02.295	2023-12-20 16:33:02.295	14
29	43	5	2023-12-20 16:33:02.623	2023-12-20 16:33:02.623	14
30	43	5	2023-12-20 16:33:02.94	2023-12-20 16:33:02.94	14
31	43	5	2023-12-20 16:33:03.278	2023-12-20 16:33:03.278	14
32	43	1	2023-12-20 16:33:12.413	2023-12-20 16:33:12.413	14
33	43	1	2023-12-20 16:33:12.831	2023-12-20 16:33:12.831	14
34	43	1	2023-12-20 16:33:13.257	2023-12-20 16:33:13.257	14
35	43	1	2023-12-20 16:33:13.661	2023-12-20 16:33:13.661	14
36	43	1	2023-12-20 16:33:14.138	2023-12-20 16:33:14.138	14
37	43	1	2023-12-20 16:33:14.554	2023-12-20 16:33:14.554	14
38	43	1	2023-12-20 16:33:14.996	2023-12-20 16:33:14.996	14
39	43	1	2023-12-20 16:33:16.807	2023-12-20 16:33:16.807	14
40	43	1	2023-12-20 16:33:16.986	2023-12-20 16:33:16.986	14
41	43	1	2023-12-20 16:33:17.089	2023-12-20 16:33:17.089	14
42	43	1	2023-12-20 16:33:17.228	2023-12-20 16:33:17.228	14
43	43	1	2023-12-20 16:33:17.393	2023-12-20 16:33:17.393	14
44	43	1	2023-12-20 16:33:17.499	2023-12-20 16:33:17.499	14
45	43	1	2023-12-20 16:33:17.623	2023-12-20 16:33:17.623	14
46	43	1	2023-12-20 16:33:17.802	2023-12-20 16:33:17.802	14
47	36	5	2023-12-20 16:33:41.156	2023-12-20 16:33:41.156	14
48	42	5	2023-12-20 20:06:37.595	2023-12-20 20:06:37.595	18
49	42	1	2023-12-20 20:06:40.377	2023-12-20 20:06:40.377	18
50	42	3	2023-12-20 20:06:41.62	2023-12-20 20:06:41.62	18
51	42	1	2023-12-20 20:06:42.864	2023-12-20 20:06:42.864	18
52	42	5	2023-12-20 20:06:44.071	2023-12-20 20:06:44.071	18
53	42	5	2023-12-20 20:06:45.227	2023-12-20 20:06:45.227	18
54	42	5	2023-12-20 20:06:45.997	2023-12-20 20:06:45.997	18
55	42	5	2023-12-20 20:06:46.531	2023-12-20 20:06:46.531	18
56	42	5	2023-12-20 20:06:46.906	2023-12-20 20:06:46.906	18
57	44	4	2023-12-21 04:21:44.374	2023-12-21 04:21:44.374	14
58	45	1	2023-12-21 04:32:44.655	2023-12-21 04:32:44.655	14
59	46	5	2023-12-21 22:01:45.772	2023-12-21 22:01:45.772	14
60	46	1	2023-12-21 23:00:22.302	2023-12-21 23:00:22.302	14
61	26	4	2023-12-22 03:39:58.286	2023-12-22 03:39:58.286	18
62	26	5	2023-12-22 03:40:02.475	2023-12-22 03:40:02.475	18
63	26	2	2023-12-22 03:40:04.647	2023-12-22 03:40:04.647	18
64	26	5	2023-12-22 03:40:18.917	2023-12-22 03:40:18.917	18
65	26	5	2023-12-22 03:40:25.553	2023-12-22 03:40:25.553	18
66	26	5	2023-12-22 03:40:32.064	2023-12-22 03:40:32.064	18
67	26	1	2023-12-22 03:40:36.245	2023-12-22 03:40:36.245	18
68	26	2	2023-12-22 03:40:38.416	2023-12-22 03:40:38.416	18
69	26	5	2023-12-22 03:40:54.931	2023-12-22 03:40:54.931	18
\.


--
-- Data for Name: item_wishlists; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.item_wishlists (id, item_id, created_at, updated_at, user_id) FROM stdin;
5	43	2023-12-20 02:06:54.693	2023-12-20 02:06:54.693	1
21	41	2023-12-20 16:21:15.214	2023-12-20 16:21:15.214	14
27	36	2023-12-20 17:47:26.761	2023-12-20 17:47:26.761	14
37	43	2023-12-21 00:23:18.776	2023-12-21 00:23:18.776	18
39	41	2023-12-21 00:23:20.548	2023-12-21 00:23:20.548	18
40	38	2023-12-21 00:23:22.174	2023-12-21 00:23:22.174	18
41	39	2023-12-21 00:23:23.025	2023-12-21 00:23:23.025	18
42	40	2023-12-21 00:23:23.848	2023-12-21 00:23:23.848	18
43	36	2023-12-21 00:23:29.908	2023-12-21 00:23:29.908	18
44	42	2023-12-21 04:16:32.304	2023-12-21 04:16:32.304	14
45	43	2023-12-21 04:17:03.251	2023-12-21 04:17:03.251	14
49	47	2023-12-22 02:30:27.627	2023-12-22 02:30:27.627	14
51	46	2023-12-22 02:59:03.065	2023-12-22 02:59:03.065	18
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.items (id, name, code, price, is_discount, discount_price, description, item_category_id, user_id, created_at, updated_at, status, excerpt, year, item_type) FROM stdin;
39	a	\N	1111	t	234	asdfadada	2	1	2023-12-18 15:31:43.463	2023-12-18 15:31:43.463	0	a	2023	2
40	Fiat Bravo	\N	24000000	f	0	awdasdadsa	1	14	2023-12-19 14:15:07.044	2023-12-19 14:15:07.044	0	hola	2021	2
24	Subaru Impreza	\N	25000000	t	400	Unico dueño, color plomo gris, automatico, asientos de cuero, llantas, sunroof	1	1	2023-12-15 02:22:33.6	2023-12-15 22:02:40.275	1	Esta es una descripción	2021	1
26	Fiat Punto	\N	15000000	t	400	Unico dueño, color plomo gris, automatico, asientos de cuero, llantas, sunroof	1	1	2023-12-15 22:05:16.044	2023-12-15 22:05:16.044	0	Esta es una descripción	2015	1
25	Subaru Impreza	\N	25000000	t	400	Unico dueño, color plomo gris, automatico, asientos de cuero, llantas, sunroof	1	1	2023-12-15 02:26:14.99	2023-12-15 02:26:14.99	1	Esta es una descripción	2021	1
33	Teslaa	\N	52000000	f	0	asdfasdsa	1	1	2023-12-17 23:42:48.869	2023-12-17 23:42:48.869	0	xy	2023	\N
34	Tesla Xy	\N	123000000	f	0	asdadasda	1	1	2023-12-17 23:47:17.682	2023-12-17 23:47:17.682	0	Hola esta es un descripcion	2023	1
35	Tesla Xy	\N	123000000	f	0	asdadasda	1	1	2023-12-17 23:48:15.72	2023-12-17 23:48:15.72	0	Hola esta es un descripcion	2023	1
36	Tesla XY	\N	123000000	f	0	Hola k asefdfsdf	1	1	2023-12-17 23:50:35.088	2023-12-17 23:50:35.088	0	Esta es una descripción	2023	1
37	Tesla XYZ	\N	50000000	f	0	Hola k asefdfsdf	1	1	2023-12-17 23:51:49.939	2023-12-17 23:51:49.939	0	Esta es una descripción	2016	1
38	Tesla XY	\N	99000000	f	78000000	El Tesla Model Y es un automóvil eléctrico eficiente, seguro y conveniente, ideal para familias y cualquier persona que necesite mucho espacio. El Model Y tiene un precio más alto que el de muchos otros coches eléctricos del mercado y puede haber largos tiempos de espera para la entrega.	1	1	2023-12-18 15:28:06.963	2023-12-18 15:28:06.963	0	El Tesla Model Y es un automóvil eléctrico eficiente, seguro y conveniente,	2023	1
43	Subaru Impreza	\N	21000000	t	20500000	Quisque ut mi sit amet risus maximus commodo. Pellentesque non orci sit amet eros eleifend pharetra a at libero. Phasellus commodo eu mi id condimentum. Proin massa nisi, varius id felis eu, fringilla tincidunt odio. Maecenas suscipit lectus erat, eu volutpat nunc luctus sed. Nunc ac convallis magna. Suspendisse ante neque, dignissim commodo rhoncus pharetra, tempus quis sem. Maecenas non orci eros. Vivamus mauris diam, tempus viverra enim vitae, malesuada porta sem.	1	18	2023-12-20 01:45:26.789	2023-12-20 01:45:26.789	0	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempus sagittis vestibulum. Quisque pellentesque nunc libero, in porttitor ante suscipit at. Etiam sodales imperdiet odio, non elementum quam pretium vestibulum. 	2023	1
46	Tesla Z	\N	15000000	f	0	prueba asdf	1	14	2023-12-21 22:01:22.829	2023-12-21 22:01:22.829	0	Hola esta es un descripcion	2023	2
47	Mazda 6	\N	15000000	t	14500000	hola k ase	2	14	2023-12-21 22:56:15.061	2023-12-21 22:56:15.061	0	Este es un autito deja el boton apretao	2021	2
45	Suzuki Expresso	\N	9000000	t	8800000	Este es el auto mas feo que existe en todo chile, es horrible	2	14	2023-12-21 04:31:38.265	2023-12-21 04:31:38.265	1	Este es un auto muy feo	2023	1
48	Nunuki	\N	1	f	0	asdadasdadadasdadas	1	14	2023-12-21 22:59:37.489	2023-12-21 22:59:37.489	1	puta el auto feo	2023	1
44	Auto de Prueba	\N	2500000	f	0	Esta es una prueba de un autito viejo clasico	1	14	2023-12-21 04:21:37.01	2023-12-21 04:21:37.01	1	esta es una descrip	2006	2
41	Fiat 600	\N	2000	f	0	esta es una descripción de autitos para la domitila	2	18	2023-12-19 15:19:41.656	2023-12-19 15:19:41.656	1	Esta es una descripción	2010	2
42	Auto	\N	1234	t	1111	dsfsfdsfsfs	1	18	2023-12-19 15:32:38.748	2023-12-19 15:32:38.748	1	asdf	2021	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.schema_migrations (version) FROM stdin;
20231205215333
20231205215400
20231205215734
20231205215803
20231205220401
20231205220723
20231205220734
20231205220756
20231205220903
20231205223634
20231205224407
20231205225032
20231206033211
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.users (id, name, lastname, password, email, phone, avatar, status, created_at, updated_at) FROM stdin;
1	coke	\N	$2a$10$meUHJbobiKYxBvquIUAIzOLHCyjU/ESJR56pmJRnxcQ6pPMaMNSAW	moo@moo.com	1234567	/uploads/users/1/user_photo_03e5c693ae1d7b040f0f81a9b3c0e030d518c80d.png	1	2023-12-14 23:10:34.613	2023-12-14 23:10:34.613
15	cokeito	\N	$2a$10$ZUpqTkVuS4/MPyGBv2nvJ.AY6ohOdYw0asTRSjVndcDsAVOA3yrQG	xcoke@mta.cl	123456	\N	1	2023-12-16 22:16:16.447	2023-12-16 22:16:16.447
16	emilio	\N	$2a$10$/381IGvUAWFo1TwNLs3TvO4nAu2/y2lXXJ1OMhCGiCWOMEFpTJ6y.	emilio@mta.cl	56999170354	\N	1	2023-12-16 22:38:42.35	2023-12-16 22:38:42.35
17	John Smith	\N	$2a$10$KwkLbzUX7A///ZvhA50UfeakzOGw4k9TWq3uGLfjPCr9lOYO56L/.	j@mta.cl	12345	\N	1	2023-12-19 14:15:28.872	2023-12-19 14:15:28.872
14	el cokeito	\N	$2a$10$dM4ZGmhOUJxgt6rgka2uaeoAmd7PIoGlSZRQwv6P/4kd1iWz0iQRS	coke@mta.cl	1233456	/uploads/users/14/user_photo_df59e12888fe84169dbbf03465f617b3721114cd.png	1	2023-12-16 21:51:26.696	2023-12-16 21:51:26.696
18	domitila	\N	$2a$10$sLtiaZBV1Kq8Y9EBt14MFOKGGixTgjPt/03ZruFd4L9EzGImn2GJa	domi@tila.com	123456	/uploads/users/18/user_photo_b7910a7dd2ccbac83d73372a55f324a4127ae2b9.png	1	2023-12-19 14:25:14.739	2023-12-19 14:25:14.739
\.


--
-- Name: item_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.item_categories_id_seq', 1, false);


--
-- Name: item_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.item_photos_id_seq', 35, true);


--
-- Name: item_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.item_scores_id_seq', 69, true);


--
-- Name: item_wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.item_wishlists_id_seq', 51, true);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.items_id_seq', 48, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: coke
--

SELECT pg_catalog.setval('public.users_id_seq', 18, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: item_categories item_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_categories
    ADD CONSTRAINT item_categories_pkey PRIMARY KEY (id);


--
-- Name: item_photos item_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_photos
    ADD CONSTRAINT item_photos_pkey PRIMARY KEY (id);


--
-- Name: item_scores item_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_scores
    ADD CONSTRAINT item_scores_pkey PRIMARY KEY (id);


--
-- Name: item_wishlists item_wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_wishlists
    ADD CONSTRAINT item_wishlists_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_item_photos_on_item_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_item_photos_on_item_id ON public.item_photos USING btree (item_id);


--
-- Name: index_item_scores_on_item_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_item_scores_on_item_id ON public.item_scores USING btree (item_id);


--
-- Name: index_item_scores_on_user_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_item_scores_on_user_id ON public.item_scores USING btree (user_id);


--
-- Name: index_item_wishlists_on_item_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_item_wishlists_on_item_id ON public.item_wishlists USING btree (item_id);


--
-- Name: index_item_wishlists_on_user_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_item_wishlists_on_user_id ON public.item_wishlists USING btree (user_id);


--
-- Name: index_items_on_item_category_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_items_on_item_category_id ON public.items USING btree (item_category_id);


--
-- Name: index_items_on_user_id; Type: INDEX; Schema: public; Owner: coke
--

CREATE INDEX index_items_on_user_id ON public.items USING btree (user_id);


--
-- Name: item_scores fk_rails_7545252142; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_scores
    ADD CONSTRAINT fk_rails_7545252142 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: items fk_rails_7977653854; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_7977653854 FOREIGN KEY (item_category_id) REFERENCES public.item_categories(id);


--
-- Name: item_wishlists fk_rails_7f368874b0; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_wishlists
    ADD CONSTRAINT fk_rails_7f368874b0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: item_photos fk_rails_7f6532063d; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_photos
    ADD CONSTRAINT fk_rails_7f6532063d FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: item_scores fk_rails_c141d5f227; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_scores
    ADD CONSTRAINT fk_rails_c141d5f227 FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: item_wishlists fk_rails_d00564294d; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_wishlists
    ADD CONSTRAINT fk_rails_d00564294d FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: items fk_rails_d4b6334db2; Type: FK CONSTRAINT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_d4b6334db2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

