import json
import boto3
from botocore.exceptions import ClientError
def lambda_handler(event, context):
   
    bucketname=event['Records'][0]['s3']['bucket']['name']
    object_key=event['Records'][0]['s3']['object']['key']
    timestamp = event['Records'][0]['eventTime']
    event_name = event['Records'][0]['eventName']
    event_source = event['Records'][0]['eventSource']
    # This address must be verified with Amazon SES.
    SENDER = 'prometheusalertiti@gmail.com'
  
    # If your account is still in the sandbox, this address must be verified.
    RECIPIENT = 'prometheusalertiti@gmail.com'
    
    
    # the AWS Region you're using for Amazon SES.
    AWS_REGION = "eu-central-1"
    
    # The subject line for the email.
    SUBJECT = 'Alert'
    
    # The email body for recipients with non-HTML email clients.
    BODY_TEXT = (f"s3 bucket {bucketname}  has been updated at {timestamp} \r\n objectKey : {object_key} \r\n eventName : {event_name} \r\neventSource : {event_source}  ")
                
    # The HTML body of the email.
    BODY_HTML = f"""<html>
    <head></head>
    <body>
      <h1>S3 Update Notification</h1>
      <p> s3 bucket {bucketname}  has been updated at {timestamp} <br>
            objectKey : {object_key}<br>
            eventName : {event_name}<br>
            eventSource : {event_source} .</p>
    </body>
    </html>
                """            
    
    # The character encoding for the email.
    CHARSET = "UTF-8"
    # Create SES client (edited)
    ses = boto3.client('ses', region_name=AWS_REGION)
    try:
        #Provide the contents of the email.
        response = ses.send_email(
            Destination={
                'ToAddresses': [
                    RECIPIENT,
                ],
            },
            Message={
                'Body': {
                    'Html': {
                        'Charset': CHARSET,
                        'Data': BODY_HTML,
                    },
                    'Text': {
                        'Charset': CHARSET,
                        'Data': BODY_TEXT,
                    },
                },
                'Subject': {
                    'Charset': CHARSET,
                    'Data': SUBJECT,
                },
            },
            Source=SENDER
        )
    # Display an error if something goes wrong. 
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:"),
        print(response['MessageId'])
    
  
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }