require 'sinatra/base'

require './db/setup'
require './lib/all'

class App < Sinatra::Base
  get "/teams/:id" do
    team_id = params[:id]
    t = Team.find team_id

    # user_hashes = []
    # t.users.each do |u|
    #   user_hashes.push({ name: u.name, email: u.email })
    # end
    user_hashes = t.users.map do |u|
      { name: u.name, email: u.email }
    end

    {
      name: t.name,
      users: user_hashes
      #[
        # { name: "Fake", email: "fake@example.com" }
      #]
    }.to_json
  end
end

App.run!
