class HomeController < ApplicationController
    def index
        if user_signed_in?
            gon.var_new = current_user.task_groups.find_or_create_by(name: current_user.default_task_group_name).tasks.order_by_time.pluck(:during_time)
        end
    end
end