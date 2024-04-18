# RECAP 1 (Semaine 1 - 2)

1. Apprentissage de Julia 
2. Image Processing 
3. Sujet du stage (Segmentation)

## 1. Apprentissage de Julia 

### Les types 

#### Int et Float 

Je connaissais déjà les types `sting, bool, int, float`

Sur Julia, on peut préciser la quantité de mémoire que l'on compte attribuer à un type numérique (int ou float)

Int8/16/32/64
UInt8/16/32/64 (only non-negative values)
Float32/64 (32 = 7 decimal, 64 = 15)

**Quel est l'intérêt ?**
- Memory efficiency: Using the appropriate type saves memory, which can be crucial when dealing with large datasets of images 
- Performance: Operations on smaller types are generally faster.
- Precision and range: Choosing between integers and floating-points can affect both the precision of the calculations and the range of values you can represent.

==> All of these reasons apply to our project for when we'll be doing machine learning.

#### Symbole 

Le `symbole` est un type que je ne connaissais pas. Si j'ai bien compris, un symbole = strings mais pas vraiment. 

Symbole est plus facile à comparer car stocké qu'une seule fois (on compare les memory adress plutôt que le contenu, ce qui est plus rapide)

**Quand utilisé symbole plutôt que string?**
- symbols when you need an efficient, immutable key that doesn't change and needs to be compared quickly.
- strings when you need to manipulate text data + splitting, concatenating, or altering the content.

### Data Structures

#### Tulpe 
Tableau qu'on ne peut pas modifier

#### Array/Matrix = tableau de donnée à N dimensions 
Image = array 
Méthodes pour manipuler une image (selectionner une partie, changer la couleur)

```julia
img_variable[top:bottom, left:right] # Access a portion of an image
```

#### Dictionnaires 
Dictionnaire = associe valeur à une clé 

```julia
my_dict = Dict(key1 => value1, key2 => value2)
my_dict["key1"]  # Output = value1
```

#### Dataframes

- Fancy arrays 
- Used when dealing with lots of data
- Need to be cleaned so that the data is easily processed(remove unwanted "," in floats, convert strings to floats, add ids, check if there are any NaN) 
- Created one using xlsx file but can do the same in csv and xml

### HDF5

HDF5 = est un format de fichier conçu pour stocker et organiser de grandes quantités de données numériques grâce à sa structure flexible et hiérarchique. (HDF5 = classeur).

Données sont stockées en groupes (dossiers), datasets (fichiers), et Attributs (metadata des datasets)

#### Proposition de Structure HDF5 pour le projet

Chaque manuscrit sera stocké dans un groupe principal, avec un sous-groupe pour les images et un autre pour les textes transcrits. Cette structure permet de séparer clairement les différents types de contenu tout en maintenant leur association sous le même manuscrit.

Exemple :

```bash
Manuscrit001/Images/Page001 - Image stockée numériquement

Manuscrit001/Textes/Page001 - Transcription
```



### Opérations 
#### Broadcast 
```julia
random = rand(10) #Create a  matrix with 10 random values 
chaque_valeur = sin.(random) # Apply sin() to each value
toute_matrix = sin(random) # Apply sin() to the entire array
```

#### Array comprehension + conditions 

```julia
# Generate numbers from 1 to 10, squared, only if they are even
squares = [i^2 for i in 1:10 if i % 2 == 0]

# Double for loops that change the colors of a matrix 
[RGB(i, j, 0) for i in 0:0.1:1, j in 0:0.1:1]
```

### Plots
Possible de créer plusieurs types de plots via le package `Plots`

```julia
# Différents types de plots 
p1 = plot(x, y, title="Line", legend=false)
p2 = scatter(x, y, title="Scatter", legend=false)
p3 = bar(x, z, title="Bar", legend=false)
p4 = histogram(z, title="Histogram", bins=5, legend=false)
```

### Genie.jl 

Framework pour faire du web via julia

Possible de créer des SPA (Single Page App) intéractives avec des graphiques qui varient en fonctino d'une variable binded à un slider. 

Je n'ai fais que check the tip of the iceberg et il faut beaucoup plus de recherches, de documentation et de pratiques si je veux atteindre l'objectif final. (***Moi qui est l'habitude de trouver des tutos complets sur Youtube pour apprendre les bases d'un framework, je me retrouve à toucher à un framework qui n'a presque aucun tuto vidéo. Il n'y a personne pour me tenir la main, ce qui est très intéressant et m'oblige à sortir de ma zone de connfort***)

## 2. Le Traitement d'image en 7 étapes

### Étape 1 : Qu'est ce qu'une image ? 

Une image numérique = une matrice rectangulaire composée de pixels. Chaque pixel = une couleur. 

Les coordonnées d'un pixel sont généralement définies avec l'origine (0,0) située au coin supérieur gauche de l'image. L'axe des x s'étend vers la droite et l'axe des y vers le bas.

Les images en couleur sont souvent composées de trois canaux (Rouge, Vert, Bleu ou RGB). Chaque canal a sa propre matrice de valeurs de pixels qui, combinées, déterminent la couleur finale de chaque pixel.

### Étape 2 : Comment modifier une Image ? 

- On peut rotate (pour les manuscrits chinois)
- On peut crop/couper une image 
- On peut la mettre en grayscale (simplifie le processus/calculs car rassemble les 3 canaux RGB en un seul +  facilite le thresholding) 
- On peut la binariser 

### Étape 3 : Masker une image 

On peut créer un mask sur une image pour choisir les éléments spécifiques que l'on veut étudier. 


### Étape 4 : Créer des Histogrames 

On peut utiliser les histogrames pour analyser la répartition des pixels (leur valeur) sur une image. On peut ainsi trouver un niveau de seuil. On peut également trouver nos régions d'intérêts (les lignes) on analysant la somme des pixels par ligne. 


### Étape 5 : Blur

Ajouter un effet de blur permet d'affiner les extrémités et d'enlever du bruit. 

Souvent utilisé avant le thresholding. 

On utilise un Gaussian Blur (appliqué via un kernel = une matrix impaire 3x3, 5x5 qui va passer par chaque pixel et effectuer une multiplication de chaque pixel autour par le pixel associé du kernel et transformer la valeur du pixel centrale par la moyenne des valeurs obtenues par l'opération)

On peut également utilise la différence de deux blurs pour séparer le background de l'objet étudié (DoG)

### Étape 6 : Thresholding/Seuillage 

Produit une image binaire (pixels = 0 ou 1 en fonction de leur valeur comparée au threshold). 

Permet d'enlever les éléments qui ne nous intéressent pas. 


### Étape 7 : Connected Component Analysis

Connected Components = permet de trouver des objets.

Logique : On part d'un pixel (qui est =1) et on se déplace d'un pixel horizontalement, puis verticalement, si on tombe sur un autre pixel = 1, alors les deux font partie d'un objet. 

Ce jump peut être de deux pixels par axe.

### Étape supplémentaire : Morphologie

On peut effectuer une érosion de l'image (qui va éliminer du bruit, mais également affiner l'objet) et/ou une dilatation (inverse). 

Opening = erosion + dilatation (enlver du bruit, puis remplir l'objet qui s'est affiné)

Closing = opératino inverse. 
