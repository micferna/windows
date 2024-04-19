# Ouvrir une boîte de dialogue pour sélectionner le fichier
$cheminFichier = Get-ChildItem -Path "$env:USERPROFILE\Downloads" | Out-GridView -Title "Sélectionner le fichier à vérifier" -PassThru

if ($cheminFichier) {
    # Le fichier a été sélectionné
    # Afficher le chemin du fichier sélectionné
    Write-Host "Fichier sélectionné : $($cheminFichier.FullName)"

    # Demander à l'utilisateur le numéro de hachage SHA-256 attendu
    $numeroSHA256Attendu = Read-Host "Entrez le numéro de hachage SHA-256 attendu"

    # Vérifier si les hachages correspondent
    $hachageSHA256Fichier = (Get-FileHash -Path $cheminFichier.FullName -Algorithm SHA256).Hash

    if ($hachageSHA256Fichier -eq $numeroSHA256Attendu) {
        Write-Host "Le fichier est intègre."
    } else {
        Write-Host "Le fichier a été altéré ou n'est pas le bon."
    }
}
