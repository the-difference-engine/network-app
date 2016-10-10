class EmployerEmail < MailForm::Base
  attribute :name,  :validate => true
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,   :captcha => true
  attribute :student_email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :student_id, :validate => true
  attribute :employer_id, :validate => true

  def headers
    {
      :subject => "DevHero: Message from Employer",
      :to => "#{student_email}",
      :from => %("#{name}" <#{email}>)
    }
  end
end