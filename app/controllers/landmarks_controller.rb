class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @titles = Title.all
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    
    if !params["title"]["name"].empty?
      @landmark.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @titles = Title.all
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    landmark = Landmark.update(params[:id], params[:landmark])

    if !params["title"]["name"].empty?
      landmark.titles << Title.find_or_create_by(name: params["title"]["name"])
    end

    redirect "/landmarks/#{figure.id}"
  end

end
