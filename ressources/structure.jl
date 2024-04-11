using HDF5, Images

# Fonction pour créer un groupe de manuscrit
function create_manuscript_group(save_file, manuscript_id)
    # Créer un groupe principal pour un nouveau manuscrit 
    group_path = "Manuscrit_$(manuscript_id)" # (j'imagine que chaque manuscrit a un identifiant unique)
    if !exists(save_file, group_path)
        create_group(save_file, group_path)
        create_group(save_file, "$(group_path)/Images")
        create_group(save_file, "$(group_path)/Textes")
    end
end

# Fonction pour ajouter une image de page à un manuscrit
function add_page_image(save_file, manuscript_id, page_id, image_path)
    img = load(image_path)
    img_matrix = Float64.(Gray.(img))
    dataset_path = "Manuscrit_$(manuscript_id)/Images/Page_$(page_id)"
    save_file[dataset_path] = img_matrix
end

# Fonction pour ajouter une description de page à un manuscrit
function add_page_text(save_file, manuscript_id, page_id, text_content)
    dataset_path = "Manuscrit_$(manuscript_id)/Textes/Page_$(page_id)"
    save_file[dataset_path] = text_content # Variable qui contient le texte transcrit en format string
end

# Exemple d'utilisation pour créer un manuscrit et ajouter une page
save_file = h5open("manuscrits.h5", "w")
create_manuscript_group(save_file, "001")
add_page_image(save_file, "001", "001", "page1.png")
add_page_text(save_file, "001", "001", "Voici le texte de la page 1...")
close(save_file)


## Pour lire les données 

# fonctions pour lire les données
function read_page_image(fileVariable, manuscript_id, page_id)
    dataset_path = "Manuscrit_$(manuscript_id)/Images/Page_$(page_id)"
    img_matrix = read(fileVariable[dataset_path])
    img = Gray.(img_matrix)
    return img
end

function read_page_text(fileVariable, manuscript_id, page_id)
    dataset_path = "Manuscrit_$(manuscript_id)/Textes/Page_$(page_id)"
    text_content = read(fileVariable[dataset_path])
    return text_content
end

# and affichage de l'image et du texte
hdf5_file = h5open("manuscrits.h5", "r")
image = read_page_image(hdf5_file, "001", "001")
text = read_page_text(hdf5_file, "001", "001")
println("Text: ", text)
close(hdf5_file)