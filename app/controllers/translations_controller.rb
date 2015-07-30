class TranslationsController < ApplicationController
  def destroy
    # TODO: errors
    @translation = Translation.find(params[:id])
    @translation.destroy
  end
end
