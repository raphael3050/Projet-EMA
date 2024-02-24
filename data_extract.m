%% Extraction des données des fichiers .csv
clc
close all
echo off 
clearvars

% Début du chrono pour mesurer le temps d'execution
tic

% Dossier contenant les fichiers de traces
folderSrc = "SECU8917/";

% Liste des fichiers dans le dossier
MyFolderInfo = dir(folderSrc);
MyFolderInfo = MyFolderInfo(3:end);

% Nombres de fichiers
Nt = 20000;
% Nombre de valeurs par fichier
Nm = 4000;

% Initialisation des matrices
pti_mat = zeros(Nt, 16);
cto_mat = zeros(Nt, 16);
key_mat = zeros(Nt, 16);
fuites_mat = zeros(Nt, Nm);

h = waitbar(0,'Please wait...');
% Parcourir les fichiers dans le dossier
for i = 1:Nt
        strfind(MyFolderInfo(i).name, 'trace');
        % Lire le fichier CSV
        tracename = MyFolderInfo(i).name;
        
        % Supprimer les identifiants "_pti" et "_cto"
        tracename_cleaned = tracename;
        tracename_cleaned = strrep(tracename_cleaned, '_pti', '');
        tracename_cleaned = strrep(tracename_cleaned, '_cto', '');
        tracename_cleaned = strrep(tracename_cleaned, '.csv', '');

        % Extraire les informations de tracename
        tracename_cleaned = split(tracename_cleaned, '=');

        key_str = char(tracename_cleaned(2,1));
        pti_str = char(tracename_cleaned(3,1));
        cto_str = char(tracename_cleaned(4,1));


        % Convertir les chaînes en matrices
        pti_mat(i, :) = hex2dec(reshape(pti_str, 2, [])')';
        cto_mat(i,:) =  hex2dec(reshape(cto_str, 2, [])')';
        key_mat(i,:) =  hex2dec(reshape(key_str, 2, [])')';
        
         % Charger le fichier CSV
        fuites_mat(i,:) = csvread(fullfile(folderSrc, tracename));
        waitbar(i/Nt,h,'Waiting for key, pti, cto extraction');
end

close(h)
% Enregistrement des matrices résultantes
save('pti.mat', 'pti_mat')
save('cto.mat', 'cto_mat')
save('key.mat', 'key_mat')
save('fuites.mat', 'fuites_mat')

% Fin du chronomètre
temps_execution = toc;

temps_execution = toc;
disp(['Temps d''exécution total : ', num2str(temps_execution), ' secondes']);