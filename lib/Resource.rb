#!/usr/bin/env ruby -w
# encoding: UTF-8
#
# = Resource.rb -- The TaskJuggler III Project Management Software
#
# Copyright (c) 2006, 2007, 2008, 2009, 2010 by Chris Schlaeger <cs@kde.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#


require 'PropertyTreeNode'
require 'ResourceScenario'

class TaskJuggler

  class Resource < PropertyTreeNode

    def initialize(project, id, name, parent)
      super(project.resources, id, name, parent)
      project.addResource(self)

      @data = Array.new(@project.scenarioCount, nil)
      @project.scenarioCount.times do |i|
        @data[i] = ResourceScenario.new(self, i, @scenarioAttributes[i])
      end
    end

    # Many Resource functions are scenario specific. These functions are
    # provided by the class ResourceScenario. In case we can't find a
    # function called for the Resource class we try to find it in
    # ResourceScenario.
    def method_missing(func, scenarioIdx, *args)
      @data[scenarioIdx].method(func).call(*args)
    end

  end

end

