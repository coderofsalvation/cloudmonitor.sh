#!/bin/sh
test -z $1 || urls="$1"
test -f $1 && urls="$(cat "$1")"

echo "URL                             ONLINE SSL TIME"
echo "-                               -      -   -"
echo "$urls" | while read url; do 
  printf "%s" "$url" | sed 's|.*://||g'
  curl -v -w 'Total: %{time_total}s\n' ${url} 2>&1 | \
  awk '
    BEGIN{
      err="\033[5m\033[36;5;94m❌\033[0m"
      ok="\033[1;36m♥\033[0m"
      c["SSL"]=err
      c["ONL"]=ok
      c["TIM"]="?"  
    }
    /SSL certificate verify ok/ {c["SSL"]=ok  } 
    /Could not resolve host:/   {c["ONL"]=err }
    /^Total: /                  {c["TIM"]=$2  }
    END { printf "\r\t\t\t\t"c["ONL"]"      "c["SSL"]"   "c["TIM"]"\n" }
  '
done
