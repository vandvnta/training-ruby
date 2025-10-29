FROM ruby:3.2.3

# Cài đặt dependencies hệ thống cần thiết
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libmariadb-dev \
  libvips \
  libvips-dev \
  imagemagick \
  git \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy Gemfile và Gemfile.lock trước để tận dụng cache Docker
COPY Gemfile Gemfile.lock ./

# Cài Bundler và các gem
RUN gem install bundler -v 2.7.2 && bundle install

# Copy toàn bộ mã nguồn ứng dụng
COPY . .

# Mở port 4000 cho Rails
EXPOSE 4000

# Lệnh khởi động server (xóa PID cũ + chuẩn bị DB)
CMD bash -c "rm -f tmp/pids/server.pid && bundle exec rails db:prepare && bundle exec rails s -b 0.0.0.0 -p 4000"
