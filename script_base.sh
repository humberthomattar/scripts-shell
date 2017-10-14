#!/bin/bash
# Job: <nome do script>
# Funcao: < descição dos objetivos do script>
# Autor: humbertho.mattar
# Execucao Avulsa - Plataforma Baixa
# Data da alteracao: <data da ultima alteracao>
# Modificacoes: <descricao do que foi alterado>
#

# Impressao formatada de informacao no log
function print_info () {
    printf "[%s %s] INFO - %s\n" "$(date +%d-%m-%Y)" "$(date +%H:%M:%S)" "$1"
}

# Impressao formatada de erro no log
function print_erro () {
    printf "[%s %s] ERRO - %s\n" "$(date +%d-%m-%Y)" "$(date +%H:%M:%S)" "$1"
}

# Validar a existencia de parametros informados
function is_args () {
  if [ "$#" -lt 1 ]; then
     print_erro "Nenhum parametro foi informado"
     print_info "Fim da execucao do $SCRIPT_NAME"
     exit 1
  fi
}

# Validar e entrar no diretorio informado
function go_dir () {
  if [ -d "$1" ]; then
    cd "$1" || exit 1
  else
    print_erro "Diretorio inexistente: $1"
    print_info "Fim da execucao do $SCRIPT_NAME"
    exit 1
  fi
}

# Validar se o argumento e um arquivo.
function is_file () {
  if [ ! -f "$1" ]; then
    print_erro "Arquivo inexistente: $1"
    print_info "Fim da execucao do $1"
    exit 1
  fi
}

# Agrupa todas as validacoes dos parametros informados
function validate_args () {
    print_info "Validando $QTD_ARGS parametro(s)"
    # Valida a existencia de argumentos
    is_args "$@"
    # loop para a validacao de todos os argumentos (diretorio e arquivo)
    for ARG in "$@"; do
      # Valida e entra no diretorio
      go_dir "$(dirname "$ARG")"
      #Validar se arquivo existe
      is_file "$(basename "$ARG")"
    done
    print_info "Validacao realizada com sucesso"
}



function main () {
  # Inicio da apresentacao do script
  print_info "Inicio da execucao do $SCRIPT_NAME"

  validate_args "$@"

  for ARG in "$@"; do
      # Nome do arquivo
      FILE=$(basename "$ARG")
      # Diretorio do arquivo
      PATH_FILE=$(dirname "$ARG")

      print_info "$FILE e $PATH_FILE"

  done

  # Termino da execucao do script
  print_info "Fim da execucao do $SCRIPT_NAME"

exit 0
}

# Parametros globais
SCRIPT_NAME=$(basename "$0")
# Quantidade de argumentos informados para o script
QTD_ARGS="$#"

# Parametros do arquivo de log
# Diretorio que o log sera criado
LOG_PATH="."
# Nome do log
LOG_NAME="$(date +%Y%m%d)$(date +%H%M).${SCRIPT_NAME%.*}.LOG"

# Chamada para execucao e roteamento do log
main "$@" | tee "$LOG_PATH$LOG_NAME"
