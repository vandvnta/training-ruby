FROM ruby:3.2.3

# Cài đặt dependencies cần thiết cho Rails + MySQL
RUN apt-get update -qq && apt-get install -y build-essential libmariadb-dev nodejs

# Tạo thư mục app
WORKDIR /app

# Copy Gemfile và Gemfile.lock để cài gem trước
COPY Gemfile Gemfile.lock ./

# Cài Bundler và gems
RUN gem install bundler && bundle install

# Copy toàn bộ mã nguồn
COPY . .

# Mở port cho Rails (container thực sự chạy port 4000)
EXPOSE 4000

# Lệnh chạy server (port 4000)
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "4000"]
