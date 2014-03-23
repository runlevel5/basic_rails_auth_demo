require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render text: "#{current_user.id}"
    end
  end

  describe '#current_user' do
    context 'when user is not signed in' do
      before do
        session[:user_id] = nil
        get :index
      end

      it 'returns nil' do
        expect(controller.current_user).to be_nil
      end
    end

    context 'when user is signed in' do
      let!(:user) { UserCreation.create(email: 'hello@example.com', password: '123', password_confirmation: '123') }

      before do
        session[:user_id] = user.id
        get :index
      end

      it 'returns signed-in user' do
        expect(controller.current_user).to eq user
      end
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