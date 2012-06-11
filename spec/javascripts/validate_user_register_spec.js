describe("UserRegister", function() {
  it("password field should be have error message", function() {
    loadFixtures("new_user_form.html");
    password_val("123");
    expect($(".error_mes_pass")).toHaveText("Password is too short (minimum is 6 characters)");
  });

  it("password field should not have error message", function() {
    loadFixtures("new_user_form.html");
    password_val("123123");
    expect($(".error_mes_pass")).toHaveText("");
  });

  it("password field should be have error message", function() {
    loadFixtures("new_user_form.html");
    IsValidEmail("example@mail.ru");
    expect($(".error_mes_email")).toHaveText("");
  });

  it("password field should not have error message", function() {
    loadFixtures("new_user_form.html");
    IsValidEmail("examplebla.ru");
    expect($(".error_mes_email")).toHaveText("Invalid email");
  });
});
