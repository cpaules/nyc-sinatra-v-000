require 'pry'
class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    #binding.pry
    @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    @figure.titles << Title.find_or_create_by(params[:title])
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if params[:title][:name]
      @figure.titles << Title.find_or_create_by(:name => params[:title][:name])
    end
    if params[:landmark][:name]
      @figure.landmarks << Title.find_or_create_by(:name => params[:landmark][:name])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
