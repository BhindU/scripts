#!/bin/bash
echo
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
RED2='\033[4;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
BLUE2='\033[7;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTPURPLE2='\033[5;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
# ----------------------------------
echo -e "${GREEN}"
echo
cat << "EOF"
UUUUUUUU     UUUUUUUURRRRRRRRRRRRRRRRR   LLLLLLLLLLL                  222222222222222    DDDDDDDDDDDDD      IIIIIIIIII      CCCCCCCCCCCCC
U::::::U     U::::::UR::::::::::::::::R  L:::::::::L                 2:::::::::::::::22  D::::::::::::DDD   I::::::::I   CCC::::::::::::C
U::::::U     U::::::UR::::::RRRRRR:::::R L:::::::::L                 2::::::222222:::::2 D:::::::::::::::DD I::::::::I CC:::::::::::::::C
UU:::::U     U:::::UURR:::::R     R:::::RLL:::::::LL                 2222222     2:::::2 DDD:::::DDDDD:::::DII::::::IIC:::::CCCCCCCC::::C
 U:::::U     U:::::U   R::::R     R:::::R  L:::::L                               2:::::2   D:::::D    D:::::D I::::I C:::::C       CCCCCC
 U:::::D     D:::::U   R::::R     R:::::R  L:::::L                               2:::::2   D:::::D     D:::::DI::::IC:::::C              
 U:::::D     D:::::U   R::::RRRRRR:::::R   L:::::L                            2222::::2    D:::::D     D:::::DI::::IC:::::C              
 U:::::D     D:::::U   R:::::::::::::RR    L:::::L                       22222::::::22     D:::::D     D:::::DI::::IC:::::C              
 U:::::D     D:::::U   R::::RRRRRR:::::R   L:::::L                     22::::::::222       D:::::D     D:::::DI::::IC:::::C              
 U:::::D     D:::::U   R::::R     R:::::R  L:::::L                    2:::::22222          D:::::D     D:::::DI::::IC:::::C              
 U:::::D     D:::::U   R::::R     R:::::R  L:::::L                   2:::::2               D:::::D     D:::::DI::::IC:::::C              
 U::::::U   U::::::U   R::::R     R:::::R  L:::::L        LLLLL      2:::::2               D:::::D    D:::::D I::::I C:::::C       CCCCCC
 U:::::::UUU:::::::U RR:::::R     R:::::RLL:::::::LLLLLLLL::::L      2:::::2       222222DDD:::::DDDDD:::::DII::::::IIC:::::CCCCCCCC::::C
  UU:::::::::::::UU  R::::::R     R:::::RL::::::::::::::::::::L      2::::::2222222:::::2D:::::::::::::::DD I::::::::I CC:::::::::::::::C
    UU:::::::::UU    R::::::R     R:::::RL::::::::::::::::::::L      2::::::::::::::::::2D::::::::::::DDD   I::::::::I   CCC::::::::::::C
      UUUUUUUUU      RRRRRRRR     RRRRRRRLLLLLLLLLLLLLLLLLLLLLL      22222222222222222222DDDDDDDDDDDDD      IIIIIIIIII      CCCCCCCCCCCCC   
EOF
echo
echo "														                            v.0.9.4"
echo "														                            BhindU"
echo
echo Escribe la URL de la que quieres extraer un diccionario
echo
echo -e "${WHITE}"
read -p "URL: " url
echo -e "${BLUE}"
echo "Que quieres hacer?"
echo
echo -e "1 - Quiero hacer un diccionario de calidad ${LIGHTCYAN} (DEPENDE)"
echo -e "${BLUE}"
echo -e "2 - Crear diccionario solo de la URL que he puesto ${LIGHTGREEN} (MUY RAPIDO)"
echo -e "${BLUE}"
echo -e "3 - Crear diccionario de la URL que he puesto y de subdirectorios ${YELLOW} (RAPIDO) "
echo -e "${BLUE}"
echo -e "4 - Quiero descargar la WEB entera! ${RED} (MUY LENTO)"
echo -e "${BLUE}"
echo -e "5 - Quiero listar subdirectorios de la WEB ${NOCOLOR} (INFO)"
echo -e "${LIGHTPURPLE2}"
echo -e "6 - MISCELLANEUS"
echo -e "${BLUE}"
echo
echo
echo -e "${BLUE2}? - Estoy un poco esturdido${BLUE} "
echo
read -p "Opcion: " action
echo
#/bin/bash
case "$action" in
  "1")
	echo    	
	echo has elegido la opcion 1
	echo	
	echo -e "Durante cuantos minutos estas dispuesto a esperar a que se descargue la web?"${WHITE}
	echo	
	read -p "Minutos: " minutos
	let "segundos = $minutos * 60"
	echo
	echo -e "${BLUE}Cuantas veces se ha de repetir la misma palabra para que esta se incluya en el diccionario?${WHITE}"	
	echo	
	read -p "Repeticiones: " repetidas
	echo
	echo -e " ${YELLOW} Descargando durante $segundos segundos..."
	rm -r webtemp 2> /dev/null
	mkdir webtemp
	cd webtemp
	timeout $segundos wget -nH -np -nd -E -r -l 0 -nv -e robots=off --random-wait --limit-rate 2m -o url.tmp $url
	urlsdescargadas=$(grep -o "http.*" url.tmp | cut -f 1 -d " " | grep -o "http.*" url.tmp | cut -f 1 -d " " | column -ts: | tr "//" " " | wc | tr -s " " | cut -f2 -d " ")
	echo 
	echo
	echo -e " ${RED2}URLs descargadas${RED} (${YELLOW} $urlsdescargadas ${RED}) ${LIGHTBLUE} "
	echo
	grep -o "http.*" url.tmp | cut -f 1 -d " " | grep -o "http.*" url.tmp | cut -f 1 -d " " | column -ts: | tr "//" " " | tr -s " " | tr " " "/" | grep -o "/.*" | sed 's/^./  /'
	rm url.tmp


	find . -name '*.html' > /tmp/data.txt

	while IFS= read -r file
        do
        [ -f "$file" ] && sed -n '/<body/,/<\/body>/p' "$file" | sed "/<script/,/<\/script>/d" | sed "/<style/,/<\/style>/d" | grep -o -P '(?<=\>).*(?=\<)' | sed -e "s/<[^>]*>/ /g" > weblimpio1.html && sed 's/&Aacute;/a/g' weblimpio1.html | sed 's/&aacute;/a/g' | sed 's/&Eacute;/e/g' | sed 's/&eacute;/e/g' | sed 's/&Iacute;/i/g' | sed 's/&iacute;/i/g' | sed 's/&Oacute;/o/g' | sed 's/&oacute;/o/g' | sed 's/&Uacute;/u/g' | sed 's/&uacute;/u/g' > weblimpio2.html && sed 's/[^a-zA-Z]/ /g' weblimpio2.html | sed 's/[A-Z]/\L&/g' | tr '[:space:]' '\n' | sort | sed '/^.\{20\}./d' | sed -e 's/[àâáä]/a/g;s/[ọõóòö]/o/g;s/[íìï]/i/g;s/[êệéèë]/e/g;s/[úùü]/u/g;s/[ñ]/n/g' | grep -E '(\w{3,})' | uniq -c |  awk -v repes="$repetidas" '$1 >= repes { print $2 }' >> predic.txt
        done < "/tmp/data.txt"
	cat predic.txt | sort | uniq >> dic.txt
	rm predic.txt
	mv dic.txt ..
	cd ..
	rm -r webtemp
	echo
	echo -e " ${GREEN} Se han descargado${YELLOW} $urlsdescargadas ${GREEN}paginas web"
	echo	
	echo
	echo -e " ${GREEN} Se ha creado el diccionario dic.txt con la URL que has proporcionado"
	echo
    ;; 
  "2")
	echo    
	echo has elegido la opcion 2
	echo
	echo -e " ${YELLOW} Espera un momentico mientras descargamos..."	
	curl $url --insecure > web.txt
	rm dic.txt 2> /dev/null	
	sed -n '/<body/,/<\/body>/p' web.txt | sed "/<script/,/<\/script>/d" | sed "/<style/,/<\/style>/d" | grep -o -P '(?<=\>).*(?=\<)' | sed -e "s/<[^>]*>/ /g" > weblimpio.txt
	sed 's/&Aacute;/a/g' weblimpio.txt | sed 's/&aacute;/a/g' | sed 's/&Eacute;/e/g' | sed 's/&eacute;/e/g' | sed 's/&Iacute;/i/g' | sed 's/&iacute;/i/g' | sed 's/&Oacute;/o/g' | sed 's/&oacute;/o/g' | sed 's/&Uacute;/u/g' | sed 's/&uacute;/u/g' > weblimpio2.txt
	sed 's/[^a-zA-Z]/ /g' weblimpio2.txt| sed 's/[A-Z]/\L&/g' | tr '[:space:]' '\n' | sort | sed '/^.\{20\}./d' | sed -e 's/[àâáä]/a/g;s/[ọõóòö]/o/g;s/[íìï]/i/g;s/[êệéèë]/e/g;s/[úùü]/u/g;s/[ñ]/n/g' | uniq | grep -E '(\w{3,})' > dic.txt
	rm web.txt weblimpio.txt weblimpio2.txt
	echo	
	echo -e " ${GREEN} Se ha creado el diccionario dic.txt con la URL que has proporcionado"
	echo
    ;;
  "3")
	echo    
	echo has elegido la opcion 3
	echo
	echo -e " ${YELLOW} Espera un momentico mientras descargamos..."
	rm -r webtemp 2> /dev/null
	mkdir webtemp
	cd webtemp
	timeout 180 wget -nH -np -nd -E -r -l 1 -nv -e robots=off --random-wait --limit-rate 2m -o url.tmp $url
	echo
	echo -e " ${RED} URLs descargadas ${LIGHTBLUE} "
	echo
	grep -o "http.*" url.tmp | cut -f 1 -d " " | grep -o "http.*" url.tmp | cut -f 1 -d " " | column -ts: | tr "//" " "
	rm url.tmp


	find . -name '*.html' > /tmp/data.txt

	while IFS= read -r file
        do
        [ -f "$file" ] && sed -n '/<body/,/<\/body>/p' "$file" | sed "/<script/,/<\/script>/d" | sed "/<style/,/<\/style>/d" | grep -o -P '(?<=\>).*(?=\<)' | sed -e "s/<[^>]*>/ /g" > weblimpio1.html && sed 's/&Aacute;/a/g' weblimpio1.html | sed 's/&aacute;/a/g' | sed 's/&Eacute;/e/g' | sed 's/&eacute;/e/g' | sed 's/&Iacute;/i/g' | sed 's/&iacute;/i/g' | sed 's/&Oacute;/o/g' | sed 's/&oacute;/o/g' | sed 's/&Uacute;/u/g' | sed 's/&uacute;/u/g' > weblimpio2.html && sed 's/[^a-zA-Z]/ /g' weblimpio2.html | sed 's/[A-Z]/\L&/g' | tr '[:space:]' '\n' | sort | sed '/^.\{20\}./d' | sed -e 's/[àâáä]/a/g;s/[ọõóòö]/o/g;s/[íìï]/i/g;s/[êệéèë]/e/g;s/[úùü]/u/g;s/[ñ]/n/g' | uniq | grep -E '(\w{3,})' >> dic.txt
        done < "/tmp/data.txt"
	mv dic.txt ..
	cd ..
	rm -r webtemp
	echo
	echo -e " ${GREEN} Se ha creado el diccionario dic.txt con la URL que has proporcionado"
	echo

    ;;
  "4")
	echo    	
	echo has elegido la opcion 4
	echo	
	echo -e "Durante cuantas horas estas dispuesto a esperar a que se descargue la web?"${WHITE}
	echo	
	read -p "Horas: " horas
	let "segundos = $horas * 60 * 60"
	echo
	echo
	echo -e " ${YELLOW} Descargando durante $segundos segundos..."
	rm -r webtemp 2> /dev/null
	mkdir webtemp
	cd webtemp
	timeout $segundos wget -nH -np -nd -E -r -l 0 -nv -e robots=off --random-wait --limit-rate 2m -o url.tmp $url
	urlsdescargadas=$(grep -o "http.*" url.tmp | cut -f 1 -d " " | grep -o "http.*" url.tmp | cut -f 1 -d " " | column -ts: | tr "//" " " | wc | tr -s " " | cut -f2 -d " ")
	echo 
	echo
	echo -e " ${RED2}URLs descargadas${RED} (${YELLOW} $urlsdescargadas ${RED}) ${LIGHTBLUE} "
	echo
	grep -o "http.*" url.tmp | cut -f 1 -d " " | grep -o "http.*" url.tmp | cut -f 1 -d " " | column -ts: | tr "//" " " | tr -s " " | tr " " "/" | grep -o "/.*" | sed 's/^./  /'
	rm url.tmp


	find . -name '*.html' > /tmp/data.txt

	while IFS= read -r file
        do
        [ -f "$file" ] && sed -n '/<body/,/<\/body>/p' "$file" | sed "/<script/,/<\/script>/d" | sed "/<style/,/<\/style>/d" | grep -o -P '(?<=\>).*(?=\<)' | sed -e "s/<[^>]*>/ /g" > weblimpio1.html && sed 's/&Aacute;/a/g' weblimpio1.html | sed 's/&aacute;/a/g' | sed 's/&Eacute;/e/g' | sed 's/&eacute;/e/g' | sed 's/&Iacute;/i/g' | sed 's/&iacute;/i/g' | sed 's/&Oacute;/o/g' | sed 's/&oacute;/o/g' | sed 's/&Uacute;/u/g' | sed 's/&uacute;/u/g' > weblimpio2.html && ssed 's/[^a-zA-Z]/ /g' indexlimpio2.html | sed 's/[A-Z]/\L&/g' | tr '[:space:]' '\n' | sort | sed '/^.\{20\}./d' | sed -e 's/[àâáä]/a/g;s/[ọõóòö]/o/g;s/[íìï]/i/g;s/[êệéèë]/e/g;s/[úùü]/u/g;s/[ñ]/n/g' | uniq | grep -E '(\w{4,})' >> dic.txt
        done < "/tmp/data.txt"
	mv dic.txt ..
	cd ..
	rm -r webtemp
	echo
	echo -e " ${GREEN} Se han descargado${YELLOW} $urlsdescargadas ${GREEN}paginas web"
	echo	
	echo
	echo -e " ${GREEN} Se ha creado el diccionario dic.txt con la URL que has proporcionado"
	echo
    ;;
  "5")
	echo    	
	echo has elegido la opcion 4
	echo	
	echo -e "A que nivel de recursividad/profundidad quieres llegar (0-99)?"${WHITE}
	echo	
	read -p "Profundidad: " depth
	echo
	echo -e "${BLUE}Cuanto tiempo estas dispuesto a esperar como maximo?${WHITE}"	
	echo	
	read -p "Minutos: " minutos
	let "segundos = $minutos * 60"
	echo	
	mkdir deleteme5
	cd deleteme5
	echo
	echo -e " ${RED} Revisando todos los subidectorios de ${RED2}$url...${RED}"
	echo
	timeout $segundos wget -r --level=$depth -x -nv --no-remove-listing --spider -T 1 $url > /dev/null 2>&1
	echo
	echo -e " ${YELLOW} Mostrando arbol ${WHITE} "
	echo	
	find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
	cd ..
	rm -r deleteme5
	echo
    ;;
  "6")
	clear	
	echo
	sleep 0.5
	echo -e "${CYAN}"
	clear
