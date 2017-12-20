class EmployeeObserver < ActiveRecord::Observer
  observe Employee

  def after_create(record)
    flush_cache!
  end

  def after_destroy(record)
    flush_cache!
  end

  private

  def flush_cache!
    puts 'flushing...'
    #EmployeesController.expire_page '/employees/info'
  end
end