# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
  SELECT
    COUNT(*)
  FROM
    stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
  SELECT
    id
  FROM
    stops
  WHERE
    name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
  SELECT 
    stops.id, stops.name
  FROM
    stops
  WHERE
    stops.id IN (
      SELECT
        routes.stop_id
      FROM
        routes
      WHERE
        routes.company = 'LRT'
        AND routes.num = '4'
    )
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
  SELECT
    company,
    num,
    COUNT(num)
  FROM
    routes
  WHERE
    stop_id IN (149, 53)
  GROUP BY
    company,
    num
  HAVING
    COUNT(num) IN (2)
  ORDER BY
    company
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
  SELECT
    r1.company,
    r1.num,
    r1.stop_id,
    r2.stop_id
  FROM
    routes r1
  JOIN
    routes r2 ON (r1.company = r2.company AND r1.num = r2.num)
  WHERE
    r1.stop_id = 53
    AND r2.stop_id IN (
      SELECT
        id
      FROM
        stops
      WHERE
        name = 'London Road'
    )
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
  SELECT
    r1.company,
    r1.num,
    s1.name,
    s2.name
  FROM
    routes r1
  JOIN
    routes r2 ON (r1.company = r2.company AND r1.num = r2.num)
  JOIN
    stops s1 ON (r1.stop_id = s1.id)
  JOIN
    stops s2 ON (r2.stop_id = s2.id)
  WHERE
    s1.name = 'Craiglockhart'
    AND s2.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
  SELECT DISTINCT
    r1.company,
    r1.num
  FROM
    routes r1
  JOIN
    routes r2 ON (r1.company = r2.company AND r1.num = r2.num)
  WHERE
    r1.stop_id = 115 AND
    r2.stop_id = 137
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
  SELECT
    start_routes.company,
    start_routes.num
  FROM
    routes start_routes
  JOIN
    routes end_routes ON start_routes.company = end_routes.company
      AND start_routes.num = end_routes.num
  JOIN
    stops origin_stops ON origin_stops.id = start_routes.stop_id
  JOIN
    stops dest_stops ON dest_stops.id = end_routes.stop_id
  WHERE
    origin_stops.name = 'Craiglockhart'
      AND dest_stops.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
  SELECT
    end_stops.name,
    end_routes.company,
    end_routes.num
  FROM
    routes start_routes
  JOIN
    routes end_routes ON start_routes.num = end_routes.num
      AND start_routes.company = end_routes.company
  JOIN
    stops end_stops ON end_stops.id = end_routes.stop_id
  JOIN
    stops orig_stops ON orig_stops.id = start_routes.stop_id
  WHERE
    orig_stops.name = 'Craiglockhart'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
  SELECT DISTINCT
    start_routes.num,
    start_routes.company,
    trans.name,
    finish.num,
    finish.company
  FROM
    routes start_routes
  JOIN
    routes trans_routes ON start_routes.company = trans_routes.company
      AND start_routes.num = trans_routes.num
  JOIN
    stops trans ON trans_routes.stop_id = trans.id
  JOIN
    routes from_trans ON trans.id = from_trans.stop_id
  JOIN
    routes finish ON from_trans.company = finish.company
      AND from_trans.num = finish.num
  JOIN
    stops orig_stops ON start_routes.stop_id = orig_stops.id
  JOIN
    stops dest_stops ON finish.stop_id = dest_stops.id
  WHERE
    orig_stops.name = 'Craiglockhart'
      AND dest_stops.name = 'Sighthill'
  SQL
end

# Needed to follow solutions closely for the last two, might have taken hours
# otherwise, definitely need practice... ?