cat << "EOF"

  _____  
 |  __ \ 
 | |  | |
 | |  | |
 | |__| |
 |_____/ 
EOF
		
	echo
	echo
	echo "  /"
	sleep 0.5
	echo -e "${LIGHTGREY}"
	clear
cat << "EOF"

  _____   ____  
 |  __ \ / __ \ 
 | |  | | |  | |
 | |  | | |  | | 
 | |__| | |__| | 
 |_____/ \____/ 
EOF
		
	echo
	echo
	echo "  |"
	sleep 0.5
	echo -e "${PURPLE} "
	clear
cat << "EOF"

  _____   ____   _____ 
 |  __ \ / __ \ / ____|
 | |  | | |  | | |    
 | |  | | |  | | |    
 | |__| | |__| | |____
 |_____/ \____/ \_____|
EOF
		
	echo
	echo
	echo "  \\"
	sleep 0.5
	echo -e "${LIGHTGREEN} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ 
 |  __ \ / __ \ / ____| |  | |
 | |  | | |  | | |    | |  | |
 | |  | | |  | | |    | |  | |
 | |__| | |__| | |____| |__| |
 |_____/ \____/ \_____|\____/
EOF
		
	echo
	echo
	echo "  -"
	sleep 0.5
	echo -e "${ORANGE} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ 
 |  __ \ / __ \ / ____| |  | |  \/  |
 | |  | | |  | | |    | |  | | \  / |
 | |  | | |  | | |    | |  | | |\/| |
 | |__| | |__| | |____| |__| | |  | |
 |_____/ \____/ \_____|\____/|_|  |_|
