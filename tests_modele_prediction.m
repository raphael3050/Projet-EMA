%% Test des différents modèle de prédiction
clc
close all
echo off 
clearvars 

%% Chargement des matrices
load("key.mat", "key_mat");
load("cto.mat","cto_mat");
load("fuites.mat", "fuites_mat");

%% Outils
% Hamming Weight
Weight_Hamming_vect =[0 1 1 2 1 2 2 3 1 2 2 3 2 3 3 4 1 2 2 3 2 3 3 4 2 3 3 4 3 4 4 5 1 2 2 3 2 3 3 4 2 3 3 4 3 4 4 5 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 1 2 2 3 2 3 3 4 2 3 3 4 3 4 4 5 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 1 2 2 3 2 3 3 4 2 3 3 4 3 4 4 5 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 2 3 3 4 3 4 4 5 3 4 4 5 4 5 5 6 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 3 4 4 5 4 5 5 6 4 5 5 6 5 6 6 7 4 5 5 6 5 6 6 7 5 6 6 7 6 7 7 8];

% Sbox
SBox=[99,124,119,123,242,107,111,197,48,1,103,43,254,215,171,118,202,130,201,125,250,89,71,240,173,212,162,175,156,164,114,192,183,253,147,38,54,63,247,204,52,165,229,241,113,216,49,21,4,199,35,195,24,150,5,154,7,18,128,226,235,39,178,117,9,131,44,26,27,110,90,160,82,59,214,179,41,227,47,132,83,209,0,237,32,252,177,91,106,203,190,57,74,76,88,207,208,239,170,251,67,77,51,133,69,249,2,127,80,60,159,168,81,163,64,143,146,157,56,245,188,182,218,33,16,255,243,210,205,12,19,236,95,151,68,23,196,167,126,61,100,93,25,115,96,129,79,220,34,42,144,136,70,238,184,20,222,94,11,219,224,50,58,10,73,6,36,92,194,211,172,98,145,149,228,121,231,200,55,109,141,213,78,169,108,86,244,234,101,122,174,8,186,120,37,46,28,166,180,198,232,221,116,31,75,189,139,138,112,62,181,102,72,3,246,14,97,53,87,185,134,193,29,158,225,248,152,17,105,217,142,148,155,30,135,233,206,85,40,223,140,161,137,13,191,230,66,104,65,153,45,15,176,84,187,22];

% ShiftRow
shiftrow=[1,6,11,16,5,10,15,4,9,14,3,8,13,2,7,12];

%% Variables associées au test
% Sous-clées 
main_key = reshape((key_mat(20000, :))', 4,4);
sub_keys = keysched2(uint32(main_key));

% hypothèses d'octets de sous-clées (2^8)
% -> [20000x256]
hypothese = uint8(ones(size(cto_mat, 1), 1) * (0:255));

% Plage de valeurs du dernier round 
lastround_min = 3000;
lastround_max = 3600;

% Octet des chiffrés sur lequel on teste nos modèles
octet = 1;

fprintf("----- Octet de w10 à obtenir par corrélation ----- \n")
w10 = reshape(sub_keys(:,:,11), 1,16);
disp(w10(octet))


%% Début du test des 3 métriques
figure
cto_extended = uint8(cto_mat(:, shiftrow(octet)) * ones(1, 256));
Z2 = bitxor(cto_extended, hypothese);
Z3 = invSBox(Z2+1);

hamming_weight_z3 = Weight_Hamming_vect(uint8(Z3)+ 1);
hamming_distance_cto_z3 = Weight_Hamming_vect(bitxor(uint8(Z3), cto_extended) + 1);
hamming_distance_z2_z3 = Weight_Hamming_vect(bitxor(uint8(Z3), uint8(Z2)) + 1);

correlation_1 = corr(single(hamming_weight_z3), fuites_mat);
correlation_2 = corr(single(hamming_distance_cto_z3), fuites_mat);
correlation_3 = corr(single(hamming_distance_z2_z3), fuites_mat);

%% Affichage du résultat
fprintf("----- Octet obtenu pour P_h(Z3) ----- \n")
subplot(1, 3, 1);
affiche_correlation(correlation_1(:,lastround_min:lastround_max))
title("Poids de hamming Z3");

fprintf("----- Octet obtenu pour D_h(cto,Z3) ----- \n")
subplot(1, 3, 2);
affiche_correlation(correlation_2(:,lastround_min:lastround_max))
title("Distance de hamming cto-Z3");

fprintf("----- Octet obtenu pour D_h(Z2,Z3) ----- \n")
subplot(1, 3, 3);
affiche_correlation(correlation_3(:,lastround_min:lastround_max))
title("Distance de hamming Z2-Z3");
