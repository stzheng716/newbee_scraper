--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

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
-- Name: job_boards; Type: TABLE; Schema: public; 
--

CREATE TABLE public.job_boards (
    id SERIAL PRIMARY KEY,
    company_name character varying(250) DEFAULT 'requires research'::character varying NOT NULL,
    careers_url text NOT NULL,
    ats_url character varying(50) NOT NULL,
    career_date_scraped timestamp without time zone DEFAULT now() NOT NULL,
    UNIQUE (company_name)
);

--
-- Name: job_postings; Type: TABLE; Schema: public; 
--

CREATE TABLE public.job_postings (
    id SERIAL PRIMARY KEY,
    job_title character varying,
    job_url text NOT NULL,
    job_id character varying NOT NULL,
    job_scraped_date timestamp without time zone DEFAULT now() NOT NULL,
    company_name character varying NOT NULL REFERENCES public.job_boards(company_name) ON DELETE CASCADE,
    job_description text,
    json_response jsonb,
    UNIQUE (job_id)
);

CREATE INDEX job_id_index ON public.job_postings (job_id);
