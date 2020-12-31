class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    if @figure
      erb :'figures/show'
    else
      redirect '/'
    end
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    if @figure
      erb :'figures/edit'
    else
      redirect '/'
    end
  end

  post '/figures' do
    @figure = Figure.new(params[:figure])
    unless params[:new_title][:name].empty?
      @figure.titles << Title.create(params[:new_title])
    end
    unless params[:new_landmark].values.all?(&:empty?)
      @figure.landmarks << Landmark.create(params[:new_landmark])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    unless params[:new_title].empty?
      @figure.titles << Title.create(params[:new_title])
    end
    unless params[:new_landmark].empty?
      @figure.landmarks << Landmark.create(params[:new_landmark])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
end
