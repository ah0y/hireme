defmodule Storex.Repo.Migrations.S3Url do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :s3_url, :string
    end


  end
end
