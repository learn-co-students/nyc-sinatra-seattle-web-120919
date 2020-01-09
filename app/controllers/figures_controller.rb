class FiguresController < ApplicationController
  # index
  get "/figures" do
    @figures = Figure.all
    erb :'/figures/index'
  end

  # new
  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  # show
  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  #create
  post "/figures" do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty? && !params["landmark"]["year_completed"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    end

    redirect "/figures/#{@figure.id}"
  end

  # edit
  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :"/figures/edit"
  end

  # update
  patch "/figures/:id" do
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end
    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end

    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    if !params["landmark"]["name"].empty? && !params["landmark"]["year_completed"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    end

    redirect "/figures/#{@figure.id}"
  end
end
