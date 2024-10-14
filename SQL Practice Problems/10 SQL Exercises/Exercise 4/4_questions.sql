-- 4.1 Select the title of all movies.

	select Title from Movies

-- 4.2 Show all the distinct ratings in the database.

	select Rating from Movies

-- 4.3  Show all unrated movies.

	select * from Movies where Rating is null

-- 4.4 Select all movie theaters that are not currently showing a movie.

	select * from movietheaters where movie is null


-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

	select a.code,a.name,a.movie, b.title,b.rating from movietheaters as a
	left join 
	movies as b
	on a.Movie = b.code

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.

	select b.title,b.rating, a.code,a.name,a.movie from movietheaters as a
	right join 
	movies as b
	on a.Movie = b.code

-- 4.7 Show the titles of movies not currently being shown in any theaters.

	select b.code, b.title from movietheaters as a
	right join 
	movies as b
	on a.Movie = b.code
	where a.movie is null

-- 4.8 Add the unrated movie "One, Two, Three".
	insert into movies(code,title) values (9,'One, Two, Three')

-- 4.9 Set the rating of all unrated movies to "G".

	update movies set Rating = 'G' where rating is null

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
	delete from movietheaters where code = 
	(select a.code from movietheaters as a
	left join 
	movies as b
	on a.Movie = b.code
	where rating = 'NC-17') 