EOF
		
	echo
	echo
	echo "  /"
	sleep 0.5
	echo -e "${WHITE} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____|
 | |  | | |  | | |    | |  | | \  / | |__  
 | |  | | |  | | |    | |  | | |\/| |  __| 
 | |__| | |__| | |____| |__| | |  | | |____
 |_____/ \____/ \_____|\____/|_|  |_|______|
EOF
		
	echo
	echo
	echo "  |"
	sleep 0.5
	echo -e "${YELLOW} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |
 | |__| | |__| | |____| |__| | |  | | |____| |\  |
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|
EOF
		
	echo
	echo
	echo "  \\"
	sleep 0.5
	echo -e "${LIGHTPURPLE} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ _______ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |__   __|
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |  | |
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |  | | 
 | |__| | |__| | |____| |__| | |  | | |____| |\  |  | |
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|  |_|
EOF
		
	echo
	echo
	echo "  -"
	sleep 0.5
	echo -e "${LIGHTBLUE} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ _______   ___ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |__   __| |__ \ 
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |  | |       ) |
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |  | |      / / 
 | |__| | |__| | |____| |__| | |  | | |____| |\  |  | |     / /_ 
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|  |_|    |____|
EOF
		
	echo
	echo
	echo "  /"
	sleep 0.5
	echo -e "${DARKGREY} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ _______   ___    _____ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |__   __| |__ \  |  __ \_
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |  | |       ) | | |  | |
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |  | |      / /  | |  | |
 | |__| | |__| | |____| |__| | |  | | |____| |\  |  | |     / /_  | |__| |
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|  |_|    |____| |_____/
EOF
		
	echo
	echo
	echo "  |"
	sleep 0.5
	echo -e "${LIGHTRED} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ _______   ___    _____ _____ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |__   __| |__ \  |  __ \_   _/
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |  | |       ) | | |  | || ||
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |  | |      / /  | |  | || ||
 | |__| | |__| | |____| |__| | |  | | |____| |\  |  | |     / /_  | |__| || ||
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|  |_|    |____| |_____/_____\
EOF
		
	echo
	echo
	echo "  \\"
	sleep 0.5
	echo -e "${LIGHTGREEN} "
	clear
