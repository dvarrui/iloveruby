
class TagController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tag_params)
      # Handle a successful update.
      flash[:success] = "Tag #{@tag.name} created!"
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tag #{@tag.name} created!"
      redirect_to @tag
    else
      render 'new'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to '/tag'
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
