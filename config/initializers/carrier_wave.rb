if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIAJE5HX3ZTK6NYEIFA'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['rails-tutorial071137']
  end
end