class ListsController < ApplicationController
  def index
    @lists = List.all.sort_by{|object| object.name.downcase}
    render :index
  end

  def show
    @list = List.find(params[:id])
    @doneTasks = @list.tasks.where(:done => true).sort_by{|object| object.description.downcase}
    @notDoneTasks = @list.tasks.where(:done => false).sort_by{|object| object.description.downcase}
    render :show
  end

  def new
    @list = List.new()
    render :new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to  lists_path
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
    render :edit
  end

  def update
    @list= List.find(params[:id])
    if @list.update(list_params)
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.tasks.each do |task|
      task.destroy
    end
    @list.destroy
    redirect_to lists_path
  end

  private
  def list_params
    params.require(:list).permit(:name, :description)
  end

end
