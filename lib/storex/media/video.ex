defmodule Storex.Media.Video do
  use Ecto.Schema
  use Rummage.Ecto
  import Ecto.Changeset
  alias Storex.Media.Video

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "videos" do
    field :content_type, :string
    field :filename, :string
    field :path, :string
    field :title, :string
    field :video_file, :any, virtual: true
    field :description, :string
    field :price, :decimal
    field :s3_url, :string

    timestamps()
  end

  def put_video_file(changeset) do
    case changeset do
    %Ecto.Changeset{valid?: true, changes: %{video_file: video_file}} ->
      path = Ecto.UUID.generate() <> Path.extname(video_file.filename)
      changeset
      |> put_change(:path, path)
      |> put_change(:filename, video_file.filename)
      |> put_change(:content_type, video_file.content_type)
    _ ->
      changeset
  end
 end
  @doc false
  def changeset(%Video{} = video, attrs) do
    video
    |> cast(attrs, [:title, :filename, :content_type, :path, :video_file, :description, :price, :s3_url])
    |> validate_required([:title, :video_file, :description, :price])
    |> put_video_file()
  end
end
