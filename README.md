# Note du jour - Lun 15 April [Day 5]

- Manipuler Dataframes (from Excel file + CSV)
- Dataframe Wrangling

Table = Fancy Array
DataFrame = Fancy Table (better for large amount of data)

### Importation des librairies 

```julia 
using DataFrames, XLSX
```

### Récupération du fichier et utiliser les données pour créer la Dataframe 

```julia 
df = DataFrame(XLSX.readtable("kd2Marc_1.xlsx", "Sheet3")...)
```

naming convention for dataframes = df


### Problème n°1 = Les id ne sont pas dans le bon ordre 

#### Ajout d'une nouvelle colonne id 

Création : 
```julia 
df.new_id = 1:nrow(df)
```

Ajout : 

```julia 
df = select!(df, :new_id, All())
```


### Problème n°2 = Les colonnes POIDS et POIDS_1 sont similaires = doublons 

Je pourrais simplement suprrimer une des colonnes : 

```julia 
# Delete la colonne POIDS_1
select!(df, Not(:POIDS_1))
```

Cependant, même si dans ces conditions, je suis sûr que les colonnes sont similaires, ce ne sera pas toujours le cas. J'ai donc décidé dans un premier temps, de vérifier si elles sont strictement identiques. 


#### Convertir les "," en "."

On remarque que les valeurs de POIDS utilisent un point alors que POIDS_1 = virgules 

Pour convertir les virgules en points :

```julia 
df.POIDS_1 = replace.(string.(df.POIDS_1), "," => ".")
```

Pour les 3 premières valeurs de la nouvelle colonne on a : 

```bash
"1050444"
"1082663"
"0.988619" // A ne pas convertir 
```


On veut à présent convertir toutes valeaurs x tels que `-1<x<1` afin d'atteindre un même de niveau de précision que POIDS. 

```julia
df.POIDS_1 = parse.(Float64, df.POIDS_1) # Données convertient en FLOAT pour pouvoir faire des opérations (ps: ce changement peut être appliqué à toutes les colonnes (puisque leur type = ANY) pour leur donner le type approrié (int, float ou string)

greater_than_1= findall(x -> x > 1, df.POIDS_1)
df.POIDS_1[greater_than_1] = df.POIDS_1[greater_than_1]./ 1_000_000
```

On obtient donc au final : 

```julia
first(select(df, [:POIDS, :POIDS_1]), 5)
```
```bash
5×2 DataFrame
 Row │ POIDS     POIDS_1  
     │ Any       Float64  
─────┼────────────────────
   1 │ 1.05044   1.05044
   2 │ 1.08266   1.08266
   3 │ 0.988619  0.988619
   4 │ 1.08266   1.08266
   5 │ 0.988619  0.988619
```

Il suffit maintant de s'assurer que les valeurs des deux colonnes soient identiques avant de supprimer le doublon: 

```julia 
equal = all(df.POIDS .== df.POIDS_1)
println("All values equal between POIDS and POIDS_1: $equal")
```


### Problème rencontré

Cependant je me suis rendu compte que cette méthode ne marchait pas. 

Car si on check la 6ème valeur, 

```bash
10×2 DataFrame
 Row │ POIDS     POIDS_1  
     │ Any       Float64  
─────┼────────────────────
   1 │ 1.05044   1.05044
   2 │ 1.08266   1.08266
   3 │ 0.988619  0.988619
   4 │ 1.08266   1.08266
   5 │ 0.988619  0.988619
   6 │ 1.0687    0.010687
```
On se rend compte qu'une simple division par 10^6 ne marchera que pour certaines valeurs. 

La question est donc, comment faire pour appliquer la bonne division à chaque valeur ? 

```julia
function normalize_value(val)
    while val >= 10
        val /= 10
    end
    return round(val, digits=7)  
end

# On applique la fonction qu'aux valeurs supérieures à 1 

df3.POIDS_1 = [x > 1 ? normalize_value(x) : x for x in df3.POIDS_1]

```

En uniformant les valeurs de la même manière que la colonne POIDS, j'ai pu conclure que les données sont bien identiques = suppression du doublon


### Création du fichier clean 

```julia 
XLSX.writetable("kd2Marc_cleaned4.xlsx", df3)
```