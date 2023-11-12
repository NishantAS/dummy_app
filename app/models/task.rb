class Task < ApplicationRecord
  belongs_to :task_group, primary_key: :name, foreign_key: :group_name
  scope :order_by_time, -> { order('UPPER("during_time")', 'LOWER("during_time")')}

  before_create do
    puts "new here"
  end

  def self.init(params)
    @new = self.new
    @new.title = params[:title]
    @new.description = params[:description]
    @start_time = nil
    @start_time = DateTime.parse(params[:from_time]) if params[:from_time].present?
    @end_time = nil
    @end_time = DateTime.parse(params[:to_time]) if params[:to_time].present?
    @new.during_time = @start_time..@end_time if @start_time.present? || @end_time.present?
    @new.group_name = params[:group_name]
    @new.private = params[:private]
    @new 
  end
end
