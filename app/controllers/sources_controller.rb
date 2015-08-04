# Sources controller to take care of CRUD operations
class SourcesController < ApplicationController
  before_action :populate_source, only: [:edit, :show, :update, :destroy]
  after_action :allow_iframe

  def index
    @sources = Source.where('text LIKE ?', "%#{params[:text]}%")
    @sources = @sources.where(language: params[:language]) if params[:language].present?
    @sources = @sources.paginate(page: params[:page], per_page: params[:per_page])
  end

  def new
    @source = Source.new
    @source.translations.build
  end

  def create
    @source = Source.new(source_params)
    if @source.save
      redirect_to @source, notice: 'Source and translations created'
    else
      render action: 'new'
    end
  end

  def update
    if @source.update_attributes(source_params)
      redirect_to @source, notice: 'Source and translations updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @source.destroy
    redirect_to sources_url, notice: 'Source and translations deleted'
  end

  private

  def populate_source
    @source = Source.includes(:translations).find(params[:id])
  end

  def source_params
    params.require(:source)
      .permit(:language, :text, :context,
              translations_attributes: [:language, :text, :context, :id, :source_id])
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end
end
