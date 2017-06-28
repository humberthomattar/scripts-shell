#!/usr/bin/env bash
# Script: PythonStructure.sh
# Objective: create structure for python applications.
# Args: ./PythonStructure.sh NameApp
# Author: https://github.com/humberthomattar
#

function isDir() {
  if [ -d "$1" ]; then
    echo -e ">> ::FALHA:: O diretorio $1 já existe. A execução será cancelada!!"
    exit 0
  fi
}

function CreateTree() {
  main_dir="$1"
  sub_dir=$(echo "$main_dir" | tr '[:upper:]' '[:lower:]')

  echo -e ">> Criando árvore de diretórios e arquivos para o projeto $main_dir..."
  mkdir "$main_dir"
  echo "" > "$main_dir"/README.md
  echo "" > "$main_dir"/requirements.txt
  echo "" > "$main_dir"/TODO.md
  mkdir "$main_dir"/bin
  mkdir "$main_dir"/docs
  mkdir "$main_dir"/"$sub_dir"
  echo "" > "$main_dir"/"$sub_dir"/__init__.py
  echo "" > "$main_dir"/"$sub_dir"/main.py
  mkdir "$main_dir"/"$sub_dir"/conf
  echo "" > "$main_dir"/"$sub_dir"/conf/__init__.py
  mkdir "$main_dir"/"$sub_dir"/tests
  echo "" > "$main_dir"/"$sub_dir"/tests/__init__.py
  echo -e ">> Estrutura de diretórios criada com sucesso!!"
}

function main() {
echo -e ">> Iniciando a execução do script.."
project_name="$1"
isDir "$project_name"
CreateTree "$project_name"
echo -e ">> Script finalizado com sucesso!!"
}

main "$@"
