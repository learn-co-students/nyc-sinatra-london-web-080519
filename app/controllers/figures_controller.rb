require "pry"
class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.update(params[:id], params[:figure])

    if !params["title"]["name"].empty?
      figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty?
      figure.landmarks << Landmark.create(params[:landmark])
    end

    redirect "/figures/#{figure.id}"
  end

end
