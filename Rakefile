require 'securerandom'
IMAGE_NAME = "ruby"

namespace :docker do
  def git_revision
    `git rev-parse --short HEAD`.strip
  end

  def git_branch
    git_branch   = `git rev-parse --abbrev-ref HEAD`.strip
  end

  def root_path
    File.expand_path "../", __FILE__
  end

  desc "Build docker image"
  task :build do |t, args|
    system "docker build --rm -t 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}' #{root_path}"
    system "docker tag -f 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}' 'quay.io/mikamai/#{IMAGE_NAME}:#{git_branch}'"
    system "docker tag -f 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}' 'quay.io/mikamai/#{IMAGE_NAME}:latest'"
  end

  desc "Push docker images"
  task :push do |t, args|
    system "docker push 'quay.io/mikamai/#{IMAGE_NAME}:latest'"
    system "docker push 'quay.io/mikamai/#{IMAGE_NAME}:#{git_branch}'"
    system "docker push 'quay.io/mikamai/#{IMAGE_NAME}:#{git_revision}'"
  end
end
