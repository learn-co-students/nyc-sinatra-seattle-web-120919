require "byebug"

class FiguresController < ApplicationController
  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post "/figures" do
    byebug
    title_info = params[:title]
    if !title_info[:name].empty?
      title = Title.create(name: title_info[:name][0])
    end
    landmark_info = params[:landmark]
    if !landmark_info[:name].empty?
      landmark = Landmark.create(name: landmark_info[:name][0], year_completed: landmark_info[:year_completed][0])
    end
    figure = Figure.create(figure[:name])
    figure.titles << title
    figure.landmarks << landmark
    redirect "/figures/#{figure.id}"
  end

  get "/figures" do
    @figures = Figure.all
    erb :'figures/index'
  end

  get "/figures/:id" do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/edit'
  end

  patch "/figures/:id" do
    Figure.update(params[:id], params[:figure])
    redirect "/figures/#{params[:id]}"
  end
end
