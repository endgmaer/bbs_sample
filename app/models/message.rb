class Message < ActiveRecord::Base
  validates :name,
            presence: :true,
            length: { maximum: 20 }

  validates :password,
            presence: :true,
            length: { minimum: 6 }

  validates :body,
            presence: :true,
            length: { maximum: 250 }

  def check_destroy_password(destory_password)
    return true if destory_password == self.password
    errors.add :password, 'がちがいます。'
    return false
  end
end
