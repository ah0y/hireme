defmodule Storex.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :filename, :string
      add :content_type, :string
      add :path, :string
      add :description, :text
      add :price, :decimal

      timestamps()
    end

  end
end
