require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { Article.new(title: 'my first title') }
  it 'has title' do
    expect(article.title).to eq 'my first title'
  end
end
