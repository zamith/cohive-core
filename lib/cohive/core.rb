require "cohive/core/version"

autoload :Repository, "repository"

module Coworkers
  autoload :Company, "cohive/core/coworkers/entities/company"
  autoload :Member, "cohive/core/coworkers/entities/member"

  autoload :CoworkerAdder, "cohive/core/coworkers/interactors/coworker_adder"

  autoload :CoworkerParams, "cohive/core/coworkers/helpers/coworker_params"
end

module Serializers
  autoload :Pipeline, "serializers/pipeline"
end

module Cohive
  module Core
    class Config
      def self.configure
        @repository_config = RepositoryConfig.new
        yield self
        post_config
      end

      def self.repository=(repo_type)
        @repository_config.default_repo_type = repo_type
      end

      def self.repository
        @repository_config
      end

      def self.post_config
        @repository_config.load_repos
      end
    end

    class RepositoryConfig
      attr_writer :default_repo_type

      def initialize
        @default_repo_type = :memory
        @repositories = {companies: nil, members: nil}
        RepositoryConfig.define_repo_methods(@repositories)
      end

      def load_repos
        @repositories.each do |repo, repo_type|
          repo_type ||= @default_repo_type
          require "repositories/#{repo.to_s}/#{repo_type.to_s}"

          Repository.register repo.singularize.to_sym, Kernel.const_get("Repositories::#{repo.const_string}::#{repo_type.const_string}").new
        end
      end

      def self.define_repo_methods(repositories)
        repositories.keys.each do |repo|
          define_method "#{repo}=" do |repo_type|
            repositories[repo] = repo_type
          end
        end
      end
    end
  end
end

class Symbol
  def const_string
    self.to_s.split('_').map(&:capitalize).join
  end

  def singularize
    string_version = self.to_s
    if string_version.end_with?("ies")
      string_version.gsub(/ies$/, 'y')
    else
      string_version.chomp("s")
    end
  end
end
