#!/bin/bash

# Script externo llamado preview_script.sh
# Se pasa el argumento $1 a la función get_preview_command
get_preview_command() {
	if [ -f "$1" ]; then
		# Es un archivo, usar bat para verlo
		echo "bat --color=always '$1'"
	elif [ -d "$1" ]; then
		# Es un directorio, usar tree para verlo
		#echo "tree -C '$1'"
		echo "ls -1F --group-directories --color=always '$1'"
	else
		# No es ni archivo ni directorio, no se puede prever
		echo "echo 'No preview available'"
	fi
}

# Llamada a la función con el argumento pasado desde FZF
get_preview_command "$1"
