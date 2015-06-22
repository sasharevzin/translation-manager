class SourcesController < ApplicationController
  def index
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

  private
  def source_params
    params.require(:source)
    .permit(:language, :text, :context,
       translations_attributes: [ :language, :text, :context ])
  end
end
