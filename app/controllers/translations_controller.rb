# Sources controller to take care of CRUD operations
class TranslationsController < ApplicationController
  before_action :populate_source, only: [:destroy]

  def destroy
    @translation.destroy
    # TODO - Add a redirect URL here or remove it completely.
    #redirect_to sources_url, notice: 'Source and translations destroyed successfully'
  end

  private

  def populate_source
    @translation = Translation.find(params[:id])
  end

  # TODO We can probably remove this.
  def source_params
    params.require(:source)
      .permit(:language, :text, :context,
              translations_attributes: [:language, :text, :context, :id, :source_id])
  end
end
