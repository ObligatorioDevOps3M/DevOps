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
    terraform destroy -var-file="$1.tfvars"
    ;;
*)
    # Código para manejar valores no válidos
    echo "Parámetro incorrecto. Los valores aceptados son: <develop|staging|production>"
    exit 2
    ;;
esac