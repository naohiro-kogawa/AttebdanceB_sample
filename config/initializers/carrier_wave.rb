if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIAJI4OPPKLYOTDR37A'],
      :aws_secret_access_key => ENV['lnSThCU7mWXaB0LH1pXlY1z / UAX + bCgwr1pIDXlI']
    }
    config.fog_directory     =  ENV['rails-tutorial071137']
  end
end