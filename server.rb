require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'CSV'


get '/articles' do
  @articles = CSV.read('articles.csv')
  erb :articles
end

get '/articles/new' do
  erb :post
end


post '/articles/confirm' do
  @url_array = []
  @articles = CSV.read('articles.csv')
  for article in @articles
    @url_array << article[1]
  end
  @article_name = params[:article_name]
  @url = params[:article_url]
  @description = params[:article_description]
  if @article_name== "" || @url == "" || @description == ""
    erb :error
  elsif @url_array.include?(@url)
    erb :duplicate
  else
    File.open('articles.csv', 'a'){|file| file.puts "#{@article_name},#{@url},#{@description}"}
    binding.pry
    erb :confirm
  end
end

# get '/'
#
#   erb :article
# end
