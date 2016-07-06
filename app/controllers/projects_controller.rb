class ProjectsController < ApplicationController
  before_action :authenticate_admin_student!

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:message] = "Project successfully created!"
      redirect to student_path(@project.student)
    else
      flash[:message] = "Unable to create project."
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      flash[:message] = "Project successfully updated!"
      redirect to student_path(@project.student)
    else 
      flash[:message] = "Unable to update project!"
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])

    if @project.destroy
      flash[:message] = "Project successfully deleted!"
      redirect to student_path(@project.student)
    else 
      flash[:message] = "Unable to delete project."
      redirect to student_path(@project.student)
    end
  end

  private
    def project_params
      params.require(:project).permit(
        :student_id,
        :name,
        :description,
        :capstone,
        :client_work,
        :github,
        :website,
        :screencast
      )
    end
end
