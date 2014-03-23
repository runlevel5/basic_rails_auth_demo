require 'spec_helper'

describe SessionsController do
  let!(:user) { UserCreation.create(email: 'hello@example.com', password: '123', password_confirmation: '123') }

  describe 'GET #destroy' do
    before do
      session[:user_id] = user.id
      get :destroy
    end

    it 'unsets session[:user_id]' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to login_url' do
      expect(response).to redirect_to(login_url)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'responds correctly' do
      expect(response.response_code).to eq 200
    end

    it 'renders template sessions/new' do
      expect(response).to render_template('sessions/new')
    end
  end

  describe 'POST #create' do
    context 'when successfully login' do
      before do
        @request.env['HTTP_REFERER'] = '/referrer'
        post :create, session: { email: 'hello@example.com', password: '123'}
      end

      it 'redirects to referrer' do
        expect(response).to redirect_to('/referrer')
      end

      it 'sets flash[:success]' do
        expect(flash[:success]).to eq('You are now signed in')
      end

      it 'sets session[:user_id]' do
        expect(session[:user_id]).to eq user.id
      end
    end

    context 'when unsuccessfully login' do
      before do
        post :create, session: { email: 'hello@example.com', password: 'abc'}
      end

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_url)
      end

      it 'sets flash[:error]' do
        expect(flash[:error]).to eq('There was a problem logging you in')
      end

      it 'does not set session[:user_id]' do
        expect(session[:user_id]).to be_nil
      end
    end
  end
end