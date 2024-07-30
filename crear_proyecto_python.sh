#!/bin/bash

clear

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

logo() {

  local text="${1:?}"
  echo -en "\n"
  printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
}

# Nombre del proyecto (opcional, se preguntará si no se proporciona)
project_name=${1:-"my_project"}

# URL del repositorio a clonar
repo_url="https://github.com/FQ211776/plantilla_para_python"

# Directorio del proyecto (se creará si no existe)
project_dir="$HOME/Dropbox/python_projects/$project_name"

# Verificar si el proyecto ya existe
if [ -d "$project_dir" ]; then
  logo "El proyecto '$project_name' ya existe."
else
  # Preguntar si se desea clonar el repositorio o iniciar un nuevo proyecto
  read -p "¿Deseas clonar el repositorio $repo_url (s/n)? " clone_repo
  echo""

  if [ "$clone_repo" == "s" ]; then
    # Clonar el repositorio
    git clone "$repo_url" "$project_dir"
    logo "Repositorio clonado en $project_dir."
  else
    # Crear el directorio del proyecto
    mkdir -p "$project_dir"
    logo "Proyecto '$project_name' creado en $project_dir."
  fi

  # Crear el entorno virtual
  logo "Creando entorno virtual en $project_dir/venv"
  python3 -m venv "$project_dir/venv"

  # Activar el entorno virtual
  logo "Activando entorno virtual"
  source "$project_dir/venv/bin/activate"

  # Actualizar pip
  logo "Actualizando pip"
  pip install --upgrade pip

  # Instalar dependencias si el archivo requirements.txt existe
  if [ -f "requirements.txt" ]; then
    logo "Instalando dependencias desde requirements.txt"
    pip install -r requirements.txt
  else
    logo "No se encontró el archivo requirements.txt. No se instalaron dependencias."
  fi

  logo "El entorno virtual se ha creado y activado correctamente."
fi

# Preguntar si se desea clonar el repositorio o iniciar un nuevo proyecto
read -p "¿Deseas crear un repositorio nuevo en github con este projecto? (s/n)? " nuevo_repo
echo""

if [ "$nuevo_repo" == "s" ]; then
  if ! command -v github-cli &>/dev/null; then # Verifica si gh NO está instalado
    sudo pacman -S --noconfirm github-cli
    echo "github-cli instalado satisfactoriamente"
  fi

  cd $project_dir

  rm -rf .git
  git init -b master
  git add --all .
  git commit -m 'La historia comienza aqui'
  gh repo create --source=. --private
  git push -u origin HEAD
  logo "Repositorio creado satusfactoriamente en $project_dir."

fi

cd $project_dir

# Abrir VSCode en el directorio del proyecto
code-insiders "$project_dir"
