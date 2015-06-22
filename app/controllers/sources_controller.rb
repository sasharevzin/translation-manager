class SourcesController < ApplicationController
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

  def show
    @source = Source.find(params[:id])
  end

  private
  def source_params
    params.require(:source)
    .permit(:language, :text, :context,
       translations_attributes: [ :language, :text, :context ])
  end
end
