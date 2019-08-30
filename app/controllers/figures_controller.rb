class FiguresController < ApplicationController
  # add controller methods
  
  # INDEX
  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  # NEW
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      figure.titles << Title.find_or_create_by(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    end
    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.update(params[:figure])
    if !params[:title][:name].empty?
      figure.titles << Title.find_or_create_by(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    end
    redirect "/figures/#{figure.id}"
  end


end
