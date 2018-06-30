require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'has title' do
    article = Article.new(title: 'my first title')

    expect(article.title).to eq 'my first title'
  end

  describe '.authored_by' do
    it 'returns only articles by john' do
      john = User.create! username: 'john', email: 'john@example.com', password: 'password'
      article = Article.create! user: john, title: 'first tile'
      Article.create! title: 'not by john'

      expect(Article.authored_by(john.username)).to eq [article]
    end
  end
end
