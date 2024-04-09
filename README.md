# Note du jour - Tue 9 April 

## Things done :

- Read the article [Lien](../../ressources/LayoutAnalysis2012.pdf)
- Read the blog article [Lien](https://digitalorientalist.com/2023/11/03/11400/)
- Started Julia learning [Lien](https://github.com/JuliaAcademy/Introduction-to-Julia)

### Read the article [Lien](../../ressources/LayoutAnalysis2012.pdf)

Ce document est une étude sur l'analyse de la mise en page de documents historiques arabes en utilisant l'apprentissage automatique. 

**Objectif principal = distinguer le texte principal du texte des notes marginales dans les manuscrits anciens, qui sont souvent complexes et ne suivent pas des règles de mise en page strictes.** 

**Pourquoi ?** Ces notes sont ajoutées aux marges due au prix du papier à l'époque. Ces notes, même si != texte principal, sont des sources d'informations supplémentaire cruciales pour l'authentification fiable du manuscrit + donner des infos importantes (temps + lieu). 

**Problème** = les manuscrits n'ont pas une structure standard, les textes ont une orientation, taille, un espacement différents. Cela rend les méthodes basées uniquement sur la géométrie insuffisantes. 

**Solution** = Utiliser un type de réseau neuronale appelé Multi-layer Perceptron (MLP) afin de classifier les différents composants comme texte principale ou side-note. 

Comment ? Analyse de la forme + context autours. 

Cette méthode permet d'avoir une segmentation précise (95% accuracy). 


**Lien avec notre projet** ? Analyse de parchemins avec des side-notes. 

**Ce que je dois apprendre** : 
- Qu'est ce qu'un réseau neuronal


### Read the blog article [Lien](https://digitalorientalist.com/2023/11/03/11400/)

About : Kraken’s segmentation model and the process of training one's own segmentation models for layout analysis tasks.

How does layout analysis work ?
1. Identifying text regions on a page
2. Marking the lines within these regions
3. Sequencing the lines in the correct reading order

**In eScriptorium, we can either use Kraken's default segemention model, which works fine for traditional top-to-bottom, left-to-right, documents. However it has problems with different layouts (with side notes or with a different structure). We can thus train our own segmentation model using Kraken's interface** 

We can either : 
- Train a model from scratch (but needs high computer power)
- An alternative is to fine-tune an existing model which is more specific to what we would like to do.

When you train a model, you have to feed it data + adjust parameters (number of traininig epochs, managing the partition)

Voc: 
- `training epochs` = concept in machine learning = going over the entire dataset to better understand it. You can set the amount of times a model has to complete a training epoch (the more they do, the better the understanding). However, going over the dataset too many times can be counter productive (necessiting more ressource than what the model is learning), so we have to manage that and stop when necessary (= stop overfitting). 
- `partition between training and validation datasets` = the process of testing the model after each epoch

### Julia course [Lien](https://github.com/JuliaAcademy/Introduction-to-Julia)

Topics:
1. How to print
2. How to assign variables
3. How to comment
4. Syntax for basic math







