function mgc = gaslib40

mgc.sound_speed = 312.805; % meters per second
mgc.temperature = 273.15;
mgc.R = 8.314;
mgc.compressibility_factor = 0.8;
mgc.gas_molar_mass = 0.0185674;
mgc.gas_specific_gravity = 0.6;
mgc.specific_heat_capacity_ratio = 1.4;
mgc.standard_density = 1.0;
mgc.baseP = 8101325;
mgc.baseF = 604.167;
mgc.per_unit = 0;

%% junction data
%  junction_i type pmin pmax status p
mgc.junction = [
32 	 	 0 	 101325 	 7101325 	 1 	 101325
29 	 	 0 	 101325 	 8101325 	 1 	 101325
1 	 	 0 	 3101325 	 8101325 	 1 	 3101325
2 	 	 0 	 3101325 	 8101325 	 1 	 3101325
600013 	 0 	 101325 	 8101325 	 1 	 101325
27 	 	 0 	 101325 	 7101325 	 1 	 101325
200002 	 0 	 101325 	 8101325 	 1 	 101325
33 	 	 0 	 101325 	 7101325 	 1 	 101325
28 	 	 0 	 101325 	 8101325 	 1 	 101325
26 	 	 0 	 101325 	 8101325 	 1 	 101325
10 	 	 0 	 101325 	 8101325 	 1 	 101325
24 	 	 0 	 101325 	 8101325 	 1 	 101325
25 	 	 0 	 101325 	 8101325 	 1 	 101325
23 	 	 0 	 101325 	 8101325 	 1 	 101325
5 	 	 0 	 3101325 	 8101325 	 1 	 3101325
31 	 	 0 	 101325 	 8101325 	 1 	 101325
39 	 	 0 	 101325 	 7101325 	 1 	 101325
34 	 	 0 	 101325 	 8101325 	 1 	 101325
17 	 	 0 	 101325 	 8101325 	 1 	 101325
37 	 	 0 	 3101325 	 8101325 	 1 	 3101325
9 	 	 0 	 101325 	 8101325 	 1 	 101325
12 	 	 0 	 101325 	 8101325 	 1 	 101325
20 	 	 0 	 101325 	 8101325 	 1 	 101325
6 	 	 0 	 101325 	 8101325 	 1 	 101325
400037 	 0 	 101325 	 8101325 	 1 	 101325
14 	 	 0 	 101325 	 8101325 	 1 	 101325
7 	 	 0 	 101325 	 8101325 	 1 	 101325
8 	 	 0 	 101325 	 8101325 	 1 	 101325
19 	 	 0 	 101325 	 8101325 	 1 	 101325
0 	 	 0 	 101325 	 8101325 	 1 	 101325
4 	 	 0 	 101325 	 8101325 	 1 	 101325
22 	 	 0 	 101325 	 8101325 	 1 	 101325
11 	 	 0 	 101325 	 8101325 	 1 	 101325
35 	 	 0 	 101325 	 7101325 	 1 	 101325
13 	 	 0 	 3101325 	 8101325 	 1 	 3101325
100021 	 0 	 101325 	 8101325 	 1 	 101325
15 	 	 0 	 101325 	 8101325 	 1 	 101325
16 	 	 0 	 101325 	 8101325 	 1 	 101325
21 	 	 0 	 3101325 	 8101325 	 1 	 3101325
38 	 	 0 	 101325 	 7101325 	 1 	 101325
300001 	 0 	 101325 	 8101325 	 1 	 101325
36 	 	 0 	 101325 	 8101325 	 1 	 101325
500005 	 0 	 101325 	 8101325 	 1 	 101325
18 	 	 0 	 101325 	 8101325 	 1 	 101325
30 	 	 0 	 101325 	 8101325 	 1 	 101325
3 	 	 0 	 101325 	 8101325 	 1 	 101325
];

