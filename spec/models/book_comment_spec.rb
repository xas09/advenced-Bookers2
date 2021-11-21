require 'rails_helper'

RSpec.describe 'BookCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:book) { build(:book, user_id: user.id) }
    # let!とすると、毎回データを作成してくれる
    let!(:book_comment) { build(:book_comment, book_id: book.id, user_id: user.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        book_comment.comment = ''
        expect(book_comment.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(BookComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Bookモデルとの関係' do
        it 'N:1となっている' do
          expect(BookComment.reflect_on_association(:book).macro).to eq :belongs_to
        end
      end
  end
end