cat << "EOF"

  _____   ____   _____ _    _ __  __ ______ _   _ _______   ___    _____ _____ _____ 
 |  __ \ / __ \ / ____| |  | |  \/  |  ____| \ | |__   __| |__ \  |  __ \_   _/ ____|
 | |  | | |  | | |    | |  | | \  / | |__  |  \| |  | |       ) | | |  | || || |     
 | |  | | |  | | |    | |  | | |\/| |  __| | . ` |  | |      / /  | |  | || || |     
 | |__| | |__| | |____| |__| | |  | | |____| |\  |  | |     / /_  | |__| || || |____ 
 |_____/ \____/ \_____|\____/|_|  |_|______|_| \_|  |_|    |____| |_____/_____\_____|
EOF
echo -e "${WHITE}"
cat << "EOF"
				  /////|  //////////|
				 ///// | ////////// |
				|~~~|  ||~~~||~~~|  |
				|===|  ||===||===|  |
				|   |  ||P  ||D  |  |
				|   |  || D || O |  |
				|   | /	|  F||  C| /
				|===|/	|===||===|/
				'---'	'---''---'
EOF
echo -e "${RED}"
cat << "EOF"
		      __...--~~~~~-._   _.-~~~~~--...__
		    //               `V'               \\ 		
		   //                 |                 \\ 		
		  //__...--~~~~~~-._  |  _.-~~~~~~--...__\\ 
		 //__.....----~~~~._\ | /_.~~~~----.....__\\
		====================\\|//====================
		                    `---`
