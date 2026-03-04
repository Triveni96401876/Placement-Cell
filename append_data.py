import os

data = """
1	459EE22157	N GANESH	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Job	05-10-2004	84%48	2022					48.1	65.2	50.2	53.3	54.2	1	Yes	8073483148	9743151864	itzmegani123@gmail.com	Ambedkar colony vaddu 
2	459EE22811	SHASHI VARMA	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Female	Electrical & Electronics	Job	31-03-2004	62.88%	2022					32.2	43.6	54.6	33.1	163.5	3	Yes	8431919809	7411266288	varmashashi311803@gmail.com	Vinayaka Nagar hospital road near Bharat portel pump ballari 
3	459EE23001	A G LOKESH	YAZAKI INDIA PVT LTD / TKM / JSW STEEL LTD	TKM	Male	Electrical & Electronics	Job	12-09-2007	82.08	2023					85.8	87.5	87.7	89	88.77	0	No	7406519109	9886790005	lokeshag548@gmail.com	S/O A G SIDDAPPA, NEAR ESHWAR TEMPLE, HOSA-DAROJI, BALLARI 
4	459EE23002	A VIGNESH	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Job	23-05-2007	50%	22-23					54.7	63.4	53.3	35.6	51.7	2	Yes	7892689448	8123170662	vignesha232007@gmail.com	Indra nagar 1st cross near anjaneyya temple Kudthini 
5	459EE23003	ABDUL AZEEZ B	YAZAKI INDIA PVT LTD / TKM	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Job	06-03-2006	63.2	2023					63.6	70.5	69.5	70.8	68.6	0	No	8095827739	9880438125	Babdulzaeez@gmail.com	33 WARD NO 07 PATHAKANDAKAM STREET BRUSPET BALLARI
6	459EE23004	ABDUL HAFEEZ	YAZAKI INDIA PVT LTD / TKM	TKM	Male	Electrical & Electronics	Job	27-12-2006	67.84%	2023					72.50%	74%	71.90%	70.50%	72%	0	No	7899065386	8105310785	hafeez3283980@gmail.com	WARD NUMBER 5 SRI VENKATESHWARA PRASANNA NILAYA VENKATAMMA COLONY GUGGARAHATTI 583101
7	459EE23005	ABHISHEK ANNAPPA ANGADI	YAZAKI INDIA PVT LTD / TKM	TKM	Male	Electrical & Electronics	Higher Education	09-09-2006	58%	2023					76.90%	85.20%	80.20%	79.40%	80.40%	0	No	9880386122	6363327667	abhishekangadi538@gmail.com	O2/07 Shankar Hill Town, Toranagallu
8	459EE23006	ABHISHEK GOUDA H	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Job	27-10-2006	55%	22-23					34.70%	46.1	39.4	34.8	38.75	3	Yes	7019444176	9448187759	abhishekgouda2006@gmail.com	Kuvempu nagar 5th cross saraswati enclave ballari 583104
9	459EE23007	ABUL SEEHAN HAVINAL	JSW STEEL LTD	JSW STEEL LTD	Male	Electrical & Electronics	Job	09-08-2006	63.2	2023					81	82.5	77	78	80	0	No	8073513138	9448343740	abulseehanhavinal982006@gmail.com	Gadang street radio park cowl bazar 
11	459EE23009	AKASH	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Job	05-05-2007	91.04%	2023					48.10%	67%	57.90%	66.30%	59.90%	1	Yes	8217078091	7618701170	aakash72046@gmail.com	17th Ward J.N.R Camp Toranagallu RS, Ballari 
12	459EE23010	AKSHAY S H M	YAZAKI INDIA PVT LTD	YAZAKI INDIA PVT LTD	Male	Electrical & Electronics	Higher Education	05-02-2007	59.20%	2022-2023					74.70%	82.50%	73.30%	72.50%	75.75%	0	No	8861912616	7338040169	shmakshay7@gmail.com	C3/14 vv nagar ,toranagallu,ballari 
14	459EE23012	AMAN SHARMA	JSW STEEL LTD	JSW STEEL LTD	Male	Electrical & Electronics	Job	20-11-2004	64.60%	2019	75.20%	2021			84.70%	84.50%	82.80%	83.60%	83.90%	0	No	6307740278	8792574107	amanbhatt8400@gmail.com	JSW TOWNSHIP VIDYANAGAR Z7 / 7
15	459EE23013	AMBRUTHA VARSHINI M	JSW STEEL LTD / TATA POWER	JSW STEEL LTD	Female	Electrical & Electronics	Job	12-04-2007	76	2023					90.3	91.5	91.6	91.8	91.3	0	No	9148096258	9964498663	ambrutha2007@gmail.com	Nagalapura (post) Sandur (taluk) Bellari (district) Karnataka (state)
17	459EE23015	ANKIT KUMAR SINGH	YAZAKI INDIA PVT LTD / TKM / JSW STEEL LTD	TKM	Male	Electrical & Electronics	Job	28-07-2004	96%	2021	89%	2023			81.40%	88%	84.80%	85.60%	84.95%	0	No	6360691138	9686512851	ankitsgp7@gmail.com	C20/10 Shankar hill township, Toranagalllu RS Ballari, Karnataka 583123
18	459EE23016	ANNIS FATHIMA	TKM	YAZAKI INDIA PVT LTD	Female	Electrical & Electronics	Job	07-12-2007	66.20%	2023					63.60%	81.60%	71.70%	74.50%	72.80%	0	Yes	8880660993	6363540510	annisfathimafathima@gmail.com	DALWALA MASJID STREET CB BALLARI
19	459EE23017	ANUSHA M R	TKM	TKM	Female	Electrical & Electronics	Job	01-06-2004	71.36, marks 446	2020					70.3	76	74	73.4	73.925	0	Yes	7975213098	8500592945	anusharavi3021@gmail.com	Hosuru venkatapura chitradurga ,karnataka 577540
20	459EE23018	ASHOK	TKM / JSW STEEL LTD	TKM	Male	Electrical & Electronics	Job	11-01-2006	82.88	2023					90.3	92.5	87.9	85.6	89.75	0	No	6361570417	7795074576	ashok2006ashokv@gmail.com	Ramanjineya Nagar Near govt school Ballari 
21	459EE23019	ASHOKA	JSW STEEL LTD	JSW STEEL LTD	Male	Electrical & Electronics	Job	15-06-2005	88	2021					86.9	92.2	90.2	90.2	89.9	0	No	9019800901	9019800901	ashokkc8262@gmail.com	D Anthapura word no1 Near GPS school 
22	459EE23020	ASHOKA G K	YAZAKI INDIA PVT LTD	SELF	Male	Electrical & Electronics	Job	15-02-2007	88	2,02,22,023					60.3	64.5	61	62.5	62	0	No	8904583269	8197038185	ashokagk469@gmail.com	KARADIHALLI VILLAGE MOLKALMURU TQ
"""

with open('student_data.txt', 'a', encoding='utf-8') as f:
    f.write(data)
