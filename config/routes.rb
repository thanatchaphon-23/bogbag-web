Rails.application.routes.draw do
  # กำหนด root path ให้เป็นหน้าโพสต์
  root "posts#index"

  # ใช้ Devise สำหรับระบบ Authentication
  devise_for :users

  # เส้นทางสำหรับ Posts และ Likes
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resource :like, only: [:create, :destroy] # เส้นทางสำหรับ Like
    resources :comments, only: [:create, :destroy]
  end

  # กำหนด health check สำหรับการตรวจสอบสถานะ
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files (หากต้องการเปิดใช้ ให้เอาคำสั่ง comment ออก)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
