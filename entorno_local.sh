#!/bin/bash
## Levantar el contenedor de dynamodb en la red de sam con el nombre de dynamodb
docker start dynamodb
docker ps

## Crear la tabla en local, para poder trabajar localmemte
aws dynamodb create-table --table-name local-TodosDynamoDbTable --attribute-definitions AttributeName=id,AttributeType=S --key-schema AttributeName=id,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 --endpoint-url http://localhost:8000

## Empaquetar sam
sam build

## Levantar la api en local, en el puerto 8080, dentro de la red de docker sam
sam local start-api --port 8081 --env-vars localEnvironment.json --docker-network sam &
