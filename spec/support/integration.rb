def fill_in_email(email)
  find("input[name*='email']").set(email)
end
