class Folder < ApplicationRecord
  belongs_to :folder, optional: true
  has_many :children, class_name: 'Folder',
                      dependent: :destroy

  validates :name, uniqueness: true

  before_save :downcase_name

  def self.tree
    [root.to_hash]
  end

  def self.root
    Folder.find_by(name: 'root')
  end

  # {
  #   name: name,
  #   folders: []
  # }
  def to_hash
    {}.tap do |hash|
      hash[:name]    = name
      hash[:folders] = children.map(&:to_hash) if children.any?
      # children.map { |c| c.to_hash }
    end
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end


class Deal

  def tree
    folders.where(name: 'root')
  end

end
