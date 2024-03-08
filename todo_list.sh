#! /bin/bash
file=tasks.txt
function _add {
  echo "0,$1,\"$2\"" >> "$file"
}
case $1 in
"add")
  while [ -n "$2" ]
  do
    case "$2" in
      -t | --title)
        if [ -z "$3" ]; then
           echo "Option -t|--title Needs a Parameter" | lolcat
           exit
        fi
        name="$3"
        shift
        shift ;;

      -p | --priority)
        priority=$3
        if [[ $priority != 'L' && $priority != 'M' && $priority != 'H' ]]; then
          echo "Option -p|--priority Only Accept L|M|H" | lolcat
          exit
        fi
        shift
        shift ;;

      *)
        echo "Invalid Option" | lolcat
        exit ;;
    esac
  done
  if [[ -z "$priority" ]]; then
    priority="L"
  fi
  _add "$priority" "$name";;
clear)
  echo -n "" > $file | lolcat;;
list)
  awk -F\, '{print FNR" | "$1" | "$2" | "$3}' $file | lolcat;;
find)
  awk -F\, '{print FNR" | "$1" | "$2" | "$3}' $file | grep "$2" | lolcat;;
done)
  sed -i -e "$2""s/0/1/" tasks.csv;;
-h | --help)
  echo " add (-t or --title)    : With this command, you can enter the name of your daily work" | lolcat
  echo " add (-p or --priority) : With this command, you can enter your daily work priority (L ,M ,H)" | lolcat
  echo " "
  echo " clear : With this command, you can clear all your daily tasks" | lolcat
  echo " "
  echo " list : With this command, you can see all your daily tasks" | lolcat
  echo " "
  echo " find : With this command, you can find your daily task from the task list" | lolcat
  echo " "
  echo " done : With this command, you can record your daily tasks" | lolcat
  echo " "
  echo " --------------------------------------------------------------------------------------------" | lolcat
  echo " "
  echo " 1 | 0 | H | First Task" | lolcat
  echo " ^ ID            ^ title" | lolcat
  echo "         ^ (L or M or H); L : Low priority; M : Medium priority; H : High priority" | lolcat
  echo "     ^ (0 or 1); 0 : undone; 1 : done" | lolcat
  ;;
*)
  echo "Command Not Supported!" | lolcat;;
esac