EOF
	echo
	echo -e "${BLUE}"
	echo -e "1 - Quiero extraer todas las palabras de un documento PDF"
	echo -e "${BLUE}"
	echo -e "2 - Quiero extraer todas las palabras de un documento WORD (no disponible)"
	echo
	read -p "Opcion: " action2
	case "$action2" in
  "1")
	echo    	
	echo has elegido la opcion 1
	echo
	echo -e "Indicame la ruta donde se encuentran todos esos PDFs${WHITE}"
	echo
	read -p "Ruta: " -e pathpdfs	
	echo
	echo -e "${BLUE}Cuantas veces se ha de repetir la misma palabra para que esta se incluya en el diccionario?${WHITE}"
	echo
	read -p "Repeticiones: " repetidas2
	echo
	echo -e " ${YELLOW} Espera un momentico..."		
	echo -e "${BLUE}"	
	pathprograma=$(pwd)	
	cd $pathpdfs
	find . -name '*.pdf' > /tmp/data.txt
	while IFS= read -r file
        do
	[ -f "$file" ] && pdftotext -eol unix "$file" "$file".txt
        [ -f "$file" ] && cat "$file".txt | sed -e 's/[^ ]*-[^ ]*//ig' | sed 's/[^a-zA-Z]/ /g' | sed -e 's/ \+/ /g' | tr '[:space:]' '\n' | grep -E '(\w{4,})' | sed 's/[A-Z]/\L&/g' | sed -e 's/[àâáä]/a/g;s/[ọõóòö]/o/g;s/[íìï]/i/g;s/[êệéèë]/e/g;s/[úùü]/u/g;s/[ñ]/n/g' | sort | uniq >> pdfsraw.txt
	[ -f "$file" ] && rm "$file".txt
        done < "/tmp/data.txt"	
	cat pdfsraw.txt | sort | uniq -c | awk -v repes="$repetidas2" '$1 >= repes { print $2 }' >> $pathprograma/dic.txt
	rm pdfsraw.txt
	echo	
	echo -e " ${GREEN} Se ha creado el diccionario dic.txt con los PDFs que has proporcionado"
	echo
    ;; 
  "2")
	echo    	
	echo has elegido la opcion 2
	echo
	echo -e "Esta opcion aun no esta disponible"
    ;;
  *)
    echo "No se que carajo has puesto, anda a cascala!"
    exit 1
    ;;
