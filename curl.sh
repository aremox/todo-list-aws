#!/bin/bash
case $1 in
  local)
    echo "local"
    BASE_URL=http://127.0.0.1:8081
  ;;
  manual)
    echo "manual"
    BASE_URL=https://zvl23y0n15.execute-api.us-east-1.amazonaws.com/Prod
  ;;
  staging)
    echo "staging"
    BASE_URL=https://wc9tncfekk.execute-api.us-east-1.amazonaws.com/Prod
  ;;
  produccion)
    echo "produccion"
  ;;
  *)
    echo $1" No es un entorno valido"
    echo "local; manual; staging; produccion;"
    exit 255
  ;;
esac

#CREATE
echo "CREATE"
curl -s -X POST $BASE_URL/todos --data '{ "text": "Hacer apartado C" }' | json_pp
#List
echo "List"
curl -s $BASE_URL/todos | json_pp
id=$( curl -s $BASE_URL/todos | json_pp | grep -i id | tail -1 |cut -d \: -f 2 | cut -d \" -f 2 )
#Get 
echo "GET"
curl -s $BASE_URL/todos/$id | json_pp
#Translate EN
echo "TRANSLATE EN"
curl -s $BASE_URL/todos/$id/en | json_pp
#Translate FR
echo "TRANSLATE FR"
curl -s $BASE_URL/todos/$id/fr | json_pp
#Update
echo "UPDATE"
curl -s -X PUT $BASE_URL/todos/$id --data '{ "text": "Hacer apartado C", "checked": true }' | json_pp
#Delete
echo "DELETE "$id
curl -s -X DELETE $BASE_URL/todos/$id
#Borrar todo
echo "BORRAR TODOS"
for i in $( curl -s $BASE_URL/todos | json_pp | grep -i id |cut -d \: -f 2 | cut -d \" -f 2)
do 
echo $i
curl -s -X DELETE $BASE_URL/todos/$i
done
#Listar todos
echo "Listar BBDD"
curl -s $BASE_URL/todos | json_pp

