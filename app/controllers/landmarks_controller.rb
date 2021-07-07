class LandmarksController < ApplicationController
  # index
  get "/landmarks" do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  # new
  get "/landmarks/new" do
    erb :'/landmarks/new'
  end

  # show
  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  # create
  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    redirect :"/landmarks/#{@landmark.id}"
  end

  # edit
  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  # update
  patch "/landmarks/:id" do
    landmark = Landmark.find(params[:id])
    landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect :"/landmarks/#{landmark.id}"
  end
end
