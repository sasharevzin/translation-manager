# Sources controller to take care of CRUD operations
class SourcesController < ApplicationController
  before_action :populate_source, only: [:edit, :show, :update, :destroy]
  after_action :allow_iframe
  skip_before_action :verify_authenticity_token, :update_by_text_and_lang

  def index
    @sources = Source.paginate(page: params[:page], per_page: params[:per_page])
  end

  def search
    if params[:text].blank? && params[:language].blank?
      redirect_to sources_path
      return
    end

    @sources = Source.search(params)
  end

  def new
    # We set attributes here because sources can be created from a search with 0 results.
    @source = Source.new(source_params)
    @source.translations.build
  end

  def create
    @source = Source.new(source_params)
    if @source.save
      redirect_to @source, notice: 'Source and translations created'
    else
      save_failed!
      render action: 'new'
    end
  end

  def update
    if @source.update_attributes(source_params)
      redirect_to @source, notice: 'Source and translations updated'
    else
      save_failed!
      render action: 'edit'
    end
  end

  def update_by_text_and_lang
    @source = Source.where(text: params[:original], language: source_params[:language]).first
    if @source
      if @source.update_attributes(source_params)
	redirect_to @source, notice: 'Source text updated successfully'
      else
	render action: 'error', status: 422, locals: {message: "Unable to update source text."}
      end
    else
      render action: 'error', status: 404, locals: {message: "No translations found for source: <#{params[:original]}>"}
    end
  end

  def destroy
    @source.destroy
    redirect_to sources_url, notice: 'Source and translations deleted'
  end

  private

  def save_failed!
    flash.now[:error] = 'Save Failed! Correct the errors below and try again.'
  end

  def populate_source
    @source = Source.includes(:translations).find(params[:id])
  end

  def source_params
    params.require(:source)
      .permit(:language, :text, :context, :original,
	      translations_attributes: [:language, :text, :context, :id, :source_id])
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end
end
