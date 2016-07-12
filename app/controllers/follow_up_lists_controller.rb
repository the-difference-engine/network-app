class FollowUpListsController < ApplicationController
  before_action :authenticate_admin_employer!

  def edit
    @follow_up_list = FollowUpList.find(params[:id])
    @employer = FollowUpList.employer
  end

  def update
    @follow_up_list = FollowUpList.find(params[:id])
    @employer = @follow_up_list.employer

    if @follow_up_list.update
      flash[:success] = "Follow-Up list successfully updated!"
      redirect_to employer_path(@employer)
    else
      flash[:warning] = "Unable to update your list."
      render :edit
    end
  end
end
