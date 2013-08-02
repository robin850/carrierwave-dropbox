feature "Upload a file to Dropbox" do

  scenario "Uploading a simple file then edit it" do
    Article.delete_all
    Article.count.should eq(0)

    visit "/articles/new"

    within("form") do
      fill_in "Title", with: "Hello world!"
      fill_in "Body", with: "Foo bar baz"
      attach_file "Image", File.expand_path('spec/fixtures/ruby.png')

      find("input[type='submit']").click
    end

    page.should have_content("Article was successfully created")
    Article.count.should eq(1)

    article = Article.last

    image_path = article.image.url
    thumb_path = article.image.url(:thumbnail)

    visit image_path
    image_path.should match(/foo/)
    page.should have_css("img[src='#{image_path}']")

    visit thumb_path
    thumb_path.should match(/foo/)
    page.should have_css("img[src='#{thumb_path}']")

    visit "/articles/#{article.id}/edit"

    within("form") do
      attach_file "Image", File.expand_path('spec/fixtures/rails.png')
      find("input[type='submit']").click
    end

    page.should have_content("Article was successfully updated")
    new_image_path = Article.last.image.url

    visit new_image_path
    page.should have_css("img[src='#{new_image_path}']")
  end
end
