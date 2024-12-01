if [ -z "$1" ]; then
    echo "Error: No se proporcionó ningún parámetro."
    echo "Uso: $0 <develop|staging|production>"
    exit 1
fi

case "$1" in
develop | staging | production)
    # Crea o se cambia al workspace correspondiente
    terraform workspace select -or-create "$1"
    # Aplica plan
    terraform apply -var-file="$1.tfvars" #-auto-approve #quizás es mejor validar y luego escribir yes.
    # Guarda referencias a recursos resultantes en el directorio "options" correspondiente.
    terraform output -raw ecr_repository_uri >./options-"$1"/ecr_repository_uri.txt
    terraform output -raw website_url >./options-"$1"/s3_website_url.txt
    terraform output -raw bucket_name >./options-"$1"/s3_bucket_name.txt
    ;;
*)
    # Código para manejar valores no válidos
    echo "Parámetro incorrecto. Los valores aceptados son: <develop|staging|production>"
    exit 2
    ;;
esac