# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SJCCHoops.Repo.insert!(%SJCCHoops.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SJCCHoops.{Repo, Player}

Repo.insert!(%Player{name: "Dave Corwin", email: "davemcorwin@gmail.com", active: true})
Repo.insert!(%Player{name: "Mike Willner", email: "m.willner@comcast.net"})
Repo.insert!(%Player{name: "Eugene Slutsky", email: "eugeneslutsky@yahoo.com"})
