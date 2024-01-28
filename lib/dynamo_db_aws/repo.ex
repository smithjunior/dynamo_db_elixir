defmodule DynamoDbAws.Repo do
  use Ecto.Repo,
    otp_app: :dynamo_db_aws,
    adapter: Ecto.Adapters.Postgres
end
