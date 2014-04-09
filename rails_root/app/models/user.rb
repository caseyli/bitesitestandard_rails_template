class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles


  def add_role(role)
    roles << role
  end


  def add_role_by_name(role_name)
    add_role(Role.find_by(name: role_name))
  end


  def remove_role(role)
    roles.delete(role)
  end


  def remove_role_by_name(role_name)
    remove_role(Role.find_by(name: role_name))
  end


  def is_role?(role)
    roles.to_a.include?(role)
  end


  def is_role_by_name?(role_name)
    is_role?(Role.find_by(name: role_name))
  end


  def is_admin?
    is_role_by_name?(:admin)
  end
end
