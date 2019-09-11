--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.13
-- Dumped by pg_dump version 9.6.15

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: language_module_descriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language_module_descriptions (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    locale character varying(255),
    module_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    language_id bigint
);


--
-- Name: language_module_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.language_module_descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language_module_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.language_module_descriptions_id_seq OWNED BY public.language_module_descriptions.id;


--
-- Name: language_module_lesson_descriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language_module_lesson_descriptions (
    id bigint NOT NULL,
    name character varying(255),
    theory text,
    instructions text,
    locale character varying(255),
    tips character varying(255)[] DEFAULT ARRAY[]::character varying[] NOT NULL,
    lesson_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    language_id bigint,
    definitions jsonb[] DEFAULT ARRAY[]::jsonb[] NOT NULL
);


--
-- Name: language_module_lesson_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.language_module_lesson_descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language_module_lesson_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.language_module_lesson_descriptions_id_seq OWNED BY public.language_module_lesson_descriptions.id;


--
-- Name: language_module_lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language_module_lessons (
    id bigint NOT NULL,
    slug character varying(255),
    state character varying(255),
    "order" integer,
    original_code text,
    prepared_code text,
    test_code text,
    path_to_code character varying(255),
    module_id bigint,
    language_id bigint,
    upload_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    natural_order integer
);


--
-- Name: language_module_lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.language_module_lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language_module_lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.language_module_lessons_id_seq OWNED BY public.language_module_lessons.id;


