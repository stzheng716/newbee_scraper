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
-- Name: job_boards; Type: TABLE; Schema: public; Owner: michael
--

CREATE TABLE public.job_boards (
    id integer NOT NULL,
    company_name character varying(250) DEFAULT 'requires research'::character varying NOT NULL,
    careers_url text NOT NULL,
    ats_url character varying(50) NOT NULL,
    career_date_scraped timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.job_boards OWNER TO michael;

--
-- Name: job_boards_id_seq; Type: SEQUENCE; Schema: public; Owner: michael
--

CREATE SEQUENCE public.job_boards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_boards_id_seq OWNER TO michael;

--
-- Name: job_boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michael
--

ALTER SEQUENCE public.job_boards_id_seq OWNED BY public.job_boards.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; Owner: michael
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
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; Owner: michael
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_postings_id_seq OWNER TO michael;

--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michael
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;


--
-- Name: job_boards id; Type: DEFAULT; Schema: public; Owner: michael
--

ALTER TABLE ONLY public.job_boards ALTER COLUMN id SET DEFAULT nextval('public.job_boards_id_seq'::regclass);


--
-- Name: job_postings id; Type: DEFAULT; Schema: public; Owner: michael
--

ALTER TABLE ONLY public.job_postings ALTER COLUMN id SET DEFAULT nextval('public.job_postings_id_seq'::regclass);


--
-- Data for Name: job_boards; Type: TABLE DATA; Schema: public; Owner: michael
--

COPY public.job_boards (id, company_name, careers_url, ats_url, career_date_scraped) FROM stdin;
1	Rubrik	https://www.linkedin.com/company/rubrik-inc/jobs/	linkedin.com	2023-11-22 14:11:23.671942
2	Redpanda Data	https://redpanda.com/careers	redpanda.com	2023-11-22 14:11:23.683743
3	Rebuilt	https://www.rebuilt.com/careers	rebuilt.com	2023-11-22 14:11:23.684151
4	Avaya	https://www.linkedin.com/company/avaya/jobs/	linkedin.com	2023-11-22 14:11:23.684429
5	Make	https://www.make.com/en/careers	make.com	2023-11-22 14:11:23.684672
6	Fluence Technologies	https://www.fluencetech.com/careers	fluencetech.com	2023-11-22 14:11:23.6849
7	Upfort	https://boards.greenhouse.io/upfort	boards.greenhouse.io	2023-11-22 14:11:23.685113
8	Ironclad	https://jobs.ashbyhq.com/ironcladhq	jobs.ashbyhq.com	2023-11-22 14:11:23.685329
9	FX Innovation	https://www.fxinnovation.com/jobs/	fxinnovation.com	2023-11-22 14:11:23.685513
10	Lodgify	https://jobs.lever.co/lodgify/	jobs.lever.co	2023-11-22 14:11:23.685719
11	Guesty	https://www.guesty.com/careers/	guesty.com	2023-11-22 14:11:23.685921
12	OneTrust	https://www.linkedin.com/company/onetrust/jobs/	linkedin.com	2023-11-22 14:11:23.686149
13	Triptych	https://www.l2d.co/careers	l2d.co	2023-11-22 14:11:23.689852
14	Totango	https://totango.applytojob.com	totango.applytojob.com	2023-11-22 14:11:23.690368
15	PerformLine	https://www.linkedin.com/company/performline-inc/jobs/	linkedin.com	2023-11-22 14:11:23.690535
16	TCP Software	https://www.tcpsoftware.com/careers	tcpsoftware.com	2023-11-22 14:11:23.690748
17	Alianza  Inc.	https://www.linkedin.com/company/alianza/jobs/	linkedin.com	2023-11-22 14:11:23.690889
18	Eleos Health	https://eleos.health/career/	eleos.health	2023-11-22 14:11:23.691101
19	Simulmedia	https://jobs.lever.co/simulmedia/	jobs.lever.co	2023-11-22 14:11:23.691242
20	Metabase	https://jobs.lever.co/metabase/	jobs.lever.co	2023-11-22 14:11:23.691395
21	Thanx	https://boards.greenhouse.io/thanx	boards.greenhouse.io	2023-11-22 14:11:23.691573
22	Multilingual Jobs Worldwide	https://www.multilingualjobsworldwide.com/jobs	multilingualjobsworldwide.com	2023-11-22 14:11:23.691712
23	Neostella	https://www.neostella.com/careers/	neostella.com	2023-11-22 14:11:23.691856
24	Premier Inc.	https://www.linkedin.com/company/premierinc/jobs/	linkedin.com	2023-11-22 14:11:23.692065
25	Terzo	https://terzocloud.freshteam.com/jobs	terzocloud.freshteam.com	2023-11-22 14:11:23.69243
26	Amplitude	https://boards.greenhouse.io/amplitude	boards.greenhouse.io	2023-11-22 14:11:23.692573
27	Landstar	https://www.linkedin.com/company/landstar/jobs/	linkedin.com	2023-11-22 14:11:23.692754
28	Insider.	https://jobs.lever.co/useinsider	jobs.lever.co	2023-11-22 14:11:23.693112
29	PayIt	https://payitgov.com/careers/	payitgov.com	2023-11-22 14:11:23.693259
30	Stayntouch	https://www.stayntouch.com/careers/	stayntouch.com	2023-11-22 14:11:23.693445
31	Luminance	https://www.luminance.com/careers.html	luminance.com	2023-11-22 14:11:23.693584
32	Fastly	https://www.fastly.com/about/careers/current-openings	fastly.com	2023-11-22 14:11:23.693729
33	Ossium Health	https://ossiumhealth.com/careers	ossiumhealth.com	2023-11-22 14:11:23.693885
34	TechnologyAdvice	https://technologyadvice.com/careers/opportunities/	technologyadvice.com	2023-11-22 14:11:23.694122
35	Uplight	https://jobs.jobvite.com/uplight/jobs	jobs.jobvite.com	2023-11-22 14:11:23.694278
36	NuvoAir	https://jobs.lever.co/NuvoAir	jobs.lever.co	2023-11-22 14:11:23.694428
37	Handshake	https://joinhandshake.com/career-centers/	joinhandshake.com	2023-11-22 14:11:23.694577
38	Infinitus Systems  Inc.	https://jobs.lever.co/infinitus	jobs.lever.co	2023-11-22 14:11:23.694745
39	Degreed	https://explore.degreed.com/careers/	explore.degreed.com	2023-11-22 14:11:23.694909
40	stakefish	https://stake.fish/jobs	stake.fish	2023-11-22 14:11:23.695078
41	Clutch	https://clutch.co/careers	clutch.co	2023-11-22 14:11:23.695274
42	RevGenius	https://jobs.revgenius.com/jobs	jobs.revgenius.com	2023-11-22 14:11:23.695448
43	ECS	https://www.linkedin.com/company/ecstechhq/jobs/	linkedin.com	2023-11-22 14:11:23.697141
44	Starburst	https://jobs.lever.co/starburstdata	jobs.lever.co	2023-11-22 14:11:23.697478
45	DemandLab	https://www.linkedin.com/company/demandlab/jobs/	linkedin.com	2023-11-22 14:11:23.697668
46	POLITICO	https://www.linkedin.com/company/politico/jobs/	linkedin.com	2023-11-22 14:11:23.697872
47	Zapier	https://zapier.com/jobs	zapier.com	2023-11-22 14:11:23.698081
48	Vareto	https://boards.greenhouse.io/vareto/	boards.greenhouse.io	2023-11-22 14:11:23.698285
49	First Republic	https://careers.firstrepublic.com/	careers.firstrepublic.com	2023-11-22 14:11:23.69846
50	Descript	https://www.descript.com/careers	descript.com	2023-11-22 14:11:23.698646
51	Jellyfish	https://boards.greenhouse.io/jellyfish/	boards.greenhouse.io	2023-11-22 14:11:23.698812
52	D2L	https://www.d2l.com/careers/jobs/	d2l.com	2023-11-22 14:11:23.69899
53	Skyscanner	https://www.linkedin.com/company/skyscanner/jobs/	linkedin.com	2023-11-22 14:11:23.69918
54	Birdie	https://www.birdie.care/join-us	birdie.care	2023-11-22 14:11:23.699523
55	Formstack	https://www.formstack.com/careers	formstack.com	2023-11-22 14:11:23.699688
56	Cryptio	https://cryptio.co/careers	cryptio.co	2023-11-22 14:11:23.699863
57	LeadIQ	https://wellfound.com/company/leadiq/jobs	wellfound.com	2023-11-22 14:11:23.700086
58	Formlabs	https://careers.formlabs.com/asia/	careers.formlabs.com	2023-11-22 14:11:23.700273
59	Six & Flow	https://www.sixandflow.com/careers/business-development-representative	sixandflow.com	2023-11-22 14:11:23.700413
60	Lusha	https://www.lusha.com/careers/	lusha.com	2023-11-22 14:11:23.700543
61	Birdeye	https://birdeye.com/careers/jobsearch/	birdeye.com	2023-11-22 14:11:23.700636
62	Torc Robotics	https://boards.greenhouse.io/torcrobotics/	boards.greenhouse.io	2023-11-22 14:11:23.700733
63	Yardi	https://careers.yardi.com/openings/	careers.yardi.com	2023-11-22 14:11:23.700827
64	CONTROLTEK	https://controltekusa.com/careers	controltekusa.com	2023-11-22 14:11:23.700922
65	Endgame	https://www.linkedin.com/company/endgamelabs/jobs/	linkedin.com	2023-11-22 14:11:23.701011
66	Newfront	https://jobs.lever.co/newfrontinsurance	jobs.lever.co	2023-11-22 14:11:23.701107
67	Salute Safety	https://www.salutesafety.com/join-our-team	salutesafety.com	2023-11-22 14:11:23.701218
68	Gameloft	https://www.linkedin.com/company/gameloft/jobs/	linkedin.com	2023-11-22 14:11:23.70135
69	Perforce Software	https://www.perforce.com/careers	perforce.com	2023-11-22 14:11:23.701441
70	A.Team	https://www.notion.so/ateams/Careers-at-A-Team-4a4af87f3a3b4246bf63d8c1c9201320	notion.so	2023-11-22 14:11:23.701529
71	Apollo.io	https://boards.greenhouse.io/apolloio	boards.greenhouse.io	2023-11-22 14:11:23.701792
72	Lenus	https://www.lenusehealth.com/careers	lenusehealth.com	2023-11-22 14:11:23.701881
73	Wrike	https://boards.greenhouse.io/wrike/jobs/4197548005	boards.greenhouse.io	2023-11-22 14:11:23.701969
74	AffiniPay	https://www.affinipay.com/careers/	affinipay.com	2023-11-22 14:11:23.702057
75	Guardsquare	https://boards.greenhouse.io/guardsquare/	boards.greenhouse.io	2023-11-22 14:11:23.702166
76	Embrace	https://boards.greenhouse.io/embrace/	boards.greenhouse.io	2023-11-22 14:11:23.702253
77	Itron  Inc.	https://www.linkedin.com/company/itroninc/jobs/	linkedin.com	2023-11-22 14:11:23.7029
78	Codesmith	https://www.linkedin.com/company/codesmithdev/jobs	linkedin.com	2023-11-22 14:11:23.703016
79	Checkr  Inc.	https://checkr.com/company/careers/open-careers	checkr.com	2023-11-22 14:11:23.703098
80	Reach Progress PBC	https://www.reach.vote/jobs/	reach.vote	2023-11-22 14:11:23.70319
81	Connection	https://www.linkedin.com/company/connection-it/jobs/	linkedin.com	2023-11-22 14:11:23.703297
82	Informed.IQ	https://www.linkedin.com/company/informediq/jobs/	linkedin.com	2023-11-22 14:11:23.703389
83	Thermo Fisher Scientific	https://www.linkedin.com/company/thermo-fisher-scientific/jobs/	linkedin.com	2023-11-22 14:11:23.703475
84	Klue	https://jobs.lever.co/klue/	jobs.lever.co	2023-11-22 14:11:23.703563
85	Momence	https://boards.greenhouse.io/momence	boards.greenhouse.io	2023-11-22 14:11:23.70365
86	Perficient	https://www.linkedin.com/company/perficient/jobs/	linkedin.com	2023-11-22 14:11:23.703758
87	Faraday	https://www.linkedin.com/company/faradayio/jobs/	linkedin.com	2023-11-22 14:11:23.703854
88	FLEX College Prep	https://jobs.lever.co/flexcollegeprep/	jobs.lever.co	2023-11-22 14:11:23.703983
89	WorkOS	https://jobs.lever.co/workos/	jobs.lever.co	2023-11-22 14:11:23.704088
90	Quix	https://quix.recruitee.com/	quix.recruitee.com	2023-11-22 14:11:23.70419
91	Keeper.app	https://jobs.ashbyhq.com/keeper	jobs.ashbyhq.com	2023-11-22 14:11:23.704273
92	Ramp	https://jobs.ashbyhq.com/ramp	jobs.ashbyhq.com	2023-11-22 14:11:23.704372
93	ShareFile	https://careers.cloud.com/jobs/search/sharefile	careers.cloud.com	2023-11-22 14:11:23.704457
94	Investis Digital	https://recruiting.ultipro.com/INV1011INDIG/JobBoard/a14bf4f0-6b5d-46be-bc8d-18d5fbf2ee6a	recruiting.ultipro.com	2023-11-22 14:11:23.704545
95	DataSnipper	https://www.linkedin.com/company/autodesk/jobs/	linkedin.com	2023-11-22 14:11:23.704647
96	New Breed	https://www.newbreedrevenue.com/careers	newbreedrevenue.com	2023-11-22 14:11:23.704753
97	Rewiring America	https://apply.workable.com/rewiring-america	apply.workable.com	2023-11-22 14:11:23.704854
98	Venn Technology	https://www.linkedin.com/company/venn-technology/jobs/	linkedin.com	2023-11-22 14:11:23.70494
99	Brightspeed	https://careers.smartrecruiters.com/Brightspeed	careers.smartrecruiters.com	2023-11-22 14:11:23.705027
100	JMA Wireless	https://jobs.lever.co/jmawireless/	jobs.lever.co	2023-11-22 14:11:23.70513
101	365 Retail Markets	https://365retailmarkets.com/careers/	365retailmarkets.com	2023-11-22 14:11:23.705211
102	Logixboard	https://jobs.lever.co/logixboard	jobs.lever.co	2023-11-22 14:11:23.70534
103	Hightouch	https://hightouch.com/careers	hightouch.com	2023-11-22 14:11:23.705474
104	Chicory	https://boards.greenhouse.io/chicory	boards.greenhouse.io	2023-11-22 14:11:23.705588
105	TechInsights	https://techinsights.applytojob.com	techinsights.applytojob.com	2023-11-22 14:11:23.705677
106	BrainSell	https://www.brainsell.com/careers/	brainsell.com	2023-11-22 14:11:23.705948
107	The AES Corporation	https://www.linkedin.com/company/aes/jobs/	linkedin.com	2023-11-22 14:11:23.706049
108	Moveworks	https://www.moveworks.com/careers	moveworks.com	2023-11-22 14:11:23.706136
109	Cadwell	https://recruitingbypaycor.com/career/CareerHome.action?clientId=8a7883c683620a4f018365990ad10010	recruitingbypaycor.com	2023-11-22 14:11:23.706242
110	Axis Communications	https://www.linkedin.com/company/axis-communications/jobs/	linkedin.com	2023-11-22 14:11:23.706336
111	CyberSmart	https://www.linkedin.com/company/be-cybersmart/jobs/	linkedin.com	2023-11-22 14:11:23.706424
112	Pickle Robot Company	https://jobs.lever.co/picklerobot	jobs.lever.co	2023-11-22 14:11:23.706511
113	BuzzFeed	https://www.buzzfeed.com/about/jobs	buzzfeed.com	2023-11-22 14:11:23.706598
114	NICE	https://www.nice.com/careers/apply	nice.com	2023-11-22 14:11:23.706696
115	Ansys	https://www.linkedin.com/company/ansys-inc/jobs	linkedin.com	2023-11-22 14:11:23.706966
116	Owner.com	https://jobs.lever.co/owner/	jobs.lever.co	2023-11-22 14:11:23.707114
117	Kojo	https://www.usekojo.com/careers	usekojo.com	2023-11-22 14:11:23.70721
118	Top Hat	https://jobs.lever.co/tophat/	jobs.lever.co	2023-11-22 14:11:23.707295
119	STIGroup	https://careers.hireology.com/stig	careers.hireology.com	2023-11-22 14:11:23.707402
120	Loft Orbital	https://jobs.lever.co/loftorbital/	jobs.lever.co	2023-11-22 14:11:23.707489
121	Heroku	https://www.heroku.com/careers	heroku.com	2023-11-22 14:11:23.707596
122	StreamSets Inc.	https://softwareag.wd3.myworkdayjobs.com/rec_sag_ext	softwareag.wd3.myworkdayjobs.com	2023-11-22 14:11:23.707684
123	Precisely	https://www.linkedin.com/company/preciselydata/jobs/	linkedin.com	2023-11-22 14:11:23.707772
124	Vestwell	https://www.vestwell.com/careers	vestwell.com	2023-11-22 14:11:23.707889
125	Priority1	https://www.linkedin.com/company/priority1/jobs/	linkedin.com	2023-11-22 14:11:23.707999
126	Shinydocs	https://shinydocs.com/careers/	shinydocs.com	2023-11-22 14:11:23.708092
127	PM Group	https://www.linkedin.com/company/pm-group_165501/jobs/	linkedin.com	2023-11-22 14:11:23.70818
128	NinjaOne	https://www.ninjaone.com/careers/	ninjaone.com	2023-11-22 14:11:23.708278
129	Allied Global Marketing	https://www.linkedin.com/company/allied-global-mkg/jobs/	linkedin.com	2023-11-22 14:11:23.708371
130	Peloton Interactive	https://www.linkedin.com/company/peloton-interactive-/jobs	linkedin.com	2023-11-22 14:11:23.70848
131	Narvar	https://corp.narvar.com/careers	corp.narvar.com	2023-11-22 14:11:23.708567
132	Redis	https://redis.com/company/careers/jobs/	redis.com	2023-11-22 14:11:23.708666
133	Stack Overflow	https://stackoverflow.com/jobs/companies?so_medium=stackoverflow&so_source=SiteNav	stackoverflow.com	2023-11-22 14:11:23.70886
134	Learn Amp | B Corp™	https://learnamp.com/careers	learnamp.com	2023-11-22 14:11:23.708964
135	Worksighted	https://worksighted.com/company/careers/	worksighted.com	2023-11-22 14:11:23.709064
136	ShipBob	https://boards.greenhouse.io/shipbobinc/	boards.greenhouse.io	2023-11-22 14:11:23.709151
137	Broadcom	https://www.linkedin.com/company/broadcom/jobs/	linkedin.com	2023-11-22 14:11:23.709242
138	GroupA	https://www.groupainc.com/careers/	groupainc.com	2023-11-22 14:11:23.709335
139	InvestNext	https://apply.workable.com/investnext	apply.workable.com	2023-11-22 14:11:23.709436
140	Chameleon	https://www.chameleon.io/jobs	chameleon.io	2023-11-22 14:11:23.70954
141	FareHarbor	https://fareharbor.com/jobs/all/	fareharbor.com	2023-11-22 14:11:23.709627
142	LaSalle Network	https://www.thelasallenetwork.com/job-search	thelasallenetwork.com	2023-11-22 14:11:23.709716
143	Cribl	https://cribl.io/job-detail/	cribl.io	2023-11-22 14:11:23.709825
144	Plotly	https://boards.greenhouse.io/plotly/	boards.greenhouse.io	2023-11-22 14:11:23.709923
145	Union.ai	https://www.linkedin.com/company/union-ai/jobs/	linkedin.com	2023-11-22 14:11:23.710031
146	impact.com	https://www.linkedin.com/company/impactdotcom/jobs/	linkedin.com	2023-11-22 14:11:23.710137
147	ClickUp	https://clickup.com/careers	clickup.com	2023-11-22 14:11:23.710242
148	Flosum	https://flosum.freshteam.com/jobs/	flosum.freshteam.com	2023-11-22 14:11:23.710342
149	Digital Asset	https://boards.greenhouse.io/digitalasset/	boards.greenhouse.io	2023-11-22 14:11:23.710477
150	SixFifty	https://www.sixfifty.com/about/careers/	sixfifty.com	2023-11-22 14:11:23.710609
151	Olo	https://jobs.lever.co/olo/	jobs.lever.co	2023-11-22 14:11:23.710725
152	Pax8	https://www.pax8.com/en-us/careers/	pax8.com	2023-11-22 14:11:23.710828
153	Atlantic Data Security  LLC	https://www.linkedin.com/jobs/search/?currentJobId=3656420315&f_C=5082062&geoId=92000000&originToLandingJobPostings=3656420315	linkedin.com	2023-11-22 14:11:23.71094
154	Preply	https://www.linkedin.com/company/preply/jobs/	linkedin.com	2023-11-22 14:11:23.711055
155	Mavrck	https://www.mavrck.co/careers/	mavrck.co	2023-11-22 14:11:23.711161
156	Embark	https://embarkwithus.wd1.myworkdayjobs.com/embarkcareersite	embarkwithus.wd1.myworkdayjobs.com	2023-11-22 14:11:23.711316
157	Trustpilot	https://www.linkedin.com/company/trustpilot/jobs/	linkedin.com	2023-11-22 14:11:23.711444
158	Avalara	https://www.linkedin.com/company/avalara/jobs/	linkedin.com	2023-11-22 14:11:23.711561
159	MetaLab	https://boards.greenhouse.io/metalab/	boards.greenhouse.io	2023-11-22 14:11:23.71168
160	Intranet Connections	https://www.linkedin.com/company/intranet-connections/jobs/	linkedin.com	2023-11-22 14:11:23.711985
161	Breezy HR	https://breezy.hr/attract	breezy.hr	2023-11-22 14:11:23.712087
162	The Trade Desk	https://www.linkedin.com/company/the-trade-desk/jobs/	linkedin.com	2023-11-22 14:11:23.7122
163	Cleo	https://web.meetcleo.com/careers	web.meetcleo.com	2023-11-22 14:11:23.712312
164	Dataiku	https://www.dataiku.com/careers/	dataiku.com	2023-11-22 14:11:23.712416
165	ADP	https://www.linkedin.com/company/adp/jobs/	linkedin.com	2023-11-22 14:11:23.712509
166	Adyen	https://careers.adyen.com/vacancies	careers.adyen.com	2023-11-22 14:11:23.712621
167	Apty	https://www.linkedin.com/company/apty/jobs/	linkedin.com	2023-11-22 14:11:23.71273
168	Rover.com	https://jobs.lever.co/rover	jobs.lever.co	2023-11-22 14:11:23.712835
169	Super.com	https://jobs.lever.co/super-com	jobs.lever.co	2023-11-22 14:11:23.712926
170	Voltus	https://jobs.lever.co/voltus	jobs.lever.co	2023-11-22 14:11:23.713028
171	Databricks	https://www.linkedin.com/company/databricks/jobs/	linkedin.com	2023-11-22 14:11:23.71316
172	Workiva	https://www.linkedin.com/company/workiva/jobs/	linkedin.com	2023-11-22 14:11:23.713297
173	Absolute Software	https://jobs.jobvite.com/absolute	jobs.jobvite.com	2023-11-22 14:11:23.713407
174	CarGurus	https://careers.cargurus.com/job-search-results/	careers.cargurus.com	2023-11-22 14:11:23.713494
175	Next Level Solutions	https://www.nlsnow.com/careers/join-us?hsLang=en	nlsnow.com	2023-11-22 14:11:23.713574
176	FORM	https://jobs.lever.co/form	jobs.lever.co	2023-11-22 14:11:23.713674
177	Emburse	https://jobs.lever.co/emburse	jobs.lever.co	2023-11-22 14:11:23.713754
178	FLYR	https://boards.greenhouse.io/flyr	boards.greenhouse.io	2023-11-22 14:11:23.713848
179	Trellix	https://www.linkedin.com/company/trellixsecurity/jobs/	linkedin.com	2023-11-22 14:11:23.71394
180	Boeing	https://www.linkedin.com/company/boeing/jobs/	linkedin.com	2023-11-22 14:11:23.714016
181	ServiceRocket	https://jobs.lever.co/servicerocket/	jobs.lever.co	2023-11-22 14:11:23.714094
182	Odoo	https://www.odoo.com/jobs	odoo.com	2023-11-22 14:11:23.7142
183	Census	https://jobs.ashbyhq.com/census/	jobs.ashbyhq.com	2023-11-22 14:11:23.714277
184	Saleo	https://www.linkedin.com/company/saleo-sales-demo-experience/jobs/	linkedin.com	2023-11-22 14:11:23.714352
185	ŌURA	https://www.linkedin.com/company/oura/jobs/	linkedin.com	2023-11-22 14:11:23.714444
186	Jobvite	https://careers.employinc.com/	careers.employinc.com	2023-11-22 14:11:23.714541
187	Westlake Financial	https://recruiting.ultipro.com/HAN1010/JobBoard/f03ae624-2195-4366-9876-a831dee4af59	recruiting.ultipro.com	2023-11-22 14:11:23.714623
188	Second Front Systems	https://jobs.lever.co/secondfrontsystems/	jobs.lever.co	2023-11-22 14:11:23.714708
189	ZipRecruiter	https://www.ziprecruiter.com/Search-Jobs-Near-Me	ziprecruiter.com	2023-11-22 14:11:23.714794
190	Sage Intacct  Inc.	https://www.sage.com/en-us/company/careers/career-search/	sage.com	2023-11-22 14:11:23.71488
191	Sila	https://silamoney.applytojob.com	silamoney.applytojob.com	2023-11-22 14:11:23.714959
192	Custom Ink	https://www.linkedin.com/company/custom-ink/jobs/	linkedin.com	2023-11-22 14:11:23.715059
193	Textio	https://www.linkedin.com/company/textio/jobs/	linkedin.com	2023-11-22 14:11:23.715136
194	Qualified	https://jobs.lever.co/qualified	jobs.lever.co	2023-11-22 14:11:23.715216
195	Apexon	https://www.apexon.com/explore-jobs/	apexon.com	2023-11-22 14:11:23.715319
196	SamCart	https://boards.greenhouse.io/samcarthiring	boards.greenhouse.io	2023-11-22 14:11:23.715433
197	Ncontracts	https://www.ncontracts.com/careers	ncontracts.com	2023-11-22 14:11:23.715545
198	BigPanda	https://www.linkedin.com/company/bigpanda/jobs/	linkedin.com	2023-11-22 14:11:23.715621
199	Liquid Web	https://www.linkedin.com/company/liquid-web/jobs/	linkedin.com	2023-11-22 14:11:23.715696
200	Collective[i]	https://jobs.lever.co/collectivei/	jobs.lever.co	2023-11-22 14:11:23.715769
201	Wistia	https://wistia.com/jobs	wistia.com	2023-11-22 14:11:23.715846
202	Availity	https://www.linkedin.com/company/availity/jobs/	linkedin.com	2023-11-22 14:11:23.715919
203	CTO.ai	https://cto.ai/careers	cto.ai	2023-11-22 14:11:23.716019
204	Warner Bros. Discovery	https://www.linkedin.com/company/warner-bros-discovery/jobs/	linkedin.com	2023-11-22 14:11:23.716113
205	3Play Media	https://www.3playmedia.com/company/jobs/	3playmedia.com	2023-11-22 14:11:23.716378
206	Egress Software Technologies	https://www.egress.com/careers/vacancies	egress.com	2023-11-22 14:11:23.716494
207	Silverfort	https://www.linkedin.com/company/silverfort/jobs/	linkedin.com	2023-11-22 14:11:23.716595
208	Thoropass	https://boards.greenhouse.io/thoropass	boards.greenhouse.io	2023-11-22 14:11:23.716699
209	Jackpocket	https://www.linkedin.com/company/jackpocket/jobs/	linkedin.com	2023-11-22 14:11:23.716799
210	Edpuzzle	https://edpuzzle.com/jobs	edpuzzle.com	2023-11-22 14:11:23.716908
211	Zylo	https://recruiting.paylocity.com/recruiting/jobs/All/f13aa047-0fd6-4ae1-95d3-058f4f531973/ZYLO-INC	recruiting.paylocity.com	2023-11-22 14:11:23.717015
212	Confluent	https://careers.confluent.io/search/jobs	careers.confluent.io	2023-11-22 14:11:23.717139
213	Aptiv	https://www.linkedin.com/company/aptiv/jobs/	linkedin.com	2023-11-22 14:11:23.717244
214	Bonterra	https://bonterra.wd1.myworkdayjobs.com/bonterratech	bonterra.wd1.myworkdayjobs.com	2023-11-22 14:11:23.717364
215	Visualping	https://www.linkedin.com/company/visualping/jobs/	linkedin.com	2023-11-22 14:11:23.717465
216	Authorized Acquisitions	https://aa-medical.rippling-ats.com/	aa-medical.rippling-ats.com	2023-11-22 14:11:23.717555
217	Visma Creditro A/S	https://creditro.com/careers	creditro.com	2023-11-22 14:11:23.717645
218	Younite-AI	https://younite-ai.com/careers	younite-ai.com	2023-11-22 14:11:23.717737
219	Marco Technologies	https://jobs.lever.co/marco	jobs.lever.co	2023-11-22 14:11:23.717823
220	Activision	https://www.linkedin.com/company/activision/jobs/	linkedin.com	2023-11-22 14:11:23.717914
221	GaggleAMP	https://www.gaggleamp.com/careers	gaggleamp.com	2023-11-22 14:11:23.718065
222	One Click LCA	https://careers.oneclicklca.com/	careers.oneclicklca.com	2023-11-22 14:11:23.718169
223	ReversingLabs	https://www.reversinglabs.com/company/careers	reversinglabs.com	2023-11-22 14:11:23.718279
224	Slickdeals	https://slickdeals.net/corp/careers.html	slickdeals.net	2023-11-22 14:11:23.718374
225	XSELL Technologies	https://www.linkedin.com/company/xsell-tech/jobs/	linkedin.com	2023-11-22 14:11:23.718498
226	Riot Games	https://www.linkedin.com/company/riot-games/jobs/	linkedin.com	2023-11-22 14:11:23.718606
227	EvenUp	https://www.evenuplaw.com/careers	evenuplaw.com	2023-11-22 14:11:23.718726
228	FlutterFlow	https://www.ycombinator.com/companies/flutterflow/jobs	ycombinator.com	2023-11-22 14:11:23.718832
229	Juniper Networks	https://careers.juniper.net/	careers.juniper.net	2023-11-22 14:11:23.718939
230	CDW	https://www.linkedin.com/company/cdw/jobs/	linkedin.com	2023-11-22 14:11:23.719043
231	Orb	http://withorb.com/careers	withorb.com	2023-11-22 14:11:23.719145
232	Cato Networks	https://www.linkedin.com/company/cato-networks/jobs/	linkedin.com	2023-11-22 14:11:23.719254
233	Khan Academy	https://www.linkedin.com/company/khan-academy/jobs/	linkedin.com	2023-11-22 14:11:23.71938
234	High Alpha	https://highalpha.com/careers/	highalpha.com	2023-11-22 14:11:23.719484
235	Trader Interactive	https://www.traderinteractive.com/careers/	traderinteractive.com	2023-11-22 14:11:23.719613
236	Appen	https://jobs.lever.co/appen-2	jobs.lever.co	2023-11-22 14:11:23.71972
237	Xigent	https://xigentsolutions.com/company/careers/	xigentsolutions.com	2023-11-22 14:11:23.719827
238	Studio Science	https://studioscience.com/careers/	studioscience.com	2023-11-22 14:11:23.719939
239	Digital.ai	https://digital.ai/current-job-openings	digital.ai	2023-11-22 14:11:23.720061
240	Nuts.com	https://nuts.com/careers	nuts.com	2023-11-22 14:11:23.720161
241	Vidyard	https://www.vidyard.com/careers/	vidyard.com	2023-11-22 14:11:23.720258
242	Hungryroot	https://www.hungryroot.com/careers/	hungryroot.com	2023-11-22 14:11:23.720358
243	Intercom	https://www.intercom.com/careers?on_pageview_event=careers_footer	intercom.com	2023-11-22 14:11:23.72047
244	Carbon Direct	https://www.carbon-direct.com/careers	carbon-direct.com	2023-11-22 14:11:23.72058
245	Rafay	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.720672
246	Blizzard Entertainment	https://www.linkedin.com/company/blizzard-entertainment/jobs/	linkedin.com	2023-11-22 14:11:23.720784
247	Noise Digital	https://noisedigital.com/careers	noisedigital.com	2023-11-22 14:11:23.720881
248	Ampla	https://boards.greenhouse.io/ampla	boards.greenhouse.io	2023-11-22 14:11:23.720994
249	Kodiak	https://jobs.lever.co/kodiak	jobs.lever.co	2023-11-22 14:11:23.721289
250	Docebo	https://jobs.lever.co/docebo/	jobs.lever.co	2023-11-22 14:11:23.721383
251	Craft.co	https://enterprise.craft.co/careers	enterprise.craft.co	2023-11-22 14:11:23.721476
252	InMarket	https://www.linkedin.com/company/inmarket_1/jobs/	linkedin.com	2023-11-22 14:11:23.721564
253	Braze	https://www.braze.com/company/careers	braze.com	2023-11-22 14:11:23.721671
254	Apex.AI	https://www.apex.ai/careers	apex.ai	2023-11-22 14:11:23.72176
255	Snowflake	https://www.linkedin.com/company/snowflake-computing/jobs/	linkedin.com	2023-11-22 14:11:23.721849
256	Revenue Analytics  Inc.	https://jobs.lever.co/revenueanalytics/	jobs.lever.co	2023-11-22 14:11:23.721963
257	Crunchtime	https://www.crunchtime.com/open-positions	crunchtime.com	2023-11-22 14:11:23.72206
258	SEVENROOMS	https://www.linkedin.com/company/sevenrooms/jobs/	linkedin.com	2023-11-22 14:11:23.722163
259	COOP by Ryder™	https://www.linkedin.com/company/coopbyryder/jobs/	linkedin.com	2023-11-22 14:11:23.722252
260	ECI Software Solutions	https://www.linkedin.com/company/eci-software--solutions/jobs/	linkedin.com	2023-11-22 14:11:23.722346
261	AlphaSense	https://boards.greenhouse.io/alphasense/	boards.greenhouse.io	2023-11-22 14:11:23.722435
262	Paper	https://paper.wd3.myworkdayjobs.com/Paper_Careers	paper.wd3.myworkdayjobs.com	2023-11-22 14:11:23.722526
263	Go1	https://grnh.se/14d59c3c5us	grnh.se	2023-11-22 14:11:23.722612
264	Tucows	https://www.tucows.com/careers/opportunities	tucows.com	2023-11-22 14:11:23.722705
265	HeadSpin	https://www.headspin.io/careers	headspin.io	2023-11-22 14:11:23.722812
266	Wavestone	https://www.linkedin.com/company/wavestone/jobs/	linkedin.com	2023-11-22 14:11:23.722901
267	Attentive	https://jobs.lever.co/attentive/	jobs.lever.co	2023-11-22 14:11:23.722997
268	MedBridge	https://www.medbridge.com/careers/	medbridge.com	2023-11-22 14:11:23.723086
269	trimplement GmbH	https://trimplement.com/work-with-us	trimplement.com	2023-11-22 14:11:23.723182
270	Pipe17	https://pipe17.com/careers/	pipe17.com	2023-11-22 14:11:23.723272
271	Clio - Cloud-Based Legal Technology	https://www.linkedin.com/company/clio---cloud-based-legal-technology/jobs/	linkedin.com	2023-11-22 14:11:23.72336
272	TriNet	https://www.linkedin.com/company/trinet/jobs/	linkedin.com	2023-11-22 14:11:23.72345
273	NewtonX	https://www.newtonx.com/careers/	newtonx.com	2023-11-22 14:11:23.723537
274	WeTravel	https://jobs.wetravel.com/	jobs.wetravel.com	2023-11-22 14:11:23.723624
275	ZeroFox	https://jobs.lever.co/zerofox/	jobs.lever.co	2023-11-22 14:11:23.723711
276	Uptycs	https://www.uptycs.com/about/career	uptycs.com	2023-11-22 14:11:23.723802
277	Vista Packaging and Logistics	https://secure.entertimeonline.com/ta/VistaPackaging.careers?CareersSearch	secure.entertimeonline.com	2023-11-22 14:11:23.723909
278	Genies	https://boards.greenhouse.io/genies/	boards.greenhouse.io	2023-11-22 14:11:23.724029
279	Algolia	https://www.linkedin.com/company/algolia/jobs/	linkedin.com	2023-11-22 14:11:23.724138
280	JMP	https://jmp-sas.icims.com/jobs/search?ss=1&hashed=-435680032	jmp-sas.icims.com	2023-11-22 14:11:23.724247
281	Planet DDS	https://planetdds.applytojob.com	planetdds.applytojob.com	2023-11-22 14:11:23.724351
282	FloQast	https://jobs.lever.co/floqast	jobs.lever.co	2023-11-22 14:11:23.724459
283	Ceribell │ Point-of-Care EEG	https://ceribell.com/careers/	ceribell.com	2023-11-22 14:11:23.72455
284	Rangle.io	https://jobs.lever.co/rangle	jobs.lever.co	2023-11-22 14:11:23.724658
285	Buildertrend	https://buildertrend.com/careers/	buildertrend.com	2023-11-22 14:11:23.724766
286	Smartcar	https://jobs.lever.co/smartcar/	jobs.lever.co	2023-11-22 14:11:23.724885
287	Avanade	https://www.linkedin.com/company/avanade/jobs/	linkedin.com	2023-11-22 14:11:23.724986
288	Dotdash Meredith	https://www.linkedin.com/company/dotdashmeredith/jobs/	linkedin.com	2023-11-22 14:11:23.725084
289	Vajro	https://www.vajro.com/careers	vajro.com	2023-11-22 14:11:23.725174
290	ngrok	https://boards.greenhouse.io/ngrokinc	boards.greenhouse.io	2023-11-22 14:11:23.725262
291	Blue Yonder	https://www.linkedin.com/company/blueyonder/jobs/	linkedin.com	2023-11-22 14:11:23.725366
292	Color Of Change	https://jobs.lever.co/colorofchange/	jobs.lever.co	2023-11-22 14:11:23.725464
293	Oneflow	https://career.oneflow.com/	career.oneflow.com	2023-11-22 14:11:23.725565
294	Hootsuite	https://www.linkedin.com/company/hootsuite/jobs/	linkedin.com	2023-11-22 14:11:23.725856
295	PolyAI	https://poly.ai/company/careers/	poly.ai	2023-11-22 14:11:23.72595
296	Warby Parker	https://boards.greenhouse.io/warbyparker	boards.greenhouse.io	2023-11-22 14:11:23.726065
297	Atlassian	https://www.linkedin.com/company/atlassian/jobs/	linkedin.com	2023-11-22 14:11:23.726161
298	Figures	https://www.linkedin.com/company/f1gures/jobs/	linkedin.com	2023-11-22 14:11:23.726256
299	InfoTrust	https://infotrust.com/careers	infotrust.com	2023-11-22 14:11:23.726353
300	Vonage	https://boards.greenhouse.io/vonage/	boards.greenhouse.io	2023-11-22 14:11:23.726448
301	InvoiceCloud  Inc.	https://www.linkedin.com/company/invoice-cloud-inc/jobs/	linkedin.com	2023-11-22 14:11:23.726547
302	Workable	https://www.linkedin.com/company/workable-hr/jobs/	linkedin.com	2023-11-22 14:11:23.726641
303	Avicado Construction Technology Services  LLC	https://www.avicado.com/about/careers/	avicado.com	2023-11-22 14:11:23.726742
304	Narmi	https://jobs.lever.co/narmi/	jobs.lever.co	2023-11-22 14:11:23.726845
305	Comeet	https://www.comeet.co/jobs/comeet/30.005?__hstc=105140060.fcd804ec6421022280f3049d5a44ccdc.1700035911638.1700035911638.1700035911638.1&__hssc=105140060.1.1700035911639&__hsfp=2764680836	comeet.co	2023-11-22 14:11:23.726947
306	Echobot	https://www.echobot.com/career/	echobot.com	2023-11-22 14:11:23.727034
307	SpaceX	https://www.spacex.com/careers/jobs/	spacex.com	2023-11-22 14:11:23.727124
308	Day Zero Diagnostics  Inc	https://www.dayzerodiagnostics.com/about-us/careers/	dayzerodiagnostics.com	2023-11-22 14:11:23.727216
309	Plug and Play Tech Center	https://www.plugandplaytechcenter.com/jobs/	plugandplaytechcenter.com	2023-11-22 14:11:23.7273
310	Insperity	https://www.linkedin.com/company/insperity/jobs/	linkedin.com	2023-11-22 14:11:23.72752
311	CyberCube	https://jobs.lever.co/cybcube	jobs.lever.co	2023-11-22 14:11:23.727626
312	GM Financial	https://www.linkedin.com/company/gm-financial/jobs/	linkedin.com	2023-11-22 14:11:23.727712
313	Nordcloud  an IBM Company	https://nordcloud-career.breezy.hr	nordcloud-career.breezy.hr	2023-11-22 14:11:23.727825
314	Imprivata	https://jobs.jobvite.com/imprivata	jobs.jobvite.com	2023-11-22 14:11:23.727922
315	TaskRay	https://www.taskray.com/careers/	taskray.com	2023-11-22 14:11:23.728018
316	Kantox	https://www.kantox.com/en/careers/?	kantox.com	2023-11-22 14:11:23.728124
317	Consensus	https://jobs.lever.co/goconsensus	jobs.lever.co	2023-11-22 14:11:23.728216
318	Fair Square	https://www.linkedin.com/company/fair-square-medicare/jobs/	linkedin.com	2023-11-22 14:11:23.728319
319	Axuall	https://www.linkedin.com/company/axuall/jobs/	linkedin.com	2023-11-22 14:11:23.728421
320	Sharebite	https://sharebite.com/careers	sharebite.com	2023-11-22 14:11:23.728518
321	Pair Eyewear	https://paireyewear.com/pages/careers	paireyewear.com	2023-11-22 14:11:23.728605
322	Hotel Engine	https://boards.greenhouse.io/hotelengine/	boards.greenhouse.io	2023-11-22 14:11:23.7287
323	Genesys	https://www.linkedin.com/company/genesys/jobs/	linkedin.com	2023-11-22 14:11:23.728786
324	Unily	https://unily.teamtailor.com/	unily.teamtailor.com	2023-11-22 14:11:23.729009
325	Dialpad	https://www.linkedin.com/company/dialpad/jobs/	linkedin.com	2023-11-22 14:11:23.729093
326	ezCater	https://www.ezcater.com/company/apply/	ezcater.com	2023-11-22 14:11:23.729194
327	Cognitive3D	https://www.linkedin.com/jobs/engineer-jobs?trk=organization_guest-browse_jobs	linkedin.com	2023-11-22 14:11:23.729361
328	Leadfeeder	https://www.leadfeeder.com/jobs/	leadfeeder.com	2023-11-22 14:11:23.729473
329	Circle	https://www.linkedin.com/company/circle-internet-financial/jobs/	linkedin.com	2023-11-22 14:11:23.729592
330	Provenir	https://www.provenir.com/careers/	provenir.com	2023-11-22 14:11:23.72972
331	Suzy	https://www.linkedin.com/company/asksuzy/jobs/	linkedin.com	2023-11-22 14:11:23.729814
332	Marco Polo	https://www.linkedin.com/company/joya-communications/jobs/	linkedin.com	2023-11-22 14:11:23.729922
333	The French Agency Professional Placement	https://frenchagency.biz/jobs/	frenchagency.biz	2023-11-22 14:11:23.730026
334	Bestpass	https://bestpass.com/about-us/careers	bestpass.com	2023-11-22 14:11:23.730139
335	Peraton	https://www.linkedin.com/company/peraton/jobs/	linkedin.com	2023-11-22 14:11:23.730253
336	Grips Intelligence	https://gripsintelligence.com/careers	gripsintelligence.com	2023-11-22 14:11:23.730549
337	Pleo	https://www.pleo.io/en/careers/jobs	pleo.io	2023-11-22 14:11:23.730641
338	Helium SEO	https://heliumseo.applytojob.com	heliumseo.applytojob.com	2023-11-22 14:11:23.730743
339	Bevi	https://bevi.co/careers/	bevi.co	2023-11-22 14:11:23.730845
340	MachineMetrics	https://www.machinemetrics.com/careers	machinemetrics.com	2023-11-22 14:11:23.730935
341	Ahern	https://www.linkedin.com/company/j--f--ahern-co-/jobs/	linkedin.com	2023-11-22 14:11:23.731048
342	The Patrick J. McGovern Foundation	https://www.mcgovern.org/about/careers/	mcgovern.org	2023-11-22 14:11:23.731152
343	Block	https://www.linkedin.com/company/joinblock/jobs/	linkedin.com	2023-11-22 14:11:23.731305
344	Feedonomics	https://feedonomics.applytojob.com	feedonomics.applytojob.com	2023-11-22 14:11:23.731411
345	Ripple	https://www.linkedin.com/company/rippleofficial/jobs/	linkedin.com	2023-11-22 14:11:23.731523
346	Attain	https://boards.greenhouse.io/attain	boards.greenhouse.io	2023-11-22 14:11:23.731621
347	Sonrai Security	https://www.linkedin.com/company/sonrai-security/jobs/	linkedin.com	2023-11-22 14:11:23.731722
348	H1	https://jobs.lever.co/h1	jobs.lever.co	2023-11-22 14:11:23.731802
349	Mercury	https://mercury.com/jobs	mercury.com	2023-11-22 14:11:23.731895
350	Reverb	https://reverb.com/page/jobs	reverb.com	2023-11-22 14:11:23.731981
351	DearDoc	https://www.linkedin.com/company/getdeardoc/jobs/	linkedin.com	2023-11-22 14:11:23.732062
352	Tray.io	https://boards.greenhouse.io/trayio/	boards.greenhouse.io	2023-11-22 14:11:23.732139
353	Elephant Energy	https://elephantenergy.com/elephant-careers/	elephantenergy.com	2023-11-22 14:11:23.732216
354	Cloudsmith	https://cloudsmith.com/careers	cloudsmith.com	2023-11-22 14:11:23.732294
355	Nextech Systems	https://jobs.lever.co/nextech	jobs.lever.co	2023-11-22 14:11:23.732383
356	Addison Group	https://www.linkedin.com/company/addisongroup/jobs/	linkedin.com	2023-11-22 14:11:23.732458
357	Virtuozzo	https://www.linkedin.com/company/virtuozzo/jobs/	linkedin.com	2023-11-22 14:11:23.732534
358	Baton	https://boards.greenhouse.io/baton	boards.greenhouse.io	2023-11-22 14:11:23.732621
359	EagleView	https://www.linkedin.com/company/eagleview-technologies-inc/jobs/	linkedin.com	2023-11-22 14:11:23.7327
360	Fenix24	https://jobs.lever.co/conversantgroup	jobs.lever.co	2023-11-22 14:11:23.732777
361	Tyson & Mendes	https://www.tysonmendes.com/careers/	tysonmendes.com	2023-11-22 14:11:23.73287
362	ReachMobi	https://reachmobi.bamboohr.com/careers	reachmobi.bamboohr.com	2023-11-22 14:11:23.732962
363	Archer Integrated Risk Management	https://recruiting.ultipro.com/RSA1000RSAS/JobBoard/d9232f43-e112-4585-a5de-af3dbf681e76	recruiting.ultipro.com	2023-11-22 14:11:23.733042
364	Sequel.io	https://apply.workable.com/sequel	apply.workable.com	2023-11-22 14:11:23.733124
365	Marble	https://jobs.lever.co/Medchart	jobs.lever.co	2023-11-22 14:11:23.733216
366	Sisense	https://www.sisense.com/careers/	sisense.com	2023-11-22 14:11:23.733305
367	SIO Logistics	https://www.linkedin.com/company/senditover/jobs	linkedin.com	2023-11-22 14:11:23.733383
368	Multiverse	https://www.linkedin.com/company/joinmultiverse/jobs/	linkedin.com	2023-11-22 14:11:23.73347
369	Aquinas Consulting	https://www.linkedin.com/company/aquinas-consulting/jobs/	linkedin.com	2023-11-22 14:11:23.733546
370	Amla Commerce (Creator of Artifi and Znode)	https://www.amla.io/careers/	amla.io	2023-11-22 14:11:23.733803
371	Cisco	https://jobs.cisco.com/jobs/SearchJobs/?source=Cisco+Jobs+Career+Site&tags=CDC+Browse+all+jobs+careers	jobs.cisco.com	2023-11-22 14:11:23.733897
372	Partly	https://www.partly.com/careers/open-roles	partly.com	2023-11-22 14:11:23.734019
373	Glia	https://www.glia.com/jobs	glia.com	2023-11-22 14:11:23.734123
374	Mediafly	https://jobs.lever.co/Mediafly	jobs.lever.co	2023-11-22 14:11:23.734236
375	Xero	https://jobs.lever.co/xero/	jobs.lever.co	2023-11-22 14:11:23.734336
376	data.world	https://data.world/company/careers/	data.world	2023-11-22 14:11:23.734447
377	Intuition Machines	https://www.linkedin.com/company/intuition-machines-inc./jobs/	linkedin.com	2023-11-22 14:11:23.734536
378	Nue.io	https://www.nue.io/company/careers/	nue.io	2023-11-22 14:11:23.734643
379	Path	https://jobs.ashbyhq.com/pathmentalhealth	jobs.ashbyhq.com	2023-11-22 14:11:23.734738
380	Numeris	https://jobs.lever.co/numeris/	jobs.lever.co	2023-11-22 14:11:23.734861
381	Zocdoc	https://www.zocdoc.com/about/careers-list/	zocdoc.com	2023-11-22 14:11:23.735054
382	CharterUP	https://charterup.teamtailor.com/	charterup.teamtailor.com	2023-11-22 14:11:23.735204
383	Awardco	https://www.award.co/careers	award.co	2023-11-22 14:11:23.735326
384	Notion	https://www.notion.so/careers	notion.so	2023-11-22 14:11:23.735419
385	Waterplan (YC S21)	https://jobs.ashbyhq.com/Waterplan	jobs.ashbyhq.com	2023-11-22 14:11:23.735537
386	Awesome Motive  Inc.	https://awesomemotive.com/careers/	awesomemotive.com	2023-11-22 14:11:23.73564
387	Nirvana Insurance	https://www.linkedin.com/company/nirvana-tech/jobs/	linkedin.com	2023-11-22 14:11:23.735763
388	Unbabel	https://careers.unbabel.com/	careers.unbabel.com	2023-11-22 14:11:23.735864
389	Affirm	https://www.affirm.com/careers	affirm.com	2023-11-22 14:11:23.735982
390	Umbra	https://careers.umbra.space/	careers.umbra.space	2023-11-22 14:11:23.736092
391	Banzai	https://www.banzai.io/careers	banzai.io	2023-11-22 14:11:23.736251
392	CARTO	https://jobs.lever.co/cartodb	jobs.lever.co	2023-11-22 14:11:23.736362
393	Chapter	https://boards.greenhouse.io/chapter/	boards.greenhouse.io	2023-11-22 14:11:23.736477
394	Grant Thornton LLP (US)	https://www.linkedin.com/company/grant-thornton-llp/jobs/	linkedin.com	2023-11-22 14:11:23.736584
395	CGI	https://www.linkedin.com/company/cgi/jobs/	linkedin.com	2023-11-22 14:11:23.736692
396	brightwheel	https://jobs.lever.co/brightwheel/	jobs.lever.co	2023-11-22 14:11:23.736818
397	Personio	https://www.linkedin.com/company/personio/jobs/	linkedin.com	2023-11-22 14:11:23.736923
398	HoneyBook	https://www.honeybook.com/careers	honeybook.com	2023-11-22 14:11:23.737059
399	Orum	https://jobs.lever.co/orum/	jobs.lever.co	2023-11-22 14:11:23.737174
400	XTM International	https://careers.xtm.cloud/	careers.xtm.cloud	2023-11-22 14:11:23.737271
401	Archimedes	https://careers.archimedesfi.com/	careers.archimedesfi.com	2023-11-22 14:11:23.737384
402	CleanHub	https://cleanhub.jobs.personio.de/	cleanhub.jobs.personio.de	2023-11-22 14:11:23.737479
403	Tomorrow.io	https://www.tomorrow.io/careers/	tomorrow.io	2023-11-22 14:11:23.737565
404	Expel	https://expel.com/about/careers/	expel.com	2023-11-22 14:11:23.737646
405	Green Irony	https://www.linkedin.com/company/green-irony/jobs/	linkedin.com	2023-11-22 14:11:23.737722
406	Form Energy	https://jobs.ashbyhq.com/formenergy/	jobs.ashbyhq.com	2023-11-22 14:11:23.737803
407	Red River	https://www.linkedin.com/company/red-river-technology/jobs/	linkedin.com	2023-11-22 14:11:23.737882
408	Fidus Systems	https://fidus.com/careers/	fidus.com	2023-11-22 14:11:23.737965
409	TIAA	https://www.linkedin.com/company/tiaa/jobs/	linkedin.com	2023-11-22 14:11:23.738149
410	BioRender	https://jobs.lever.co/biorender	jobs.lever.co	2023-11-22 14:11:23.738231
411	EquipmentShare	https://www.linkedin.com/company/equipmentshare/jobs/	linkedin.com	2023-11-22 14:11:23.738329
412	Lula Group	https://www.linkedin.com/company/lula-group/jobs/	linkedin.com	2023-11-22 14:11:23.738422
413	Mutinex	https://www.linkedin.com/company/mutinex/jobs/	linkedin.com	2023-11-22 14:11:23.738508
414	Snowplow	https://jobs.lever.co/snowplow	jobs.lever.co	2023-11-22 14:11:23.738768
415	Avetta	https://www.avetta.com/company/careers/careers-list	avetta.com	2023-11-22 14:11:23.738854
416	Kimoby	https://www.kimoby.com/careers	kimoby.com	2023-11-22 14:11:23.738946
417	GuestReady	https://www.linkedin.com/company/guestready/jobs/	linkedin.com	2023-11-22 14:11:23.739034
418	Hubtek	https://gohubtek.com/careers/	gohubtek.com	2023-11-22 14:11:23.739134
419	Nutanix	https://jobs.jobvite.com/nutanix	jobs.jobvite.com	2023-11-22 14:11:23.739242
420	Preqin	https://www.linkedin.com/company/preqin/jobs/	linkedin.com	2023-11-22 14:11:23.739341
421	PitchBook	https://www.linkedin.com/company/pitchbook/jobs/	linkedin.com	2023-11-22 14:11:23.739458
422	Athelas	https://www.athelas.com/careers	athelas.com	2023-11-22 14:11:23.739543
423	Whova	https://whova.com/jobs/	whova.com	2023-11-22 14:11:23.73963
424	Revivn	https://jobs.lever.co/revivn.com	jobs.lever.co	2023-11-22 14:11:23.73972
425	Other World Computing	https://owc.applytojob.com/apply	owc.applytojob.com	2023-11-22 14:11:23.739812
426	Sanity	https://boards.greenhouse.io/sanityio/	boards.greenhouse.io	2023-11-22 14:11:23.739898
427	Nextdoor	https://www.linkedin.com/company/nextdoor-com/jobs/	linkedin.com	2023-11-22 14:11:23.73998
428	MOSTLY AI	https://mostly.ai/jobs	mostly.ai	2023-11-22 14:11:23.740069
429	OpenPhone	https://www.openphone.com/careers	openphone.com	2023-11-22 14:11:23.740154
430	Automox	https://jobs.lever.co/automox/	jobs.lever.co	2023-11-22 14:11:23.740246
431	QuillHash Group	https://www.quillhash.com/careers	quillhash.com	2023-11-22 14:11:23.740341
432	Uber	https://www.linkedin.com/company/uber-com/jobs/	linkedin.com	2023-11-22 14:11:23.740432
433	Convertr	https://www.convertr.io/careers	convertr.io	2023-11-22 14:11:23.740538
434	AHEAD	https://jobs.lever.co/thinkahead	jobs.lever.co	2023-11-22 14:11:23.740641
435	Pure Storage	https://www.linkedin.com/company/purestorage/jobs/	linkedin.com	2023-11-22 14:11:23.740732
436	ConstructConnect	https://careers-constructconnect.icims.com/jobs/search?hashed=-625918455&mobile=false&width=1140&height=500&bga=true&needsRedirect=false&jan1offset=-300&jun1offset=-240	careers-constructconnect.icims.com	2023-11-22 14:11:23.740843
437	Cruise	https://www.linkedin.com/company/getcruise/jobs/	linkedin.com	2023-11-22 14:11:23.740941
438	Seismic	https://www.linkedin.com/company/seismic/jobs/	linkedin.com	2023-11-22 14:11:23.741027
439	Momentum	https://jobs.lever.co/givemomentum	jobs.lever.co	2023-11-22 14:11:23.741153
440	SYSPRO USA	https://www.linkedin.com/company/syspro-usa/jobs/	linkedin.com	2023-11-22 14:11:23.741277
441	Triblio (a Foundry company)	https://tribliocareers-idg.icims.com/jobs/search?ss=1	tribliocareers-idg.icims.com	2023-11-22 14:11:23.741382
442	PingPong Payments	https://www.linkedin.com/company/pingpongpayments/jobs	linkedin.com	2023-11-22 14:11:23.741502
443	GILLIG	https://boards.greenhouse.io/gillig/	boards.greenhouse.io	2023-11-22 14:11:23.741603
444	SEAM Group	https://www.linkedin.com/company/seamgroup/jobs/	linkedin.com	2023-11-22 14:11:23.741721
445	Creyos (formerly Cambridge Brain Sciences)	https://www.linkedin.com/company/creyos/jobs/	linkedin.com	2023-11-22 14:11:23.741829
446	DeepL	https://jobs.deepl.com/	jobs.deepl.com	2023-11-22 14:11:23.741952
447	Scratchpad	https://www.scratchpad.com/careers	scratchpad.com	2023-11-22 14:11:23.742057
448	Cvent	https://www.linkedin.com/company/cvent/jobs/	linkedin.com	2023-11-22 14:11:23.742154
449	TripActions	https://tripactions.com/job-openings	tripactions.com	2023-11-22 14:11:23.742257
450	Linus Health	https://linushealth.com/careers	linushealth.com	2023-11-22 14:11:23.742371
451	Restaurant365	https://jobs.lever.co/restaurant365/	jobs.lever.co	2023-11-22 14:11:23.742481
452	Heartland	https://www.linkedin.com/company/heartland-payment-systems/jobs/	linkedin.com	2023-11-22 14:11:23.742604
453	7shifts: Team Management for Restaurants	https://boards.greenhouse.io/7shifts/	boards.greenhouse.io	2023-11-22 14:11:23.742697
454	SettleMint	https://www.linkedin.com/company/settlemint/jobs/	linkedin.com	2023-11-22 14:11:23.742822
455	Intapp	https://www.linkedin.com/company/intapp/jobs/	linkedin.com	2023-11-22 14:11:23.742926
456	Bookipi	https://bookipi.com/job-openings/	bookipi.com	2023-11-22 14:11:23.74303
457	Ekata  a Mastercard company	https://mastercard.wd1.myworkdayjobs.com/CorporateCareers	mastercard.wd1.myworkdayjobs.com	2023-11-22 14:11:23.743149
458	dbt Labs	https://boards.greenhouse.io/dbtlabsinc	boards.greenhouse.io	2023-11-22 14:11:23.743434
459	SUSE	https://www.linkedin.com/company/suse/jobs/	linkedin.com	2023-11-22 14:11:23.743559
460	Monte Carlo	https://jobs.ashbyhq.com/montecarlodata	jobs.ashbyhq.com	2023-11-22 14:11:23.743663
461	Novel Capital	https://apply.workable.com/novel-capital	apply.workable.com	2023-11-22 14:11:23.743783
462	Siemens	https://www.linkedin.com/company/siemens/jobs/	linkedin.com	2023-11-22 14:11:23.743884
463	Agilyx	https://agilyx.com/careers/	agilyx.com	2023-11-22 14:11:23.744003
464	Marigold	https://campaignmonitor.wd5.myworkdayjobs.com/marigold	campaignmonitor.wd5.myworkdayjobs.com	2023-11-22 14:11:23.744108
465	Coperion	https://www.linkedin.com/company/coperion/jobs/	linkedin.com	2023-11-22 14:11:23.744231
466	Petal	https://petalmd.recruitee.com	petalmd.recruitee.com	2023-11-22 14:11:23.744333
467	Modern Energy	https://jobs.lever.co/modern	jobs.lever.co	2023-11-22 14:11:23.744435
468	Nautical Commerce	https://jobs.lever.co/nautical-commerce	jobs.lever.co	2023-11-22 14:11:23.744537
469	Sodexo	https://www.linkedin.com/company/sodexo/jobs/	linkedin.com	2023-11-22 14:11:23.744659
470	Orca Security	https://orca.security/about/careers/	orca.security	2023-11-22 14:11:23.74475
471	N1 Health	https://www.n1health.com/about/careers/	n1health.com	2023-11-22 14:11:23.744866
472	DexCare	https://jobs.lever.co/dexcarehealth	jobs.lever.co	2023-11-22 14:11:23.744976
473	Superblocks	https://www.superblocks.com/careers	superblocks.com	2023-11-22 14:11:23.745121
474	Meltwater	https://meltwatercareers.ttcportals.com/search/jobs	meltwatercareers.ttcportals.com	2023-11-22 14:11:23.745235
475	ApolloMed	https://jobs.jobvite.com/apollomed	jobs.jobvite.com	2023-11-22 14:11:23.745398
476	Jamf	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.745576
477	IP Fabric	https://ipfabric.io/jobs-listing/	ipfabric.io	2023-11-22 14:11:23.745688
478	ReadMe	https://jobs.ashbyhq.com/readme/	jobs.ashbyhq.com	2023-11-22 14:11:23.745807
479	Granite Telecommunications	https://www.linkedin.com/company/granite-telecommunications/jobs/	linkedin.com	2023-11-22 14:11:23.74592
480	Vendr	https://www.vendr.com/careers	vendr.com	2023-11-22 14:11:23.746037
481	Dun & Bradstreet	https://www.linkedin.com/company/dun-&-bradstreet/jobs/	linkedin.com	2023-11-22 14:11:23.746134
482	Moogsoft	https://jobs.lever.co/moogsoft	jobs.lever.co	2023-11-22 14:11:23.746242
483	Backbase	https://www.backbase.com/careers/jobs	backbase.com	2023-11-22 14:11:23.746335
484	CommerceIQ	https://boards.greenhouse.io/commerceiq	boards.greenhouse.io	2023-11-22 14:11:23.746427
485	Quantcast	https://jobs.lever.co/quantcast/	jobs.lever.co	2023-11-22 14:11:23.74653
486	Uniphore	https://jobs.lever.co/uniphore/	jobs.lever.co	2023-11-22 14:11:23.746633
487	Muck Rack	https://boards.greenhouse.io/muckrack/	boards.greenhouse.io	2023-11-22 14:11:23.74672
488	Corsha	https://corsha.com/career	corsha.com	2023-11-22 14:11:23.746807
489	Zencore	https://jobs.lever.co/zencore/	jobs.lever.co	2023-11-22 14:11:23.746915
490	Yext	https://www.linkedin.com/company/yext/jobs/	linkedin.com	2023-11-22 14:11:23.747004
491	Remote	https://www.linkedin.com/company/remote.com/jobs/	linkedin.com	2023-11-22 14:11:23.747107
492	Icertis	https://jobs.lever.co/icertis/	jobs.lever.co	2023-11-22 14:11:23.747214
493	Splunk	https://www.linkedin.com/company/splunk/jobs/	linkedin.com	2023-11-22 14:11:23.747304
494	NexHealth	https://www.nexhealth.com/careers/open-positions	nexhealth.com	2023-11-22 14:11:23.747408
495	MPB	https://careers.mpb.com/	careers.mpb.com	2023-11-22 14:11:23.747496
496	Render	https://render.com/careers	render.com	2023-11-22 14:11:23.747585
497	Pacific Northwest National Laboratory	https://www.linkedin.com/company/pacific-northwest-national-laboratory/jobs/	linkedin.com	2023-11-22 14:11:23.747696
498	EDB	https://www.enterprisedb.com/careers/job-openings	enterprisedb.com	2023-11-22 14:11:23.74779
499	Call Box	https://www.callbox.com/careers	callbox.com	2023-11-22 14:11:23.747885
500	Zyte	https://www.zyte.com/jobs/	zyte.com	2023-11-22 14:11:23.748007
501	Secure Code Warrior	https://jobs.lever.co/securecodewarrior/	jobs.lever.co	2023-11-22 14:11:23.748126
502	Tapcart	https://www.tapcart.com/careers	tapcart.com	2023-11-22 14:11:23.748232
503	Dixa	https://jobs.lever.co/dixa	jobs.lever.co	2023-11-22 14:11:23.748552
504	Revolut	https://www.linkedin.com/company/revolut/jobs/	linkedin.com	2023-11-22 14:11:23.748659
505	Boulevard	https://www.joinblvd.com/careers	joinblvd.com	2023-11-22 14:11:23.748782
506	Aircall	https://jobs.lever.co/aircall	jobs.lever.co	2023-11-22 14:11:23.748892
507	Alegeus	https://alegeus.wd1.myworkdayjobs.com/Alegeus_External_Careers	alegeus.wd1.myworkdayjobs.com	2023-11-22 14:11:23.749002
508	adMarketplace	https://boards.greenhouse.io/admarketplaceinc	boards.greenhouse.io	2023-11-22 14:11:23.749106
509	Auror	https://www.linkedin.com/company/auror/jobs/	linkedin.com	2023-11-22 14:11:23.749239
510	Resourcely	https://jobs.ashbyhq.com/resourcely/	jobs.ashbyhq.com	2023-11-22 14:11:23.749359
511	percipient.ai	https://jobs.lever.co/percipient	jobs.lever.co	2023-11-22 14:11:23.749487
512	Voice123	https://voice123.com/voice-over-jobs	voice123.com	2023-11-22 14:11:23.749628
513	Mogli	https://www.mogli.com/about/team	mogli.com	2023-11-22 14:11:23.749751
514	Tulip Interfaces	https://tulip.co/careers	tulip.co	2023-11-22 14:11:23.749857
515	SPS Commerce	https://careers-spscommerce.icims.com/jobs/7375/strategic-account-executive/job	careers-spscommerce.icims.com	2023-11-22 14:11:23.749977
516	Bloomberg Industry Group	https://www.linkedin.com/company/bloomberg-industry-group/jobs/	linkedin.com	2023-11-22 14:11:23.750082
517	T-Mobile	https://www.linkedin.com/company/t-mobile/jobs/	linkedin.com	2023-11-22 14:11:23.750204
518	Warriors Recruiting	https://jobs.crelate.com/portal/warriorsrecruiting	jobs.crelate.com	2023-11-22 14:11:23.750325
519	System Six	https://systemsix.applytojob.com	systemsix.applytojob.com	2023-11-22 14:11:23.75043
520	Rye	https://www.linkedin.com/company/rye/jobs/	linkedin.com	2023-11-22 14:11:23.750532
521	GoodLeap	https://jobs.lever.co/goodleap	jobs.lever.co	2023-11-22 14:11:23.750654
522	Varonis	https://www.linkedin.com/company/varonis/jobs/	linkedin.com	2023-11-22 14:11:23.750775
523	Zerto	https://www.zerto.com/company/careers/	zerto.com	2023-11-22 14:11:23.750886
524	ElevationHR  LLC	https://elevationhr.com/career/	elevationhr.com	2023-11-22 14:11:23.750989
525	Semgrep	https://semgrep.dev/about/careers/	semgrep.dev	2023-11-22 14:11:23.751109
526	Aeonsemi	https://aeonsemi.com/jobs?locale=en	aeonsemi.com	2023-11-22 14:11:23.751211
527	DigiCert	https://www.digicert.com/careers	digicert.com	2023-11-22 14:11:23.751334
528	O'Reilly	https://www.linkedin.com/company/oreilly/jobs/	linkedin.com	2023-11-22 14:11:23.751468
529	Wanderu	https://wanderu.breezy.hr/	wanderu.breezy.hr	2023-11-22 14:11:23.751591
530	Vicinity Energy	https://www.vicinityenergy.us/careers	vicinityenergy.us	2023-11-22 14:11:23.751711
531	Pivotal	https://jobs.lever.co/pivotal	jobs.lever.co	2023-11-22 14:11:23.751824
532	Woflow	https://jobs.ashbyhq.com/woflow/	jobs.ashbyhq.com	2023-11-22 14:11:23.751922
533	Panzura	https://panzura.com/company/panzura-careers/	panzura.com	2023-11-22 14:11:23.752026
534	Forecast	https://forecasthq.bamboohr.com/careers	forecasthq.bamboohr.com	2023-11-22 14:11:23.752117
535	Quorum	https://www.quorum.us/about/careers/	quorum.us	2023-11-22 14:11:23.752224
536	Weights & Biases	https://jobs.lever.co/wandb	jobs.lever.co	2023-11-22 14:11:23.752402
537	Chewy	https://www.linkedin.com/company/chewy-com/jobs/	linkedin.com	2023-11-22 14:11:23.75255
538	Klaviyo	https://careers.klaviyo.com/en/search-jobs/	careers.klaviyo.com	2023-11-22 14:11:23.75271
539	Flexera	https://www.linkedin.com/company/flexera/jobs/	linkedin.com	2023-11-22 14:11:23.752841
540	Enel X	https://www.linkedin.com/company/enelx/jobs/	linkedin.com	2023-11-22 14:11:23.752957
541	Clubhouse	https://jobs.lever.co/clubhouse/	jobs.lever.co	2023-11-22 14:11:23.753093
542	Intuit	https://www.linkedin.com/company/intuit/jobs/	linkedin.com	2023-11-22 14:11:23.753183
543	Fundraise Up	https://boards.greenhouse.io/fundraiseup	boards.greenhouse.io	2023-11-22 14:11:23.753306
544	Emergent Holdings	https://ejko.fa.us2.oraclecloud.com/hcmUI/CandidateExperience/en/sites/CX_2/requisitions	ejko.fa.us2.oraclecloud.com	2023-11-22 14:11:23.753407
545	WellnessLiving	https://jobs.gohire.io/wellnessliving-zvcrxvet/	jobs.gohire.io	2023-11-22 14:11:23.753507
546	LeanIX	https://www.leanix.net/en/company/career/open-positions	leanix.net	2023-11-22 14:11:23.753587
547	LaunchDarkly	https://boards.greenhouse.io/launchdarkly/	boards.greenhouse.io	2023-11-22 14:11:23.7537
548	Mux	https://www.mux.com/jobs	mux.com	2023-11-22 14:11:23.753992
549	Tricentis	https://www.linkedin.com/company/tricentis/jobs/	linkedin.com	2023-11-22 14:11:23.754079
550	Rendered.ai	https://rendered.ai/careers/	rendered.ai	2023-11-22 14:11:23.754158
551	Elsevier	https://www.linkedin.com/company/elsevier/jobs/	linkedin.com	2023-11-22 14:11:23.754238
552	SentinelOne	https://www.linkedin.com/company/sentinelone/jobs/	linkedin.com	2023-11-22 14:11:23.754316
553	Seequent	https://seequent.csod.com/ux/ats/careersite/1/home?c=seequent	seequent.csod.com	2023-11-22 14:11:23.754411
554	Sunhero	https://jobs.lever.co/sunhero/	jobs.lever.co	2023-11-22 14:11:23.754501
555	Figma	https://www.figma.com/careers/	figma.com	2023-11-22 14:11:23.754583
556	Paylocity	https://www.linkedin.com/company/paylocity/jobs/	linkedin.com	2023-11-22 14:11:23.754674
557	Avantor	https://www.linkedin.com/company/avantorinc/jobs/	linkedin.com	2023-11-22 14:11:23.754748
558	SmartBear	https://smartbear.com/company/careers/	smartbear.com	2023-11-22 14:11:23.754838
559	Dashlane	https://boards.greenhouse.io/dashlane/	boards.greenhouse.io	2023-11-22 14:11:23.754921
560	Evisort	https://jobs.lever.co/evisort-2	jobs.lever.co	2023-11-22 14:11:23.754998
561	Virtualitics  Inc.	https://virtualitics.breezy.hr/	virtualitics.breezy.hr	2023-11-22 14:11:23.755088
562	Workday	https://www.linkedin.com/company/workday/jobs/	linkedin.com	2023-11-22 14:11:23.755163
563	TapMango	https://www.tapmango.com/careers/	tapmango.com	2023-11-22 14:11:23.755243
564	EigenLayer	https://boards.greenhouse.io/eigenlabs	boards.greenhouse.io	2023-11-22 14:11:23.755334
565	Uptempo	https://www.linkedin.com/company/uptempo/jobs/	linkedin.com	2023-11-22 14:11:23.755418
566	Signals	https://getsignals.ai/careers/	getsignals.ai	2023-11-22 14:11:23.755512
567	CHEQ	https://www.linkedin.com/company/cheq-ai/jobs/	linkedin.com	2023-11-22 14:11:23.755601
568	Glide	https://www.glideapps.com/jobs	glideapps.com	2023-11-22 14:11:23.755693
569	Dynatrace	https://careers.dynatrace.com/jobs/	careers.dynatrace.com	2023-11-22 14:11:23.755773
570	Sincere Corporation	https://www.sincere.com/careers	sincere.com	2023-11-22 14:11:23.755871
571	Integral.	https://apply.workable.com/integral-2	apply.workable.com	2023-11-22 14:11:23.755973
572	LMAX Group	https://careers.lmax.com/	careers.lmax.com	2023-11-22 14:11:23.756068
573	Open Systems	https://www.open-systems.com/careers	open-systems.com	2023-11-22 14:11:23.75615
574	Ross Video	https://www.linkedin.com/company/rossvideo/jobs/	linkedin.com	2023-11-22 14:11:23.756243
575	SourceWhale	https://sourcewhale.jobs.personio.com/	sourcewhale.jobs.personio.com	2023-11-22 14:11:23.756327
576	OnLogic	https://www.onlogic.com/company/careers/	onlogic.com	2023-11-22 14:11:23.756411
577	Cloudinary	https://jobs.lever.co/cloudinary/	jobs.lever.co	2023-11-22 14:11:23.756503
578	Avoma	https://www.avoma.com/careers	avoma.com	2023-11-22 14:11:23.756584
579	N-able	https://www.linkedin.com/company/n-able/jobs/	linkedin.com	2023-11-22 14:11:23.756687
580	Signifyd	https://boards.greenhouse.io/signifyd95	boards.greenhouse.io	2023-11-22 14:11:23.756787
581	Epos Now	https://www.eposnow.com/us/careers/open-positions/	eposnow.com	2023-11-22 14:11:23.756887
582	Shift Markets	https://www.linkedin.com/company/shiftmarkets/jobs/	linkedin.com	2023-11-22 14:11:23.756976
583	Text	https://jobs.lever.co/livechatinc	jobs.lever.co	2023-11-22 14:11:23.757068
584	Bright Machines	https://jobs.lever.co/brightmachines/	jobs.lever.co	2023-11-22 14:11:23.757178
585	Verkada	https://jobs.lever.co/verkada/	jobs.lever.co	2023-11-22 14:11:23.757264
586	Teamwork.com	https://teamwork.teamtailor.com/	teamwork.teamtailor.com	2023-11-22 14:11:23.757412
587	Cloudflare	https://www.cloudflare.com/careers/jobs/	cloudflare.com	2023-11-22 14:11:23.757507
588	Thryv	https://recruiting2.ultipro.com/SUP1002SPRM	recruiting2.ultipro.com	2023-11-22 14:11:23.757609
589	Avidbots Corp.	https://avidbots.com/company/careers/	avidbots.com	2023-11-22 14:11:23.757709
590	ClickBank	https://www.clickbank.com/careers/	clickbank.com	2023-11-22 14:11:23.757814
591	Tekion Corp	https://www.linkedin.com/company/tekion/jobs/	linkedin.com	2023-11-22 14:11:23.757903
592	Atomic Invest	https://boards.greenhouse.io/atomicvest	boards.greenhouse.io	2023-11-22 14:11:23.758012
593	Zenni Optical	https://www.linkedin.com/company/zenni-optical/jobs/	linkedin.com	2023-11-22 14:11:23.758291
594	Form3	https://www.linkedin.com/company/form3-financial-cloud/jobs/	linkedin.com	2023-11-22 14:11:23.758388
595	HelloFresh	https://careers.hellofresh.com/global/en/freshtalent	careers.hellofresh.com	2023-11-22 14:11:23.758516
596	Ava Labs	https://www.avalabs.org/careers	avalabs.org	2023-11-22 14:11:23.758604
597	Semrush	https://www.linkedin.com/company/semrush/jobs/	linkedin.com	2023-11-22 14:11:23.758691
598	Aisera	https://boards.greenhouse.io/aiserajobs	boards.greenhouse.io	2023-11-22 14:11:23.758774
599	Real	https://boards.greenhouse.io/real	boards.greenhouse.io	2023-11-22 14:11:23.758861
600	DrFirst  Inc.	https://careers-drfirst.icims.com/jobs/2023/architect/job	careers-drfirst.icims.com	2023-11-22 14:11:23.758983
601	QA Consultants	https://qaconsultants.com/careers/	qaconsultants.com	2023-11-22 14:11:23.759088
602	Upside	https://www.upside.com/about/careers	upside.com	2023-11-22 14:11:23.759203
603	Q4	https://jobs.lever.co/q4inc	jobs.lever.co	2023-11-22 14:11:23.759308
604	Paycor	https://www.linkedin.com/company/paycor/jobs/	linkedin.com	2023-11-22 14:11:23.759419
605	Audicus	https://boards.greenhouse.io/audicus	boards.greenhouse.io	2023-11-22 14:11:23.759512
606	Flex Technology Group	https://flextgcareers.ttcportals.com/jobs/search	flextgcareers.ttcportals.com	2023-11-22 14:11:23.759596
607	Blackbaud	https://www.linkedin.com/company/blackbaud/jobs/	linkedin.com	2023-11-22 14:11:23.759705
608	Amplemarket	https://www.amplemarket.com/careers	amplemarket.com	2023-11-22 14:11:23.759797
609	Reddit  Inc.	https://www.redditinc.com/careers	redditinc.com	2023-11-22 14:11:23.759908
610	MAVAN	https://www.linkedin.com/company/mavan/jobs/	linkedin.com	2023-11-22 14:11:23.760001
611	Zeta Global	https://zetaglobal.com/about/life-at-zeta/	zetaglobal.com	2023-11-22 14:11:23.760108
612	Improbable	https://jobs.lever.co/improbable/	jobs.lever.co	2023-11-22 14:11:23.760204
613	Notable	https://jobs.ashbyhq.com/notable/	jobs.ashbyhq.com	2023-11-22 14:11:23.760341
614	Confiant Inc	https://www.confiant.com/careers	confiant.com	2023-11-22 14:11:23.760552
615	Drata	https://drata.com/careers	drata.com	2023-11-22 14:11:23.76067
616	Equi	https://jobs.ashbyhq.com/equi/	jobs.ashbyhq.com	2023-11-22 14:11:23.760775
617	connectRN	https://www.connectrn.com/careers	connectrn.com	2023-11-22 14:11:23.760867
618	Plentific	https://www.plentific.com/en-us/careers/	plentific.com	2023-11-22 14:11:23.76097
619	TeamWorx Security	https://www.teamworxsecurity.com/careers/	teamworxsecurity.com	2023-11-22 14:11:23.76108
620	Freshworks	https://careers.smartrecruiters.com/Freshworks	careers.smartrecruiters.com	2023-11-22 14:11:23.761183
621	Veza	https://www.veza.com/company/careers	veza.com	2023-11-22 14:11:23.761314
622	Burwood Group	https://careers.smartrecruiters.com/BurwoodGroupInc	careers.smartrecruiters.com	2023-11-22 14:11:23.761413
623	Swirlds Labs	https://swirldslabs.com/careers	swirldslabs.com	2023-11-22 14:11:23.761515
624	Veeva Systems	https://careers.veeva.com/job-search-results/	careers.veeva.com	2023-11-22 14:11:23.761617
625	Brightly	https://www.linkedin.com/company/brightlysoftware/jobs/	linkedin.com	2023-11-22 14:11:23.761716
626	Amaze	https://jobs.lever.co/amaze/	jobs.lever.co	2023-11-22 14:11:23.761797
627	Sauce Labs	https://saucelabs.com/company/careers	saucelabs.com	2023-11-22 14:11:23.761877
628	Stampli	https://www.stampli.com/careers	stampli.com	2023-11-22 14:11:23.761958
629	Uberall	https://jobs.eu.lever.co/uberall	jobs.eu.lever.co	2023-11-22 14:11:23.762036
630	Veryfi	https://www.ycombinator.com/companies/veryfi-inc/jobs	ycombinator.com	2023-11-22 14:11:23.762111
631	Prolink	https://www.linkedin.com/company/prolinkworks/jobs/	linkedin.com	2023-11-22 14:11:23.762195
632	Corestream	https://recruitingbypaycor.com/career/CareerHome.action?clientId=8a7883c6894c4dc90189694bd55509d1	recruitingbypaycor.com	2023-11-22 14:11:23.76229
633	Aclima  Inc.	https://www.aclima.io/careers	aclima.io	2023-11-22 14:11:23.762369
634	OutboundEngine	https://www.outboundengine.com/careers	outboundengine.com	2023-11-22 14:11:23.762489
635	Living Security	https://www.livingsecurity.com/careers-and-culture	livingsecurity.com	2023-11-22 14:11:23.762583
636	BOK Financial	https://www.linkedin.com/company/bok-financial/jobs/	linkedin.com	2023-11-22 14:11:23.762661
637	WEKA	https://www.weka.io/company/careers/	weka.io	2023-11-22 14:11:23.76276
638	CodeHS	https://codehs.hire.trakstar.com/	codehs.hire.trakstar.com	2023-11-22 14:11:23.763003
639	Build Staffing Group	https://buildstaffing.com/job-seekers	buildstaffing.com	2023-11-22 14:11:23.763098
640	Parsyl	https://www.parsyl.com/about#team	parsyl.com	2023-11-22 14:11:23.763175
641	Built Technologies	https://boards.greenhouse.io/getbuilt	boards.greenhouse.io	2023-11-22 14:11:23.763255
642	Systech International	https://careers.dovercorporation.com/search/?createNewAlert=false&q=systech&locationsearch=&optionsFacetsDD_department=&optionsFacetsDD_facility=	careers.dovercorporation.com	2023-11-22 14:11:23.763354
643	Cleary	https://gocleary.com/careers/	gocleary.com	2023-11-22 14:11:23.76343
644	IBM	https://www.linkedin.com/company/ibm/jobs/	linkedin.com	2023-11-22 14:11:23.763505
645	Bluebeam  Inc.	https://careers.nemetschek.com/Bluebeam/search/?createNewAlert=false&q=&optionsFacetsDD_customfield1=	careers.nemetschek.com	2023-11-22 14:11:23.763603
646	Acceleration Partners	https://boards.greenhouse.io/accelerationpartners	boards.greenhouse.io	2023-11-22 14:11:23.763694
647	ServiceNow	https://www.linkedin.com/company/servicenow/jobs/	linkedin.com	2023-11-22 14:11:23.76379
648	Arcadia	https://www.arcadia.com/careers	arcadia.com	2023-11-22 14:11:23.763864
649	Lenovo	https://www.linkedin.com/company/lenovo/jobs/	linkedin.com	2023-11-22 14:11:23.763971
650	ConductorOne	https://careers.conductorone.com/	careers.conductorone.com	2023-11-22 14:11:23.764077
651	Equinix	https://www.linkedin.com/company/equinix/jobs/	linkedin.com	2023-11-22 14:11:23.764161
652	MetLife	https://www.linkedin.com/company/metlife/jobs/	linkedin.com	2023-11-22 14:11:23.764269
653	Aumni	https://www.aumni.fund/careers	aumni.fund	2023-11-22 14:11:23.76437
654	OneUp Sales	https://oneup.app.wearecandidly.com/careers	oneup.app.wearecandidly.com	2023-11-22 14:11:23.764463
655	Tropic	https://boards.greenhouse.io/tropic	boards.greenhouse.io	2023-11-22 14:11:23.764548
656	LogicManager	https://jobs.lever.co/logicmanager/	jobs.lever.co	2023-11-22 14:11:23.764703
657	Pica8  Inc.	https://www.pica8.com/company/careers/	pica8.com	2023-11-22 14:11:23.764841
658	OwnBackup	https://www.ownbackup.com/careers/	ownbackup.com	2023-11-22 14:11:23.764953
659	Protiviti	https://www.linkedin.com/company/protiviti/jobs/	linkedin.com	2023-11-22 14:11:23.765065
660	Aktion Associates  Inc.	https://www.aktion.com/company/careers/	aktion.com	2023-11-22 14:11:23.765158
661	Anthology Inc	https://www.linkedin.com/company/anthologyinc/jobs/	linkedin.com	2023-11-22 14:11:23.76525
662	Apptegy	https://jobs.lever.co/apptegy	jobs.lever.co	2023-11-22 14:11:23.765367
663	Fidelity Investments	https://www.linkedin.com/company/fidelity-investments/jobs/	linkedin.com	2023-11-22 14:11:23.765471
664	SoFi	https://www.linkedin.com/company/sofi/jobs/	linkedin.com	2023-11-22 14:11:23.76557
665	ModMed	https://www.modmed.com/company/careers/	modmed.com	2023-11-22 14:11:23.765672
666	OpenSpace	https://www.openspace.ai/careers/	openspace.ai	2023-11-22 14:11:23.765772
667	insightsoftware	https://jobs.smartrecruiters.com/Insightsoftware	jobs.smartrecruiters.com	2023-11-22 14:11:23.765885
668	Matillion	https://jobs.lever.co/matillion/	jobs.lever.co	2023-11-22 14:11:23.765989
669	StrongMind	https://recruiting2.ultipro.com/STR1017SMINC/JobBoard/e883a137-8797-484c-bf4d-c3d514ec5e38	recruiting2.ultipro.com	2023-11-22 14:11:23.766102
670	MVMNT	https://www.linkedin.com/company/mvmntfreight/jobs/	linkedin.com	2023-11-22 14:11:23.766205
671	Leapsome	https://jobs.ashbyhq.com/leapsome/	jobs.ashbyhq.com	2023-11-22 14:11:23.766299
672	CE Broker	https://jobs.ashbyhq.com/propelus	jobs.ashbyhq.com	2023-11-22 14:11:23.766394
673	GoodRx	https://www.linkedin.com/company/goodrx/jobs/	linkedin.com	2023-11-22 14:11:23.766489
674	Thunkable	https://jobs.lever.co/thunkable/	jobs.lever.co	2023-11-22 14:11:23.766589
675	FutureFit AI	https://jobs.ashbyhq.com/futurefitai/	jobs.ashbyhq.com	2023-11-22 14:11:23.766681
676	Happeo	https://jobs.ashbyhq.com/happeo/	jobs.ashbyhq.com	2023-11-22 14:11:23.766786
677	Coolset	https://www.linkedin.com/company/coolset/jobs/	linkedin.com	2023-11-22 14:11:23.766876
678	TicketNetwork	https://corporate.ticketnetwork.com/careers/index.aspx	corporate.ticketnetwork.com	2023-11-22 14:11:23.766962
679	eBay	https://www.linkedin.com/company/ebay/jobs/	linkedin.com	2023-11-22 14:11:23.767047
680	MelodyArc	https://melodyarc.breezy.hr/	melodyarc.breezy.hr	2023-11-22 14:11:23.767134
681	Pontosense	https://jobs.ashbyhq.com/Pontosense	jobs.ashbyhq.com	2023-11-22 14:11:23.767491
682	Supermetrics	https://careers.supermetrics.com/	careers.supermetrics.com	2023-11-22 14:11:23.76758
683	AT&T	https://www.linkedin.com/company/att/jobs/	linkedin.com	2023-11-22 14:11:23.767688
684	Pointer	https://jobs.pointerstrategy.com.au/	jobs.pointerstrategy.com.au	2023-11-22 14:11:23.767794
685	Budderfly	https://www.budderfly.com/careers/	budderfly.com	2023-11-22 14:11:23.767899
686	Block Renovation	https://boards.greenhouse.io/blockrenovation/	boards.greenhouse.io	2023-11-22 14:11:23.767987
687	BetterUp	https://www.betterup.com/about-us/careers	betterup.com	2023-11-22 14:11:23.768093
688	HME	https://www.hme.com/careers/	hme.com	2023-11-22 14:11:23.768188
689	VETRO  Inc.	https://vetro-fibermap-inc.breezy.hr	vetro-fibermap-inc.breezy.hr	2023-11-22 14:11:23.768306
690	Hopebridge	https://www.linkedin.com/company/hopebridge-autism-therapy-centers/jobs/	linkedin.com	2023-11-22 14:11:23.768403
691	Torus	https://www.linkedin.com/company/torusrev/jobs/	linkedin.com	2023-11-22 14:11:23.768499
692	Sayva Solutions	https://sayvasolutions.com/search-open-positions/	sayvasolutions.com	2023-11-22 14:11:23.768614
693	DoubleVerify	https://doubleverify.com/careers/current-openings/	doubleverify.com	2023-11-22 14:11:23.76872
694	Acerta	https://acerta.bamboohr.com/jobs/	acerta.bamboohr.com	2023-11-22 14:11:23.768835
695	Technical Toolboxes	https://technicaltoolboxes.com/careers/	technicaltoolboxes.com	2023-11-22 14:11:23.768933
696	Soundstripe	https://app.soundstripe.com/careers	app.soundstripe.com	2023-11-22 14:11:23.769043
697	McKesson	https://www.linkedin.com/company/mckesson/jobs/	linkedin.com	2023-11-22 14:11:23.769136
698	Trolley	https://jobs.lever.co/trolley	jobs.lever.co	2023-11-22 14:11:23.769234
699	Veeam Software	https://www.linkedin.com/company/veeam-software/jobs/	linkedin.com	2023-11-22 14:11:23.769329
700	Golioth	https://golioth.rippling-ats.com	golioth.rippling-ats.com	2023-11-22 14:11:23.769422
701	Vation Ventures	https://www.vationventures.com/careers	vationventures.com	2023-11-22 14:11:23.76952
702	Fast Enterprises  LLC	https://www.linkedin.com/company/fast-enterprises/jobs/	linkedin.com	2023-11-22 14:11:23.769608
703	Matterport	https://jobs.lever.co/matterport/	jobs.lever.co	2023-11-22 14:11:23.769747
704	Sift	https://sift.com/careers	sift.com	2023-11-22 14:11:23.769822
705	SEON Fraud Fighters	https://seon.io/careers/	seon.io	2023-11-22 14:11:23.769908
706	ProjectDiscovery.io	https://boards.greenhouse.io/projectdiscoveryinc	boards.greenhouse.io	2023-11-22 14:11:23.769987
707	Cepton	https://jobs.lever.co/cepton/	jobs.lever.co	2023-11-22 14:11:23.770225
708	ReminderMedia	http://careers.remindermedia.com/	careers.remindermedia.com	2023-11-22 14:11:23.770299
709	Stryker	https://www.linkedin.com/company/stryker/jobs/	linkedin.com	2023-11-22 14:11:23.770374
710	Benchling	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.770447
711	Litmos	https://www.litmos.com/company/careers	litmos.com	2023-11-22 14:11:23.770518
712	Loop	https://jobs.lever.co/loopreturns	jobs.lever.co	2023-11-22 14:11:23.770611
713	Bazaarvoice	https://jobs.lever.co/bazaarvoice/	jobs.lever.co	2023-11-22 14:11:23.770687
714	FundApps	https://jobs.lever.co/fundapps/	jobs.lever.co	2023-11-22 14:11:23.770759
715	Match2one - part of Verve Group	https://www.match2one.com/careers/	match2one.com	2023-11-22 14:11:23.770845
716	Homebase	https://boards.greenhouse.io/homebase/	boards.greenhouse.io	2023-11-22 14:11:23.770917
717	Vantage	https://jobs.ashbyhq.com/vantage/	jobs.ashbyhq.com	2023-11-22 14:11:23.770989
718	Naologic	https://naologic.com/careers/jobs	naologic.com	2023-11-22 14:11:23.77108
719	parcelLab	https://jobs.lever.co/parcellab/	jobs.lever.co	2023-11-22 14:11:23.77116
720	Curvature	https://www.curvature.com/about-us/careers/	curvature.com	2023-11-22 14:11:23.771241
721	Sonatype	https://jobs.lever.co/sonatype/	jobs.lever.co	2023-11-22 14:11:23.771334
722	ZoomInfo	https://www.zoominfo.com/about/careers	zoominfo.com	2023-11-22 14:11:23.771424
723	Echo Global Logistics	https://www.linkedin.com/company/echo-global-logistics/jobs/	linkedin.com	2023-11-22 14:11:23.771501
724	Upland Software	https://jobs.jobvite.com/upland-software	jobs.jobvite.com	2023-11-22 14:11:23.771577
725	Property Meld	https://property-meld.breezy.hr	property-meld.breezy.hr	2023-11-22 14:11:23.771656
726	HighRadius	https://www.highradius.com/about/careers/	highradius.com	2023-11-22 14:11:23.771744
727	Softchoice	https://www.linkedin.com/company/softchoice/jobs/	linkedin.com	2023-11-22 14:11:23.771818
799	Centric Software	https://www.centricsoftware.com/careers/	centricsoftware.com	2023-11-22 14:11:23.778718
728	Arhaus	https://recruiting.ultipro.com/ARH1000ARH/JobBoard/e5051b40-e91f-fa81-f0bf-ed2e9361f690/?q=&o=postedDateDesc&w=&wc=&we=&wpst=	recruiting.ultipro.com	2023-11-22 14:11:23.771923
729	Agiloft	https://jobs.lever.co/agiloft/	jobs.lever.co	2023-11-22 14:11:23.772052
730	Premise	https://www.premise.com/careers/	premise.com	2023-11-22 14:11:23.772153
731	Askable	https://www.askable.com/company/jobs	askable.com	2023-11-22 14:11:23.77226
732	iCapital	https://boards.greenhouse.io/icapitalnetwork	boards.greenhouse.io	2023-11-22 14:11:23.772347
733	Prezi	https://prezi.com/jobs/	prezi.com	2023-11-22 14:11:23.772451
734	Extend	https://www.linkedin.com/company/paywithextend/jobs/	linkedin.com	2023-11-22 14:11:23.772535
735	Coupa Software	https://www.linkedin.com/company/coupa-software/jobs/	linkedin.com	2023-11-22 14:11:23.772618
736	Justworks	https://www.justworks.com/careers	justworks.com	2023-11-22 14:11:23.772719
737	Community Brands	https://www.linkedin.com/company/communitybrands/jobs/	linkedin.com	2023-11-22 14:11:23.772802
738	Sigma Computing	https://www.sigmacomputing.com/careers	sigmacomputing.com	2023-11-22 14:11:23.772892
739	Yahoo	https://www.linkedin.com/company/yahoo/jobs/	linkedin.com	2023-11-22 14:11:23.772968
740	Seqera	https://seqera.io/careers/	seqera.io	2023-11-22 14:11:23.773042
741	Stinger	https://www.linkedin.com/company/stinger-solutions/jobs/	linkedin.com	2023-11-22 14:11:23.773122
742	Bloomberg News	https://www.linkedin.com/company/bloomberg-news/jobs/	linkedin.com	2023-11-22 14:11:23.77321
743	Passport	https://jobs.lever.co/passportshipping	jobs.lever.co	2023-11-22 14:11:23.773296
744	ForgeRock	https://www.forgerock.com/about-us/careers	forgerock.com	2023-11-22 14:11:23.773382
745	SumUp	https://www.sumup.com/careers/positions/	sumup.com	2023-11-22 14:11:23.773466
746	Flipp	https://corp.flipp.com/job-openings/	corp.flipp.com	2023-11-22 14:11:23.77355
747	Carrus	https://us63.dayforcehcm.com/CandidatePortal/en-US/pennfostercarrus/SITE/PFCCareerSite	us63.dayforcehcm.com	2023-11-22 14:11:23.773636
748	CaliberMind	https://calibermind.com/about/careers/	calibermind.com	2023-11-22 14:11:23.773738
749	Vertex Inc.	https://www.linkedin.com/company/vertex-inc./jobs/	linkedin.com	2023-11-22 14:11:23.773854
750	Trust Machines	https://trustmachines.co/careers/	trustmachines.co	2023-11-22 14:11:23.773941
751	Grindr	https://boards.greenhouse.io/grindr/	boards.greenhouse.io	2023-11-22 14:11:23.774051
752	Atlas	https://www.atlashxm.com/careers	atlashxm.com	2023-11-22 14:11:23.774309
753	Luminate	https://luminatedata.com/careers/	luminatedata.com	2023-11-22 14:11:23.77439
754	Midwest Family Marketing	https://www.midwestfamilymadison.com/careers/	midwestfamilymadison.com	2023-11-22 14:11:23.774481
755	Traba	https://jobs.lever.co/Traba	jobs.lever.co	2023-11-22 14:11:23.774579
756	Reaktor	https://www.reaktor.com/careers	reaktor.com	2023-11-22 14:11:23.774669
757	Mural	https://boards.greenhouse.io/mural/	boards.greenhouse.io	2023-11-22 14:11:23.774752
758	Microchip Technology Inc.	https://www.linkedin.com/company/microchip-technology/jobs/	linkedin.com	2023-11-22 14:11:23.774835
759	WalkMe™	https://www.linkedin.com/company/walkme/jobs/	linkedin.com	2023-11-22 14:11:23.774917
760	kimkim	https://www.kimkim.com/careers	kimkim.com	2023-11-22 14:11:23.77499
761	Premier Technology Advisors	https://www.procureit.com/careers	procureit.com	2023-11-22 14:11:23.775063
762	Abnormal Security	https://careers.abnormalsecurity.com/open-roles	careers.abnormalsecurity.com	2023-11-22 14:11:23.775142
763	GitKraken	https://www.gitkraken.com/careers	gitkraken.com	2023-11-22 14:11:23.775299
764	Groove  a Clari Company	https://jobs.lever.co/grooveapp	jobs.lever.co	2023-11-22 14:11:23.775373
765	JABU	https://www.linkedin.com/company/jabu/jobs/	linkedin.com	2023-11-22 14:11:23.775446
766	Straker	https://strakertranslations.bamboohr.com/careers	strakertranslations.bamboohr.com	2023-11-22 14:11:23.775528
767	Kforce Inc	https://www.linkedin.com/company/kforce/jobs/	linkedin.com	2023-11-22 14:11:23.775629
768	Seenons	https://jobs.seenons.com/	jobs.seenons.com	2023-11-22 14:11:23.775707
769	Motive	https://www.linkedin.com/company/motive-inc/jobs/	linkedin.com	2023-11-22 14:11:23.775805
770	Loopio	https://jobs.lever.co/loopio	jobs.lever.co	2023-11-22 14:11:23.775913
771	Rapid7	https://careers.rapid7.com/jobs/search	careers.rapid7.com	2023-11-22 14:11:23.776003
772	Analog Devices	https://www.linkedin.com/company/analog-devices/jobs/	linkedin.com	2023-11-22 14:11:23.776093
773	Secureframe	https://jobs.lever.co/secureframe/	jobs.lever.co	2023-11-22 14:11:23.77618
774	Freddie Mac	https://www.linkedin.com/company/freddie-mac/jobs/	linkedin.com	2023-11-22 14:11:23.776285
775	Swan	https://www.welcometothejungle.com/en/companies/swan/jobs	welcometothejungle.com	2023-11-22 14:11:23.776455
776	ClassDojo	https://www.classdojo.com/jobs/	classdojo.com	2023-11-22 14:11:23.776545
777	Flexcar	https://careers.flexcar.com/	careers.flexcar.com	2023-11-22 14:11:23.776638
778	AppFolio  Inc.	https://www.appfolio.com/open-roles	appfolio.com	2023-11-22 14:11:23.776748
779	Immutable	https://jobs.lever.co/immutable/	jobs.lever.co	2023-11-22 14:11:23.776839
780	Trakstar  part of Mitratech	https://www.trakstar.com/jobs/	trakstar.com	2023-11-22 14:11:23.776928
781	JPMorgan Chase & Co.	https://www.linkedin.com/company/jpmorganchase/jobs/	linkedin.com	2023-11-22 14:11:23.777025
782	Enverus	https://jobs.jobvite.com/drillinginfo	jobs.jobvite.com	2023-11-22 14:11:23.777129
783	Sounder	https://jobs.lever.co/sounder/	jobs.lever.co	2023-11-22 14:11:23.777218
784	EcoVadis	https://careers.smartrecruiters.com/ecovadis	careers.smartrecruiters.com	2023-11-22 14:11:23.77731
785	Funnel	https://jobs.funnel.io/	jobs.funnel.io	2023-11-22 14:11:23.777414
786	doxo	https://www.doxo.com/about/careers/	doxo.com	2023-11-22 14:11:23.777488
787	LinkedIn	https://www.linkedin.com/jobs?trk=homepage-basic_directory_jobsHomeUrl	linkedin.com	2023-11-22 14:11:23.777575
788	OneSignal	https://www.linkedin.com/company/onesignal/jobs/	linkedin.com	2023-11-22 14:11:23.777667
789	Mutiny	https://boards.greenhouse.io/mutiny/	boards.greenhouse.io	2023-11-22 14:11:23.777746
790	Regal.io	https://jobs.lever.co/regalvoice	jobs.lever.co	2023-11-22 14:11:23.777839
791	HubSpot	https://www.hubspot.com/careers/jobs?hubs_signup-cta=careers-nav-cta&hubs_content=www.hubspot.com%2F&hubs_content-cta=Careers	hubspot.com	2023-11-22 14:11:23.777931
792	ICIS	https://relx.wd3.myworkdayjobs.com/RiskSolutions	relx.wd3.myworkdayjobs.com	2023-11-22 14:11:23.778023
793	ByteDance	https://www.linkedin.com/company/bytedance/jobs/	linkedin.com	2023-11-22 14:11:23.778098
794	Lumavate	https://www.lumavate.com/company/careers	lumavate.com	2023-11-22 14:11:23.778335
795	YCharts	https://recruiting.paylocity.com/recruiting/jobs/All/78419728-0f20-46ce-8f93-12ae28d00481/YCHARTS-INC	recruiting.paylocity.com	2023-11-22 14:11:23.778417
796	Aquatic Capital Management	https://boards.greenhouse.io/aquaticcapitalmanagement/	boards.greenhouse.io	2023-11-22 14:11:23.778491
797	Flowcode	https://boards.greenhouse.io/flowcode	boards.greenhouse.io	2023-11-22 14:11:23.778567
798	DuckDuckGo	https://duckduckgo.recruitee.com	duckduckgo.recruitee.com	2023-11-22 14:11:23.778642
800	Busuu	https://www.linkedin.com/company/busuu-com/jobs/	linkedin.com	2023-11-22 14:11:23.778814
801	EvolutionIQ	https://evolutioniq.com/careers/	evolutioniq.com	2023-11-22 14:11:23.778902
802	Rootstock Software	https://rootstock-software.breezy.hr	rootstock-software.breezy.hr	2023-11-22 14:11:23.778992
803	Infostrux Solutions	https://www.infostrux.com/careers	infostrux.com	2023-11-22 14:11:23.779086
804	Plooto	https://www.plooto.com/cs/c/?cta_guid=87a7a048-734d-4a33-91a9-4d43f2abd939&signature=AAH58kEA--gj6jNhP57y9W7AO_nxCTkHjQ&pageId=41062483586&placement_guid=4b2f0676-b87d-4e57-97d9-7eab49620d62&click=f6f98c9b-12fb-408d-859b-100a9e237f3f&hsutk=bbf4471d73fc2beb0bd7bd3d91d1e890&canon=https%3A%2F%2Fwww.plooto.com%2Fplooto-careers&portal_id=7379058&redirect_url=APefjpHnXgeOQz9SXzeU8gta2_l65vg-JIGCGUOFG04k-xZFZaMNYWvvXJi_iKaiMLVWApQskdYO4MYRa9TqBTjQnDJAPOEG2F5_VfYIb9eNzBCzoi04K2j79A-o_uwebtiawP_kK244p-DPXgfyeQne_FAtuVRX2sLD34RHGifGlvJ81bX4UbL9acBT9Y1qCvjPbVgdY_6f&__hstc=235273246.bbf4471d73fc2beb0bd7bd3d91d1e890.1700075780786.1700075780786.1700075780786.1&__hssc=235273246.1.1700075780787&__hsfp=2764680836&contentType=standard-page	plooto.com	2023-11-22 14:11:23.779168
805	Demand Chain	https://www.demandchain.com/careers/	demandchain.com	2023-11-22 14:11:23.779267
806	Rose Rocket	https://jobs.ashbyhq.com/rose%20rocket	jobs.ashbyhq.com	2023-11-22 14:11:23.779342
807	X  the moonshot factory	https://www.linkedin.com/company/x/jobs/	linkedin.com	2023-11-22 14:11:23.779435
808	Entegee	https://www.entegee.com/engineering-jobs/	entegee.com	2023-11-22 14:11:23.779509
809	BECU	https://www.linkedin.com/company/becu/jobs/	linkedin.com	2023-11-22 14:11:23.779584
810	Tailored Brands  Inc.	https://www.linkedin.com/company/tailored-brands-inc-/jobs/	linkedin.com	2023-11-22 14:11:23.779658
811	Klara	https://www.klara.com/careers/jobs	klara.com	2023-11-22 14:11:23.779732
812	Salem Media Group	https://www.linkedin.com/company/salemmediagroup/jobs/	linkedin.com	2023-11-22 14:11:23.779807
813	ISC2	https://www.linkedin.com/company/isc2/jobs/	linkedin.com	2023-11-22 14:11:23.779895
814	Fusion Worldwide	https://fusionww.com/careers	fusionww.com	2023-11-22 14:11:23.77999
815	Via	https://www.linkedin.com/company/ridewithvia/jobs/	linkedin.com	2023-11-22 14:11:23.78009
816	CleanSlate Technology Group	https://www.cleanslatetg.com/who-we-are/careers/	cleanslatetg.com	2023-11-22 14:11:23.780189
817	Sprout Social  Inc.	https://sproutsocial.com/careers/open-positions/	sproutsocial.com	2023-11-22 14:11:23.780265
818	Boats Group	https://www.boatsgroup.com/careers/	boatsgroup.com	2023-11-22 14:11:23.780369
819	Northbeam	https://www.northbeam.io/partner-program	northbeam.io	2023-11-22 14:11:23.780445
820	Boozt	https://careers.booztgroup.com/	careers.booztgroup.com	2023-11-22 14:11:23.780539
821	ROLLER	https://www.roller.software/people-and-culture/careers-jobs/	roller.software	2023-11-22 14:11:23.780635
822	project44	https://boards.greenhouse.io/project44	boards.greenhouse.io	2023-11-22 14:11:23.780716
823	Zello	https://zello.com/careers/	zello.com	2023-11-22 14:11:23.780809
824	Leankor	https://www.leankor.com/careers/	leankor.com	2023-11-22 14:11:23.78089
825	Cube	https://jobs.ashbyhq.com/cubesoftware	jobs.ashbyhq.com	2023-11-22 14:11:23.780997
826	Intrepid Studios  Inc	https://intrepidstudios.applytojob.com	intrepidstudios.applytojob.com	2023-11-22 14:11:23.781105
827	Logikcull | a reveal technology	https://jobs.lever.co/logikcull/	jobs.lever.co	2023-11-22 14:11:23.781213
828	Nodes & Links	https://jobs.lever.co/nodeslinks	jobs.lever.co	2023-11-22 14:11:23.781321
829	VELOX Media	https://www.linkedin.com/company/velox-media/jobs/	linkedin.com	2023-11-22 14:11:23.78141
830	Thirty Capital	https://www.thirtycapital.com/careers/	thirtycapital.com	2023-11-22 14:11:23.781496
831	BetterCloud	https://www.bettercloud.com/job-board/	bettercloud.com	2023-11-22 14:11:23.781596
832	Tegus	https://jobs.lever.co/tegus	jobs.lever.co	2023-11-22 14:11:23.781708
833	VRChat Inc.	https://jobs.lever.co/vrchat	jobs.lever.co	2023-11-22 14:11:23.781802
834	nth Venture	https://www.nthventure.com/careers	nthventure.com	2023-11-22 14:11:23.781909
835	Porch Group	https://porchgroup.com/careers	porchgroup.com	2023-11-22 14:11:23.782017
836	Rippling	https://www.rippling.com/careers/open-roles	rippling.com	2023-11-22 14:11:23.782128
837	Traction Rec	https://www.tractionrec.com/careers	tractionrec.com	2023-11-22 14:11:23.782372
838	Paxos	https://paxos.com/careers/	paxos.com	2023-11-22 14:11:23.782474
839	WorkTango Inc.	https://www.worktango.com/careers#open-roles	worktango.com	2023-11-22 14:11:23.782559
840	runZero	https://www.runzero.com/careers/	runzero.com	2023-11-22 14:11:23.782644
841	Opentrons Labworks Inc.	https://jobs.jobvite.com/opentrons	jobs.jobvite.com	2023-11-22 14:11:23.782732
842	Cordial	https://cordial.com/careers	cordial.com	2023-11-22 14:11:23.782822
843	Plate IQ	https://www.linkedin.com/company/plateiq/jobs/	linkedin.com	2023-11-22 14:11:23.782926
844	ResQ	https://jobs.ashbyhq.com/resq	jobs.ashbyhq.com	2023-11-22 14:11:23.783015
845	OpenGov Inc.	https://jobs.lever.co/opengov	jobs.lever.co	2023-11-22 14:11:23.783122
846	Sprinklr	https://www.linkedin.com/company/sprinklr/jobs/	linkedin.com	2023-11-22 14:11:23.783206
847	Plative	https://www.linkedin.com/company/plative/jobs/	linkedin.com	2023-11-22 14:11:23.783314
848	Anvil	https://www.useanvil.com/careers/	useanvil.com	2023-11-22 14:11:23.783423
849	ApplicantPro	https://www.applicantpro.com/openings/iapplicants/jobs	applicantpro.com	2023-11-22 14:11:23.78351
850	Social Factor	https://www.linkedin.com/company/social-factor/jobs/	linkedin.com	2023-11-22 14:11:23.783618
851	Design Interactive  Inc.	https://recruiting.paylocity.com/recruiting/jobs/All/7e700d27-1c17-4273-9855-c424190be932/Design-Interactive-Inc	recruiting.paylocity.com	2023-11-22 14:11:23.78373
852	Netskope	https://www.netskope.com/company/careers/open-positions	netskope.com	2023-11-22 14:11:23.78382
853	PerkSpot	https://perkspot12.applytojob.com	perkspot12.applytojob.com	2023-11-22 14:11:23.783909
854	Coconut Software	https://www.coconutsoftware.com/careers/	coconutsoftware.com	2023-11-22 14:11:23.784017
855	Losant	https://www.losant.com/careers	losant.com	2023-11-22 14:11:23.784105
856	Pigment	https://jobs.lever.co/pigment/	jobs.lever.co	2023-11-22 14:11:23.784213
857	HSTK (Haystack)	https://hstk.breezy.hr	hstk.breezy.hr	2023-11-22 14:11:23.784319
858	Cambridge Systematics  Inc.	https://camsys.com/careers-and-culture	camsys.com	2023-11-22 14:11:23.784436
859	Donut	https://jobs.lever.co/donut	jobs.lever.co	2023-11-22 14:11:23.784542
860	Clockwork	https://www.clockwork.com/careers/	clockwork.com	2023-11-22 14:11:23.784639
861	Vetster Inc.	https://angel.co/company/vetster	angel.co	2023-11-22 14:11:23.784747
862	Eco	https://www.linkedin.com/company/eco-pay/jobs/	linkedin.com	2023-11-22 14:11:23.784858
863	Propagate	https://www.linkedin.com/company/propagateag/jobs/	linkedin.com	2023-11-22 14:11:23.784951
864	SpryPoint	https://www.sprypoint.com/pages/careers/why-sprypoint/	sprypoint.com	2023-11-22 14:11:23.78504
865	Smaato (Now part of Verve Group)	https://vervegroup.recruitee.com	vervegroup.recruitee.com	2023-11-22 14:11:23.785157
866	TALSMART	https://www.talsmart.com/jobs	talsmart.com	2023-11-22 14:11:23.785247
867	Adverity	https://www.adverity.com/careers	adverity.com	2023-11-22 14:11:23.785358
868	Liberty Mutual Insurance	https://www.linkedin.com/company/liberty-mutual-insurance/jobs/	linkedin.com	2023-11-22 14:11:23.785483
869	athenahealth	https://www.linkedin.com/company/athenahealth/jobs/	linkedin.com	2023-11-22 14:11:23.785602
870	Cambly Inc.	https://www.linkedin.com/company/cambly/jobs/	linkedin.com	2023-11-22 14:11:23.785715
871	Konica Minolta Sensing Americas  Inc.	https://careers.konicaminoltaus.com/	careers.konicaminoltaus.com	2023-11-22 14:11:23.785833
872	1-800Accountant	https://1800accountant.teamtailor.com/	1800accountant.teamtailor.com	2023-11-22 14:11:23.785926
873	AIM Consulting Group	https://aimconsulting.com/careers	aimconsulting.com	2023-11-22 14:11:23.786026
874	Adobe	https://www.linkedin.com/company/adobe/jobs/	linkedin.com	2023-11-22 14:11:23.786111
875	JLL	https://www.linkedin.com/company/jll/jobs/	linkedin.com	2023-11-22 14:11:23.786195
876	Outreach	https://jobs.lever.co/outreach/	jobs.lever.co	2023-11-22 14:11:23.786295
877	Houzz	https://www.linkedin.com/company/houzz/jobs/	linkedin.com	2023-11-22 14:11:23.78638
878	Pixability	https://boards.greenhouse.io/pixability#.WCJZjuFrjBI	boards.greenhouse.io	2023-11-22 14:11:23.786498
879	Hyperproof	https://hyperproof.io/working-at-hyperproof/	hyperproof.io	2023-11-22 14:11:23.786599
880	The New York Times	https://www.linkedin.com/company/the-new-york-times/jobs/	linkedin.com	2023-11-22 14:11:23.786679
881	GetYourGuide	https://careers.getyourguide.com/	careers.getyourguide.com	2023-11-22 14:11:23.786918
882	AbbVie	https://www.linkedin.com/company/abbvie/jobs/	linkedin.com	2023-11-22 14:11:23.787
883	Commure	https://www.commure.com/careers/	commure.com	2023-11-22 14:11:23.787082
884	Procore Technologies	https://www.linkedin.com/company/procore-technologies/jobs/	linkedin.com	2023-11-22 14:11:23.787185
885	Chronosphere	https://boards.greenhouse.io/chronosphere/	boards.greenhouse.io	2023-11-22 14:11:23.787267
886	Parcel Perform	https://parcelperform.freshteam.com/jobs/	parcelperform.freshteam.com	2023-11-22 14:11:23.787349
887	FinancialForce	https://certinia.com/about/careers/	certinia.com	2023-11-22 14:11:23.787448
888	SafeLease	https://jobs.lever.co/SafeLease	jobs.lever.co	2023-11-22 14:11:23.787532
889	SOCi  Inc.	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.78763
890	Yokoy	https://jobs.eu.lever.co/yokoy	jobs.eu.lever.co	2023-11-22 14:11:23.787728
891	Toast	https://careers.toasttab.com/jobs/search	careers.toasttab.com	2023-11-22 14:11:23.787819
892	Vicasso | We Accelerate Service	https://www.vicasso.com/company/careers	vicasso.com	2023-11-22 14:11:23.787917
893	Deloitte	https://www.linkedin.com/company/deloitte/jobs/	linkedin.com	2023-11-22 14:11:23.788002
894	Information Security Media Group (ISMG)	https://ismg.careers/careers	ismg.careers	2023-11-22 14:11:23.788102
895	SmartRecruiters	https://jobs.smartrecruiters.com/	jobs.smartrecruiters.com	2023-11-22 14:11:23.788202
896	Close	https://jobs.lever.co/close.io	jobs.lever.co	2023-11-22 14:11:23.788304
897	Forward	https://jobs.lever.co/goforward	jobs.lever.co	2023-11-22 14:11:23.788406
898	Aurora Solar	https://aurorasolar.com/careers/	aurorasolar.com	2023-11-22 14:11:23.788489
899	GROPYUS	https://boards.eu.greenhouse.io/gropyus	boards.eu.greenhouse.io	2023-11-22 14:11:23.788573
900	Broad Institute of MIT and Harvard	https://www.linkedin.com/company/broad-institute_2/jobs/	linkedin.com	2023-11-22 14:11:23.788712
901	NeuraFlash	https://www.neuraflash.com/join-our-team/jobs	neuraflash.com	2023-11-22 14:11:23.788815
902	Bluevine	https://www.bluevine.com/careers	bluevine.com	2023-11-22 14:11:23.788899
903	Tailscale	https://tailscale.com/careers/	tailscale.com	2023-11-22 14:11:23.788982
904	Bloomreach	https://www.linkedin.com/company/bloomreach/jobs/	linkedin.com	2023-11-22 14:11:23.789082
905	AutoLeap	https://autoleap.com/applynow/	autoleap.com	2023-11-22 14:11:23.789162
906	Acquia	https://www.linkedin.com/company/acquia/jobs/	linkedin.com	2023-11-22 14:11:23.789256
907	BMNT	https://boards.greenhouse.io/bmnt	boards.greenhouse.io	2023-11-22 14:11:23.789346
908	Ad Hoc LLC	https://adhoc.team/join/jobs/	adhoc.team	2023-11-22 14:11:23.789444
909	Expedia Group	https://expediagroup.com/careers/default.aspx	expediagroup.com	2023-11-22 14:11:23.789541
910	The Believer Company	https://believer.gg/jobs	believer.gg	2023-11-22 14:11:23.789623
911	Lightico	https://www.lightico.com/careers/	lightico.com	2023-11-22 14:11:23.789703
912	Profisee	https://profisee.com/job-openings/	profisee.com	2023-11-22 14:11:23.789793
913	Sysdig	https://boards.greenhouse.io/sysdig/	boards.greenhouse.io	2023-11-22 14:11:23.789877
914	Ontra	https://www.ontra.ai/careers/	ontra.ai	2023-11-22 14:11:23.78996
915	ecobee	https://www.ecobee.com/en-us/careers/job-board/	ecobee.com	2023-11-22 14:11:23.790043
916	Leapfin	https://www.leapfin.com/careers/	leapfin.com	2023-11-22 14:11:23.790123
917	Apptega	https://www.apptega.com/careers/	apptega.com	2023-11-22 14:11:23.790204
918	Hawk Ridge Systems	https://hawkridgesys.com/careers	hawkridgesys.com	2023-11-22 14:11:23.790287
919	VertiGIS	https://vertigis.recruitee.com/	vertigis.recruitee.com	2023-11-22 14:11:23.790383
920	Scratch Financial	https://jobs.lever.co/scratchfinancial/	jobs.lever.co	2023-11-22 14:11:23.790491
921	JumpCloud	https://jobs.lever.co/jumpcloud/	jobs.lever.co	2023-11-22 14:11:23.790587
922	Aspire	https://www.linkedin.com/company/aspireio/jobs/	linkedin.com	2023-11-22 14:11:23.790681
923	MarketStar Bulgaria	https://wasatchproperty.wd1.myworkdayjobs.com/MarketStarCareers	wasatchproperty.wd1.myworkdayjobs.com	2023-11-22 14:11:23.790775
924	Palantir Technologies	https://jobs.lever.co/palantir	jobs.lever.co	2023-11-22 14:11:23.790893
925	CVS Health	https://www.linkedin.com/company/cvshealth/jobs/	linkedin.com	2023-11-22 14:11:23.790973
926	JLL Technologies	https://www.linkedin.com/company/jlltechnologies/jobs/	linkedin.com	2023-11-22 14:11:23.791186
927	Apollo Interactive	https://www.apollointeractive.com/careers/index.php	apollointeractive.com	2023-11-22 14:11:23.791273
928	Applecart	https://www.applecart.co/careers	applecart.co	2023-11-22 14:11:23.791362
929	Prokeep	https://prokeep-llc.rippling-ats.com	prokeep-llc.rippling-ats.com	2023-11-22 14:11:23.791436
930	Torch Dental	https://jobs.lever.co/torchdental	jobs.lever.co	2023-11-22 14:11:23.791522
931	Tide	https://www.linkedin.com/company/autodesk/jobs/	linkedin.com	2023-11-22 14:11:23.791599
932	Hotjar	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.79167
933	Freestar	https://freestar.com/careers/	freestar.com	2023-11-22 14:11:23.79175
934	RLDatix	https://www.linkedin.com/company/rldatix/jobs/	linkedin.com	2023-11-22 14:11:23.791821
935	Visier Inc.	https://boards.greenhouse.io/visiersolutionsinc	boards.greenhouse.io	2023-11-22 14:11:23.791891
936	Montoux	https://www.montoux.com/careers	montoux.com	2023-11-22 14:11:23.791975
937	Mindex	https://www.mindex.com/jobs	mindex.com	2023-11-22 14:11:23.792046
938	Coveo	https://www.coveo.com/en/company/careers	coveo.com	2023-11-22 14:11:23.792128
939	Plante Moran	https://www.linkedin.com/company/plante-moran/jobs/	linkedin.com	2023-11-22 14:11:23.792227
940	Xembly	https://www.xembly.com/jobs	xembly.com	2023-11-22 14:11:23.792307
941	Asana	https://asana.com/jobs/all	asana.com	2023-11-22 14:11:23.792392
942	Coherent	https://coherent.bamboohr.com/jobs	coherent.bamboohr.com	2023-11-22 14:11:23.792477
943	Stackline	https://boards.greenhouse.io/stackline	boards.greenhouse.io	2023-11-22 14:11:23.792548
944	ASCENDING Inc.	https://www.linkedin.com/company/ascendingllc/jobs/	linkedin.com	2023-11-22 14:11:23.792624
945	Walmart Connect	https://careers.walmart.com/results?q=Walmart%20Connect&page=1&sort=rank&expand=department,brand,type,rate&jobCareerArea=all	careers.walmart.com	2023-11-22 14:11:23.792711
946	Canary Technologies	https://jobs.lever.co/canarytechnologies/	jobs.lever.co	2023-11-22 14:11:23.79279
947	Flying Cat Marketing	https://flyingcatmarketing.com/careers/	flyingcatmarketing.com	2023-11-22 14:11:23.792875
948	Thankful	https://www.gladly.com/careers/	gladly.com	2023-11-22 14:11:23.792949
949	Covariant	https://jobs.lever.co/covariant	jobs.lever.co	2023-11-22 14:11:23.793027
950	CaptivateIQ	https://jobs.lever.co/captivateiq/	jobs.lever.co	2023-11-22 14:11:23.793123
951	Groundswell Cloud Solutions	https://www.linkedin.com/company/groundswellcloudsolutions/jobs/	linkedin.com	2023-11-22 14:11:23.793232
952	Retool	https://retool.com/careers	retool.com	2023-11-22 14:11:23.793343
953	Esusu	https://esusurent.com/careers/	esusurent.com	2023-11-22 14:11:23.793457
954	Geoforce	https://jobs.ashbyhq.com/Geoforce	jobs.ashbyhq.com	2023-11-22 14:11:23.793555
955	Criteo	https://www.linkedin.com/company/criteo/jobs/	linkedin.com	2023-11-22 14:11:23.793666
956	Roblox	https://www.linkedin.com/company/roblox/jobs/	linkedin.com	2023-11-22 14:11:23.793759
957	BlackBerry	https://www.linkedin.com/company/blackberry/jobs/	linkedin.com	2023-11-22 14:11:23.793863
958	Trulioo	https://www.trulioo.com/apply	trulioo.com	2023-11-22 14:11:23.794
959	Kiteworks	https://kiteworks.bamboohr.com/jobs	kiteworks.bamboohr.com	2023-11-22 14:11:23.794093
960	Respondent	https://jobs.lever.co/respondent/	jobs.lever.co	2023-11-22 14:11:23.794193
961	Crossbeam	https://www.crossbeam.com/careers/	crossbeam.com	2023-11-22 14:11:23.794283
962	Podium	https://boards.greenhouse.io/podium81/	boards.greenhouse.io	2023-11-22 14:11:23.79436
963	AMAROK Security	https://www.linkedin.com/company/amarok-security/jobs/	linkedin.com	2023-11-22 14:11:23.794476
964	ComplYant	https://complyant.breezy.hr/	complyant.breezy.hr	2023-11-22 14:11:23.794588
965	Mindtickle	https://jobs.lever.co/mindtickle/	jobs.lever.co	2023-11-22 14:11:23.794714
966	Tech Talent & Strategy	https://boards.greenhouse.io/techtalentandstrategy	boards.greenhouse.io	2023-11-22 14:11:23.794816
967	RevPartners	https://www.linkedin.com/company/revpartners/jobs/	linkedin.com	2023-11-22 14:11:23.794936
968	Certn	https://certn.co/careers/	certn.co	2023-11-22 14:11:23.79504
969	Arcade	https://jobs.ashbyhq.com/arcade/	jobs.ashbyhq.com	2023-11-22 14:11:23.795149
970	LHH	https://jobs.jobvite.com/lhhcareers	jobs.jobvite.com	2023-11-22 14:11:23.795414
971	Workato	https://boards.greenhouse.io/workato	boards.greenhouse.io	2023-11-22 14:11:23.795505
972	Docker  Inc	https://www.docker.com/career-openings/	docker.com	2023-11-22 14:11:23.795606
973	Super Dispatch	https://superdispatch.breezy.hr/	superdispatch.breezy.hr	2023-11-22 14:11:23.795698
974	Jobber	https://boards.greenhouse.io/jobber/	boards.greenhouse.io	2023-11-22 14:11:23.79577
975	1Password	https://jobs.lever.co/1password	jobs.lever.co	2023-11-22 14:11:23.795854
976	Huron	https://www.linkedin.com/company/huronconsulting/jobs/	linkedin.com	2023-11-22 14:11:23.795938
977	Canva	https://jobs.lever.co/canva/	jobs.lever.co	2023-11-22 14:11:23.796011
978	Info-Tech Research Group	https://www.linkedin.com/company/info-tech-research-group/jobs/	linkedin.com	2023-11-22 14:11:23.796083
979	RxVantage	https://www.linkedin.com/company/rxvantage/jobs/	linkedin.com	2023-11-22 14:11:23.796157
980	AppOmni	https://appomni.com/about-us/careers/	appomni.com	2023-11-22 14:11:23.796231
981	SuperAnnotate	https://www.linkedin.com/company/superannotate/jobs/	linkedin.com	2023-11-22 14:11:23.796317
982	PandaDoc	https://www.pandadoc.com/careers/	pandadoc.com	2023-11-22 14:11:23.796391
983	Flock Safety	https://www.flocksafety.com/careers	flocksafety.com	2023-11-22 14:11:23.79646
984	Tellent (formerly Recruitee)	https://careers.tellent.com/open-positions	careers.tellent.com	2023-11-22 14:11:23.796633
985	BILL	https://www.bill.com/about-us/jobs	bill.com	2023-11-22 14:11:23.796734
986	Episode Six	https://www.linkedin.com/company/episode-six/jobs/	linkedin.com	2023-11-22 14:11:23.796821
987	Datavant	https://datavant.com/jobs	datavant.com	2023-11-22 14:11:23.796909
988	Behavioral Health Group - BHG	https://info.bhgrecovery.com/open-positions	info.bhgrecovery.com	2023-11-22 14:11:23.796995
989	CrowdStrike	https://www.linkedin.com/company/crowdstrike/jobs/	linkedin.com	2023-11-22 14:11:23.797069
990	TestBox	https://www.testbox.com/career	testbox.com	2023-11-22 14:11:23.797142
991	Cintas	https://www.linkedin.com/company/cintas/jobs/	linkedin.com	2023-11-22 14:11:23.79722
992	Candid Health	https://jobs.ashbyhq.com/candidhealth/	jobs.ashbyhq.com	2023-11-22 14:11:23.797316
993	FreightWaves	https://freightwavesinc.applytojob.com/apply	freightwavesinc.applytojob.com	2023-11-22 14:11:23.797426
994	e-Core	https://boards.greenhouse.io/ecore/	boards.greenhouse.io	2023-11-22 14:11:23.797611
995	Calendly	https://careers.calendly.com/jobs/	careers.calendly.com	2023-11-22 14:11:23.79779
996	Snagajob	https://www.snagajob.com/career	snagajob.com	2023-11-22 14:11:23.797907
997	Box	https://www.linkedin.com/company/box/jobs/	linkedin.com	2023-11-22 14:11:23.798112
998	PayNearMe	https://careers.smartrecruiters.com/PayNearMe	careers.smartrecruiters.com	2023-11-22 14:11:23.798244
999	nTop	https://boards.greenhouse.io/ntop	boards.greenhouse.io	2023-11-22 14:11:23.798344
1000	Billd	https://billd.com/careers/	billd.com	2023-11-22 14:11:23.798527
1001	Solv.	https://jobs.lever.co/solvhealth	jobs.lever.co	2023-11-22 14:11:23.798629
1002	WillowTree	https://www.linkedin.com/company/willowtree/jobs/	linkedin.com	2023-11-22 14:11:23.79872
1003	Varicent	https://jobs.lever.co/varicent	jobs.lever.co	2023-11-22 14:11:23.798819
1004	Smartcat	https://www.linkedin.com/company/smartcatai/jobs/	linkedin.com	2023-11-22 14:11:23.798911
1005	StarRez  Inc.	https://www.starrez.com/company/careers	starrez.com	2023-11-22 14:11:23.799033
1006	Synctera	https://synctera.com/careers	synctera.com	2023-11-22 14:11:23.799135
1007	DICK'S Sporting Goods	https://www.linkedin.com/company/dick%27s-sporting-goods/jobs/	linkedin.com	2023-11-22 14:11:23.799234
1008	Mila Cares	https://www.linkedin.com/company/milacares/jobs/	linkedin.com	2023-11-22 14:11:23.799326
1009	Insurity	https://jobs.jobvite.com/insurity/jobs/positions	jobs.jobvite.com	2023-11-22 14:11:23.799444
1010	Boldly Remote Staffing	https://www.linkedin.com/company/workboldly/jobs/	linkedin.com	2023-11-22 14:11:23.799562
1011	MongoDB	https://www.linkedin.com/company/mongodbinc/jobs/	linkedin.com	2023-11-22 14:11:23.799662
1012	GoLinks	https://www.golinks.io/careers_list.php	golinks.io	2023-11-22 14:11:23.79978
1013	Sunrun	https://www.linkedin.com/company/sunrun/jobs/	linkedin.com	2023-11-22 14:11:23.799924
1014	Tango	https://jobs.ashbyhq.com/tango/	jobs.ashbyhq.com	2023-11-22 14:11:23.800047
1015	Marqeta	https://www.marqeta.com/company/careers	marqeta.com	2023-11-22 14:11:23.800344
1016	Conduktor	https://www.linkedin.com/company/conduktor/jobs/	linkedin.com	2023-11-22 14:11:23.800436
1017	Black Kite	https://black-kite.rippling-ats.com	black-kite.rippling-ats.com	2023-11-22 14:11:23.800536
1018	Crowe	https://www.linkedin.com/company/crowe/jobs/	linkedin.com	2023-11-22 14:11:23.800638
1019	Placer.ai	https://www.placer.ai/company/we-are-hiring	placer.ai	2023-11-22 14:11:23.800741
1020	Yelp	https://www.linkedin.com/company/yelp-com/jobs/	linkedin.com	2023-11-22 14:11:23.80086
1021	Grammarly	https://www.grammarly.com/jobs/openings	grammarly.com	2023-11-22 14:11:23.800964
1022	AgentSync	https://agentsync.io/careers	agentsync.io	2023-11-22 14:11:23.801095
1023	Webflow	https://www.linkedin.com/company/webflow-inc-/jobs/	linkedin.com	2023-11-22 14:11:23.801203
1024	Workpath	https://boards.greenhouse.io/workpath/	boards.greenhouse.io	2023-11-22 14:11:23.801331
1025	MRE Consulting	https://mre-consulting.com/careers/	mre-consulting.com	2023-11-22 14:11:23.801444
1026	IntelyCare	https://www.linkedin.com/company/intelycare/jobs/	linkedin.com	2023-11-22 14:11:23.801569
1027	Bothrs	https://www.bothrs.com/careers	bothrs.com	2023-11-22 14:11:23.801712
1028	Upraised	https://upraised.freshteam.com/jobs/	upraised.freshteam.com	2023-11-22 14:11:23.80182
1029	LogicMonitor	https://www.logicmonitor.com/careers	logicmonitor.com	2023-11-22 14:11:23.801955
1030	GlobalLogic	https://www.linkedin.com/company/globallogic/jobs/	linkedin.com	2023-11-22 14:11:23.802094
1031	Relay Network	https://www.relaynetwork.com/company/careers/	relaynetwork.com	2023-11-22 14:11:23.80222
1032	ChannelEngine	https://jobs.channelengine.com/	jobs.channelengine.com	2023-11-22 14:11:23.802337
1033	Basis Technologies	https://jobs.lever.co/centro/	jobs.lever.co	2023-11-22 14:11:23.802466
1034	Biofire	https://www.linkedin.com/company/biofire/jobs/	linkedin.com	2023-11-22 14:11:23.80257
1035	Republic Services	https://www.linkedin.com/company/republic-services-inc/jobs/	linkedin.com	2023-11-22 14:11:23.802683
1036	Lightspeed Commerce	https://www.lightspeedhq.com/careers/openings/	lightspeedhq.com	2023-11-22 14:11:23.802798
1037	Tresata	https://tresata.ai/careers/	tresata.ai	2023-11-22 14:11:23.802928
1038	FICO	https://www.linkedin.com/company/fico/jobs/	linkedin.com	2023-11-22 14:11:23.803045
1039	Modern Treasury	https://jobs.ashbyhq.com/moderntreasury/	jobs.ashbyhq.com	2023-11-22 14:11:23.803183
1040	requires research	https://gohighlevel.com/careers	gohighlevel.com	2023-11-22 14:11:23.803308
1041	ASAPP	https://jobs.lever.co/asapp-2	jobs.lever.co	2023-11-22 14:11:23.803421
1042	Hillenbrand	https://hillenbrand.wd3.myworkdayjobs.com/Global	hillenbrand.wd3.myworkdayjobs.com	2023-11-22 14:11:23.803518
1043	Bitly	https://bitly.com/pages/careers	bitly.com	2023-11-22 14:11:23.803637
1044	Donnelley Financial Solutions (DFIN)	https://jobs.dfinsolutions.com/go/All-Current-Job-Opportunities/4347000/	jobs.dfinsolutions.com	2023-11-22 14:11:23.803745
1045	THRILLWORKS	https://jobs.lever.co/thrillworks	jobs.lever.co	2023-11-22 14:11:23.803864
1046	Autodesk	https://www.linkedin.com/company/autodesk/jobs/	linkedin.com	2023-11-22 14:11:23.803982
1047	Stout Systems	https://www.stoutsystems.com/job-search-michigan-and-beyond/	stoutsystems.com	2023-11-22 14:11:23.804161
1048	Relay	https://boards.greenhouse.io/relaypro	boards.greenhouse.io	2023-11-22 14:11:23.804295
1049	Clearco	https://clearco.breezy.hr/	clearco.breezy.hr	2023-11-22 14:11:23.804402
1050	Makersite	https://makersitegmbh.recruitee.com	makersitegmbh.recruitee.com	2023-11-22 14:11:23.804519
1051	MassMutual	https://www.linkedin.com/company/massmutual-financial-group/jobs/	linkedin.com	2023-11-22 14:11:23.804622
1052	Gorgias	https://www.gorgias.com/about-us/jobs	gorgias.com	2023-11-22 14:11:23.804737
1053	Allthenticate	https://www.allthenticate.com/careers	allthenticate.com	2023-11-22 14:11:23.804838
1054	Virtuous	https://jobs.ashbyhq.com/virtuous	jobs.ashbyhq.com	2023-11-22 14:11:23.804945
1055	Reibus	https://jobs.lever.co/reibus/	jobs.lever.co	2023-11-22 14:11:23.805052
1056	Doran Jones Inc.	https://jobs.lever.co/doranjones	jobs.lever.co	2023-11-22 14:11:23.805154
1057	Iterable	https://iterable.com/careers/	iterable.com	2023-11-22 14:11:23.805258
1058	Emarsys	https://jobs.emarsys.com/	jobs.emarsys.com	2023-11-22 14:11:23.805362
1059	OSF Digital	https://osf.digital/careers/jobs	osf.digital	2023-11-22 14:11:23.805478
1060	Hiya Inc.	https://www.hiya.com/careers	hiya.com	2023-11-22 14:11:23.805791
1061	Monitaur	https://www.monitaur.ai/company	monitaur.ai	2023-11-22 14:11:23.805906
1062	Swoon	https://www.swoonstaffing.com/jobs/	swoonstaffing.com	2023-11-22 14:11:23.806006
1063	ThousandEyes (part of Cisco)	https://www.thousandeyes.com/careers/	thousandeyes.com	2023-11-22 14:11:23.806108
1064	Zip	https://boards.greenhouse.io/zip/	boards.greenhouse.io	2023-11-22 14:11:23.806207
1065	the LEGO Group	https://www.linkedin.com/company/lego-group/jobs/	linkedin.com	2023-11-22 14:11:23.80633
1066	Omni Creator Products	https://www.ocp.gg/jobs	ocp.gg	2023-11-22 14:11:23.806433
1067	CloudTalk	https://www.cloudtalk.io/careers/	cloudtalk.io	2023-11-22 14:11:23.806577
1068	ClickTime	https://jobs.lever.co/clicktime/	jobs.lever.co	2023-11-22 14:11:23.80669
1069	Archive	https://jobs.lever.co/Archive	jobs.lever.co	2023-11-22 14:11:23.80681
1070	Alma	https://boards.greenhouse.io/alma/	boards.greenhouse.io	2023-11-22 14:11:23.806915
1071	Lunio	https://lunio.ai/about-us/careers/	lunio.ai	2023-11-22 14:11:23.807035
1072	Shawbrook Bank	https://careers.shawbrook.co.uk/opportunities/	careers.shawbrook.co.uk	2023-11-22 14:11:23.807141
1073	Grafana Labs	https://www.linkedin.com/company/grafana-labs/jobs/	linkedin.com	2023-11-22 14:11:23.807256
1074	Express Employment International	https://www.linkedin.com/company/expressemploymentinternational/jobs/	linkedin.com	2023-11-22 14:11:23.807361
1075	AuditBoard	https://www.auditboard.com/careers/jobs/	auditboard.com	2023-11-22 14:11:23.807483
1076	Fetch	https://www.linkedin.com/company/fetch-rewards/jobs/	linkedin.com	2023-11-22 14:11:23.807585
1077	Fluency - Advertising Automation Platform	https://fluency.applytojob.com	fluency.applytojob.com	2023-11-22 14:11:23.807703
1078	Easygenerator	https://www.linkedin.com/company/easygenerator/jobs/	linkedin.com	2023-11-22 14:11:23.807818
1079	Redaptive  Inc	https://jobs.lever.co/redaptiveinc/	jobs.lever.co	2023-11-22 14:11:23.807934
1080	Zopa Bank	https://jobs.lever.co/zopa/	jobs.lever.co	2023-11-22 14:11:23.808036
1081	Palo Alto Networks	https://jobs.paloaltonetworks.com/en/jobs/	jobs.paloaltonetworks.com	2023-11-22 14:11:23.808154
1082	The Lacek Group	https://www.lacek.com/careers	lacek.com	2023-11-22 14:11:23.808301
1083	Global Laser Enrichment	https://www.gle-us.com/careers/	gle-us.com	2023-11-22 14:11:23.808467
1084	PacBio	https://www.linkedin.com/company/pacbio/jobs/	linkedin.com	2023-11-22 14:11:23.80858
1085	OneCause	https://jobs.jobvite.com/onecause/	jobs.jobvite.com	2023-11-22 14:11:23.80868
1086	PlayStation	https://boards.greenhouse.io/sonyinteractiveentertainmentglobal	boards.greenhouse.io	2023-11-22 14:11:23.808791
1087	Visit.org	https://visit-talent.freshteam.com/jobs	visit-talent.freshteam.com	2023-11-22 14:11:23.808877
1088	numa	https://numastays.com/en/careers	numastays.com	2023-11-22 14:11:23.808954
1089	At-Bay	https://www.linkedin.com/company/at-bay/jobs/	linkedin.com	2023-11-22 14:11:23.80904
1090	Paychex	https://www.linkedin.com/company/paychex/jobs/	linkedin.com	2023-11-22 14:11:23.809123
1091	Everytable	https://everytable.careerplug.com/account	everytable.careerplug.com	2023-11-22 14:11:23.809212
1092	Responsive	https://boards.greenhouse.io/rfpio	boards.greenhouse.io	2023-11-22 14:11:23.809296
1093	Vena Solutions	https://www.lifeatvena.com/jobs	lifeatvena.com	2023-11-22 14:11:23.809385
1094	JFrog	https://www.linkedin.com/company/jfrog-ltd/jobs/	linkedin.com	2023-11-22 14:11:23.809473
1095	A.P. Moller - Maersk	https://www.linkedin.com/company/maersk-group/jobs/	linkedin.com	2023-11-22 14:11:23.809568
1096	Vanta	https://jobs.ashbyhq.com/vanta/	jobs.ashbyhq.com	2023-11-22 14:11:23.809658
1097	DataGrail	https://www.datagrail.io/careers/	datagrail.io	2023-11-22 14:11:23.809758
1098	Capella Space	https://www.capellaspace.com/about-us/careers/	capellaspace.com	2023-11-22 14:11:23.809849
1099	UP.Partners	https://axiomspace.bamboohr.com/careers	axiomspace.bamboohr.com	2023-11-22 14:11:23.809938
1100	United Imaging Healthcare	https://www.linkedin.com/company/united-imaging-healthcare/jobs/	linkedin.com	2023-11-22 14:11:23.810029
1101	Lydonia Technologies	https://lydoniatech.com/career/	lydoniatech.com	2023-11-22 14:11:23.810112
1102	Connatix	https://connatix.com/careers	connatix.com	2023-11-22 14:11:23.810196
1103	BD	https://www.linkedin.com/company/bd1/jobs/	linkedin.com	2023-11-22 14:11:23.810281
1104	Optm	https://optm.com/company/careers#Open-Roles	optm.com	2023-11-22 14:11:23.810362
1105	IGT	https://www.linkedin.com/company/igt/jobs/	linkedin.com	2023-11-22 14:11:23.810634
1106	SafeRide Health	https://saferidehealth.bamboohr.com/careers	saferidehealth.bamboohr.com	2023-11-22 14:11:23.81077
1107	OxBlue	https://www.oxblue.com/company/careers	oxblue.com	2023-11-22 14:11:23.810892
1108	HG Insights	https://www.linkedin.com/company/autodesk/jobs/	linkedin.com	2023-11-22 14:11:23.810983
1109	Thoughtful AI	https://www.thoughtful.ai/careers	thoughtful.ai	2023-11-22 14:11:23.811091
1110	Tripadvisor	https://boards.greenhouse.io/tripadvisor	boards.greenhouse.io	2023-11-22 14:11:23.811176
1111	MyFitnessPal	https://boards.greenhouse.io/myfitnesspal/	boards.greenhouse.io	2023-11-22 14:11:23.811259
1112	Acronis	https://www.linkedin.com/company/acronis/jobs/	linkedin.com	2023-11-22 14:11:23.811364
1113	Infor	https://www.linkedin.com/company/infor/jobs/	linkedin.com	2023-11-22 14:11:23.811452
1114	CleverTap	https://jobs.lever.co/clevertap/	jobs.lever.co	2023-11-22 14:11:23.811554
1115	Seamless.AI	https://seamless.ai/company/careers	seamless.ai	2023-11-22 14:11:23.811638
1116	Later	https://www.linkedin.com/company/latergram-me/jobs/	linkedin.com	2023-11-22 14:11:23.811731
1117	UiPath	https://www.linkedin.com/company/uipath/jobs/	linkedin.com	2023-11-22 14:11:23.811831
1118	Farm Credit Services of America	https://www.linkedin.com/company/farm-credit-services-of-america/jobs/	linkedin.com	2023-11-22 14:11:23.81191
1119	ButterflyMX®	https://www.linkedin.com/company/butterflymx/jobs/	linkedin.com	2023-11-22 14:11:23.811999
1120	Cority	https://jobs.lever.co/cority/	jobs.lever.co	2023-11-22 14:11:23.812076
1121	Siteline	https://www.siteline.com/about-us	siteline.com	2023-11-22 14:11:23.81216
1122	Imply	https://imply.io/positions	imply.io	2023-11-22 14:11:23.812249
1123	Sees Candy Shops Inc	https://sees.wd1.myworkdayjobs.com/Sees_Candies	sees.wd1.myworkdayjobs.com	2023-11-22 14:11:23.812325
1124	Kaseya	https://www.linkedin.com/company/kaseya/jobs/	linkedin.com	2023-11-22 14:11:23.8124
1125	Picovoice	https://picovoice.ai/careers/	picovoice.ai	2023-11-22 14:11:23.812489
1126	ANSER	https://anser.org/careers/opportunity/	anser.org	2023-11-22 14:11:23.812562
1127	Zerocater	https://jobs.ashbyhq.com/Zerocater	jobs.ashbyhq.com	2023-11-22 14:11:23.812638
1128	RevenueCat	https://www.revenuecat.com/careers/	revenuecat.com	2023-11-22 14:11:23.812728
1129	Canopy	https://jobs.lever.co/canopyservicing/	jobs.lever.co	2023-11-22 14:11:23.812802
1130	Kaleyra	https://kaleyra.teamtailor.com/	kaleyra.teamtailor.com	2023-11-22 14:11:23.812892
1131	Promenade Group	https://jobs.lever.co/promenade	jobs.lever.co	2023-11-22 14:11:23.812983
1132	BambooHR	https://www.linkedin.com/company/bamboohr/jobs/	linkedin.com	2023-11-22 14:11:23.813068
1133	Akamai Technologies	https://akamaicareers.inflightcloud.com/search	akamaicareers.inflightcloud.com	2023-11-22 14:11:23.813157
1134	Neo Financial	https://www.linkedin.com/company/neo-financial/jobs/	linkedin.com	2023-11-22 14:11:23.81323
1135	Axon	https://boards.greenhouse.io/axon/	boards.greenhouse.io	2023-11-22 14:11:23.813303
1136	Pave	https://boards.greenhouse.io/paveakatroveinformationtechnologies	boards.greenhouse.io	2023-11-22 14:11:23.813391
1137	Anomalo	https://www.anomalo.com/jobs	anomalo.com	2023-11-22 14:11:23.813466
1138	Shopmonkey	https://boards.greenhouse.io/shopmonkey	boards.greenhouse.io	2023-11-22 14:11:23.813539
1139	Schoox	https://www.linkedin.com/company/schoox/jobs/	linkedin.com	2023-11-22 14:11:23.813634
1140	Unit21	https://www.unit21.ai/company/careers	unit21.ai	2023-11-22 14:11:23.813707
1141	BrightBid	https://www.linkedin.com/company/brightbid/jobs/	linkedin.com	2023-11-22 14:11:23.813854
1142	Tipalti	https://www.linkedin.com/company/tipalti/jobs/	linkedin.com	2023-11-22 14:11:23.813929
1143	incident.io	https://incident.io/careers	incident.io	2023-11-22 14:11:23.814003
1144	Classy	https://www.classy.org/careers/	classy.org	2023-11-22 14:11:23.814107
1145	AnyRoad	https://jobs.lever.co/anyroad/	jobs.lever.co	2023-11-22 14:11:23.814214
1146	OTA Insight	https://www.mylighthouse.com/company/careers/	mylighthouse.com	2023-11-22 14:11:23.814314
1147	MarketOne International	https://www.marketone.com/jobs	marketone.com	2023-11-22 14:11:23.814396
1148	Nektar.ai	https://nektar.freshteam.com/jobs	nektar.freshteam.com	2023-11-22 14:11:23.814697
1149	Apploi	https://apploi.com/careers/	apploi.com	2023-11-22 14:11:23.814821
1150	Maven Clinic	https://www.mavenclinic.com/careers	mavenclinic.com	2023-11-22 14:11:23.814924
1151	Lightrun	https://lightrun.com/careers/	lightrun.com	2023-11-22 14:11:23.81503
1152	Mercedes-Benz Research & Development North America  Inc.	https://jobs.lever.co/MBRDNA	jobs.lever.co	2023-11-22 14:11:23.815155
1153	Flare	https://flare.io/company/careers/	flare.io	2023-11-22 14:11:23.815282
1154	X-Team	https://x-team.com/remote-programming-jobs/	x-team.com	2023-11-22 14:11:23.81539
1155	Celigo	https://www.celigo.com/careers/	celigo.com	2023-11-22 14:11:23.815502
1156	Kobiton	https://kobiton.com/careers/	kobiton.com	2023-11-22 14:11:23.81561
1157	Michelin	https://www.linkedin.com/company/michelin/jobs/	linkedin.com	2023-11-22 14:11:23.815732
1158	Tekmetric	https://boards.greenhouse.io/tekmetric	boards.greenhouse.io	2023-11-22 14:11:23.815861
1159	Apaleo	https://boards.greenhouse.io/apaleo/	boards.greenhouse.io	2023-11-22 14:11:23.81597
1160	Lyra Health	https://www.linkedin.com/company/autodesk/jobs/	linkedin.com	2023-11-22 14:11:23.816117
1161	ZOLL Medical Corporation	https://www.zoll.com/contact/careers-at-zoll/careers-search	zoll.com	2023-11-22 14:11:23.816222
1162	Allovue	https://www.allovue.com/careers	allovue.com	2023-11-22 14:11:23.816333
1163	Deltek	https://www.linkedin.com/company/deltek/jobs/	linkedin.com	2023-11-22 14:11:23.816436
1164	Chainalysis	https://www.chainalysis.com/careers/job-openings/	chainalysis.com	2023-11-22 14:11:23.816559
1165	PwC	https://www.linkedin.com/company/pwc/jobs/	linkedin.com	2023-11-22 14:11:23.816668
1166	SiriusXM	https://www.linkedin.com/company/siriusxm/jobs/	linkedin.com	2023-11-22 14:11:23.816787
1167	CoinTracker	https://www.cointracker.io/careers	cointracker.io	2023-11-22 14:11:23.816891
1168	Sonendo  Inc.	https://careers-sonendo.icims.com/jobs/intro?hashed=-626009781&mobile=false&width=1425&height=500&bga=true&needsRedirect=false&jan1offset=-300&jun1offset=-240	careers-sonendo.icims.com	2023-11-22 14:11:23.817022
1169	Wiz	https://www.wiz.io/careers	wiz.io	2023-11-22 14:11:23.817132
1170	Jeeng  an OpenWeb company	https://www.jeeng.com/careers/	jeeng.com	2023-11-22 14:11:23.817271
1171	Datadog	https://www.linkedin.com/company/datadog/jobs/	linkedin.com	2023-11-22 14:11:23.817378
1172	Deel	https://jobs.ashbyhq.com/Deel	jobs.ashbyhq.com	2023-11-22 14:11:23.817489
1173	Papa	https://www.papa.com/about/careers	papa.com	2023-11-22 14:11:23.817588
1174	Motorola Solutions	https://www.linkedin.com/company/motorolasolutions/jobs/	linkedin.com	2023-11-22 14:11:23.817709
1175	Egen	https://www.linkedin.com/company/egenai/jobs/	linkedin.com	2023-11-22 14:11:23.81781
1176	Cognota	https://cognota.com/careers/	cognota.com	2023-11-22 14:11:23.817943
1177	Precoa	https://careers.precoa.com/search/jobs	careers.precoa.com	2023-11-22 14:11:23.818054
1178	Digital Remedy	https://jobs.lever.co/digitalremedy/	jobs.lever.co	2023-11-22 14:11:23.818158
1179	KEYENCE CORPORATION	https://www.linkedin.com/company/keyence/jobs/	linkedin.com	2023-11-22 14:11:23.818261
1180	WP Engine	https://www.linkedin.com/company/wpengine/jobs/	linkedin.com	2023-11-22 14:11:23.818371
1181	Schell Games	https://schellgames.com/careers	schellgames.com	2023-11-22 14:11:23.81846
1182	Whip Around	https://www.linkedin.com/company/whip-around/jobs/	linkedin.com	2023-11-22 14:11:23.818556
1183	StackAdapt	https://jobs.lever.co/stackadapt/	jobs.lever.co	2023-11-22 14:11:23.818649
1184	Ascent Cloud	https://ascentcloud.io/careers/	ascentcloud.io	2023-11-22 14:11:23.818754
1185	Uber Freight	https://www.linkedin.com/company/uber-freight/jobs/	linkedin.com	2023-11-22 14:11:23.818878
1186	Figure	https://boards.greenhouse.io/figure/	boards.greenhouse.io	2023-11-22 14:11:23.819004
1187	Osano	https://jobs.lever.co/Osano	jobs.lever.co	2023-11-22 14:11:23.81913
1188	PingCAP	https://jobs.lever.co/pingcap/	jobs.lever.co	2023-11-22 14:11:23.819245
1189	Guild	https://www.guildeducation.com/about-us/careers/open-positions/	guildeducation.com	2023-11-22 14:11:23.819363
1190	HCLTech	https://www.linkedin.com/company/hcltech/jobs/	linkedin.com	2023-11-22 14:11:23.819483
1191	Relevant Healthcare	https://relevant.healthcare/jobs	relevant.healthcare	2023-11-22 14:11:23.819587
1192	John Deere	https://www.linkedin.com/company/john-deere/jobs/	linkedin.com	2023-11-22 14:11:23.819862
1193	Vetted	https://jobs.lever.co/vetted/	jobs.lever.co	2023-11-22 14:11:23.819986
1194	MycoWorks	https://boards.greenhouse.io/mycoworks	boards.greenhouse.io	2023-11-22 14:11:23.820086
1195	Abridge	https://jobs.lever.co/abridge/	jobs.lever.co	2023-11-22 14:11:23.820192
1196	FreshBooks	https://boards.greenhouse.io/freshbooks	boards.greenhouse.io	2023-11-22 14:11:23.820294
1197	Incode Technologies	https://incode.com/careers/open-positions/	incode.com	2023-11-22 14:11:23.820393
1198	Provi	https://jobs.lever.co/provi/	jobs.lever.co	2023-11-22 14:11:23.82049
1199	EngageSmart	https://engagesmart.com/careers-engagesmart/	engagesmart.com	2023-11-22 14:11:23.820603
1200	Paynuity	https://jobs.lever.co/paynuity/	jobs.lever.co	2023-11-22 14:11:23.820698
1201	PSD Citywide	https://psdcitywide.com/about/careers/	psdcitywide.com	2023-11-22 14:11:23.820793
1202	Chef Robotics	https://jobs.lever.co/ChefRobotics	jobs.lever.co	2023-11-22 14:11:23.820901
1203	3Cloud	https://boards.greenhouse.io/3cloud/	boards.greenhouse.io	2023-11-22 14:11:23.820994
1204	DirectShifts	https://www.directshifts.com/careers	directshifts.com	2023-11-22 14:11:23.821101
1205	Coastal Cloud	https://coastalcloud.us/coastal-cloud-careers-2-2-2/	coastalcloud.us	2023-11-22 14:11:23.821203
1206	Rokt	https://www.rokt.com/careers	rokt.com	2023-11-22 14:11:23.821302
1207	PartsTech	https://partstech.com/careers/	partstech.com	2023-11-22 14:11:23.821402
1208	Synthace	https://jobs.lever.co/synthace/	jobs.lever.co	2023-11-22 14:11:23.82151
1209	Moody's Analytics	https://www.linkedin.com/company/moodysanalytics/jobs/	linkedin.com	2023-11-22 14:11:23.821618
1210	Causal	https://jobs.ashbyhq.com/pear	jobs.ashbyhq.com	2023-11-22 14:11:23.821732
1211	Medallion	https://medallion.co/about-medallion/careers	medallion.co	2023-11-22 14:11:23.821903
1212	BMC Software	https://jobs.bmc.com/Careers/SearchJobs	jobs.bmc.com	2023-11-22 14:11:23.822013
1213	Lumafield	https://jobs.lever.co/lumafield/	jobs.lever.co	2023-11-22 14:11:23.822108
1214	Informa Markets	https://careers.smartrecruiters.com/InformaGroupPlc/informa-markets	careers.smartrecruiters.com	2023-11-22 14:11:23.822206
1215	AVIOBOOK	https://www.linkedin.com/jobs/aviobook-jobs-worldwide?f_C=1003745&trk=top-card_top-card-primary-button-top-card-primary-cta&position=1&pageNum=0	linkedin.com	2023-11-22 14:11:23.822309
1216	F5	https://www.linkedin.com/company/f5/jobs/	linkedin.com	2023-11-22 14:11:23.822416
1217	Constant Contact	https://boards.greenhouse.io/constantcontact	boards.greenhouse.io	2023-11-22 14:11:23.822533
1218	Vestmark	https://www.vestmark.com/careers	vestmark.com	2023-11-22 14:11:23.822644
1220	InfluxData	https://www.influxdata.com/careers/	influxdata.com	2023-11-22 14:11:23.822785
1221	Storyblok	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.822883
1222	Lead Forensics	https://careers.leadforensics.com/	careers.leadforensics.com	2023-11-22 14:11:23.822994
1223	Propel  Inc	https://www.linkedin.com/company/propel-inc/jobs/	linkedin.com	2023-11-22 14:11:23.823095
1224	IZEA	https://izea.com/company/careers/apply-to-join-izea/	izea.com	2023-11-22 14:11:23.823192
1225	Costco IT	https://www.linkedin.com/company/costco-weareit/jobs/	linkedin.com	2023-11-22 14:11:23.823314
1226	Cloud Software Group	https://careers.cloud.com/jobs/search	careers.cloud.com	2023-11-22 14:11:23.82345
1227	Binti	https://binti.com/current-openings/	binti.com	2023-11-22 14:11:23.823535
1228	Gartner	https://jobs.gartner.com/search-jobs?_its=JTdCJTIydmlkJTIyJTNBJTIyNGE3MzlkZWYtNTg1MC00YWI1LTlkNDctNmMzNjA3NmZhOTY3JTIyJTJDJTIyc3RhdGUlMjIlM0ElMjJybHR%2BMTcwMDA4OTgyM35sYW5kfjJfMTY0NjdfZGlyZWN0XzQ0OWU4MzBmMmE0OTU0YmM2ZmVjNWMxODFlYzI4Zjk0JTIyJTJDJTIyc2l0ZUlkJTIyJTNBNDAxMzElN0Q%3D	jobs.gartner.com	2023-11-22 14:11:23.82364
1229	Roo	https://jobs.lever.co/roo/	jobs.lever.co	2023-11-22 14:11:23.82374
1230	Cohere Health	https://coherehealth.com/careers/	coherehealth.com	2023-11-22 14:11:23.823874
1231	Zuva	https://zuva.ai/careers/	zuva.ai	2023-11-22 14:11:23.823982
1232	Audacy  Inc.	https://www.linkedin.com/company/audacy-inc/jobs/	linkedin.com	2023-11-22 14:11:23.824098
1233	Optiply	https://optiply.com/nl/vacatures/	optiply.com	2023-11-22 14:11:23.824196
1234	ZayZoon	https://www.zayzoon.com/work-with-us	zayzoon.com	2023-11-22 14:11:23.824304
1235	EasyPost	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.824404
1236	Auvik	https://www.linkedin.com/company/auvik/jobs/	linkedin.com	2023-11-22 14:11:23.824531
1237	CMC Global Company Limited.	https://www.linkedin.com/company/cmc-global-company-limited/jobs/	linkedin.com	2023-11-22 14:11:23.824637
1238	Mimecast	https://careers.mimecast.com/en/jobs/	careers.mimecast.com	2023-11-22 14:11:23.824903
1239	PerformYard	https://www.linkedin.com/company/performyard/jobs/	linkedin.com	2023-11-22 14:11:23.824997
1240	Fandom	https://about.fandom.com/careers	about.fandom.com	2023-11-22 14:11:23.825118
1241	Airbase	https://boards.greenhouse.io/airbase	boards.greenhouse.io	2023-11-22 14:11:23.825261
1242	Aurora	https://aurora.tech/careers	aurora.tech	2023-11-22 14:11:23.825346
1243	Certain Affinity	https://www.linkedin.com/company/certain-affinity/jobs/	linkedin.com	2023-11-22 14:11:23.825458
1244	Findigs  Inc.	https://jobs.lever.co/findigs	jobs.lever.co	2023-11-22 14:11:23.825545
1245	Fortify	https://3dfortify.com/careers/	3dfortify.com	2023-11-22 14:11:23.82563
1246	Lev	https://www.levdigital.com/join-the-team	levdigital.com	2023-11-22 14:11:23.825718
1247	Softdocs	https://www.softdocs.com/company/careers	softdocs.com	2023-11-22 14:11:23.825813
1248	Blackcart	https://apply.workable.com/blackcart	apply.workable.com	2023-11-22 14:11:23.825903
1249	Propeller	https://propelleraero.breezy.hr/	propelleraero.breezy.hr	2023-11-22 14:11:23.826005
1250	interface.ai	https://www.linkedin.com/company/interface-ai/jobs/	linkedin.com	2023-11-22 14:11:23.826099
1251	Trapp Technology	https://trapptechnology.com/careers/careers-portal/	trapptechnology.com	2023-11-22 14:11:23.826187
1252	ADvendio	https://www.linkedin.com/jobs/search/?f_C=1544606&geoId=92000000&keywords=advendio&location=Worldwide	linkedin.com	2023-11-22 14:11:23.826278
1253	RecordPoint	https://www.recordpoint.com/careers	recordpoint.com	2023-11-22 14:11:23.826375
1254	Nebula	https://jobs.nebula.tv/	jobs.nebula.tv	2023-11-22 14:11:23.826464
1255	Ontotext	https://www.ontotext.com/company/careers/	ontotext.com	2023-11-22 14:11:23.826542
1256	Zscaler	https://www.linkedin.com/company/zscaler/jobs/	linkedin.com	2023-11-22 14:11:23.826626
1257	Mastercard	https://www.linkedin.com/company/mastercard/jobs/	linkedin.com	2023-11-22 14:11:23.826702
1258	Ashby	https://www.ashbyhq.com/careers	ashbyhq.com	2023-11-22 14:11:23.826777
1259	SaaScend	https://www.linkedin.com/company/saascend/jobs/	linkedin.com	2023-11-22 14:11:23.826859
1260	Gecko Robotics  Inc.	https://www.geckorobotics.com/careers	geckorobotics.com	2023-11-22 14:11:23.826947
1261	Labelbox	https://www.linkedin.com/company/labelbox/jobs/	linkedin.com	2023-11-22 14:11:23.827035
1262	CMI Media Group	https://www.linkedin.com/company/cmimediagroup/jobs/	linkedin.com	2023-11-22 14:11:23.827119
1263	Couchbase	https://www.couchbase.com/careers/open-positions/	couchbase.com	2023-11-22 14:11:23.827207
1264	Addigy	https://addigy.bamboohr.com/careers	addigy.bamboohr.com	2023-11-22 14:11:23.827296
1265	LinearB	https://jobs.lever.co/LinearB	jobs.lever.co	2023-11-22 14:11:23.827379
1266	Immersive Labs	https://careers.immersivelabs.com/jobs/	careers.immersivelabs.com	2023-11-22 14:11:23.827472
1267	Synapse	https://synapsefi.com/careers	synapsefi.com	2023-11-22 14:11:23.827558
1268	Zoox	https://jobs.lever.co/zoox/	jobs.lever.co	2023-11-22 14:11:23.827634
1269	Novidea	https://novidea.com/careers/	novidea.com	2023-11-22 14:11:23.827723
1270	TaxBit	https://boards.greenhouse.io/taxbit	boards.greenhouse.io	2023-11-22 14:11:23.827797
1271	Lockheed Martin	https://www.linkedin.com/company/lockheed-martin/jobs/	linkedin.com	2023-11-22 14:11:23.827874
1272	BEMO	https://bemo.rippling-ats.com	bemo.rippling-ats.com	2023-11-22 14:11:23.82795
1273	Jackpot.com	https://www.jackpot.com/careers	jackpot.com	2023-11-22 14:11:23.828024
1274	Xendoo Online Bookkeeping & Accounting	https://www.linkedin.com/company/xendoo/jobs/	linkedin.com	2023-11-22 14:11:23.828099
1275	Capital One	https://www.linkedin.com/company/capital-one/jobs/	linkedin.com	2023-11-22 14:11:23.828189
1276	Cognism	https://www.cognism.com/jobs	cognism.com	2023-11-22 14:11:23.828263
1277	HealthJoy	https://www.healthjoy.com/careers	healthjoy.com	2023-11-22 14:11:23.828343
1278	Axios	https://www.linkedin.com/company/axios-media/jobs/	linkedin.com	2023-11-22 14:11:23.828432
1279	New Relic	https://newrelic.careers/	newrelic.careers	2023-11-22 14:11:23.828504
1280	Hearsay Systems	https://jobs.lever.co/easypost-2	jobs.lever.co	2023-11-22 14:11:23.82859
1281	PDQ	https://jobs.lever.co/PDQ	jobs.lever.co	2023-11-22 14:11:23.828676
1282	Dealpath	https://www.dealpath.com/careers/	dealpath.com	2023-11-22 14:11:23.828747
1283	Ascend Learning	https://recruiting.ultipro.com/ASC1003/JobBoard/57b0d3c6-a250-9a6a-7787-1093a619de01/?q=&o=postedDateDesc	recruiting.ultipro.com	2023-11-22 14:11:23.828966
1284	Airwallex	https://jobs.lever.co/airwallex/	jobs.lever.co	2023-11-22 14:11:23.829052
1285	Spokeo	https://www.spokeo.com/careers/jobs	spokeo.com	2023-11-22 14:11:23.829141
1286	Spring Health	https://www.springhealth.com/open-roles	springhealth.com	2023-11-22 14:11:23.829214
1287	Urban Jungle Insurance	https://myurbanjungle.com/explore/careers	myurbanjungle.com	2023-11-22 14:11:23.829304
1288	SmithRx	https://smithrx.com/careers/	smithrx.com	2023-11-22 14:11:23.829378
1289	MacroFab	https://www.macrofab.com/careers/	macrofab.com	2023-11-22 14:11:23.829465
1290	Factbird	https://www.linkedin.com/company/factbird-aps/jobs/	linkedin.com	2023-11-22 14:11:23.829553
1291	intenseye	https://jobs.lever.co/intenseye/	jobs.lever.co	2023-11-22 14:11:23.829629
1292	Astranis Space Technologies	https://boards.greenhouse.io/astranis	boards.greenhouse.io	2023-11-22 14:11:23.829716
1293	Monotype	https://www.linkedin.com/company/monotype/jobs/	linkedin.com	2023-11-22 14:11:23.829808
1294	TransPerfect	https://www.linkedin.com/company/transperfect/jobs/	linkedin.com	2023-11-22 14:11:23.829894
1295	Fleetio	https://www.fleetio.com/careers	fleetio.com	2023-11-22 14:11:23.829983
1296	SpotOn	https://www.spoton.com/careers/	spoton.com	2023-11-22 14:11:23.830058
1297	Lumos	https://boards.greenhouse.io/lumos	boards.greenhouse.io	2023-11-22 14:11:23.830134
1298	Watershed	https://watershed.com/jobs	watershed.com	2023-11-22 14:11:23.830212
1299	LegitScript	https://www.legitscript.com/about/careers/	legitscript.com	2023-11-22 14:11:23.830288
1300	Impact Networking  LLC	https://careers.impactmybiz.com/search/jobs	careers.impactmybiz.com	2023-11-22 14:11:23.830445
1301	MUI	https://jobs.ashbyhq.com/mui/	jobs.ashbyhq.com	2023-11-22 14:11:23.830565
1302	Apex Systems	https://www.linkedin.com/company/apex-systems/jobs/	linkedin.com	2023-11-22 14:11:23.830689
1303	Samsara	https://samsara.com/company/careers/roles	samsara.com	2023-11-22 14:11:23.830783
1304	Plenty of Fish	https://jobs.lever.co/matchgroup	jobs.lever.co	2023-11-22 14:11:23.830892
1305	Alteryx	https://www.linkedin.com/company/alteryx/jobs/	linkedin.com	2023-11-22 14:11:23.830995
1306	Plum	https://www.linkedin.com/company/plum-io/jobs/	linkedin.com	2023-11-22 14:11:23.831117
1307	Patch	https://jobs.lever.co/patch/	jobs.lever.co	2023-11-22 14:11:23.831213
1308	Turing	https://www.linkedin.com/company/turingcom/jobs/	linkedin.com	2023-11-22 14:11:23.831308
1309	Verve Group	https://vervegroup.recruitee.com	vervegroup.recruitee.com	2023-11-22 14:11:23.8314
1310	#paid	https://jobs.lever.co/hashtagpaid	jobs.lever.co	2023-11-22 14:11:23.831492
1311	Lightpath	https://www.linkedin.com/company/lightpath/jobs/	linkedin.com	2023-11-22 14:11:23.831598
1312	One Medical	https://www.linkedin.com/company/one-medical-group/jobs/	linkedin.com	2023-11-22 14:11:23.831688
1313	Milk Moovement	https://jobs.lever.co/milk-moovement	jobs.lever.co	2023-11-22 14:11:23.831789
1314	Merge	https://boards.greenhouse.io/merge/	boards.greenhouse.io	2023-11-22 14:11:23.83188
1315	CybSafe	https://www.linkedin.com/company/cybsafe-limited/jobs/	linkedin.com	2023-11-22 14:11:23.831973
1316	Antithesis	https://antithesis.breezy.hr/	antithesis.breezy.hr	2023-11-22 14:11:23.832082
1317	M3 Global Research	https://careers.eu.m3.com/Creative/m3global	careers.eu.m3.com	2023-11-22 14:11:23.832174
1318	The Pokémon Company International	https://boards.greenhouse.io/pokemoncareers	boards.greenhouse.io	2023-11-22 14:11:23.832431
1319	Dropbox	https://www.linkedin.com/company/dropbox/jobs/	linkedin.com	2023-11-22 14:11:23.832538
1320	Bynder	https://careers.bynder.com/	careers.bynder.com	2023-11-22 14:11:23.832669
1321	Kensho Technologies	https://jobs.lever.co/kensho	jobs.lever.co	2023-11-22 14:11:23.832804
1322	iPullRank	https://www.linkedin.com/company/ipullrank/jobs/	linkedin.com	2023-11-22 14:11:23.832937
1323	Live Chair Health	https://www.linkedin.com/company/live-chair-health/jobs	linkedin.com	2023-11-22 14:11:23.833092
1324	BeyondTrust	https://boards.greenhouse.io/beyondtrust/	boards.greenhouse.io	2023-11-22 14:11:23.833231
1325	Front	https://jobs.lever.co/frontapp	jobs.lever.co	2023-11-22 14:11:23.83334
1326	AudioEye	https://boards.greenhouse.io/audioeye/	boards.greenhouse.io	2023-11-22 14:11:23.833469
1327	Resource Innovations	https://www.linkedin.com/company/resourceinnovations/jobs/	linkedin.com	2023-11-22 14:11:23.833595
1328	Accenture	https://www.linkedin.com/company/accenture/jobs/	linkedin.com	2023-11-22 14:11:23.833732
1329	Sourcewell	https://sourcewell.wd1.myworkdayjobs.com/SWCareers	sourcewell.wd1.myworkdayjobs.com	2023-11-22 14:11:23.833835
1330	GRIN	https://grin.co/careers/jobs/	grin.co	2023-11-22 14:11:23.833967
1331	Andela	https://www.linkedin.com/company/andela/jobs/	linkedin.com	2023-11-22 14:11:23.83411
1332	Otter.ai	https://otter.ai/careers	otter.ai	2023-11-22 14:11:23.834234
1333	OpsLevel	https://jobs.lever.co/opslevel/	jobs.lever.co	2023-11-22 14:11:23.834365
\.


--
-- Data for Name: job_postings; Type: TABLE DATA; Schema: public; Owner: michael
--

COPY public.job_postings (id, job_title, job_url, job_id, job_scraped_date, company_name, job_description, json_response) FROM stdin;
1	Senior Backend Engineer	https://boards.greenhouse.io/upfort/jobs/4123933007	4123933007	2023-11-22 14:12:57.778905	Upfort	\N	{"salary": "", "location": "Remote | United States", "department": "", "tech_stack": []}
2	Legal Engineer (Implementation Consultant)	https://jobs.ashbyhq.com/ironcladhq/3026a514-c578-4acc-af15-d38aa7af5dbf	3026a514-c578-4acc-af15-d38aa7af5dbf	2023-11-22 14:12:57.787732	Ironclad	\N	{"salary": "", "location": "New York, NY", "department": "", "tech_stack": []}
4	Senior Software Engineer - Product	https://jobs.ashbyhq.com/ironcladhq/42b3c52d-0de8-438a-aac8-c741bbd45072	42b3c52d-0de8-438a-aac8-c741bbd45072	2023-11-22 14:12:57.788752	Ironclad	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
195	Lead Fullstack Software Engineer	https://jobs.lever.co/picklerobot/96ca4edf-0887-4ad7-b5f4-b60351112ac6	96ca4edf-0887-4ad7-b5f4-b60351112ac6	2023-11-22 14:12:57.833736	Pickle Robot Company	\N	{"salary": "", "location": "Cambridge, MA", "department": "", "tech_stack": []}
196	Senior Frontend Software Engineer	https://jobs.lever.co/picklerobot/fd6afadc-9d8f-4776-b8e8-0348ab3f6f15	fd6afadc-9d8f-4776-b8e8-0348ab3f6f15	2023-11-22 14:12:57.833847	Pickle Robot Company	\N	{"salary": "", "location": "Cambridge, MA", "department": "", "tech_stack": []}
213	Senior Backend Engineer	https://jobs.lever.co/loftorbital/f333f930-26b5-4655-85a0-a240d6236599	f333f930-26b5-4655-85a0-a240d6236599	2023-11-22 14:12:57.836386	Loft Orbital	\N	{"salary": "", "location": "Toulouse", "department": "", "tech_stack": []}
214	Senior Backend Engineer	https://jobs.lever.co/loftorbital/a9a1199a-e9e2-4c27-a256-3ba295515c2c	a9a1199a-e9e2-4c27-a256-3ba295515c2c	2023-11-22 14:12:57.836562	Loft Orbital	\N	{"salary": "", "location": "Golden, CO / San Francisco", "department": "", "tech_stack": []}
215	System Security Engineer	https://jobs.lever.co/loftorbital/fe983961-897d-4dd0-bc35-2d8c59611d5e	fe983961-897d-4dd0-bc35-2d8c59611d5e	2023-11-22 14:12:57.836683	Loft Orbital	\N	{"salary": "", "location": "Toulouse", "department": "", "tech_stack": []}
217	Systems Engineer, Virtual Missions	https://jobs.lever.co/loftorbital/4bf9c786-49d4-4dd1-83d6-6be22073f084	4bf9c786-49d4-4dd1-83d6-6be22073f084	2023-11-22 14:12:57.836934	Loft Orbital	\N	{"salary": "", "location": "Toulouse", "department": "", "tech_stack": []}
219	Test Infrastructure Engineer	https://jobs.lever.co/loftorbital/b5fe0c78-9990-4405-9594-2df97dcdce0f	b5fe0c78-9990-4405-9594-2df97dcdce0f	2023-11-22 14:12:57.837183	Loft Orbital	\N	{"salary": "", "location": "Toulouse", "department": "", "tech_stack": []}
232	Software Support Engineer	https://boards.greenhouse.io/digitalasset/jobs/5140438	5140438	2023-11-22 14:12:57.838969	Digital Asset	\N	{"salary": "", "location": "Budapest", "department": "", "tech_stack": []}
233	Software Support Engineer - Ireland	https://boards.greenhouse.io/digitalasset/jobs/5328443	5328443	2023-11-22 14:12:57.839071	Digital Asset	\N	{"salary": "", "location": "Dublin", "department": "", "tech_stack": []}
234	Software Support Engineer - UK	https://boards.greenhouse.io/digitalasset/jobs/5328434	5328434	2023-11-22 14:12:57.839158	Digital Asset	\N	{"salary": "", "location": "London", "department": "", "tech_stack": []}
238	Principal Engineer, Machine Learning	https://boards.greenhouse.io/metalab/jobs/4971982	4971982	2023-11-22 14:12:57.839622	MetaLab	\N	{"salary": "", "location": "LATAM", "department": "", "tech_stack": []}
239	Senior Full Stack Developer	https://boards.greenhouse.io/metalab/jobs/2986532	2986532	2023-11-22 14:12:57.839726	MetaLab	\N	{"salary": "", "location": "LATAM", "department": "", "tech_stack": []}
240	Senior Full Stack Developer, Machine Learning	https://boards.greenhouse.io/metalab/jobs/5383950	5383950	2023-11-22 14:12:57.83982	MetaLab	\N	{"salary": "", "location": "LATAM", "department": "", "tech_stack": []}
241	Senior Software Engineer	https://jobs.lever.co/rover/a825940e-3c09-408a-bfe8-a4f14c9f2c9a	a825940e-3c09-408a-bfe8-a4f14c9f2c9a	2023-11-22 14:12:57.839986	Rover.com	\N	{"salary": "", "location": "Barcelona", "department": "", "tech_stack": []}
242	Senior Software Engineer - Internal Tools (Remote)	https://jobs.lever.co/super-com/4a1f30e3-3046-40cd-ab3c-86512e99cd9d	4a1f30e3-3046-40cd-ab3c-86512e99cd9d	2023-11-22 14:12:57.840173	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
243	Senior Software Engineer - Internal Tools (Remote)	https://jobs.lever.co/super-com/fecb043b-30c1-4496-8e28-0a681ad75c28	fecb043b-30c1-4496-8e28-0a681ad75c28	2023-11-22 14:12:57.840339	Super.com	\N	{"salary": "", "location": "Vancouver", "department": "", "tech_stack": []}
244	Senior Software Engineer - Internal Tools (Remote)	https://jobs.lever.co/super-com/ccfcc284-972b-4864-9de0-8be6f0ddcd0d	ccfcc284-972b-4864-9de0-8be6f0ddcd0d	2023-11-22 14:12:57.840653	Super.com	\N	{"salary": "", "location": "Boston", "department": "", "tech_stack": []}
245	Senior Software Engineer - Internal Tools (Remote)	https://jobs.lever.co/super-com/65c7e72a-6cf6-40fe-ac2b-3664e49c1068	65c7e72a-6cf6-40fe-ac2b-3664e49c1068	2023-11-22 14:12:57.840793	Super.com	\N	{"salary": "", "location": "Portland", "department": "", "tech_stack": []}
246	Engineering Manager - Product (Remote)	https://jobs.lever.co/super-com/a9306171-e3f2-4278-b055-4f48da418cb0	a9306171-e3f2-4278-b055-4f48da418cb0	2023-11-22 14:12:57.840888	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
247	Engineering Manager - Product (Remote)	https://jobs.lever.co/super-com/9e6accde-3bc0-4742-b8d3-b87255f82bbf	9e6accde-3bc0-4742-b8d3-b87255f82bbf	2023-11-22 14:12:57.840979	Super.com	\N	{"salary": "", "location": "Vancouver", "department": "", "tech_stack": []}
248	Engineering Manager - Product (Remote)	https://jobs.lever.co/super-com/fa7b27e4-c434-4bde-8f45-c52ca80acf06	fa7b27e4-c434-4bde-8f45-c52ca80acf06	2023-11-22 14:12:57.841084	Super.com	\N	{"salary": "", "location": "Austin", "department": "", "tech_stack": []}
249	Engineering Manager - Product (Remote)	https://jobs.lever.co/super-com/ce4985f9-b976-4a66-8ca1-5dd32b05aa92	ce4985f9-b976-4a66-8ca1-5dd32b05aa92	2023-11-22 14:12:57.841175	Super.com	\N	{"salary": "", "location": "Raleigh, NC", "department": "", "tech_stack": []}
250	Engineering Manager - Product (Remote)	https://jobs.lever.co/super-com/24808cc7-2e22-41a8-925b-9a0921e1e2d5	24808cc7-2e22-41a8-925b-9a0921e1e2d5	2023-11-22 14:12:57.84128	Super.com	\N	{"salary": "", "location": "Boston", "department": "", "tech_stack": []}
251	Full Stack Engineer (Remote)	https://jobs.lever.co/super-com/984cf22a-fcc5-4291-ad25-c430b9bcf2be	984cf22a-fcc5-4291-ad25-c430b9bcf2be	2023-11-22 14:12:57.84137	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
31	Senior Software Engineer, Growth	https://boards.greenhouse.io/amplitude/jobs/6963673002	6963673002	2023-11-22 14:12:57.803664	Amplitude	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
252	Intermediate Software Engineer (Full Stack) (Remote)	https://jobs.lever.co/super-com/ed61b8d4-10dd-48ef-87e4-908ad461656c	ed61b8d4-10dd-48ef-87e4-908ad461656c	2023-11-22 14:12:57.841461	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
253	Senior Full-Stack Software Engineer	https://jobs.lever.co/super-com/9a4828ed-9c3f-420e-96cd-a81b0416b77c	9a4828ed-9c3f-420e-96cd-a81b0416b77c	2023-11-22 14:12:57.841552	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
254	Senior Full-Stack Software Engineer	https://jobs.lever.co/super-com/aebcd1c2-2eac-4fdc-8b55-866f4c41e231	aebcd1c2-2eac-4fdc-8b55-866f4c41e231	2023-11-22 14:12:57.841642	Super.com	\N	{"salary": "", "location": "Los Angeles", "department": "", "tech_stack": []}
255	Senior Full-Stack Software Engineer	https://jobs.lever.co/super-com/0e74e0dd-f742-4440-ad6d-582f2dd9a5f0	0e74e0dd-f742-4440-ad6d-582f2dd9a5f0	2023-11-22 14:12:57.841731	Super.com	\N	{"salary": "", "location": "Chicago", "department": "", "tech_stack": []}
256	Senior Full-Stack Software Engineer	https://jobs.lever.co/super-com/1ab08c68-64d9-4b84-ad9b-dd01da784ce8	1ab08c68-64d9-4b84-ad9b-dd01da784ce8	2023-11-22 14:12:57.841823	Super.com	\N	{"salary": "", "location": "Austin", "department": "", "tech_stack": []}
257	Senior Full-Stack Software Engineer	https://jobs.lever.co/super-com/62c0288d-2f32-4069-a854-236f6668a66f	62c0288d-2f32-4069-a854-236f6668a66f	2023-11-22 14:12:57.841915	Super.com	\N	{"salary": "", "location": "Boston", "department": "", "tech_stack": []}
258	Senior Full-Stack Software Engineer (Remote)	https://jobs.lever.co/super-com/eb4af77f-ae23-4d52-8c32-7fb773c0d50d	eb4af77f-ae23-4d52-8c32-7fb773c0d50d	2023-11-22 14:12:57.842009	Super.com	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
259	Senior Full-Stack Software Engineer (Remote)	https://jobs.lever.co/super-com/072d2372-dc3e-4c8a-85e7-298e124b1355	072d2372-dc3e-4c8a-85e7-298e124b1355	2023-11-22 14:12:57.842116	Super.com	\N	{"salary": "", "location": "Chicago", "department": "", "tech_stack": []}
260	Senior Software Backend Engineer - Asset Foundations	https://jobs.lever.co/voltus/091124f4-a8e3-479e-90b2-be73a6d5101d	091124f4-a8e3-479e-90b2-be73a6d5101d	2023-11-22 14:12:57.842221	Voltus	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
261	Senior Software Engineer - Data Systems	https://jobs.lever.co/voltus/552ab97b-414d-4b54-83ce-b353f8196a5c	552ab97b-414d-4b54-83ce-b353f8196a5c	2023-11-22 14:12:57.842307	Voltus	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
263	Field Engineering Manager	https://jobs.lever.co/voltus/f4942672-2a09-400a-a1f2-2d6596bd15ca	f4942672-2a09-400a-a1f2-2d6596bd15ca	2023-11-22 14:12:57.842499	Voltus	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
264	.NET Engineer II-387 (Delft - Hybrid)	https://jobs.lever.co/emburse/86335028-5b4c-4655-807e-9060ed54a04c	86335028-5b4c-4655-807e-9060ed54a04c	2023-11-22 14:12:57.842586	Emburse	\N	{"salary": "", "location": "Delft", "department": "", "tech_stack": []}
265	Senior Software Engineer I - 451  (Toronto - Hybrid)	https://jobs.lever.co/emburse/319294a2-aa71-4c00-a99e-c17171e91047	319294a2-aa71-4c00-a99e-c17171e91047	2023-11-22 14:12:57.842674	Emburse	\N	{"salary": "", "location": "Toronto, Canada", "department": "", "tech_stack": []}
267	Site Reliability Engineer III (Toronto - Hybrid) - 304	https://jobs.lever.co/emburse/8e5a8816-2c38-4f5b-8b73-dafaac751e91	8e5a8816-2c38-4f5b-8b73-dafaac751e91	2023-11-22 14:12:57.843027	Emburse	\N	{"salary": "", "location": "Toronto, Canada", "department": "", "tech_stack": []}
268	Site Reliability Engineer III-304 (Barcelona - Hybrid)	https://jobs.lever.co/emburse/406018ca-36eb-418f-8eca-6d2893a687bf	406018ca-36eb-418f-8eca-6d2893a687bf	2023-11-22 14:12:57.843114	Emburse	\N	{"salary": "", "location": "Barcelona", "department": "", "tech_stack": []}
269	Sr Manager, Site Reliability Engineer (Toronto, Hybrid)- 462	https://jobs.lever.co/emburse/d1178118-459e-4e16-9fe1-8cc5cad6cb85	d1178118-459e-4e16-9fe1-8cc5cad6cb85	2023-11-22 14:12:57.843199	Emburse	\N	{"salary": "", "location": "Toronto, Canada", "department": "", "tech_stack": []}
270	Backend Senior Developer	https://boards.greenhouse.io/flyr/jobs/4296770006	4296770006	2023-11-22 14:12:57.843296	FLYR	\N	{"salary": "", "location": "Manizales, Colombia", "department": "", "tech_stack": []}
271	Cloud Platform Engineer	https://boards.greenhouse.io/flyr/jobs/4273709006	4273709006	2023-11-22 14:12:57.843395	FLYR	\N	{"salary": "", "location": "Frankfurt, Germany", "department": "", "tech_stack": []}
272	Cloud Platform Engineer	https://boards.greenhouse.io/flyr/jobs/4282385006	4282385006	2023-11-22 14:12:57.843508	FLYR	\N	{"salary": "", "location": "Amsterdam, Netherlands", "department": "", "tech_stack": []}
273	Frontend Engineer	https://boards.greenhouse.io/flyr/jobs/4282375006	4282375006	2023-11-22 14:12:57.843614	FLYR	\N	{"salary": "", "location": "Kraków, Poland", "department": "", "tech_stack": []}
276	Platform Engineering Manager	https://boards.greenhouse.io/flyr/jobs/4282369006	4282369006	2023-11-22 14:12:57.843934	FLYR	\N	{"salary": "", "location": "Amsterdam, Netherlands", "department": "", "tech_stack": []}
277	Senior Backend Engineer	https://boards.greenhouse.io/flyr/jobs/4282359006	4282359006	2023-11-22 14:12:57.844019	FLYR	\N	{"salary": "", "location": "Kraków, Poland", "department": "", "tech_stack": []}
278	Senior Backend Engineer	https://boards.greenhouse.io/flyr/jobs/4282361006	4282361006	2023-11-22 14:12:57.844108	FLYR	\N	{"salary": "", "location": "Los Angeles, California", "department": "", "tech_stack": []}
279	Senior Cloud Platform Engineer	https://boards.greenhouse.io/flyr/jobs/4282373006	4282373006	2023-11-22 14:12:57.844214	FLYR	\N	{"salary": "", "location": "Amsterdam, Netherlands", "department": "", "tech_stack": []}
280	Senior Data Engineer	https://boards.greenhouse.io/flyr/jobs/4289791006	4289791006	2023-11-22 14:12:57.844297	FLYR	\N	{"salary": "", "location": "Los Angeles, California", "department": "", "tech_stack": []}
281	Senior Data Engineer	https://boards.greenhouse.io/flyr/jobs/4240999006	4240999006	2023-11-22 14:12:57.8444	FLYR	\N	{"salary": "", "location": "San Francisco, California", "department": "", "tech_stack": []}
282	Senior Frontend Developer	https://boards.greenhouse.io/flyr/jobs/4296801006	4296801006	2023-11-22 14:12:57.844505	FLYR	\N	{"salary": "", "location": "Manizales, Colombia", "department": "", "tech_stack": []}
283	Senior Frontend Engineer	https://boards.greenhouse.io/flyr/jobs/4282381006	4282381006	2023-11-22 14:12:57.844603	FLYR	\N	{"salary": "", "location": "Kraków, Poland", "department": "", "tech_stack": []}
284	Senior Full-Stack Engineer	https://boards.greenhouse.io/flyr/jobs/4282357006	4282357006	2023-11-22 14:12:57.844717	FLYR	\N	{"salary": "", "location": "Los Angeles, California", "department": "", "tech_stack": []}
285	Software Architect	https://boards.greenhouse.io/flyr/jobs/4282403006	4282403006	2023-11-22 14:12:57.844816	FLYR	\N	{"salary": "", "location": "Amsterdam, Netherlands", "department": "", "tech_stack": []}
55	Backend Engineer (Senior)	https://jobs.lever.co/infinitus/d9ba043c-f53e-476a-9a6d-2fa02036ed14	d9ba043c-f53e-476a-9a6d-2fa02036ed14	2023-11-22 14:12:57.812199	Infinitus Systems  Inc.	\N	{"salary": "", "location": "San Francisco Bay Area, CA", "department": "", "tech_stack": []}
57	Software Engineer - Distributed Systems	https://jobs.lever.co/starburstdata/d76fa98c-4fa2-4ef4-be8b-68283a881a55	d76fa98c-4fa2-4ef4-be8b-68283a881a55	2023-11-22 14:12:57.812677	Starburst	\N	{"salary": "", "location": "Tel Aviv", "department": "", "tech_stack": []}
286	Software Developer	https://boards.greenhouse.io/flyr/jobs/4301033006	4301033006	2023-11-22 14:12:57.844928	FLYR	\N	{"salary": "", "location": "Manizales, Colombia", "department": "", "tech_stack": []}
287	Software Engineer in Test	https://boards.greenhouse.io/flyr/jobs/4303437006	4303437006	2023-11-22 14:12:57.845026	FLYR	\N	{"salary": "", "location": "Amsterdam, Netherlands", "department": "", "tech_stack": []}
288	Software Tech Lead	https://boards.greenhouse.io/flyr/jobs/4296797006	4296797006	2023-11-22 14:12:57.845156	FLYR	\N	{"salary": "", "location": "Manizales, Colombia", "department": "", "tech_stack": []}
289	Software Tech Lead	https://boards.greenhouse.io/flyr/jobs/4296780006	4296780006	2023-11-22 14:12:57.845255	FLYR	\N	{"salary": "", "location": "Barcelona, Spain", "department": "", "tech_stack": []}
290	Staff Backend Software Engineer	https://boards.greenhouse.io/flyr/jobs/4282407006	4282407006	2023-11-22 14:12:57.845375	FLYR	\N	{"salary": "", "location": "Los Angeles, California", "department": "", "tech_stack": []}
291	Agile Developer	https://jobs.lever.co/servicerocket/5e80dfd2-4b60-4c7c-b41e-ca88e6ee5545	5e80dfd2-4b60-4c7c-b41e-ca88e6ee5545	2023-11-22 14:12:57.845482	ServiceRocket	\N	{"salary": "", "location": "Kuala Lumpur, Malaysia", "department": "", "tech_stack": []}
292	Senior Software Engineer	https://jobs.lever.co/servicerocket/5ea45f87-d79e-4bf6-a428-c9d4fb3cf49b	5ea45f87-d79e-4bf6-a428-c9d4fb3cf49b	2023-11-22 14:12:57.845599	ServiceRocket	\N	{"salary": "", "location": "Kuala Lumpur, Malaysia", "department": "", "tech_stack": []}
293	Associate Support Engineer KUL (LST)	https://jobs.lever.co/servicerocket/bc04edc2-13cc-46b1-b256-d2bf1b7c259a	bc04edc2-13cc-46b1-b256-d2bf1b7c259a	2023-11-22 14:12:57.845884	ServiceRocket	\N	{"salary": "", "location": "Kuala Lumpur, Malaysia", "department": "", "tech_stack": []}
294	Engineer, Customer Support	https://jobs.lever.co/servicerocket/1e9a1c84-ac10-4370-b7d5-96971f87d6e7	1e9a1c84-ac10-4370-b7d5-96971f87d6e7	2023-11-22 14:12:57.845998	ServiceRocket	\N	{"salary": "", "location": "Kuala Lumpur, Malaysia", "department": "", "tech_stack": []}
959	Technical Support Engineer	https://jobs.ashbyhq.com/vantage/214d3845-e3f7-4282-a7bc-b211fb678a80	214d3845-e3f7-4282-a7bc-b211fb678a80	2023-11-22 14:12:57.925831	Vantage	Technical Support Engineer	{"salary": "", "summary": null, "location": "New York - NY", "reasoning": null, "department": "", "tech_stack": []}
297	Senior Software Engineer - Platform Team	https://jobs.lever.co/secondfrontsystems/eb9f3406-24d4-4d2f-9e20-5b01dcaf193a	eb9f3406-24d4-4d2f-9e20-5b01dcaf193a	2023-11-22 14:12:57.846334	Second Front Systems	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
298	Senior Software Engineer - Platform Team (Federal Delivery)	https://jobs.lever.co/secondfrontsystems/d715690b-e748-4970-9e92-3867a9082d98	d715690b-e748-4970-9e92-3867a9082d98	2023-11-22 14:12:57.84642	Second Front Systems	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
301	Senior Software Engineer - Infrastructure	https://jobs.lever.co/qualified/d247ebd7-34e0-4f84-b7ec-0498c2a50497	d247ebd7-34e0-4f84-b7ec-0498c2a50497	2023-11-22 14:12:57.846737	Qualified	\N	{"salary": "", "location": "Remote (US/Canada)", "department": "", "tech_stack": []}
302	Senior Software Engineer - Infrastructure (Brazil)	https://jobs.lever.co/qualified/99a9a8c6-823d-4654-9f2a-7c4d88df7758	99a9a8c6-823d-4654-9f2a-7c4d88df7758	2023-11-22 14:12:57.846841	Qualified	\N	{"salary": "", "location": "Remote (Brazil)", "department": "", "tech_stack": []}
303	Senior Software Engineer (Full Stack)	https://jobs.lever.co/qualified/824616d1-dc21-4303-924a-49b6b484e910	824616d1-dc21-4303-924a-49b6b484e910	2023-11-22 14:12:57.84696	Qualified	\N	{"salary": "", "location": "Remote (US/Canada)", "department": "", "tech_stack": []}
304	Senior Software Engineer (Full-Stack - Brazil)	https://jobs.lever.co/qualified/9709858d-ce18-4745-8be4-6e99831565e1	9709858d-ce18-4745-8be4-6e99831565e1	2023-11-22 14:12:57.847075	Qualified	\N	{"salary": "", "location": "Remote (Brazil)", "department": "", "tech_stack": []}
305	Senior Software Engineering Manager	https://jobs.lever.co/qualified/45a3fc67-4268-4736-b927-99a7e8d1ba6c	45a3fc67-4268-4736-b927-99a7e8d1ba6c	2023-11-22 14:12:57.84718	Qualified	\N	{"salary": "", "location": "San Francisco", "department": "", "tech_stack": []}
306	Sr Engineering Manager	https://boards.greenhouse.io/samcarthiring/jobs/4997641004	4997641004	2023-11-22 14:12:57.847281	SamCart	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
307	Software Engineer	https://boards.greenhouse.io/samcarthiring/jobs/5021130004	5021130004	2023-11-22 14:12:57.847368	SamCart	\N	{"salary": "", "location": "Remote (UK)", "department": "", "tech_stack": []}
308	Sr. DevOps Engineer 	https://boards.greenhouse.io/samcarthiring/jobs/4968616004	4968616004	2023-11-22 14:12:57.84748	SamCart	\N	{"salary": "", "location": "Remote (UK)", "department": "", "tech_stack": []}
309	AWS Staff Engineer	https://boards.greenhouse.io/thoropass/jobs/5020588004	5020588004	2023-11-22 14:12:57.847649	Thoropass	\N	{"salary": "", "location": "Costa Rica (Remote)", "department": "", "tech_stack": []}
82	Software Engineer	https://jobs.lever.co/newfrontinsurance/435a7508-e288-460e-9200-e6ec9dee33ef	435a7508-e288-460e-9200-e6ec9dee33ef	2023-11-22 14:12:57.820924	Newfront	From the Mayflower to the moon landing, every venture relies on insurance. The 1 trillion dollar insurance industry is fundamental to our economy, but has been slow to modernize. It’s a fragmented market that represents an enormous opportunity. We’re the fastest-growing brokerage in the country because we’re built for the 21st century.By building a tech-driven insurance brokerage, we're able to transform the experience for our clients and teammates. Our platform eliminates paperwork for clients and gives them a modern dashboard to administer their Property & Casualty and Employee Benefits. For our internal teams, we take repetitive tasks off their plate by automating hundreds of workflows. Finally, we use data and analytics to negotiate with the insurance markets and find the best coverage and pricing. As part of the Technology team at Newfront, you'll face complex technical challenges like building a files processing engine that can parse and analyze millions of insurance documents or designing a data analytics product that helps HR leaders select among hundreds of plans and vendors.There are lots of opportunities for growth and ownership, including leading projects and teams. Also, we're eager to leverage new technologies and frameworks. Here are a few examples using LLMs that came from a recent hackathon.Our unique approach recognizes both the vast potential of technology and the fundamental role of insurance experts. DE&I is in our DNA and we keep our core values at the center of everything we do. This position is open to remote candidates with Pacific Time Zone preferred. #LI-RemoteEngineering @ Newfront Newfront is building the platform that powers all insurance and benefits decisions to unlock global economic progress. The core engineering organization at Newfront operates with the mission to provide a transformational experience to clients while empowering the producers and service teams with efficient tools and powerful insights. We strive to make the insurance buying process smooth, seamless, and transparent to businesses while providing a powerful internal ecosystem of administrative tools for insurance professionals to successfully onboard and service the client.What You’ll Be Responsible For:Work as an active owner of Newfront Platform Team’s system and product features.Design and build engineering solutions with high reliability and extensibility.Write well-crafted, well-tested, readable, maintainable codeCollaborate with cross-functional design, product, and data science teams to deliver high-quality products and positive business impacts.Qualifications: BS or MS in computer science or related field, or equivalent work experience.6+ years of experience in web application development at scale.Experience shipping enterprise products or applications.Ability to take a thoughtful, pragmatic, and efficient approach to problem-solving.Great communication skills and eagerness to learn and grow.Deep experience with cloud infrastructure such as Docker, Kubernetes, Helm, etc.Experience with AWS infrastructure.Proficiency in one or more backend server languages (Java/Python/Ruby/Go/C++/TypeScript/etc.). Experience using TypeScript on the backend is preferred.Experience with RDBMS such as MySQL/PostgreSQL.Preferred Knowledge, Skills and Abilities:Experience with JavaScript backend frameworks such as Express/Node.js/Nest.js is preferred.Experience with JavaScript frontend frameworks. Experience with React.js/Next.js is preferred.Experience with platform engineering fundamentals like Authentication, Authorization, Search, etc.Experience with building devops ecosystem: CI/CD pipelines, local development environment.The pay range for this position in California, Washington, Colorado, and New York at the commencement of employment is expected to be between $186,800 and $233,500/yr; however, base pay offered may vary depending on multiple individualized factors, including market location, job-related knowledge, skills, and experience. The total compensation package for this position may also include other elements, including a bonus, restricted stock units, and discretionary awards in addition to a full range of medical, financial, and/or other benefits (including 401(k) eligibility and various paid time off benefits, such as vacation, sick time, and parental leave), dependent on the position offered. Details of participation in these benefit plans will be provided if an employee receives an offer of employment. If hired, the employee will be in an “at-will position,” and the Company reserves the right to modify base salary (as well as any other discretionary payment or compensation program) at any time, including for reasons related to individual performance, Company or individual department/team performance, and market factors.At Newfront, we are committed to hiring diverse talent and supporting an inclusive workplace environment. If you are excited about a role at Newfront but feel you’re missing a few of the qualifications, we still encourage you to apply and tell us about yourself. You may just be the next Newfront team member that we are looking for! Newfront is proud to be an equal opportunity workplace. Diversity is in our DNA and we believe that creating an inclusive workplace elevates the value we are able to bring to our customers and employees alike. All qualified applicants will receive consideration for employment without regard to age, race, color, religion, sex, sexual orientation, gender identity, national origin, genetic information, disability, veteran status, or any other applicable status protected by state or local law. If you require reasonable accommodations throughout the application or interview process, please contact us at careers@newfront.com. For information regarding how Newfront collects and uses personal information, please review our Privacy Policy.	{"apply": "False", "salary": "$186,800 - $233,500/year", "summary": "Newfront, a tech-driven insurance brokerage, is seeking a highly experienced full stack developer to work on their platform team. The role involves designing and building engineering solutions, collaborating with cross-functional teams, and leveraging new technologies and frameworks. The position offers a competitive salary and benefits package, and the company is committed to diversity and inclusion.", "location": "United States (Remote)", "reasoning": "The job is not applicable for a full stack developer with 0-3 years of experience as it requires 6+ years of experience and a degree in computer science or related field.", "department": null, "tech_stack": ["Docker", "Kubernetes", "Helm", "AWS", "Java", "Python", "Ruby", "Go", "C++", "TypeScript", "Express", "Node.js", "Nest.js", "React.js", "Next.js", "RDBMS", "MySQL", "PostgreSQL"]}
58	Senior Software Engineer - Distributed Systems	https://jobs.lever.co/starburstdata/35327781-234c-434e-a75e-0c1c61dc4291	35327781-234c-434e-a75e-0c1c61dc4291	2023-11-22 14:12:57.812893	Starburst	\N	{"salary": "", "location": "Warsaw / Poland", "department": "", "tech_stack": []}
59	Software Engineer - Full Stack	https://jobs.lever.co/starburstdata/c034a6d6-57a3-4a19-b732-752fdadf7584	c034a6d6-57a3-4a19-b732-752fdadf7584	2023-11-22 14:12:57.813108	Starburst	\N	{"salary": "", "location": "Warsaw / Poland", "department": "", "tech_stack": []}
311	Cloud Network Engineer	https://jobs.lever.co/marco/c97c5ae6-f56d-438b-84be-013131310a3a	c97c5ae6-f56d-438b-84be-013131310a3a	2023-11-22 14:12:57.847866	Marco Technologies	\N	{"salary": "", "location": "St. Cloud, MN / Rochester, MN / Eau Claire, WI / Little Chute, WI / Madison, WI / Maple Grove, MN / Mankato, MN / Milwaukee, WI / Minnetonka, MN", "department": "", "tech_stack": []}
312	Senior Data Center Engineer	https://jobs.lever.co/marco/06f9250c-b28c-4b22-9b0b-2ac41ec71adc	06f9250c-b28c-4b22-9b0b-2ac41ec71adc	2023-11-22 14:12:57.847964	Marco Technologies	\N	{"salary": "", "location": "St. Cloud, MN / Appleton, WI / Madison, WI / Mankato, MN / Milwaukee, WI / Minnetonka, MN / Rochester, MN", "department": "", "tech_stack": []}
313	Senior Systems Engineer - Innovation	https://jobs.lever.co/marco/fea23d1a-5ae0-432d-8936-9bcfccc5666b	fea23d1a-5ae0-432d-8936-9bcfccc5666b	2023-11-22 14:12:57.848078	Marco Technologies	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
317	Principal Software Engineer - Carrier Group	https://jobs.lever.co/easypost-2/c61446fd-ff86-4c24-99ee-94c238d53a58	c61446fd-ff86-4c24-99ee-94c238d53a58	2023-11-22 14:12:57.848643	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
318	Senior Software Engineer - Carriers Network - Python	https://jobs.lever.co/easypost-2/71d6f72d-a786-4d67-aac3-05408a67725d	71d6f72d-a786-4d67-aac3-05408a67725d	2023-11-22 14:12:57.848727	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
319	Senior Software Engineer - Golang	https://jobs.lever.co/easypost-2/bec0d98a-9229-49f8-9416-79944a1c8338	bec0d98a-9229-49f8-9416-79944a1c8338	2023-11-22 14:12:57.84883	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
320	Director of Engineering Systems	https://jobs.lever.co/easypost-2/b56db448-2137-4e26-b821-cfc32784309b	b56db448-2137-4e26-b821-cfc32784309b	2023-11-22 14:12:57.848915	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
321	Staff Platform Software Engineer (Go/ Ruby)	https://jobs.lever.co/easypost-2/30c48d59-28e9-4af7-9216-d01c1512a5f2	30c48d59-28e9-4af7-9216-d01c1512a5f2	2023-11-22 14:12:57.849019	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
322	Senior Application Security Engineer	https://jobs.lever.co/easypost-2/646e8255-c4f2-4625-8445-3591d761195f	646e8255-c4f2-4625-8445-3591d761195f	2023-11-22 14:12:57.84911	Rafay	\N	{"salary": "", "location": "Remote", "department": "", "tech_stack": []}
323	Hardware Engineer, Electrical	https://jobs.lever.co/kodiak/fa3a18c6-95bc-4fce-b5fe-365e68be9b76	fa3a18c6-95bc-4fce-b5fe-365e68be9b76	2023-11-22 14:12:57.849213	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
324	Senior Mechanical Engineer	https://jobs.lever.co/kodiak/8f847858-95cf-4016-b218-4a68d5680989	8f847858-95cf-4016-b218-4a68d5680989	2023-11-22 14:12:57.849314	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
332	Senior Software Engineer, Deep Learning for Computer Vision	https://jobs.lever.co/kodiak/9622dc96-b70c-4836-8a0f-194a7969e320	9622dc96-b70c-4836-8a0f-194a7969e320	2023-11-22 14:12:57.850199	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
333	Senior Software Engineer, Machine Learning Infrastructure	https://jobs.lever.co/kodiak/82af5068-734f-44a1-b62b-e863acea6d75	82af5068-734f-44a1-b62b-e863acea6d75	2023-11-22 14:12:57.850291	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
997	Infrastructure Engineer	https://boards.greenhouse.io/mutiny/jobs/4334699005	4334699005	2023-11-22 14:12:57.932014	Mutiny	\N	{"salary": "", "location": "Remote (North America)", "department": "", "tech_stack": []}
334	Senior Software Engineer, Sensor Fusion & State Estimation	https://jobs.lever.co/kodiak/4badda56-856f-487d-9aba-20825c111204	4badda56-856f-487d-9aba-20825c111204	2023-11-22 14:12:57.850401	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
335	Senior Software Engineer, Simulation	https://jobs.lever.co/kodiak/105f7ba2-b0f5-44f6-b911-595e925f3bc0	105f7ba2-b0f5-44f6-b911-595e925f3bc0	2023-11-22 14:12:57.850495	Kodiak	\N	{"salary": "", "location": "Mountain View, CA", "department": "", "tech_stack": []}
339	Application Security Engineer - AppSec	https://jobs.lever.co/docebo/8c222f00-2dad-4ea4-a843-c1457c27c021	8c222f00-2dad-4ea4-a843-c1457c27c021	2023-11-22 14:12:57.851074	Docebo	\N	{"salary": "", "location": "Biassono, Italy", "department": "", "tech_stack": []}
340	Cloud Security Engineer - SecOps	https://jobs.lever.co/docebo/044023ed-7d43-4b11-8d92-4695549ec94c	044023ed-7d43-4b11-8d92-4695549ec94c	2023-11-22 14:12:57.851166	Docebo	\N	{"salary": "", "location": "Biassono, Italy", "department": "", "tech_stack": []}
341	AI RESEARCH ENGINEER	https://boards.greenhouse.io/alphasense/jobs/6888226002	6888226002	2023-11-22 14:12:57.85126	AlphaSense	\N	{"salary": "", "location": "Bengaluru, Karnataka, India", "department": "", "tech_stack": []}
342	Cloud Platform Engineer (Storages)	https://boards.greenhouse.io/alphasense/jobs/6847552002	6847552002	2023-11-22 14:12:57.851356	AlphaSense	\N	{"salary": "", "location": "Delhi, India", "department": "", "tech_stack": []}
343	Director of Engineering - Enterprise Technology	https://boards.greenhouse.io/alphasense/jobs/6910632002	6910632002	2023-11-22 14:12:57.85145	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
344	Director of Engineering - Enterprise Technology	https://boards.greenhouse.io/alphasense/jobs/6914423002	6914423002	2023-11-22 14:12:57.851556	AlphaSense	\N	{"salary": "", "location": "London, Greater London, England, United Kingdom", "department": "", "tech_stack": []}
345	Engineering Manager	https://boards.greenhouse.io/alphasense/jobs/6985757002	6985757002	2023-11-22 14:12:57.851691	AlphaSense	\N	{"salary": "", "location": "Bengaluru, Karnataka, India", "department": "", "tech_stack": []}
346	Engineering Manager - Cloud Platform Engineer Core (Kubernetes)	https://boards.greenhouse.io/alphasense/jobs/7004266002	7004266002	2023-11-22 14:12:57.851805	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
60	Senior Backend Engineer	https://boards.greenhouse.io/vareto/jobs/4896109004	4896109004	2023-11-22 14:12:57.813303	Vareto	\N	{"salary": "", "location": "Remote in US, Canada, Brazil", "department": "", "tech_stack": []}
63	Engineering Manager	https://boards.greenhouse.io/jellyfish/jobs/4682397004	4682397004	2023-11-22 14:12:57.814354	Jellyfish	\N	{"salary": "", "location": "Boston, MA or Remote", "department": "", "tech_stack": []}
65	Director, Engineering - Vehicle Intent	https://boards.greenhouse.io/torcrobotics/jobs/6942684002	6942684002	2023-11-22 14:12:57.814762	Torc Robotics	\N	{"salary": "", "location": "Blacksburg, VA; Austin, TX; Remote, US", "department": "", "tech_stack": []}
347	Engineering Manager, Expert Insights	https://boards.greenhouse.io/alphasense/jobs/7002180002	7002180002	2023-11-22 14:12:57.851921	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
348	QA Automation Engineer	https://boards.greenhouse.io/alphasense/jobs/6934586002	6934586002	2023-11-22 14:12:57.852027	AlphaSense	\N	{"salary": "", "location": "Pune", "department": "", "tech_stack": []}
349	Senior Automation QA Engineer	https://boards.greenhouse.io/alphasense/jobs/7002335002	7002335002	2023-11-22 14:12:57.852127	AlphaSense	\N	{"salary": "", "location": "Bengaluru, Karnataka, India", "department": "", "tech_stack": []}
350	Senior Cloud Platform Engineer	https://boards.greenhouse.io/alphasense/jobs/6805290002	6805290002	2023-11-22 14:12:57.85223	AlphaSense	\N	{"salary": "", "location": "Delhi, India", "department": "", "tech_stack": []}
351	Senior Cloud Platform Engineer (Cloud Integrations & Crossplane)	https://boards.greenhouse.io/alphasense/jobs/6947687002	6947687002	2023-11-22 14:12:57.852329	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
352	Senior Cloud Platform Engineer (Data Management)	https://boards.greenhouse.io/alphasense/jobs/6945894002	6945894002	2023-11-22 14:12:57.852446	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
353	Senior Cloud Platform Engineer DevEx (GitHub)	https://boards.greenhouse.io/alphasense/jobs/6935193002	6935193002	2023-11-22 14:12:57.85256	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
354	Senior Cloud Platform Engineer (FinOps)	https://boards.greenhouse.io/alphasense/jobs/6935184002	6935184002	2023-11-22 14:12:57.852664	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
355	Senior Cloud Platform Engineer (Kubernetes - Azure)	https://boards.greenhouse.io/alphasense/jobs/6935166002	6935166002	2023-11-22 14:12:57.852779	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
356	Senior QA Automation Engineer, Expert Insights	https://boards.greenhouse.io/alphasense/jobs/6988175002	6988175002	2023-11-22 14:12:57.85289	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
357	Senior Software Engineer, AI Platform	https://boards.greenhouse.io/alphasense/jobs/7012313002	7012313002	2023-11-22 14:12:57.853009	AlphaSense	\N	{"salary": "", "location": "New York, New York, United States", "department": "", "tech_stack": []}
358	Senior Software Engineer - AI & Search Platform	https://boards.greenhouse.io/alphasense/jobs/6872841002	6872841002	2023-11-22 14:12:57.85312	AlphaSense	\N	{"salary": "", "location": "Bengaluru, Karnataka, India", "department": "", "tech_stack": []}
359	Senior Software Engineer - AI & Search Platform - Vector Search	https://boards.greenhouse.io/alphasense/jobs/6894154002	6894154002	2023-11-22 14:12:57.853232	AlphaSense	\N	{"salary": "", "location": "Bengaluru, Karnataka, India", "department": "", "tech_stack": []}
360	Senior Software Engineer (Java), Expert Insights	https://boards.greenhouse.io/alphasense/jobs/7002210002	7002210002	2023-11-22 14:12:57.853346	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
361	Senior Software Engineer, LLM	https://boards.greenhouse.io/alphasense/jobs/6915354002	6915354002	2023-11-22 14:12:57.853472	AlphaSense	\N	{"salary": "", "location": "New York, New York, United States", "department": "", "tech_stack": []}
362	Senior Software Engineer - Search (Java)	https://boards.greenhouse.io/alphasense/jobs/6980400002	6980400002	2023-11-22 14:12:57.853594	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
363	Senior Software Engineer (TypeScript), Expert Insights	https://boards.greenhouse.io/alphasense/jobs/7002204002	7002204002	2023-11-22 14:12:57.853686	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
364	Senior Software Engineer, User Management (Java)	https://boards.greenhouse.io/alphasense/jobs/6778724002	6778724002	2023-11-22 14:12:57.853982	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
365	Software Engineer (Frontend)	https://boards.greenhouse.io/alphasense/jobs/7002328002	7002328002	2023-11-22 14:12:57.854083	AlphaSense	\N	{"salary": "", "location": "Pune", "department": "", "tech_stack": []}
366	Software Engineer Platform	https://boards.greenhouse.io/alphasense/jobs/6976126002	6976126002	2023-11-22 14:12:57.854181	AlphaSense	\N	{"salary": "", "location": "Pune", "department": "", "tech_stack": []}
1128	Enterprise Sales Engineer 	https://boards.greenhouse.io/sysdig/jobs/5320962	5320962	2023-11-22 14:12:57.94657	Sysdig	\N	{"salary": "", "location": "Boston (Flexible) ", "department": "", "tech_stack": []}
367	Software Engineer / Senior Software Engineer	https://boards.greenhouse.io/alphasense/jobs/7015816002	7015816002	2023-11-22 14:12:57.854278	AlphaSense	\N	{"salary": "", "location": "Mumbai", "department": "", "tech_stack": []}
368	Software Engineer / Senior Software Engineer	https://boards.greenhouse.io/alphasense/jobs/7004268002	7004268002	2023-11-22 14:12:57.854388	AlphaSense	\N	{"salary": "", "location": "Delhi, India", "department": "", "tech_stack": []}
369	Software Engineer / Senior Software Engineer	https://boards.greenhouse.io/alphasense/jobs/7015814002	7015814002	2023-11-22 14:12:57.854502	AlphaSense	\N	{"salary": "", "location": "Pune", "department": "", "tech_stack": []}
370	Software Engineer/Senior Software Engineer	https://boards.greenhouse.io/alphasense/jobs/6740876002	6740876002	2023-11-22 14:12:57.854614	AlphaSense	\N	{"salary": "", "location": "India", "department": "", "tech_stack": []}
424	Senior Java Developer (VBC)	https://boards.greenhouse.io/vonage/jobs/6470460002	6470460002	2023-11-22 14:12:57.860312	Vonage	\N	{"salary": "", "location": "Bangalore", "department": "", "tech_stack": []}
1620	Manufacturing Process Quality Engineer	https://jobs.lever.co/zoox/9ce5bb7a-5e20-4685-bfb8-f0fff13f2cd7	9ce5bb7a-5e20-4685-bfb8-f0fff13f2cd7	2023-11-22 14:12:58.002402	Zoox	The Manufacturing Process Quality Engineer will ensure that all processes that are conducted as part of the assembly, bring-up, and End-of-Line (EOL) testing of our vehicles will meet the high-quality standard of Zoox. This includes the development and implementation of In-Line and End-of-Line quality checks as well as driving the root cause resolution of any issues that occur during the manufacturing process. As part of a daily routine, the Manufacturing Process Quality Engineer will interact with many different parties including Corporate Quality, Vehicle Engineering, Supplier Quality, and Software.ResponsibilitiesDevelopment and integration of quality and functional checks into the manufacturing processConduct root-cause analysis for any assembly-related issuesDevelopment, implementation, and optimization of the End-of-Line processCreating and maintaining of PFMEAsDevelopment and Implementation of control plansAnalysis of quality data to improve the assembly and test processWork cross-functionally to help resolve supplier quality or design-related issues that occurred during the manufacturing processContribute to the definition and improvement of Zoox Quality Policy and ManualCreate the procedures, instructions, and processes that will allow Zoox to align with the international standards for Quality Systems (IATF 16949, ISO 9000, and similar)QualificationsEngineering Degree in the respective field (Manufacturing, Electrical, Mechanical, Industrial)Minimum 3 years of experience in quality/manufacturing engineeringExperience with creating FMEA process / Control Plan / APQPAble to work fully independent with minimal supervisionBonus QualificationsAutomotive OEM or Tier 1 supplier experienceProcess Improvement certification (Lean Six Sigma / Shainin)CATIA V5/V6 experienceCompensationThere are three major components to compensation for this position: salary, Amazon Restricted Stock Units (RSUs), and Zoox Stock Appreciation Rights. The salary range for this position is $113,000 to $184,000. A sign-on bonus may be offered as part of the compensation package. Compensation will vary based on geographic location and level. Leveling, as well as positioning within a level, is determined by a range of factors, including, but not limited to, a candidate's relevant years of experience, domain knowledge, and interview performance. The salary range listed in this posting is representative of the range of levels Zoox is considering for this position. Zoox also offers a comprehensive package of benefits including paid time off (e.g. sick leave, vacation, bereavement), unpaid time off, Zoox Stock Appreciation Rights, Amazon RSUs, health insurance, long-term care insurance, long-term and short-term disability insurance, and life insurance.About ZooxZoox is developing the first ground-up, fully autonomous vehicle fleet and the supporting ecosystem required to bring this technology to market. Sitting at the intersection of robotics, machine learning, and design, Zoox aims to provide the next generation of mobility-as-a-service in urban environments. We’re looking for top talent that shares our passion and wants to be part of a fast-moving and highly execution-oriented team.Follow us on LinkedInA Final Note:You do not need to match every listed expectation to apply for this position. Here at Zoox, we know that diverse perspectives foster the innovation we need to be successful, and we are committed to building a team that encompasses a variety of backgrounds, experiences, and skills.	{"apply": "False", "salary": "$113,000 - $184,000 /year", "summary": "The Manufacturing Process Quality Engineer at Zoox is responsible for ensuring high-quality standards in the assembly and testing of autonomous vehicles. This role involves developing quality checks, analyzing data, and driving resolution of manufacturing issues. The position requires a minimum of 3 years of experience and expertise in various quality and manufacturing processes. Knowledge of international quality standards and experience in the automotive industry are preferred. The salary ranges from $113,000 to $184,000 per year, with additional benefits and stock options.", "location": "Fremont, CA", "reasoning": "False", "department": null, "tech_stack": ["IATF 16949", "ISO 9000", "Lean Six Sigma", "Shainin", "CATIA V5/V6"]}
371	Staff Cloud platform Engineer (Storages)	https://boards.greenhouse.io/alphasense/jobs/6847564002	6847564002	2023-11-22 14:12:57.854718	AlphaSense	\N	{"salary": "", "location": "Delhi, India", "department": "", "tech_stack": []}
372	Staff Engineer, iOS	https://boards.greenhouse.io/alphasense/jobs/6945857002	6945857002	2023-11-22 14:12:57.854806	AlphaSense	\N	{"salary": "", "location": "Helsinki, Uusimaa, Finland", "department": "", "tech_stack": []}
373	Data Engineer, Business Intelligence	https://jobs.lever.co/attentive/fa10ee2c-db2a-4c73-9850-c523411deeb6	fa10ee2c-db2a-4c73-9850-c523411deeb6	2023-11-22 14:12:57.8549	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
374	Director of Engineering - User Data	https://jobs.lever.co/attentive/eac5d1af-c3fc-49b9-a1d7-b7cbe2661274	eac5d1af-c3fc-49b9-a1d7-b7cbe2661274	2023-11-22 14:12:57.855008	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
375	Engineering Manager	https://jobs.lever.co/attentive/15b40ce2-d9f5-4523-8d98-6722c3fb0587	15b40ce2-d9f5-4523-8d98-6722c3fb0587	2023-11-22 14:12:57.855092	Attentive	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
376	Engineering Manager, Machine Learning	https://jobs.lever.co/attentive/9452f1d5-71e5-4b49-868c-7cccaf018813	9452f1d5-71e5-4b49-868c-7cccaf018813	2023-11-22 14:12:57.855198	Attentive	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
377	Engineering Manager, Site Reliability	https://jobs.lever.co/attentive/8c76ded5-4755-4d4d-9e4e-5450862bb1ba	8c76ded5-4755-4d4d-9e4e-5450862bb1ba	2023-11-22 14:12:57.855284	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
378	Principal Software Engineer	https://jobs.lever.co/attentive/6c25dbb4-c9de-48ea-bca5-e64d81dd87e3	6c25dbb4-c9de-48ea-bca5-e64d81dd87e3	2023-11-22 14:12:57.855373	Attentive	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
379	Senior Machine Learning Engineer	https://jobs.lever.co/attentive/5fe02951-3584-4363-9a64-94b1fe38d357	5fe02951-3584-4363-9a64-94b1fe38d357	2023-11-22 14:12:57.855476	Attentive	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
380	Senior Security Engineer, Cloud Security	https://jobs.lever.co/attentive/609b521f-ed82-4a78-bc16-9a8bdccd34bc	609b521f-ed82-4a78-bc16-9a8bdccd34bc	2023-11-22 14:12:57.855569	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
381	Senior Software Engineer	https://jobs.lever.co/attentive/d71aaf51-10f5-4a55-9595-559ea09b04a8	d71aaf51-10f5-4a55-9595-559ea09b04a8	2023-11-22 14:12:57.855675	Attentive	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
382	Senior Software Engineer	https://jobs.lever.co/attentive/ae899b91-8ec1-4420-9e42-cf0abafda349	ae899b91-8ec1-4420-9e42-cf0abafda349	2023-11-22 14:12:57.855772	Attentive	\N	{"salary": "", "location": "New York, NY", "department": "", "tech_stack": []}
383	Senior Software Engineer - BI Reporting Team	https://jobs.lever.co/attentive/f170b808-c076-4ee1-9000-5bd8c5408a19	f170b808-c076-4ee1-9000-5bd8c5408a19	2023-11-22 14:12:57.855859	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
384	Senior Software Engineer, Integrations	https://jobs.lever.co/attentive/36f6ccc3-49fc-45ca-84d4-010462b52432	36f6ccc3-49fc-45ca-84d4-010462b52432	2023-11-22 14:12:57.85595	Attentive	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
385	Platform Engineer	https://jobs.lever.co/zerofox/af573545-a6b5-45c3-bb26-c4f08eec7a70	af573545-a6b5-45c3-bb26-c4f08eec7a70	2023-11-22 14:12:57.856037	ZeroFox	\N	{"salary": "", "location": "Bengaluru", "department": "", "tech_stack": []}
386	Senior Data Engineer	https://jobs.lever.co/zerofox/85f78569-4524-48ea-9478-83200811e1d0	85f78569-4524-48ea-9478-83200811e1d0	2023-11-22 14:12:57.856132	ZeroFox	\N	{"salary": "", "location": "Santiago", "department": "", "tech_stack": []}
387	Senior DevOps Engineer	https://jobs.lever.co/zerofox/35f0ddda-728f-4eeb-9bb4-ff7eb338f202	35f0ddda-728f-4eeb-9bb4-ff7eb338f202	2023-11-22 14:12:57.856229	ZeroFox	\N	{"salary": "", "location": "Santiago", "department": "", "tech_stack": []}
388	Senior Machine Learning Engineer	https://jobs.lever.co/zerofox/7bfc5fb7-72ad-477e-bdd9-1d83befd6fcd	7bfc5fb7-72ad-477e-bdd9-1d83befd6fcd	2023-11-22 14:12:57.85648	ZeroFox	\N	{"salary": "", "location": "Santiago", "department": "", "tech_stack": []}
389	Senior Quality Assurance Automation Engineer	https://jobs.lever.co/zerofox/84d52952-4617-49f4-92e9-43853444fccf	84d52952-4617-49f4-92e9-43853444fccf	2023-11-22 14:12:57.856564	ZeroFox	\N	{"salary": "", "location": "Santiago", "department": "", "tech_stack": []}
390	Senior Software Engineer - Prague	https://jobs.lever.co/zerofox/100bfee8-58a2-4f4b-b255-9e2700cf3dcc	100bfee8-58a2-4f4b-b255-9e2700cf3dcc	2023-11-22 14:12:57.856651	ZeroFox	\N	{"salary": "", "location": "Prague", "department": "", "tech_stack": []}
391	Engineering Manager - Infrastructure	https://boards.greenhouse.io/genies/jobs/5784226003	5784226003	2023-11-22 14:12:57.856757	Genies	\N	{"salary": "", "location": "San Mateo, CA", "department": "", "tech_stack": []}
66	Engineering Manager, Sensing & Understanding	https://boards.greenhouse.io/torcrobotics/jobs/7013745002	7013745002	2023-11-22 14:12:57.815037	Torc Robotics	\N	{"salary": "", "location": "Austin, TX, Blacksburg, VA; Remote, US", "department": "", "tech_stack": []}
67	Senior Embedded Software Engineer - Automotive	https://boards.greenhouse.io/torcrobotics/jobs/6960450002	6960450002	2023-11-22 14:12:57.817518	Torc Robotics	\N	{"salary": "", "location": "Blacksburg, VA; Austin, TX; Remote", "department": "", "tech_stack": []}
68	Senior Test Engineer	https://boards.greenhouse.io/torcrobotics/jobs/7010026002	7010026002	2023-11-22 14:12:57.817919	Torc Robotics	\N	{"salary": "", "location": "Albuquerque, NM; Remote - US", "department": "", "tech_stack": []}
392	Lead Unity Engineer - Developer Kit	https://boards.greenhouse.io/genies/jobs/5774129003	5774129003	2023-11-22 14:12:57.856849	Genies	\N	{"salary": "", "location": "San Mateo, CA", "department": "", "tech_stack": []}
393	Senior NLP Research Engineer 	https://boards.greenhouse.io/genies/jobs/5740650003	5740650003	2023-11-22 14:12:57.856957	Genies	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
395	Senior Gameplay Engineer	https://boards.greenhouse.io/genies/jobs/5766919003	5766919003	2023-11-22 14:12:57.857148	Genies	\N	{"salary": "", "location": "San Francisco, CA", "department": "", "tech_stack": []}
396	Sales Engineer (Accounting/Audit) Sydney, AUS	https://jobs.lever.co/floqast/7a0bede1-dba6-489f-ac40-0ac33700eaf7	7a0bede1-dba6-489f-ac40-0ac33700eaf7	2023-11-22 14:12:57.857234	FloQast	\N	{"salary": "", "location": "Sydney", "department": "", "tech_stack": []}
397	Sales Engineer (Accounting/Audit), EMEA	https://jobs.lever.co/floqast/eb1d9d20-58d3-4b04-a59b-b77af42d4fda	eb1d9d20-58d3-4b04-a59b-b77af42d4fda	2023-11-22 14:12:57.857317	FloQast	\N	{"salary": "", "location": "London, England", "department": "", "tech_stack": []}
1929	Developer Advocate / DevEx Engineer	https://jobs.ashbyhq.com/mui/28287eeb-88d2-465f-96d7-e7fd99fabd7d	28287eeb-88d2-465f-96d7-e7fd99fabd7d	2023-11-22 14:12:58.038183	MUI	You will delight our users and make them excited about the product roadmap.	{"salary": "", "summary": null, "location": "Remote", "reasoning": null, "department": "", "tech_stack": []}
401	Netsuite Developer	https://jobs.lever.co/floqast/f1bfde09-4a56-4fbd-b166-02bee12dc755	f1bfde09-4a56-4fbd-b166-02bee12dc755	2023-11-22 14:12:57.857701	FloQast	\N	{"salary": "", "location": "United States", "department": "", "tech_stack": []}
402	Software Developer	https://jobs.lever.co/rangle/134fbc95-505f-455f-a8cc-98f7d1618218	134fbc95-505f-455f-a8cc-98f7d1618218	2023-11-22 14:12:57.857803	Rangle.io	\N	{"salary": "", "location": "Toronto", "department": "", "tech_stack": []}
404	Backend Engineer	https://boards.greenhouse.io/vonage/jobs/6999623002	6999623002	2023-11-22 14:12:57.858012	Vonage	\N	{"salary": "", "location": "London, England, United Kingdom, Remote - Poland, Remote - Spain", "department": "", "tech_stack": []}
405	DevOps Engineer	https://boards.greenhouse.io/vonage/jobs/6714754002	6714754002	2023-11-22 14:12:57.858136	Vonage	\N	{"salary": "", "location": "Poland", "department": "", "tech_stack": []}
406	DevOps Engineer	https://boards.greenhouse.io/vonage/jobs/6980194002	6980194002	2023-11-22 14:12:57.858232	Vonage	\N	{"salary": "", "location": "UK", "department": "", "tech_stack": []}
407	DevOps Engineer	https://boards.greenhouse.io/vonage/jobs/6904902002	6904902002	2023-11-22 14:12:57.858341	Vonage	\N	{"salary": "", "location": "Israel", "department": "", "tech_stack": []}
408	DevOps Engineering Manager	https://boards.greenhouse.io/vonage/jobs/6983703002	6983703002	2023-11-22 14:12:57.858679	Vonage	\N	{"salary": "", "location": "Bangalore", "department": "", "tech_stack": []}
409	Engineering Manager	https://boards.greenhouse.io/vonage/jobs/7018556002	7018556002	2023-11-22 14:12:57.858829	Vonage	\N	{"salary": "", "location": "Poland - Remote ", "department": "", "tech_stack": []}
410	Engineering Manager - BSS	https://boards.greenhouse.io/vonage/jobs/6988003002	6988003002	2023-11-22 14:12:57.85892	Vonage	\N	{"salary": "", "location": "Bangalore", "department": "", "tech_stack": []}
411	Full Stack Developer (Dashboard) 	https://boards.greenhouse.io/vonage/jobs/6722925002	6722925002	2023-11-22 14:12:57.859034	Vonage	\N	{"salary": "", "location": "Remote, Spain ", "department": "", "tech_stack": []}
412	Java Backend Developer 	https://boards.greenhouse.io/vonage/jobs/6714753002	6714753002	2023-11-22 14:12:57.859133	Vonage	\N	{"salary": "", "location": "Poland", "department": "", "tech_stack": []}
413	Java Backend Developer 	https://boards.greenhouse.io/vonage/jobs/6851713002	6851713002	2023-11-22 14:12:57.859239	Vonage	\N	{"salary": "", "location": "Poland", "department": "", "tech_stack": []}
414	Java Software Engineer	https://boards.greenhouse.io/vonage/jobs/6853412002	6853412002	2023-11-22 14:12:57.85934	Vonage	\N	{"salary": "", "location": "Remote, Poland", "department": "", "tech_stack": []}
415	.Net Software Engineer	https://boards.greenhouse.io/vonage/jobs/6815588002	6815588002	2023-11-22 14:12:57.859447	Vonage	\N	{"salary": "", "location": "Poland - Remote", "department": "", "tech_stack": []}
416	.Net Software Engineer	https://boards.greenhouse.io/vonage/jobs/6889876002	6889876002	2023-11-22 14:12:57.859535	Vonage	\N	{"salary": "", "location": "Spain - Remote", "department": "", "tech_stack": []}
417	Python - Backend Engineer	https://boards.greenhouse.io/vonage/jobs/6953694002	6953694002	2023-11-22 14:12:57.859632	Vonage	\N	{"salary": "", "location": "Bangalore", "department": "", "tech_stack": []}
418	Senior Backend Developer	https://boards.greenhouse.io/vonage/jobs/6711460002	6711460002	2023-11-22 14:12:57.859737	Vonage	\N	{"salary": "", "location": "Poland", "department": "", "tech_stack": []}
419	Senior Backend Engineer	https://boards.greenhouse.io/vonage/jobs/6980489002	6980489002	2023-11-22 14:12:57.859825	Vonage	\N	{"salary": "", "location": "London, UK, Remote Spain, Poland ", "department": "", "tech_stack": []}
70	Staff Engineer (m/f/d), Generative AI	https://boards.greenhouse.io/torcrobotics/jobs/7022908002	7022908002	2023-11-22 14:12:57.818413	Torc Robotics	\N	{"salary": "", "location": "Stuttgart, DEU", "department": "", "tech_stack": []}
420	Senior Director - Software Engineering	https://boards.greenhouse.io/vonage/jobs/6967488002	6967488002	2023-11-22 14:12:57.859932	Vonage	\N	{"salary": "", "location": "London, England, United Kingdom, Remote - Spain, Wrocław, Dolnośląskie, Poland", "department": "", "tech_stack": []}
421	Senior Director - Software Engineering	https://boards.greenhouse.io/vonage/jobs/6968777002	6968777002	2023-11-22 14:12:57.860019	Vonage	\N	{"salary": "", "location": "USA, East Coast - Remote ", "department": "", "tech_stack": []}
422	Senior Frontend Engineer	https://boards.greenhouse.io/vonage/jobs/6980508002	6980508002	2023-11-22 14:12:57.860123	Vonage	\N	{"salary": "", "location": "London, UK, Remote Poland - Spain ", "department": "", "tech_stack": []}
423	Senior Full stack Engineer	https://boards.greenhouse.io/vonage/jobs/6932815002	6932815002	2023-11-22 14:12:57.860223	Vonage	\N	{"salary": "", "location": "England, Remote UK", "department": "", "tech_stack": []}
430	Software Engineer	https://boards.greenhouse.io/vonage/jobs/6940275002	6940275002	2023-11-22 14:12:57.861585	Vonage	\N	{"salary": "", "location": "Israel", "department": "", "tech_stack": []}
431	Test Engineer	https://boards.greenhouse.io/vonage/jobs/6960444002	6960444002	2023-11-22 14:12:57.861686	Vonage	\N	{"salary": "", "location": "Israel", "department": "", "tech_stack": []}
432	VP of Software Engineering	https://boards.greenhouse.io/vonage/jobs/6967330002	6967330002	2023-11-22 14:12:57.861813	Vonage	\N	{"salary": "", "location": "London, England, United Kingdom, Remote - Spain, Wrocław, Dolnośląskie, Poland", "department": "", "tech_stack": []}
433	VP of Software Engineering	https://boards.greenhouse.io/vonage/jobs/6968707002	6968707002	2023-11-22 14:12:57.861944	Vonage	\N	{"salary": "", "location": "USA East Coast - Remote", "department": "", "tech_stack": []}
434	DevOps Engineer (Windows admin experience 6+ years)	https://boards.greenhouse.io/vonage/jobs/6769430002	6769430002	2023-11-22 14:12:57.862196	Vonage	\N	{"salary": "", "location": "Bangalore, India", "department": "", "tech_stack": []}
437	Sr Security & Compliance Engineer	https://boards.greenhouse.io/vonage/jobs/6948671002	6948671002	2023-11-22 14:12:57.862504	Vonage	\N	{"salary": "", "location": "Holmdel, NJ ", "department": "", "tech_stack": []}
438	Lead Software Engineer - FedNow Team	https://jobs.lever.co/narmi/210854a8-2afd-4056-8917-d1ae4bb52943	210854a8-2afd-4056-8917-d1ae4bb52943	2023-11-22 14:12:57.862607	Narmi	\N	{"salary": "", "location": "New York, NY", "department": "", "tech_stack": []}
439	Staff Software Engineer - Account Opening	https://jobs.lever.co/narmi/17d884f9-4a66-4ff7-b184-551ba7eda0da	17d884f9-4a66-4ff7-b184-551ba7eda0da	2023-11-22 14:12:57.86273	Narmi	\N	{"salary": "", "location": "New York, NY", "department": "", "tech_stack": []}
440	Software Engineer - Backend Java	https://jobs.lever.co/cybcube/07060b9d-65b4-4308-a35b-177f6828cbca	07060b9d-65b4-4308-a35b-177f6828cbca	2023-11-22 14:12:57.862825	CyberCube	\N	{"salary": "", "location": "Tallinn, Estonia", "department": "", "tech_stack": []}
441	Automation QA Engineer (Remote - Bulgaria)	https://jobs.lever.co/goconsensus/2646e801-1f69-46d3-93a3-90229b766a2f	2646e801-1f69-46d3-93a3-90229b766a2f	2023-11-22 14:12:57.86294	Consensus	\N	{"salary": "", "location": "Bulgaria", "department": "", "tech_stack": []}
442	Automation QA Engineer (Remote - Poland)	https://jobs.lever.co/goconsensus/6031677a-7912-4c16-ae29-b6271a4198bd	6031677a-7912-4c16-ae29-b6271a4198bd	2023-11-22 14:12:57.863047	Consensus	\N	{"salary": "", "location": "Bulgaria", "department": "", "tech_stack": []}
443	Senior Automation QA Engineer (Remote - Bulgaria)	https://jobs.lever.co/goconsensus/90cdea76-1420-4829-aa90-7656dbebbba8	90cdea76-1420-4829-aa90-7656dbebbba8	2023-11-22 14:12:57.863136	Consensus	\N	{"salary": "", "location": "Bulgaria", "department": "", "tech_stack": []}
444	Senior Automation QA Engineer (Remote - Poland)	https://jobs.lever.co/goconsensus/f2f29b6c-a4bc-46e5-85fa-c4dcd0c4aab2	f2f29b6c-a4bc-46e5-85fa-c4dcd0c4aab2	2023-11-22 14:12:57.863223	Consensus	\N	{"salary": "", "location": "Bulgaria", "department": "", "tech_stack": []}
445	Staff Applied AI Engineer 	https://boards.greenhouse.io/hotelengine/jobs/5750490003	5750490003	2023-11-22 14:12:57.863331	Hotel Engine	\N	{"salary": "", "location": "Remote - United States", "department": "", "tech_stack": []}
448	Engineering - Security Engineer	https://boards.greenhouse.io/trayio/jobs/6994640002	6994640002	2023-11-22 14:12:57.863664	Tray.io	\N	{"salary": "", "location": "London", "department": "", "tech_stack": []}
449	Engineering - Senior Backend Engineer (Scala) - Core APIs	https://boards.greenhouse.io/trayio/jobs/5875486002	5875486002	2023-11-22 14:12:57.863785	Tray.io	\N	{"salary": "", "location": "London", "department": "", "tech_stack": []}
450	Engineering - Senior Backend Engineer (Scala) - Insights 	https://boards.greenhouse.io/trayio/jobs/7009497002	7009497002	2023-11-22 14:12:57.863892	Tray.io	\N	{"salary": "", "location": "London", "department": "", "tech_stack": []}
451	Senior Software Development Engineer in Test	https://boards.greenhouse.io/baton/jobs/4019824007	4019824007	2023-11-22 14:12:57.864175	Baton	\N	{"salary": "", "location": "San Francisco, California, United States", "department": "", "tech_stack": []}
452	Senior Software Engineer - Infrastructure	https://boards.greenhouse.io/baton/jobs/4011487007	4011487007	2023-11-22 14:12:57.864295	Baton	\N	{"salary": "", "location": "San Francisco, California, United States", "department": "", "tech_stack": []}
453	Senior Software Engineer - Testing Infrastructure 	https://boards.greenhouse.io/baton/jobs/4144198007	4144198007	2023-11-22 14:12:57.864404	Baton	\N	{"salary": "", "location": "San Francisco, California, United States", "department": "", "tech_stack": []}
455	Staff Software Engineer - Backend	https://boards.greenhouse.io/baton/jobs/4122651007	4122651007	2023-11-22 14:12:57.864625	Baton	\N	{"salary": "", "location": "San Francisco, California, United States", "department": "", "tech_stack": []}
