class RepositoriesController < ApplicationController
  
  def index
    @code = session[:token]

    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    @username = body['login']

    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    @repos = body.map do |r|
      r['name']
    end
  end

  def create
    name = params[:name]

    resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
      req.body = { 'name': name, 'private': true }.to_json
    end

    redirect_to root_path
  end
end