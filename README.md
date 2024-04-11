# Note du jour - Jeu 11 April

Comme je ne suis pas satisfait de mon avancé hier, j'ai décidé de passer directement à la pratique en me basant sur le livre "Hands on Computer Vision with Julia". 

Mon objectif principal aujourd'hui est de maitriser les bases de JuliaImages et pouvoir réaliser la segmentation que l'on m'a demandé de réaliser hier. 

## JuliaImages
- change saturation of an Image
- grayscale 
- Custom Color Filter
- Blur
- Sharpening 


## Bases de HDF5

### Qu'est-ce que le Format HDF5?

HDF5 = est un format de fichier conçu pour stocker et organiser de grandes quantités de données numériques grâce à sa structure flexible et hiérarchique. (HDF5 = classeur)

#### Avantages du Format HDF5

##### Gestion de Grandes Quantités de Données

Capable de stocker et d'indexer des volumes de données extrêmement grands, ce qui le rend parfait pour les applications scientifiques et d'ingénierie qui génèrent beaucoup de données.

##### Structure Hiérarchique:

Les données peuvent être organisées en groupes et sous-groupes, similaires aux dossiers et sous-dossiers dans un système de fichiers, ce qui facilite la navigation et l'organisation des données.

#### Intérêt de l'Utiliser avec Julia via la Librairie HDF5.jl

**Intégration Facile** : HDF5.jl permet d'utiliser HDF5 de manière native en Julia, facilitant l'intégration dans les flux de travail de data science et d'analyse de données.

**Performance Optimisée** : Profite de la rapidité de Julia pour la manipulation de grands datasets, essentielle pour le traitement et l'analyse de grandes quantités de données.

### Concepts de base

#### Groupe = dossier

Un groupe peut contenir plusieurs datasets ainsi que d'autres groupes .

#### Dataset = fichier

Un dataset peut contenir des éléments de base comme des tableaux numériques, des images.

#### Attribut = données sur des données (=propriétés)

Uilisé pour stocker des métadonnées sur les datasets et les groupes. Cela peut inclure des descriptions, des timestamps, ou d'autres données annotatives

(Exercice ajout image + description + xml)[https://github.com/AY2018/Stage-notes/blob/main/ressources/hdf5.jl]