describe("UserRegister", function() {
  it("password field should be error message", function() {
    loadFixtures("new_user_form.html");
    password_val("123");
    expect($(".error_mes_pass")).toHaveText("Password is too short (minimum is 6 characters)");
    password_val("123123");
    expect($(".error_mes_pass")).toHaveText("");
  });
});
