require 'pry'
require 'repository'
require 'repositories/members/memory'
require 'repositories/companies/memory'
require 'repositories/spaces/memory'

Repository.register :company, Repositories::Companies::Memory.new
Repository.register :member, Repositories::Members::Memory.new
Repository.register :space, Repositories::Spaces::Memory.new
