class FollowUpListsController < ApplicationController
  before_action :authenticate_admin_employer!

  def edit
    @follow_up_list = FollowUpList.find(params[:id])
    @employer = @follow_up_list.employer
  end

  def update
    @follow_up_list = FollowUpList.find(params[:id])
    @employer = @follow_up_list.employer

    if @follow_up_list.update(follow_up_list_params)
      flash[:success] = "Follow-Up list successfully updated!"
      redirect_to employer_path(@employer)
    else
      flash[:warning] = "Unable to update your list."
      render :edit
    end
  end

  private

    def follow_up_list_params
      params.require(:follow_up_list).permit(:employer_id, :name)
    end
end
