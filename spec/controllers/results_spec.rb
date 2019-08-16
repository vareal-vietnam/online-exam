require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:test) { create :test }
  let(:result) { create :result, test: test }

  describe '#show' do
    context 'Logged in with user' do
      context 'Can find result' do
        before do
          session[:user_id] = user.id
          get :show, params: { test_id: test.id, id: result.id }
        end

        it { is_expected.to render_template 'show' }
      end

      context 'Can not find result' do
        before do
          session[:user_id] = user.id
          get :show, params: { test_id: test.id, id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Not login' do
      before { get :show, params: { test_id: test.id, id: result.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#update' do
    let(:params) { attributes_for :result }

    context 'Logged in with user' do
      before { session[:user_id] = user.id }

      context 'Can find result' do
        context 'Can find test' do
          before do
            post :update, params: { id: result.id,
                                    test_id: test.id,
                                    result: params }
          end

          it { is_expected.to set_flash }
          it do
            is_expected.to redirect_to test_result_path(test, assigns(:result))
          end
        end

        context 'Can not find test' do
          before do
            post :update, params: { id: result.id, test_id: -1, result: params }
          end

          it { is_expected.to set_flash }
          it { is_expected.to redirect_to root_path }
        end
      end

      context 'Can not find result' do
        before do
          post :update, params: { id: -1, test_id: test.id, result: params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Not login' do
      before do
        post :update, params: { id: result.id,
                                test_id: test.id,
                                result: params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#index' do
    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }

      context 'Can find test' do
        before { get :index, params: { test_id: test.id } }

        it { is_expected.to render_template 'index' }
      end

      context 'Can not find test' do
        before { get :index, params: { test_id: -1 } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged in with user' do
      before do
        session[:user_id] = user.id
        get :index, params: { test_id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :index, params: { test_id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#destroy' do
    context 'Logged in with admin' do
      before { session[:user_id] = admin.id }

      context 'Can find result' do
        context 'Can find test' do
          before do
            delete :destroy, params: { id: result.id, test_id: test.id }
          end

          it { is_expected.to set_flash }
          it { is_expected.to redirect_to test_results_path test }
        end

        context 'Can not find test' do
          before { delete :destroy, params: { id: result.id, test_id: -1 } }

          it { is_expected.to set_flash }
          it { is_expected.to redirect_to root_path }
        end
      end

      context 'Can not find result' do
        before { delete :destroy, params: { id: -1, test_id: -1 } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged in with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: result, test_id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { delete :destroy, params: { id: result, test_id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
