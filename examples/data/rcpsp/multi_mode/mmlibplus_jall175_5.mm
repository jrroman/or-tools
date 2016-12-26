jobs  (incl. supersource/sink ):	52
RESOURCES
- renewable                 : 4 R
- nonrenewable              : 2 N
- doubly constrained        : 0 D
************************************************************************
PRECEDENCE RELATIONS:
jobnr.    #modes  #successors   successors
1	1	11		2 4 5 6 7 9 10 11 12 13 17 
2	6	6		37 21 20 18 15 3 
3	6	8		33 30 29 27 26 24 16 14 
4	6	5		37 30 24 15 8 
5	6	6		37 30 25 24 21 16 
6	6	7		37 30 27 26 25 24 19 
7	6	5		33 29 26 24 16 
8	6	4		33 29 27 16 
9	6	4		37 33 30 16 
10	6	7		36 33 30 29 28 23 22 
11	6	5		33 31 30 26 24 
12	6	7		51 37 36 34 32 30 25 
13	6	5		37 36 33 31 23 
14	6	4		36 28 25 23 
15	6	5		36 33 31 28 22 
16	6	4		36 28 23 22 
17	6	4		47 33 30 23 
18	6	7		51 49 36 34 32 31 28 
19	6	8		51 49 48 47 36 34 33 32 
20	6	5		39 32 31 29 28 
21	6	7		51 50 49 39 33 32 29 
22	6	7		49 48 47 46 39 34 32 
23	6	6		51 50 49 39 34 32 
24	6	5		51 46 39 34 28 
25	6	5		49 44 39 35 31 
26	6	5		49 47 36 35 34 
27	6	6		50 49 44 43 41 36 
28	6	3		47 38 35 
29	6	7		48 46 45 44 43 42 40 
30	6	6		48 46 45 43 40 38 
31	6	6		50 48 47 46 43 40 
32	6	2		43 35 
33	6	2		43 35 
34	6	4		43 42 41 38 
35	6	4		45 42 41 40 
36	6	3		46 42 40 
37	6	2		41 40 
38	6	1		44 
39	6	1		41 
40	6	1		52 
41	6	1		52 
42	6	1		52 
43	6	1		52 
44	6	1		52 
45	6	1		52 
46	6	1		52 
47	6	1		52 
48	6	1		52 
49	6	1		52 
50	6	1		52 
51	6	1		52 
52	1	0		
************************************************************************
REQUESTS/DURATIONS
jobnr.	mode	dur	R1	R2	R3	R4	N1	N2	
------------------------------------------------------------------------
1	1	0	0	0	0	0	0	0	
2	1	20	5	4	4	2	15	14	
	2	21	5	3	3	2	14	14	
	3	23	5	3	3	2	11	11	
	4	24	5	2	3	1	9	11	
	5	26	5	2	3	1	8	7	
	6	27	5	1	3	1	7	6	
3	1	5	2	3	1	4	23	24	
	2	11	2	3	1	4	19	22	
	3	19	2	2	1	3	18	20	
	4	20	2	2	1	3	15	16	
	5	26	1	1	1	3	9	15	
	6	27	1	1	1	2	8	14	
4	1	4	5	5	4	1	29	3	
	2	6	4	3	3	1	25	3	
	3	8	4	3	3	1	22	3	
	4	12	3	2	2	1	19	3	
	5	13	2	2	2	1	16	3	
	6	19	2	1	2	1	14	3	
5	1	1	2	4	4	1	27	28	
	2	3	2	3	3	1	25	28	
	3	11	2	3	3	1	24	26	
	4	12	1	2	3	1	22	24	
	5	16	1	2	2	1	20	24	
	6	22	1	2	2	1	19	22	
6	1	8	1	4	4	4	19	11	
	2	11	1	3	3	3	17	10	
	3	13	1	3	3	3	15	7	
	4	17	1	3	3	3	12	6	
	5	25	1	3	2	3	10	5	
	6	26	1	3	1	3	6	2	
7	1	8	1	4	5	4	21	22	
	2	18	1	4	4	3	21	21	
	3	25	1	4	4	2	17	20	
	4	26	1	3	4	2	13	19	
	5	28	1	2	3	1	12	18	
	6	29	1	2	3	1	9	17	
