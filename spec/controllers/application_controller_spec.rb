require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      render text: 'Hello World'
    end
  end

  describe '#authenticate!' do
    context 'when user is not signed in' do
      before do
        session[:user_id] = nil
        get :index
      end

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_url)
      end
    end

    context 'when user is signed in' do
      let!(:user) { UserCreation.create(email: 'hello@example.com', password: '123', password_confirmation: '123') }

      before do
        session[:user_id] = user.id
        get :index
      end

      it 'does not redirect to login_url' do
        expect(response).not_to redirect_to(login_url)
      end
    end

  end
end