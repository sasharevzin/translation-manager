# Sources controller to take care of CRUD operations
class SourcesController < ApplicationController
  before_action :populate_source, only: [:edit, :show, :update, :destroy]

  def index
    @sources = Source.includes(:translations)
               .paginate(page: params[:page], per_page: params[:per_page])
  end

  def new
    @source = Source.new
    @translations = @source.translations.build
  end

  def create
    @source = Source.new(source_params)
    if @source.save
      redirect_to @source, notice: 'Source and translations are saved successfully'
    else
      render action: 'new'
    end
  end

  def update
    if @source.update_attributes(source_params)
      redirect_to @source, notice: 'Source and translations are updated successfully'
    else
      render action: 'edit'
    end
  end

  def destroy
    @source.destroy
    redirect_to sources_url, notice: 'Source and translations destroyed successfully'
  end

  private

  def populate_source
    @source = Source.find(params[:id])
  end

  def source_params
    params.require(:source)
      .permit(:language, :text, :context,
              translations_attributes: [:language, :text, :context, :id, :source_id])
  end
end