8	1	3	5	4	3	4	19	19	
	2	5	5	4	3	3	17	16	
	3	6	5	4	3	3	17	15	
	4	12	5	4	3	2	15	13	
	5	13	5	3	3	2	15	10	
	6	18	5	3	3	2	14	9	
9	1	3	4	4	4	4	21	21	
	2	4	3	4	3	3	19	17	
	3	8	2	4	3	3	19	15	
	4	25	2	4	2	3	17	11	
	5	26	2	4	1	2	17	7	
	6	29	1	4	1	2	16	4	
10	1	1	4	2	2	2	23	26	
	2	9	4	1	2	1	21	22	
	3	15	4	1	2	1	20	18	
	4	22	3	1	2	1	17	15	
	5	24	3	1	1	1	16	13	
	6	27	3	1	1	1	13	10	
11	1	6	2	4	1	5	22	28	
	2	10	1	4	1	4	20	22	
	3	13	1	3	1	4	17	20	
	4	22	1	3	1	4	15	15	
	5	23	1	2	1	4	14	13	
	6	24	1	2	1	4	13	9	
12	1	6	4	3	4	4	24	29	
	2	12	3	2	4	3	20	24	
	3	13	3	2	4	3	19	22	
	4	20	2	2	4	3	15	20	
	5	23	1	2	4	3	13	20	
	6	25	1	2	4	3	13	18	
13	1	5	4	2	5	4	30	16	
	2	8	4	1	4	4	23	15	
	3	21	3	1	4	4	19	15	
	4	24	3	1	4	4	19	14	
	5	25	1	1	4	3	12	13	
	6	28	1	1	4	3	9	13	
14	1	2	4	3	3	1	20	28	
	2	11	4	3	3	1	20	27	
	3	19	4	3	3	1	20	26	
	4	22	4	3	3	1	20	25	
	5	26	3	3	3	1	19	27	
	6	29	3	3	3	1	19	26	
15	1	3	2	3	4	4	26	14	
	2	9	1	3	3	4	24	14	
	3	10	1	3	3	4	20	9	
	4	18	1	3	2	4	17	9	
	5	19	1	3	1	4	13	6	
	6	29	1	3	1	4	9	2	
16	1	5	3	4	1	4	23	28	
	2	15	3	4	1	4	19	27	
	3	17	2	3	1	4	17	26	
	4	18	2	3	1	4	13	24	
	5	19	2	2	1	4	10	23	
	6	26	1	1	1	4	8	21	
17	1	3	3	2	4	3	24	20	
	2	4	3	2	4	3	19	16	
	3	9	3	2	4	3	19	15	
	4	18	2	1	4	2	13	11	
	5	20	1	1	4	2	9	9	
	6	21	1	1	4	2	6	5	
18	1	2	4	4	2	3	25	26	
	2	3	4	3	2	3	25	25	
	3	8	4	3	2	3	24	25	
	4	12	4	2	2	3	23	25	
	5	14	4	2	2	3	22	23	
	6	21	4	2	2	3	20	23	
19	1	2	3	3	3	1	27	18	
	2	4	3	3	2	1	23	14	
	3	14	3	3	2	1	20	11	
	4	20	2	2	2	1	15	8	
	5	23	1	2	2	1	12	7	
	6	26	1	2	2	1	10	4	
20	1	7	4	3	4	2	24	16	
	2	8	4	2	4	2	20	14	
	3	13	4	2	4	2	17	11	
	4	14	3	2	3	2	14	10	
	5	20	2	2	3	2	10	6	
	6	24	2	2	3	2	10	3	
21	1	1	5	3	4	3	21	11	
	2	8	4	2	3	2	20	11	
	3	9	4	2	2	2	18	11	
	4	17	4	1	2	2	18	10	
	5	21	4	1	2	2	16	10	
	6	26	4	1	1	2	15	10	
22	1	3	5	2	4	3	18	23	
	2	5	4	2	3	3	15	19	
	3	13	4	2	3	3	11	19	
	4	14	4	2	3	3	10	12	
	5	21	4	2	3	3	7	10	
	6	25	4	2	3	3	2	4	
