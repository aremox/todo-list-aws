#!/bin/bash
case $1 in
  local)
    echo "local"
    BASE_URL=http://127.0.0.1:8081
  ;;
  staging)
    echo "staging"
    BASE_URL=https://tz0tn4nqc9.execute-api.us-east-1.amazonaws.com/Prod
  ;;
  produccion)
    echo "produccion"
  ;;
  *)
    echo $1" No es un entorno valido"
    echo "local; staging; produccion;"
    exit 255
  ;;
esac

#CREATE
echo "CREATE"
curl -s -X POST $BASE_URL/todos --data '{ "text": "Learn Serverless" }' | json_pp
#List
echo "List"
curl -s $BASE_URL/todos | json_pp
id=$( curl -s $BASE_URL/todos | json_pp | grep -i id | tail -1 |cut -d \: -f 2 | cut -d \" -f 2 )
#Get 
echo "GET"
curl -s $BASE_URL/todos/$id | json_pp
#Update
echo "UPDATE"
curl -s -X PUT $BASE_URL/todos/$id --data '{ "text": "Learn Serverless", "checked": true }' | json_pp
#Delete
echo "DELETE "$id
curl -s -X DELETE $BASE_URL/todos/$id
#Borrar todo
echo "BORRAR TODOS"
for i in $( curl -s https://tz0tn4nqc9.execute-api.us-east-1.amazonaws.com/Prod/todos | json_pp | grep -i id |cut -d \: -f 2 | cut -d \" -f 2)
do 
echo $i
curl -s -X DELETE $BASE_URL/todos/$i
done
#Listar todos
echo "Listar BBDD"
curl -s $BASE_URL/todos | json_pp

