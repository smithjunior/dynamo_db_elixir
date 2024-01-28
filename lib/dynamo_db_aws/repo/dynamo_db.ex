defmodule DynamoDbAws.Repo.DynamoDB do
  import ExAws.Dynamo

  @table_name "dynamo_db_table_test"

  def create_table do
    secondary_index = [
      %{
        index_name: "MyGSI",
        key_schema: [
          %{
            attribute_name: "sort_key",
            key_type: "HASH"
          }
        ],
        provisioned_throughput: %{
          read_capacity_units: 1,
          write_capacity_units: 1
        },
        projection: %{
          projection_type: "KEYS_ONLY"
        }
      }
    ]

    ExAws.Dynamo.create_table(
      @table_name,
      [partition_key: :hash, sort_key: :range],
      %{partition_key: :string, sort_key: :string},
      1,
      1,
      secondary_index,
      []
    )
  end

  def query do
    ExAws.Dynamo.query(@table_name,
      limit: 10,
      expression_attribute_values: [partition_key_val: "USER#12346"],
      key_condition_expression: "partition_key = :partition_key_val"
    )
    |> ExAws.request()
  end

  def query_gsi do
    ExAws.Dynamo.query(@table_name,
      limit: 10,
      index_name: "MyGSI",
      expression_attribute_values: [sort_key_val: "USER#12347"],
      key_condition_expression: "sort_key = :sort_key_val"
    )
    |> ExAws.request()
  end

  def put_item do
    item = %{
      partition_key: "USER#12346",
      sort_key: "USER#12347"
    }

    ExAws.Dynamo.put_item(@table_name, item)
    |> ExAws.request()
  end

  def describe_table do
    ExAws.Dynamo.describe_table(@table_name)
    |> ExAws.request()
  end

  def list_tables do
    ExAws.Dynamo.list_tables()
    |> ExAws.request()
  end

  def scan do
    ExAws.Dynamo.scan(@table_name)
    |> ExAws.request()
  end
end
