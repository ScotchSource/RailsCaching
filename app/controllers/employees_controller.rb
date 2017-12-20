class EmployeesController < ApplicationController
  before_action :stupid_authentication!, only: [:index]

  #caches_action :index
  #caches_page :info

  def index
    @employees = Employee.by_gender params[:gender]
    #binding.pry
    puts @employees.first.updated_at

    fresh_when etag: @employees, last_modified: @employees.first.updated_at
  end

  def info
    @employees = Employee.all
  end

  private

  def stupid_authentication!
    redirect_to '/404' and return unless params[:admin].present?
  end
end