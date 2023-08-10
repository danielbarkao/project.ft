import boto3

def lambda_handler(event, context):
    # Retrieve the desired action from the input
    action = event.get('status')

    if action == 'start':
        # Start the EC2 instance
        instance_id = 'your-instance-id'  # Replace with your EC2 instance ID
        ec2_client = boto3.client('ec2')
        response = ec2_client.start_instances(InstanceIds=[instance_id])
        print(f'Starting EC2 instance {instance_id}')
        print(response)
    elif action == 'stop':
        # Stop the EC2 instance
        instance_id = 'your-instance-id'  # Replace with your EC2 instance ID
        ec2_client = boto3.client('ec2')
        response = ec2_client.stop_instances(InstanceIds=[instance_id])
        print(f'Stopping EC2 instance {instance_id}')
        print(response)
    else:
        print('Invalid action specified')