esac
;;
  "?")
	echo    
	echo has elegido la opcion de ayuda
	echo	
	echo "La opcion 1 empezara a descargar la web objetivo enter hasta que pase el tiempo que le hayas establecido."
	echo "Ademas, le podras decir cuantas veces como minimo se ha de repetir la misma palabra para incluirla en el diccionario que va a acabar generando."
	echo
	echo "La opcion 2 lo que hace es descargar solo la URL que hayas introducido y anadir los resultados a un diccionario."
	echo
	echo "La opcion 3 lo que hace es descargar solo la URL que hayas introducido, las webs que aparecen en el codigo fuente de la URL introducida (lo que comunmente se llama un nivel de profundidad/recursividad) y te crea un diccionario con las palabras de todas esas webs."
	echo "Es posible que en el codigo de la web que hayas introducido existan muchas otras webs, por lo que podria tardar bastante tiempo en sacar el diccionario; por ello se ha establecido que el tiempo maximo que puede estar descargando es de 3 minutos." 
	echo
	echo "La opcion 4 es para descargar todas las palabras existentes en una web."
	echo "Lo unico que necesitas es decirle durante cuantas horas quieres que este descargando esa pagina web."
	echo "Importante saber que, si quieres hacer esto mismo pero que las palabras que salgan en tu diccionario se hayan tenido que repetir n veces, lo puedes hacer con la opcion 1 del menu principal."
	echo
	echo "La opcion 5 sirve para descargarte la estructura de archivos de una web en formato de arbol (formato del comando tree de Windows) y mostrarla por pantalla."
	echo
	echo "La opcion 6 es para crear diccionarios usando como base documentos WORD y PDF que tengas descargados."
    ;;
  *)
    echo "No se que carajo has puesto, anda a cascala!"
    exit 1
    ;;
esac





