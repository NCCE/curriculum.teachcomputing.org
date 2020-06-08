class Admin::KeyStagesController < ApplicationController
  def index
    @key_stages = KeyStage.all
  end

  def show
    @key_stage = KeyStage.find_by!(id: params[:id])
  end
end