%% pipeline data
% pipeline_i f_junction t_junction diameter length friction_factor status
mgc.pipe = [
32 	 21 	 34 	 0.8 	 3479.4547 	 	 0.0074 	 1
29 	 4 	 	 17 	 1.0 	 12766.7034 	 0.0071 	 1
1 	 32 	 18 	 0.8 	 76893.5508 	 0.0074 	 1
2 	 37 	 15 	 1.0 	 21557.5662 	 0.0071 	 1
27 	 31 	 30 	 0.8 	 22224.1532 	 0.0074 	 1
33 	 35 	 36 	 1.0 	 3418.0083 	 	 0.0071 	 1
28 	 31 	 4 	 	 0.8 	 31179.6191 	 0.0074 	 1
26 	 17 	 31 	 0.8 	 36061.0099 	 0.0074 	 1
10 	 20 	 8 	 	 0.8 	 32868.2025 	 0.0074 	 1
24 	 27 	 22 	 0.6 	 66036.5946 	 0.0078 	 1
25 	 27 	 17 	 1.0 	 18969.4127 	 0.0071 	 1
23 	 10 	 22 	 0.6 	 19303.192 	 	 0.0078 	 1
5 	 27 	 28 	 0.8 	 86690.2656 	 0.0074 	 1
31 	 35 	 21 	 0.8 	 49866.1484 	 0.0074 	 1
34 	 29 	 36 	 1.0 	 32449.372 	 	 0.0071 	 1
17 	 23 	 14 	 0.4 	 12015.8748 	 0.0085 	 1
37 	 12 	 33 	 0.8 	 65057.1743 	 0.0074 	 1
9 	 6 	 	 22 	 0.6 	 20322.2054 	 0.0078 	 1
12 	 8 	 	 9 	 	 0.6 	 3802.5867 	 	 0.0078 	 1
20 	 19 	 6 	 	 0.6 	 10586.1295 	 0.0078 	 1
6 	 28 	 11 	 0.6 	 16579.326 	 	 0.0078 	 1
14 	 9 	 	 26 	 0.4 	 38659.8244 	 0.0085 	 1
7 	 11 	 20 	 0.6 	 10022.783 	 	 0.0078 	 1
8 	 28 	 6 	 	 0.6 	 35218.8391 	 0.0078 	 1
19 	 7 	 	 19 	 0.6 	 20634.6983 	 0.0078 	 1
0 	 0 	 	 5 	 	 1.0 	 13071.0852 	 0.0071 	 1
4 	 16 	 12 	 0.8 	 58218.9696 	 0.0074 	 1
22 	 5 	 	 25 	 0.8 	 12397.3522 	 0.0074 	 1
11 	 27 	 39 	 0.8 	 47488.2838 	 0.0074 	 1
35 	 29 	 21 	 0.8 	 26427.4817 	 0.0074 	 1
13 	 8 	 	 24 	 0.8 	 39036.0418 	 0.0074 	 1
15 	 24 	 3 	 	 0.6 	 18017.8496 	 0.0078 	 1
16 	 26 	 23 	 0.6 	 3067.5474 	 	 0.0078 	 1
21 	 19 	 10 	 0.6 	 10452.0312 	 0.0078 	 1
38 	 12 	 34 	 0.8 	 65532.2127 	 0.0074 	 1
36 	 12 	 13 	 1.0 	 18136.5973 	 0.0071 	 1
18 	 9 	 	 7 		 0.4 	 14043.1135 	 0.0085 	 1
30 	 31 	 38 	 0.8 	 32921.2598 	 0.0074 	 1
3 	 15 	 16 	 1.0 	 6998.0538 	 	 0.0071 	 1
];

%% compressor data
% compressor_i f_junction t_junction cmin cmax power_max fmin fmax status
mgc.compressor = [
41 	 	 21 	 100021 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
42 	 	 2 	 	 200002 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100003 	 27 	 400037 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
43 	 	 1 	 	 300001 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
39 	 	 37 	 400037 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
44 	 	 5 	 	 500005 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100002 	 38 	 300001 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100004 	 39 	 500005 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100001 	 35 	 200002 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100000 	 33 	 100021 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
40 	 	 13 	 600013 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
100005 	 32 	 600013 	 1.0 	 5.0 	 3500 	 0 	 700 	 1
];

%% producer
% producer_i junction fgmin fgmax fg status dispatchable
mgc.producer = [
1 	 1 	 0 	 201.38888888889 201.38888888889 	 1 0
2 	 2 	 0 	 201.38888888889 201.38888888889	 1 0
0 	 0 	 0 	 201.38888888889 201.38888888889	 1 0
];

%% consumer
% consumer_i junction fd status dispatchable
mgc.consumer = [
24 	 24 	 20.833333333333 	 1 0
4 	 4 	 	 20.833333333333 	 1 0
29 	 29 	 20.833333333333 	 1 0
12 	 12 	 20.833333333333 	 1 0
20 	 20 	 20.833333333333 	 1 0
6 	 6 	 	 20.833333333333 	 1 0
25 	 25 	 20.833333333333 	 1 0
23 	 23 	 20.833333333333 	 1 0
22 	 22 	 20.833333333333 	 1 0
11 	 11 	 20.833333333333 	 1 0
13 	 13 	 20.833333333333 	 1 0
5 	 5 	 	 20.833333333333 	 1 0
15 	 15 	 20.833333333333 	 1 0
27 	 27 	 20.833333333333 	 1 0
31 	 31 	 20.833333333333 	 1 0
28 	 28 	 20.833333333333 	 1 0
16 	 16 	 20.833333333333 	 1 0
14 	 14 	 20.833333333333 	 1 0
21 	 21 	 20.833333333333 	 1 0
7 	 7 	 	 20.833333333333 	 1 0
8 	 8 	 	 20.833333333333 	 1 0
26 	 26 	 20.833333333333 	 1 0
17 	 17 	 20.833333333333 	 1 0
10 	 10 	 20.833333333333 	 1 0
19 	 19 	 20.833333333333 	 1 0
9 	 9 	 	 20.833333333333 	 1 0
18 	 18 	 20.833333333333 	 1 0
30 	 30 	 20.833333333333 	 1 0
3 	 3 	 	 20.833333333333 	 1 0
];

end
