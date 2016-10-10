class StudentEmail < MailForm::Base
  attribute :name,  :validate => true
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,   :captcha => true
  attribute :employer_email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :student_id, :validate => true
  attribute :employer_id, :validate => true

  def headers
    {
      :subject => "DevHero: Student Message",
      :to => "#{employer_email}",
      :from => %("#{name}" <#{email}>)
    }
  end
end