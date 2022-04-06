require 'pg'

feature 'signup page' do
  it 'visits the signup page without being redirected' do
    visit '/signup'
    expect(current_path).to eq '/signup'
  end

  it 'has username field' do
    visit '/signup'
    expect(page).to have_field 'email'
  end

  it 'has password field' do
    visit '/signup'
    expect(page).to have_field 'password'
  end

  it 'has submit button' do
    visit '/signup'
    expect(page).to have_button 'submit'
  end

  it 'user inputs email and password and it is stored on database' do
    visit '/signup'
    fill_in 'email', with: "leigh@hotmail.com"
    fill_in "password", with: "pa55word"
    click_button 'submit'
    connection = PG.connect(dbname: "makersbnb_test")
    result = connection.exec(
      "SELECT * FROM users;"
    )
    result.map { |i| {"id" => i['id'], "email" => i['email'], "password" => i['password']} }
    expect(result[0]["email"]).to eq "leigh@hotmail.com"
    expect(result[0]["password"]).to eq "pa55word"
  end
end