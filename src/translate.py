import json
import decimalencoder
import todoList


def translate(event, context):
    # create a response
    item = todoList.get_item(event['pathParameters']['id'])
    print(json.dumps(event['pathParameters'], indent=4))
    traduccion = str(
        todoList.get_translate(
            item["text"], event['pathParameters']['idioma']
            )
        )
    item["text"] = traduccion
    print("Pintar Traduccion: \n\r")
    print(
        json.dumps(
            item["text"], cls=decimalencoder.DecimalEncoder, indent=4
            )
        )
    if item:
        response = {
            "statusCode": 200,
            "body": json.dumps(item,
                               cls=decimalencoder.DecimalEncoder)
        }
    else:
        response = {
            "statusCode": 404,
            "body": ""
        }
    return response
