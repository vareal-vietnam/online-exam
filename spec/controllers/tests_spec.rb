require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:test) { create :test }

  describe '#index' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :index
      end

      it { is_expected.to render_template 'tests/admin/index' }
    end

    context 'Logged with user or not login' do
      before { get :index }

      it { is_expected.to render_template 'index' }
    end
  end

  describe '#show' do
    context 'Logged in with admin' do
      context 'Can find test' do
        before do
          session[:user_id] = admin.id
          get :show, params: { id: test.id }
        end

        it { is_expected.to render_template 'tests/admin/show' }
      end

      context 'Can not find test' do
        before do
          session[:user_id] = admin.id
          get :show, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      context 'Can find test' do
        before do
          session[:user_id] = user.id
          get :show, params: { id: test.id }
        end

        it { is_expected.to render_template 'show' }
      end

      context 'Can not find test' do
        before do
          session[:user_id] = user.id
          get :show, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Not login' do
      before { get :show, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#new' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :new
      end

      it { is_expected.to render_template 'new' }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :new
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :new }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#create' do
    let(:test_params) { attributes_for :test }
    subject { put :create, params: { test: test_params } }

    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }

      context 'Can save' do
        it { expect{ subject }.to change{ Test.count }.by(1) }
        it { expect( subject.request.flash[:success] ).to_not be_nil }
        it { is_expected.to redirect_to root_path }
      end

      context 'Can not save' do
        let(:test_params) { attributes_for :test, name: '' }

        it { is_expected.to render_template 'new' }
      end
    end

    context 'Logged with user' do
      before { session[:user_id] = user.id }

      it { expect( subject.request.flash[:danger] ).to_not be_nil }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      it { expect( subject.request.flash[:danger] ).to_not be_nil }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#edit' do
    context 'Logged in with admin' do
      context 'Can find test' do
        before do
          session[:user_id] = admin.id
          get :edit, params: { id: test.id }
        end

        it { is_expected.to render_template 'edit' }
        it do
          is_expected.to render_template(partial: '_form',
                                         locals: { test: test })
        end
      end

      context 'Can not find test' do
        before do
          session[:user_id] = admin.id
          get :edit, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :edit, params: { id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :edit, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#update' do
    let(:test_params) { attributes_for :test, name: 'Test' }

    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }

      context 'Can find test' do
        context 'Can save' do
          let!(:test_update) do
            put :update, params: { id: test.id, test: test_params }
          end

          it do
            expect{ test.reload }.to change{ test.name }.
              from(test.name).to('Test')
          end
          it { is_expected.to set_flash }
          it { is_expected.to redirect_to root_path }
        end

        context 'Can not save' do
          let(:test_params) { attributes_for :test, name: '' }
          before do
            put :update, params: { id: test.id, test: test_params }
          end

          it { is_expected.to render_template 'edit' }
          it do
            is_expected.to render_template(partial: '_form',
                                           locals: { test: test })
          end
          it do
            is_expected.to render_template(partial: 'shared/error_messages',
                                           locals: { object: test })
          end
        end
      end

      context 'Can not find test' do
        before { put :update, params: { id: -1, test: test_params } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        put :update, params: { id: test.id, test: test_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { put :update, params: { id: test.id, test: test_params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#destroy' do
    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }
      context 'Can find test' do
        before { delete :destroy, params: { id: test.id } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end

      context 'Can not find test' do
        before { delete :destroy, params: { id: -1 } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { delete :destroy, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
