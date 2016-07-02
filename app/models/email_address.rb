class EmailAddress

  def initialize(unparsed_email)
    @unparsed_email = unparsed_email
  end

  def parse_email
    /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}\b/i.match(@unparsed_email) 
  end

end