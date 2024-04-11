using HDF5, Images, ImageShow

img = load(download("https://media.istockphoto.com/id/1040006084/fr/photo/d%C3%A9couvre-sur-la-vieille-ville-dessaouira-au-maroc.jpg?s=612x612&w=0&k=20&c=CxUu_O1l3zAC_Mx2DAvlVWXWbDzLedUlcD-bdPCoF_A=", "maroc.png"))

# Convertir l'image en matrice de gris que l'on pourra stocker
img_matrix = Float64.(Gray.(img))

# Ouvrir/créer le fichier if not exist
h5file = h5open("mon_fichier.h5", "w")


create_group(h5file, "Images")

h5file["Images/image_matrix"] = img_matrix #Create dataset inside Images

write_attribute(h5file["Images/image_matrix"], "Description", "This is an image of Essaouira, Maroc")

close(h5file)

## Vérification

# Ouvrir le fichier en mode lecture only
h5file = h5open("mon_fichier.h5", "r")

# Accéder au dataset de l'image
retrieved_matrix = read(h5file["Images/image_matrix"])

# Accéder à l'attribut
description_recup = read_attribute(h5file["Images/image_matrix"], "Description")

println("Description récupérée : ", description_recup)

# Visualiser la matrice comme une image et sauvegarder
img_reconstructed = Gray.(retrieved_matrix)
save("image_reconstructed.png", img_reconstructed)

close(h5file)


# Données XML à ajouter
xml_data = """
<info>
    <photographe>Ayoub Kahfy</photographe>
    <ville>Tanja</ville>
    <description>Répertoire de photo de la ville de Tanja au Maroc</description>
</info>
"""


h5file = h5open("mon_fichier.h5", "r+")

h5file["Images/xml_data"] = xml_data

close(h5file)