23	1	1	3	1	4	3	26	20	
	2	2	3	1	3	3	23	20	
	3	13	3	1	3	3	21	19	
	4	21	2	1	3	3	20	19	
	5	22	2	1	2	3	17	18	
	6	26	1	1	2	3	14	18	
24	1	11	3	1	2	4	28	12	
	2	13	3	1	2	3	26	12	
	3	19	3	1	2	2	23	12	
	4	25	3	1	2	2	23	11	
	5	26	2	1	2	1	19	11	
	6	27	2	1	2	1	18	10	
25	1	14	5	4	1	4	20	29	
	2	19	4	3	1	4	19	29	
	3	21	4	3	1	3	19	28	
	4	23	4	2	1	3	19	28	
	5	26	4	2	1	2	19	27	
	6	29	4	2	1	2	19	26	
26	1	2	5	3	4	5	25	15	
	2	3	4	2	3	3	25	14	
	3	12	3	2	3	3	25	12	
	4	16	3	2	3	3	25	10	
	5	21	2	2	3	2	25	9	
	6	23	2	2	3	1	25	8	
27	1	1	4	5	3	2	25	22	
	2	3	3	4	3	2	22	16	
	3	5	2	4	3	2	20	13	
	4	11	2	4	2	2	20	11	
	5	15	2	4	2	2	16	6	
	6	21	1	4	2	2	14	4	
28	1	3	2	5	3	4	28	15	
	2	7	2	4	2	3	27	13	
	3	15	2	4	2	3	27	11	
	4	21	1	4	1	3	25	9	
	5	27	1	4	1	3	25	7	
	6	29	1	4	1	3	24	6	
29	1	4	3	4	3	3	25	25	
	2	6	2	3	2	2	23	25	
	3	17	2	3	2	2	23	21	
	4	25	1	2	2	2	22	14	
	5	26	1	2	2	2	21	13	
	6	27	1	1	2	2	19	6	
30	1	2	3	3	5	4	25	19	
	2	5	2	2	4	4	21	14	
	3	6	2	2	4	3	20	13	
	4	7	1	2	4	3	17	12	
	5	13	1	2	4	2	16	9	
	6	23	1	2	4	2	15	5	
31	1	3	3	2	4	3	9	11	
	2	9	2	1	4	3	9	10	
	3	10	2	1	4	3	8	10	
	4	22	2	1	4	3	8	9	
	5	23	2	1	3	2	6	10	
	6	26	2	1	3	2	6	9	
32	1	8	1	2	2	4	20	12	
	2	10	1	2	1	3	19	12	
	3	14	1	2	1	3	19	10	
	4	15	1	2	1	2	19	9	
	5	19	1	1	1	1	19	9	
	6	29	1	1	1	1	19	7	
33	1	10	4	4	3	1	30	24	
	2	11	3	3	3	1	26	20	
	3	20	3	3	3	1	22	18	
	4	21	2	3	3	1	18	14	
	5	25	2	3	3	1	17	11	
	6	26	1	3	3	1	14	7	
34	1	1	4	2	4	5	17	24	
	2	5	4	2	3	4	14	22	
	3	6	4	2	3	4	14	18	
	4	7	4	2	3	4	12	18	
	5	11	4	2	3	4	11	14	
	6	29	4	2	3	4	11	10	
35	1	1	3	1	4	1	13	26	
	2	8	3	1	4	1	11	24	
	3	9	3	1	4	1	10	21	
	4	18	3	1	3	1	9	19	
	5	21	2	1	2	1	8	13	
	6	25	2	1	2	1	6	12	
36	1	1	5	4	5	4	23	29	
	2	2	4	3	4	3	22	27	
	3	4	4	3	3	3	22	27	
	4	5	3	2	2	3	21	26	
	5	13	3	2	2	3	21	24	
	6	20	2	1	1	3	20	24	
37	1	1	2	4	4	5	13	16	
	2	2	2	3	4	4	13	15	
	3	7	2	3	4	4	13	14	
	4	15	2	2	4	3	13	10	
	5	20	2	2	4	3	13	8	
	6	24	2	2	4	3	13	4	
