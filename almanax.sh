#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: almanax.sh [-d YYYY-MM-DD] [-f YYYY-MM-DD] [-p NOMBRE] [-l LANG]

Recupere les offrandes Almanax et affiche un tableau des quantites.

Options:
  -d DATE   Date de debut au format YYYY-MM-DD (defaut: date du jour)
  -f DATE   Date de fin au format YYYY-MM-DD (defaut: meme valeur que -d)
  -p N      Nombre de personnages (defaut: 1)
  -l LANG   Langue API (defaut: fr)
  -h        Affiche cette aide
EOF
}

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Erreur: commande requise introuvable: $cmd" >&2
    exit 1
  fi
}

is_valid_date() {
  [[ "$1" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
}

is_positive_int() {
  [[ "$1" =~ ^[1-9][0-9]*$ ]]
}

fetch_almanax() {
  local almanax_date="$1"
  local lang="$2"
  local url="https://api.dofusdu.de/dofus3/v1/${lang}/almanax/${almanax_date}"
  local payload

  payload="$(curl -fsS "$url")"

  if ! jq -e '.tribute.item.name and .tribute.quantity' >/dev/null <<<"$payload"; then
    echo "Erreur: reponse API incomplete pour $almanax_date ($lang)" >&2
    return 1
  fi

  jq -r '[.tribute.item.name, .tribute.quantity] | @tsv' <<<"$payload"
}

main() {
  local start_date
  local end_date
  local lang="fr"
  local characters=1
  local current_date
  local name
  local quantity
  local total_quantity

  start_date="$(date +%F)"
  end_date="$start_date"

  while getopts ":d:f:p:l:h" opt; do
    case "$opt" in
      d)
        start_date="$OPTARG"
        ;;
      f)
        end_date="$OPTARG"
        ;;
      p)
        characters="$OPTARG"
        ;;
      l)
        lang="$OPTARG"
        ;;
      h)
        usage
        exit 0
        ;;
      :)
        echo "Erreur: option -$OPTARG requiert une valeur" >&2
        usage
        exit 1
        ;;
      \?)
        echo "Erreur: option invalide -$OPTARG" >&2
        usage
        exit 1
        ;;
    esac
  done

  require_cmd curl
  require_cmd jq
  require_cmd date

  if ! is_valid_date "$start_date"; then
    echo "Erreur: date de debut invalide '$start_date' (attendu: YYYY-MM-DD)" >&2
    exit 1
  fi

  if ! is_valid_date "$end_date"; then
    echo "Erreur: date de fin invalide '$end_date' (attendu: YYYY-MM-DD)" >&2
    exit 1
  fi

  if ! is_positive_int "$characters"; then
    echo "Erreur: nombre de personnages invalide '$characters' (attendu: entier positif)" >&2
    exit 1
  fi

  if [[ "$(date -d "$start_date" +%s)" -gt "$(date -d "$end_date" +%s)" ]]; then
    echo "Erreur: la date de debut est posterieure a la date de fin" >&2
    exit 1
  fi

  printf "%-10s | %-40s | %8s | %11s\n" "Date" "Offrande" "Quantite" "Total perso"
  printf '%s\n' "-----------+------------------------------------------+----------+------------"

  current_date="$start_date"
  while [[ "$(date -d "$current_date" +%s)" -le "$(date -d "$end_date" +%s)" ]]; do
    if ! IFS=$'\t' read -r name quantity < <(fetch_almanax "$current_date" "$lang"); then
      exit 1
    fi

    total_quantity=$((quantity * characters))
    printf "%-10s | %-40s | %8s | %11s\n" "$current_date" "$name" "$quantity" "$total_quantity"

    current_date="$(date -d "$current_date + 1 day" +%F)"
  done

  printf "\nNombre de personnages: %s\n" "$characters"
}

main "$@"
