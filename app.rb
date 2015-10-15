require 'sinatra/base'

require './db/setup'
require './lib/all'

class App < Sinatra::Base
  def current_user
    auth_header = request.env["HTTP_AUTHORIZATION"]
    if auth_header
      user_id, given_password = auth_header.split(":", 2)

      user = User.find user_id
      if user.password == given_password
        return user
      else
        halt 401, "Passwords didn't match"
      end
    else
      halt 401, "You must authenticate"
    end
  end

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

  post "/teams/:id" do
    t = Team.find params[:id]
    # or t.memberships.create! user: current_user
    current_user.memberships.create! team: t

    status 200
  end
end

App.run!
