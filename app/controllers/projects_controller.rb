class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin_student!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:success] = "Project successfully created!"
      redirect_to student_path(@project.student)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @technologies = @project.technologies if @project.technologies.any?
  end

  def edit
    @project = Project.find(params[:id])

    unless admin_signed_in? || student_signed_in? && @project.student_id == current_student.id
      redirect_to students_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def update
    @project = Project.find(params[:id])

    if admin_signed_in? || student_signed_in? && @project.student_id == current_student.id
      if @project.update(project_params)
        flash[:success] = "Project successfully updated!"
        redirect_to project_path(@project)
      else 
        render :edit
      end
    else 
      redirect_to students_path
      flash[:warning] = "You do not have access to that page!"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.remove_project_image!
    @project.save

    if admin_signed_in? || student_signed_in? && @project.student_id == current_student.id
      if @project.destroy
        flash[:success] = "Project successfully deleted!"
        redirect_to student_path(@project.student)
      else 
        flash[:warning] = "Unable to delete project."
        redirect_to student_path(@project.student)
      end
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
        :screencast,
        :project_image,
        :remove_project_image,
        technology_ids: []
      )
    end
end
