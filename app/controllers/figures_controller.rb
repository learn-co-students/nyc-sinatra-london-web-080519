class FiguresController < ApplicationController
  # add controller methods
  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/new" do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"/figures/new"
  end

  post "/figures" do
    @figure = Figure.create(params[:figure])
    if params[:figure].keys.any?("title_ids")
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    if params[:figure].keys.any?("landmark_ids")
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect :"/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])
    if params[:landmark][:name] != ""
      @landmark = Landmark.create(params[:landmark])
      @landmark.update(figure_id: @figure.id)
    end
    @figure.update(params[:figure])
    redirect :"/figures/#{@figure.id}"
  end

end
