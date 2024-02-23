clc
close all
echo off 

load("fuites.mat", "fuites_mat");


%% Question 1 - Tracé d'une courbe de consommation

figure;
plot(fuites_mat(10000,:),'r');
xlabel('Échantillons');
ylabel('Consommation');
title('Tracé de la trace n°10000');
grid on;

%% Question 2 - Tracé de la moyenne des courbes de consommation

% Calcul de la moyenne le long de l'axe 1 (colonnes)
fuites_mean = mean(fuites_mat, 1);
figure;
plot(fuites_mean); hold on;
xlabel('Échantillons');
ylabel('Moyenne des traces');
title('Tracé de la moyenne des fuites');
grid on;
