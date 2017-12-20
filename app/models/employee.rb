class Employee < ApplicationRecord
  VALID_GENDER = %w(male female)

  scope :by_gender, ->(gender) do
    if VALID_GENDER.include?(gender)
      Rails.cache.fetch("employees_#{gender}") { where(gender: gender).order(updated_at: :desc) }
    else
      Rails.cache.fetch('all_employees') { all.order(updated_at: :desc) }
    end
  end

  after_commit :flush_cache!

  def final_salary
    Rails.cache.fetch("#{cache_key}/tax") { puts 'calculating tax...' ; salary - salary * 0.13 }
  end

  private

  def flush_cache!
    puts 'flushing the cache...'
    Rails.cache.delete 'all_employees'
    Rails.cache.delete "employees_#{gender}"
  end
end
