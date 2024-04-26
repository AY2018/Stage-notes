# Chapitre 2 


Déroulement des tâches 

1. Alimenter le réseau de neurones en données issues de l'ensemble d'entraînement (qui sont stockées dans les tenseurs train_images et train_labels)

2. Le réseau apprendra à associer aux images d'entrée des étiquettes 

3. Réseau produit des prédictions à partir des images contenues dans le tenseur test_images > then vérification que prédiction = étiquete dans le tenseur test_labels


### Étape 1 : préparer le réseau de neuronne et les données. 
Réseau = composé de couches (layers) = filtres (données entrées en ressortent en données plus utiles)


Compilation du modèle : 
Pour préparer le réseau à l'entraînement, nous devons choisir trois autres composantes à l'étape de la compilation : la fonction de perte, l'optimiseur et les mesures de performance (accuracy)

```python 
network.compile(optimizer='rmsprop',
                loss='categorical_crossentropy',
                metrics=['accuracy'])
```

Avant l'entrainement = important de convertir/transformer les données dans la forme attendue par le réseau. 

On peut maintenant passer à l'entrainement. 

### Étape 2 : Entrainement 

```python 
network.fit(train_images, train_labels, epochs=5, batch_size=128)
```


### Étape 3 : Vérification


```python
test_loss, test_acc = model.evaluate(test_images, test_labels)
```

model.evaluate va faire prédir test_images et comparé le résulat au test_labels associé. 



# Théorie

### Tenseurs 

Qu'est ce qu'un tenseurs ? Tableaux multidimensionnels Numpy
Questions possibles : 
- Quelles sont les différentes étapes ?
- Qu'est ce qu'il se passe lors de l'étape de la compilation ?
- Qu'est ce que le listing 
- Def tenseurs
- Def descente de gradient