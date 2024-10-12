class KittensController < ApplicationController
  before_action :set_kitten, only: [:show, :edit, :update, :destroy]

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.xml { render xml: @kittens }
      format.json { render json: @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to kittens_path
    else
      flash[:danger] = "Could not create kitten"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render xml: @kitten }
      format.json { render json: @kitten }
    end
  end

  def edit
  end

  def update
    if @kitten.update(kitten_params)
      redirect_to kitten_path(@kitten), notice: "Kitten has been succesfully updated"
    else
      flash[:danger] = "Cannot update kitten"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @kitten.destroy
      flash[:success] = "Kitten has been deleted"
      redirect_to kittens_path
    else
      flash[:danger] = "Could not delete kitten "
      redirect_to kittens_path, status: :unprocessable_entity
    end
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end
end
