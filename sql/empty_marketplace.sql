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

CREATE SEQUENCE public.item_categories_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
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

CREATE SEQUENCE public.item_photos_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
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

CREATE SEQUENCE public.item_scores_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
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

CREATE SEQUENCE public.item_wishlists_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
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

CREATE SEQUENCE public.items_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.items_id_seq OWNER TO coke;
--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;
--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: coke
--

CREATE TABLE public.schema_migrations (version character varying NOT NULL);
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

CREATE SEQUENCE public.users_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.users_id_seq OWNER TO coke;
--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: coke
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
--
-- Name: item_categories id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_categories
ALTER COLUMN id
SET DEFAULT nextval('public.item_categories_id_seq'::regclass);
--
-- Name: item_photos id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_photos
ALTER COLUMN id
SET DEFAULT nextval('public.item_photos_id_seq'::regclass);
--
-- Name: item_scores id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_scores
ALTER COLUMN id
SET DEFAULT nextval('public.item_scores_id_seq'::regclass);
--
-- Name: item_wishlists id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.item_wishlists
ALTER COLUMN id
SET DEFAULT nextval('public.item_wishlists_id_seq'::regclass);
--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.items
ALTER COLUMN id
SET DEFAULT nextval('public.items_id_seq'::regclass);
--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: coke
--

ALTER TABLE ONLY public.users
ALTER COLUMN id
SET DEFAULT nextval('public.users_id_seq'::regclass);
--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at)
FROM stdin;
environment development 2023 -12 -14 23 :35 :18.188822 2023 -12 -14 23 :35 :18.188822 \.--
-- Data for Name: item_categories; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.item_categories (id, name, status, created_at, updated_at, photo)
FROM stdin;
2 Clásicos 1 2023 -12 -15 00 :13 :58.766911 2023 -12 -15 00 :13 :58.766911 classic.webp 3 SUV 1 2023 -12 -22 03 :43 :46.465597 2023 -12 -22 03 :43 :46.465597 suv.webp 5 Electricos 1 2023 -12 -22 03 :46 :04.568759 2023 -12 -22 03 :46 :04.568759 electric.webp 6 Camiones 1 2023 -12 -22 03 :46 :31.744614 2023 -12 -22 03 :46 :31.744614 motor_truck.webp 1 Deportivos 1 2023 -12 -15 00 :13 :25.702032 2023 -12 -15 00 :13 :25.702032 sports.webp 4 Motos 1 2023 -12 -22 03 :45 :33.80083 2023 -12 -22 03 :45 :33.80083 moto.webp \.--
-- Data for Name: item_photos; Type: TABLE DATA; Schema: public; Owner: coke
--

--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.schema_migrations (version)
FROM stdin;
20231205215333 20231205215400 20231205215734 20231205215803 20231205220401 20231205220723 20231205220734 20231205220756 20231205220903 20231205223634 20231205224407 20231205225032 20231206033211 \.--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: coke
--

COPY public.users (
  id,
  name,
  lastname,
  password,
  email,
  phone,
  avatar,
  status,
  created_at,
  updated_at
)
FROM stdin;
1 coke \ N $2a$10$meUHJbobiKYxBvquIUAIzOLHCyjU / ESJR56pmJRnxcQ6pPMaMNSAW moo @moo.com 1234567 / uploads / users / 1 / user_photo_03e5c693ae1d7b040f0f81a9b3c0e030d518c80d.png 1 2023 -12 -14 23 :10 :34.613 2023 -12 -14 23 :10 :34.613 14 el cokeito \ N $2a$10$dM4ZGmhOUJxgt6rgka2uaeoAmd7PIoGlSZRQwv6P / 4kd1iWz0iQRS coke @mta.cl 1233456 / uploads / users / 14 / user_photo_df59e12888fe84169dbbf03465f617b3721114cd.png 1 2023 -12 -16 21 :51 :26.696 2023 -12 -16 21 :51 :26.696 \.--
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