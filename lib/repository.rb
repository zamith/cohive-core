class Repository
  def self.register(type, repo)
    repositories[type] = repo
  end

  def self.for(type)
    repositories[type] || raise("There is no repository for #{type}")
  end

  def self.repositories
    @_repos ||= {}
  end
end