38	1	2	3	5	5	4	10	22	
	2	5	3	4	4	4	10	20	
	3	15	3	3	4	4	10	18	
	4	19	2	3	3	4	9	14	
	5	20	1	1	3	4	8	13	
	6	21	1	1	2	4	8	9	
39	1	3	5	3	1	4	24	20	
	2	5	4	3	1	4	19	19	
	3	9	4	3	1	3	16	19	
	4	12	4	3	1	3	13	18	
	5	16	4	3	1	1	10	18	
	6	22	4	3	1	1	7	17	
40	1	1	4	4	5	2	20	26	
	2	4	4	3	5	2	16	25	
	3	6	3	3	5	2	13	25	
	4	14	3	2	5	2	13	23	
	5	24	2	2	5	2	10	23	
	6	25	1	1	5	2	9	22	
41	1	3	1	4	3	3	17	12	
	2	13	1	3	2	3	15	12	
	3	20	1	3	2	3	13	12	
	4	21	1	2	2	3	9	12	
	5	22	1	2	2	3	8	12	
	6	26	1	2	2	3	5	12	
42	1	1	3	3	5	2	16	21	
	2	2	2	2	4	1	12	19	
	3	5	2	2	4	1	10	17	
	4	8	2	2	4	1	6	13	
	5	9	1	1	4	1	4	12	
	6	11	1	1	4	1	1	9	
43	1	7	2	5	4	5	27	27	
	2	8	2	4	3	4	24	19	
	3	16	2	4	3	4	23	16	
	4	17	1	4	2	4	22	13	
	5	18	1	4	2	4	20	7	
	6	19	1	4	1	4	19	6	
44	1	1	3	1	3	4	22	22	
	2	3	3	1	3	3	21	22	
	3	9	2	1	3	3	21	22	
	4	19	2	1	3	3	20	22	
	5	25	1	1	3	3	20	22	
	6	29	1	1	3	3	19	22	
45	1	4	3	1	5	3	21	28	
	2	5	3	1	4	3	21	26	
	3	8	2	1	4	3	19	22	
	4	9	2	1	4	3	15	19	
	5	17	2	1	3	3	13	17	
	6	30	1	1	3	3	12	11	
46	1	3	4	4	4	2	20	26	
	2	17	4	4	4	2	16	25	
	3	22	3	4	4	2	15	25	
	4	25	3	3	4	2	13	23	
	5	29	3	3	3	2	9	22	
	6	30	2	3	3	2	7	21	
47	1	2	4	3	4	5	24	9	
	2	4	4	3	3	5	20	8	
	3	7	4	3	3	5	17	7	
	4	26	4	3	3	5	16	7	
	5	28	4	2	3	5	14	5	
	6	29	4	2	3	5	9	5	
48	1	7	2	5	5	3	27	26	
	2	8	1	3	5	3	24	26	
	3	10	1	3	5	3	23	22	
	4	17	1	3	5	2	22	20	
	5	25	1	2	5	2	20	16	
	6	26	1	1	5	2	20	11	
49	1	2	4	3	2	4	16	13	
	2	3	4	3	2	4	15	13	
	3	17	4	2	2	4	15	13	
	4	28	4	2	2	4	14	13	
	5	29	4	1	2	4	12	13	
	6	30	4	1	2	4	12	12	
50	1	1	2	4	1	5	12	28	
	2	4	2	4	1	5	12	26	
	3	5	2	4	1	5	12	19	
	4	16	2	4	1	5	11	17	
	5	19	2	4	1	5	11	12	
	6	20	2	4	1	5	11	10	
51	1	6	2	2	4	1	27	28	
	2	7	2	2	4	1	26	21	
	3	10	2	2	4	1	22	20	
	4	13	2	2	4	1	21	15	
	5	24	2	1	4	1	18	11	
	6	28	2	1	4	1	15	5	
52	1	0	0	0	0	0	0	0	
************************************************************************

 RESOURCE AVAILABILITIES 
	R 1	R 2	R 3	R 4	N 1	N 2
	20	21	23	19	746	675

************************************************************************