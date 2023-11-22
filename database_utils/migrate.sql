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
    id integer NOT NULL,
    company_name character varying(250) DEFAULT 'requires research'::character varying NOT NULL,
    careers_url text NOT NULL,
    ats_url character varying(50) NOT NULL,
    career_date_scraped timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: job_boards_id_seq; Type: SEQUENCE; Schema: public; 
--

CREATE SEQUENCE public.job_boards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: job_boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; 
--

ALTER SEQUENCE public.job_boards_id_seq OWNED BY public.job_boards.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; 
--

CREATE TABLE public.job_postings (
    id integer NOT NULL,
    job_title character varying,
    job_url text NOT NULL,
    job_id character varying NOT NULL,
    job_scraped_date timestamp without time zone DEFAULT now() NOT NULL,
    company_name character varying NOT NULL,
    job_description text,
    json_response json
);


--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; 
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_boards_id_seq OWNER TO michael;

--
-- Name: job_boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; 
--

ALTER SEQUENCE public.job_boards_id_seq OWNED BY public.job_boards.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; 
--

CREATE TABLE public.job_postings (
    id integer NOT NULL,
    job_title character varying,
    job_url text NOT NULL,
    job_id character varying NOT NULL,
    job_scraped_date timestamp without time zone DEFAULT now() NOT NULL,
    company_name character varying NOT NULL,
    job_description text,
    json_response json
);


ALTER TABLE public.job_postings OWNER TO michael;

--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; 
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; 
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;
