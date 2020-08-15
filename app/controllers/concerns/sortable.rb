module Sortable
  extend ActiveSupport::Concern

  private

  def model_klass
    controller_name.classify.constantize
  end

  def sort_column
    return custom_sort_column if self.class.private_method_defined?(:custom_sort_columns)
    model_klass.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def default_sort_column
    custom_sort_columns[:default] || 'id'
  end

  def column_name
    params[:sort].try(:to_sym)
  end

  def custom_sort_column
    custom_sort_columns.key?(column_name) ? custom_sort_columns[column_name] : default_sort_column
  end

  def sort_direction
    params[:direction] == 'asc' ? 'ASC' : 'DESC'
  end

  def sort
    Arel.sql("#{sort_column}\s#{sort_direction}")
  end
end