--
-- Name: language_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language_modules (
    id bigint NOT NULL,
    slug character varying(255),
    state character varying(255),
    "order" integer,
    language_id bigint,
    upload_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: language_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.language_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.language_modules_id_seq OWNED BY public.language_modules.id;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    id bigint NOT NULL,
    name character varying(255),
    slug character varying(255),
    extension character varying(255),
    docker_image character varying(255),
    exercise_filename character varying(255),
    exercise_test_filename character varying(255),
    state character varying(255),
    upload_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uploads (
    id bigint NOT NULL,
    language_name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uploads_id_seq OWNED BY public.uploads.id;


--
-- Name: user_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_accounts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: user_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_accounts_id_seq OWNED BY public.user_accounts.id;


--
-- Name: user_finished_lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_finished_lessons (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    language_module_lesson_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: user_finished_lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_finished_lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_finished_lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_finished_lessons_id_seq OWNED BY public.user_finished_lessons.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    nickname character varying(255),
    github_uid integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    facebook_uid character varying(255),
    encrypted_password character varying(255),
    confirmation_token character varying(255),
    reset_password_token character varying(255),
    state character varying(255),
    locale character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: language_module_descriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_descriptions ALTER COLUMN id SET DEFAULT nextval('public.language_module_descriptions_id_seq'::regclass);


--
-- Name: language_module_lesson_descriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lesson_descriptions ALTER COLUMN id SET DEFAULT nextval('public.language_module_lesson_descriptions_id_seq'::regclass);


--
-- Name: language_module_lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lessons ALTER COLUMN id SET DEFAULT nextval('public.language_module_lessons_id_seq'::regclass);


--
-- Name: language_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_modules ALTER COLUMN id SET DEFAULT nextval('public.language_modules_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: uploads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads ALTER COLUMN id SET DEFAULT nextval('public.uploads_id_seq'::regclass);


--
-- Name: user_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_accounts ALTER COLUMN id SET DEFAULT nextval('public.user_accounts_id_seq'::regclass);


--
-- Name: user_finished_lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_finished_lessons ALTER COLUMN id SET DEFAULT nextval('public.user_finished_lessons_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: language_module_descriptions language_module_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_descriptions
    ADD CONSTRAINT language_module_descriptions_pkey PRIMARY KEY (id);


--
-- Name: language_module_lesson_descriptions language_module_lesson_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lesson_descriptions
    ADD CONSTRAINT language_module_lesson_descriptions_pkey PRIMARY KEY (id);


--
-- Name: language_module_lessons language_module_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lessons
    ADD CONSTRAINT language_module_lessons_pkey PRIMARY KEY (id);


--
-- Name: language_modules language_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_modules
    ADD CONSTRAINT language_modules_pkey PRIMARY KEY (id);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: uploads uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: user_accounts user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (id);


--
-- Name: user_finished_lessons user_finished_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_finished_lessons
    ADD CONSTRAINT user_finished_lessons_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: language_module_descriptions_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_module_descriptions_module_id_index ON public.language_module_descriptions USING btree (module_id);


--
-- Name: language_module_lesson_descriptions_lesson_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_module_lesson_descriptions_lesson_id_index ON public.language_module_lesson_descriptions USING btree (lesson_id);


--
-- Name: language_module_lessons_language_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_module_lessons_language_id_index ON public.language_module_lessons USING btree (language_id);


--
-- Name: language_module_lessons_module_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_module_lessons_module_id_index ON public.language_module_lessons USING btree (module_id);


--
-- Name: language_module_lessons_upload_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_module_lessons_upload_id_index ON public.language_module_lessons USING btree (upload_id);


--
-- Name: language_modules_language_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_modules_language_id_index ON public.language_modules USING btree (language_id);


--
-- Name: language_modules_upload_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX language_modules_upload_id_index ON public.language_modules USING btree (upload_id);


--
-- Name: languages_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX languages_slug_index ON public.languages USING btree (slug);


--
-- Name: languages_upload_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX languages_upload_id_index ON public.languages USING btree (upload_id);


--
-- Name: user_finished_lessons_language_module_lesson_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_finished_lessons_language_module_lesson_id_index ON public.user_finished_lessons USING btree (language_module_lesson_id);


--
-- Name: user_finished_lessons_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_finished_lessons_user_id_index ON public.user_finished_lessons USING btree (user_id);


--
-- Name: user_finished_lessons_user_id_language_module_lesson_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_finished_lessons_user_id_language_module_lesson_id_index ON public.user_finished_lessons USING btree (user_id, language_module_lesson_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: language_module_descriptions language_module_descriptions_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_descriptions
    ADD CONSTRAINT language_module_descriptions_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: language_module_descriptions language_module_descriptions_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_descriptions
    ADD CONSTRAINT language_module_descriptions_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.language_modules(id);


--
-- Name: language_module_lesson_descriptions language_module_lesson_descriptions_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lesson_descriptions
    ADD CONSTRAINT language_module_lesson_descriptions_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: language_module_lesson_descriptions language_module_lesson_descriptions_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lesson_descriptions
    ADD CONSTRAINT language_module_lesson_descriptions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.language_module_lessons(id);


--
-- Name: language_module_lessons language_module_lessons_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lessons
    ADD CONSTRAINT language_module_lessons_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: language_module_lessons language_module_lessons_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lessons
    ADD CONSTRAINT language_module_lessons_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.language_modules(id);


--
-- Name: language_module_lessons language_module_lessons_upload_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_module_lessons
    ADD CONSTRAINT language_module_lessons_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES public.uploads(id);


--
-- Name: language_modules language_modules_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_modules
    ADD CONSTRAINT language_modules_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: language_modules language_modules_upload_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_modules
    ADD CONSTRAINT language_modules_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES public.uploads(id);


--
-- Name: languages languages_upload_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES public.uploads(id);


--
-- Name: user_accounts user_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_finished_lessons user_finished_lessons_language_module_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_finished_lessons
    ADD CONSTRAINT user_finished_lessons_language_module_lesson_id_fkey FOREIGN KEY (language_module_lesson_id) REFERENCES public.language_module_lessons(id);


--
-- Name: user_finished_lessons user_finished_lessons_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_finished_lessons
    ADD CONSTRAINT user_finished_lessons_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20171125194458), (20171126054250), (20171126070001), (20171126070653), (20171126070825), (20171127083442), (20171127083829), (20171214111434), (20171214172819), (20171226110804), (20171226162229), (20180111153426), (20180201133326), (20180201133426), (20190603193727), (20190805163126), (20190807123154), (20190808094808), (20190812125644), (20190819131621), (20190902131653), (20190904072740);

