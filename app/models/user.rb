class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_many :pages

  after_create :add_to_mailchimp

  def name
    "#{first_name} #{last_name}"
  end

  private

  def add_to_mailchimp
    begin
      Gibbon::Request.lists('a55ae640a2').members.create(body: { email_address: email, status: 'subscribed' }) if Rails.env.production?
    rescue => e
      puts 'failed to subscribe to mailchimp'
    end
  end
end
