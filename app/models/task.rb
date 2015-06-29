class Task < ActiveRecord::Base
  belongs_to :list

  validates :description, :presence => true

  def self.done
    return Task.all.where(:done => true).sort_by{|object| object.description.downcase}
  end

  def self.notDone
    return Task.all.where(:done => false).sort_by{|object| object.description.downcase} 
  end
end
