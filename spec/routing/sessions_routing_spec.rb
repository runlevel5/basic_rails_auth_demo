require 'spec_helper'

describe SessionsController do
  describe 'routing' do
    describe 'GET /login' do
      it 'routes to sessions#new' do
        expect(get('/login')).to route_to('sessions#new')
      end
    end

    describe 'POST /login' do
      it 'routes to sessions#create' do
        expect(post('/login')).to route_to('sessions#create')
      end
    end

    describe 'GET /logout' do
      it 'routes to sessions#destroy' do
        expect(get('/logout')).to route_to('sessions#destroy')
      end
    end
  end
end