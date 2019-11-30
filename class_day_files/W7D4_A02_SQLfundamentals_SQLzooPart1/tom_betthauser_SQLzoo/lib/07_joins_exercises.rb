# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  SELECT
    m.title
  FROM
    movies m
  JOIN
    castings c ON m.id = c.movie_id
  JOIN
    actors a ON a.id = c.actor_id
  WHERE
    a.name='Harrison Ford'
  ORDER BY
    a.name
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    m.title
  FROM
    movies m
  JOIN
    castings c ON c.movie_id = m.id
  JOIN
    actors a ON c.actor_id = a.id
  WHERE
    a.name = 'Harrison Ford'
      AND c.ord != 1
  ORDER BY
    m.title
  DESC
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT
    m.title, a.name
  FROM
    movies m
  JOIN
    castings c ON m.id = c.movie_id
  JOIN
    actors a ON a.id = c.actor_id
  WHERE
    m.yr = '1962'
      AND c.ord = '1'
  ORDER BY
    m.title;
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT
    m.yr, COUNT(*)
  FROM
    movies m
  JOIN
    castings c ON m.id = c.movie_id
  JOIN
    actors a ON a.id = c.actor_id
  WHERE
    a.name = 'John Travolta'
  GROUP BY
    m.yr
  HAVING
    COUNT(*) >= 2
  ORDER BY
    m.yr
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  SELECT
    m.title, a.name
  FROM
    movies m
  JOIN
    castings c ON c.movie_id = m.id
  JOIN
    actors a ON a.id = c.actor_id
  WHERE
    m.id IN (
        SELECT
          c2.movie_id
        FROM
          castings c2
        JOIN
          actors a2 ON a2.id = c2.actor_id
        WHERE
          a2.name = 'Julie Andrews'
      ) AND c.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  SELECT
    actors.name
  FROM
    actors
  WHERE
    actors.id IN (
      SELECT 
        actor_id 
      FROM 
        castings 
      WHERE 
        ord = 1 
      GROUP BY 
        actor_id 
      HAVING 
        COUNT(*) >= 15
    )
  GROUP BY
    actors.name
  ORDER BY
    actors.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      movies.title,
      COUNT(DISTINCT castings.actor_id) AS actor_count
    FROM
      movies
    JOIN
      castings ON castings.movie_id = movies.id
    WHERE
      movies.yr = 1978
    GROUP BY
      movies.id
    ORDER BY
      COUNT(*) DESC, movies.title ASC;
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  -- garfunkel id: 2016 -- select id from actors where name = 'Art Garfunkel'
  -- movies with garf ids: 1412, 1597 -- select movie_id from castings where actor_id = 2064
  -- movie actor_ids with garf -- select actor_id from castings where movie_id IN (1412, 1597);
  SELECT
    actors.name
  FROM
    actors
  WHERE
    actors.id IN (
      SELECT actor_id FROM castings WHERE movie_id IN (
        SELECT movie_id FROM castings WHERE actor_id = (
          SELECT id FROM actors WHERE actors.name = 'Art Garfunkel'
        )
      )
    ) AND actors.name != 'Art Garfunkel'
    ORDER BY actors.name;
  SQL
end
