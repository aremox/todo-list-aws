import json
import decimalencoder
import todoList

def translate(event, context):
    # create a response
    item = todoList.get_item(event['pathParameters']['id'])
    #traduccion = todoList.get_translate("Hola Mundo", "en")
    #print(str(traduccion))
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