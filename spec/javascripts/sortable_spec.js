describe("ProductPage", function() {
  it("sortable function should have item 'tr'", function() {
    loadFixtures("product_list_form.html");
    expect($(".product").sortable()).toContain('tr');
  });
})
