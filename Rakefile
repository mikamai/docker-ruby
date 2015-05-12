require 'securerandom'
IMAGE_NAME = "ruby"

namespace :docker do
  def git_revision
    `git rev-parse --short HEAD`.strip
  end

  desc "Build docker image"
  task :build do |t, args|
    root_path = File.expand_path "../", __FILE__

    dockerfile = File.join root_path, "Dockerfile"
    system "docker build --rm -t 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}' #{root_path}"
    system "docker tag -f 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}' 'quay.io/mikamai/#{IMAGE_NAME}:latest'"
  end

  desc "Push docker images"
  task :push do |t, args|
    root_path = File.expand_path "../", __FILE__
    system "docker push 'quay.io/mikamai/#{IMAGE_NAME}:latest'"
    system "docker push 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}'"
  end
end
