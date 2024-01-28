aws --profile localstack --endpoint-url=http://localhost:4566 dynamodb create-table \
    --table-name dynamo_db_table_test \
    --attribute-definitions \
        AttributeName=partition_key,AttributeType=S \
        AttributeName=sort_key,AttributeType=S \
    --key-schema \
        AttributeName=partition_key,KeyType=HASH \
        AttributeName=sort_key,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --global-secondary-indexes \
        "IndexName=MyGSI,KeySchema=[{AttributeName=sort_key,KeyType=HASH},{AttributeName=partition_key,KeyType=RANGE}],Projection={ProjectionType=ALL},ProvisionedThroughput={ReadCapacityUnits=1,WriteCapacityUnits=1}"


aws --profile localstack --endpoint-url=http://localhost:4566 dynamodb describe-table --table-name dynamo_db_table_test
