class Task < ActiveRecord::Base
  belongs_to :list

  validates :description, :presence => true

  def self.done
    return Task.all.where(:done => true)
  end

  def self.notDone
    return Task.all.where(:done => false)
  end
end
