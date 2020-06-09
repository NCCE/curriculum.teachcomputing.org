class Admin::YearGroupsController < ApplicationController
  def index
    @key_stage = KeyStage.find_by!(id: params[:key_stage_id])
    @year_groups = @key_stage.year_groups
  end

  def show
    puts params
    @key_stage = KeyStage.find_by!(id: params[:key_stage_id])
    @year_group = @key_stage.year_groups.find_by!(id: params[:id])
  end
end
