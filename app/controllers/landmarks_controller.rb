class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @landmarks = Landmark.all

    erb :"landmarks/index"
  end

  get '/landmarks/new' do
    @figures = Figure.all
    @titles = Title.all
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    landmark = Landmark.create(params[:landmark])


    if !params[:figure][:name].empty?
      figure = Figure.create(params[:figure])
      landmark.figure = figure
      landmark.save
    end
    # if !params[:title][:name].empty?
    #   figure.titles << Title.create(params[:title])
    #   figure.save
    # end
    redirect "/landmarks/#{landmark.id}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    erb :"landmarks/edit"
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find(params[:id])
    landmark.update(params[:landmark])
    if !params[:figure][:name].empty?
      figure = Figure.create(params[:figure])
      landmark.figure = figure
      landmark.save
    end
    redirect "/landmarks/#{landmark.id}"
  end

end
