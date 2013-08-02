feature "Upload a file to Dropbox" do
  before(:each) do
    Article.delete_all
  end

  scenario "Uploading a simple file" do
    visit "/articles/new"
    Article.count.should eq(0)

    within("form") do
      fill_in "Title", with: "Hello world!"
      fill_in "Body", with: "Foo bar baz"
      attach_file "Image", File.expand_path('spec/fixtures/ruby.png')

      find("input[type='submit']").click
    end

    page.should have_content("Article was successfully created")
    Article.count.should eq(1)

    image_path = Article.last.image.url
    thumb_path = Article.last.image.url(:thumbnail)

    visit image_path
    image_path.should match(/foo/)
    page.should have_css("img")

    visit thumb_path
    thumb_path.should match(/foo/)
    page.should have_css("img")
  end
end
