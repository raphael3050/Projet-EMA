# Projet-EMA

Cette archive contient l'ensemble des scripts Matlab utilisés pour mettre en place l'attaque CPA sur le dernier round de l'algorithme `AES 128bits`


<p align=center><a href="https://commons.wikimedia.org/wiki/File:AES_(Rijndael)_Round_Function.png#/media/File:AES_(Rijndael)_Round_Function.png"><img src="https://upload.wikimedia.org/wikipedia/commons/5/50/AES_%28Rijndael%29_Round_Function.png" alt="AES (Rijndael) Round Function.png" height="400" width="300" justify-content:'center'></a>

---
 ## Auteur
 Raphaël AZOU, *Master ASSEL 2025*

---

####  keysched2.m
Algorhitme implémentant le `Key Scheduler` de AES. Celui-ci est utilisé pour calculer les sous-clés à partir de la clé principale, et notamment pour calculer la sous-clé $w_{10}$ afin de la comparer avec le résultat de notre attaque. 

####  data_extract.m
Ce script extrait les données de chaque nom de fichier `csv` de l'archive `SECU8917` pour constituer les matrices `key_mat` `cto_mat` `pti_mat` et `fuites_mat`.

####  main.m

Ce script contient l'implémentation de l'attaque. 

####  tests_modele_prediction.m
Le rôle de ce fichier est de tester les différents modèles de prédictions théoriques que nous avons définis afin de déterminer le plus efficace d'entre eux pour la détermination du premier octet de la sous-clé.


####  moyenne_fuites.m

Ce script trace la courbe de la trace n°10000, puis trace ensuite une courbe correspondant à la moyenne des fuites. Les figures résultantes sont enregistrées dans le dossier `figures`.

####  affiche_correlation.m

Fonction utilisée pour afficher nos 256 courbes de corrélation et pour retourner l'octet produisant la valeur de corrélation maximale.

#### guessing_entropy.m

Ce script permet d'optimiser l'attaque en utilisant le métrique Guessing Entropy, dans le but de minimiser le nombre de traces nécessaires à la réussite de celle-ci.