#!/bin/bash

# Assurez-vous que le script est exécuté par un utilisateur avec les droits appropriés
if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être exécuté avec des privilèges de superutilisateur."
  exit 1
fi

# Emplacement des fichiers de logs
LOG_FILES=(
  "/var/log/system.log"
  # "/var/log/authd.log" # Décommentez si authd.log devient disponible
)

# Expressions régulières pour la recherche de mots-clés supplémentaires
REGEX_PATTERNS=(
  "auth.*fail"
  "login.*fail"
  "invalid.*user"
  "password.*incorrect"
  "account.*lock"
  "session.*open"
  "session.*close"
  "access.*denied"
  "permission.*denied"
  "unauthorized.*access"
  "fail.*open"
  "file.*not.*found"
  "error"
  "critical"
  "warning"
  "panic"
  "segmentation.*fault"
  "core.*dumped"
  "connection.*refused"
  "connection.*accepted"
  "port.*scan"
  "suspicious.*activity"
  "denial.*of.*service"
  "packet.*loss"
  "unexpected.*shutdown"
  "service.*restart"
  "disk.*error"
  "memory.*error"
  "cpu.*error"
  "network.*error"
  "application.*crash"
  "system.*overload"
  "configuration.*error"
  "database.*error"
  "timeout"
  "resource.*exhaustion"
  "malware.*detected"
  "virus.*detected"
  "intrusion.*detected"
  "illegal.*operation"
)

# Fonction pour valider l'existence et la lisibilité des fichiers de logs
validate_log_file() {
  local log_file=$1
  if [ ! -f "$log_file" ]; then
    echo "Le fichier de logs ${log_file} n'existe pas ou n'est pas un fichier régulier."
    return 1
  elif [ ! -r "$log_file" ]; then
    echo "Le fichier de logs ${log_file} n'est pas lisible."
    return 1
  fi
  return 0
}

# Fonction pour rechercher les expressions régulières dans les logs et afficher des détails
search_logs() {
  local log_file=$1
  local regex_pattern=$2
  local match_count
  local line_details
  echo "------------------------------------------------"
  echo "Recherche de '${regex_pattern}' dans ${log_file}..."
  match_count=$(grep -Eioc "${regex_pattern}" "${log_file}")
  echo "Nombre de correspondances pour '${regex_pattern}': ${match_count}"
  if [ "$match_count" -gt 0 ]; then
    grep -Ei "${regex_pattern}" "${log_file}" | while read -r line; do
      # Extraction de l'horodatage, de l'adresse IP et du nom d'utilisateur si disponible
      line_details=$(echo "$line" | awk '{print $1, $2, $3, $4, $5, $6, $7, $8, $9}')
      echo "$line_details"
    done
  fi
}

# Créer un rapport consolidé
report_file="rapport_$(date +%Y%m%d_%H%M%S).txt"
echo "Rapport d'analyse des logs - $(date)" > "$report_file"

# Parcourir chaque fichier de logs et rechercher chaque expression régulière
for log_file in "${LOG_FILES[@]}"; do
  if validate_log_file "$log_file"; then
    for regex_pattern in "${REGEX_PATTERNS[@]}"; do
      search_logs "$log_file" "$regex_pattern" >> "$report_file"
    done
  else
    echo "Le fichier de logs ${log_file} a été ignoré." >> "$report_file"
  fi
done

echo "Rapport d'analyse terminé. Vérifiez le fichier ${report_file}."
