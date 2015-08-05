module SourceHelper
  def current_search_query(params)
    q = []
    q << sprintf('language "%s"', params[:language]) unless params[:language].blank?
    q << sprintf('text "%s"', truncate(params[:text], length: 75)) unless params[:text].blank?
    q.to_sentence.html_safe
  end
end
