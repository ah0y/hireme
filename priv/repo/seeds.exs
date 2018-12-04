# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Storex.Repo.insert!(%Storex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Storex.Repo
alias Storex.Accounts

{:ok, user} = Accounts.create_user(%{
  full_name: "Test User", email: "test@user.tld", password: "123456"})

{:ok, user} = Accounts.mark_as_admin(user)


