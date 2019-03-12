class RepositoriesController < ApplicationController

  def index
    'inside the repositories index'
    response = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = 'token ' + session[:token]
    end
    response_two = Faraday.get "https://api.github.com/user/repos" do |req|
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = 'token ' + session[:token]
    end
    body = JSON.parse(response.body)
    @login = body['login']
    @repos = JSON.parse(response_two.body)


        #save the array of repos in an instance variable
        #in the view, iterate over that array and display whatever the test wants you to display
  end

end
