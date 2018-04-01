use movierating;

#1. Find the titles of all movies directed by Steven Spielberg

select Title from movie where director='Steven Spielberg';

#2. Find all years that have a movie that received a rating of 4 or 5, and sort them in
#increasing order.

Select Year from Movie
where mID IN (select mID from Rating where stars IN (4,5))
order by year asc;

#3 Find the titles of all movies that have no ratings.

select Title from movie where mID NOT IN (select mID from rating);

#4 Some reviewers didn't provide a date with their rating. Find the names of all reviewers
#who have ratings with a NULL value for the date.

select Name from reviewer 
where rid IN (Select rid from rating where ratingDate IS NULL);		

#5 Write a query to return the ratings data in a more readable format: reviewer name, movie title,
#stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title,
# and lastly by number of stars.

select reviewer.Name,movie.Title,rating.Stars,rating.ratingDate
from Rating 
Join reviewer on Rating.rID = Reviewer.rID
join Movie on Movie.mID=Rating.mID
order by Reviewer.name, Movie.title, stars  ASC;

#6. For all cases where the same reviewer rated the same movie twice and gave it a higher
#rating the second time, return the reviewer's name and the title of the movie.

select reviewer.Name , movie.Title
from reviewer, movie , (select R1.rID, R1.mID from Rating R1, Rating R2 where R1.rID=R2.rID and R1.mID=R2.mID and R2.ratingDate>R1.ratingDate and R2.stars>R1.stars) as T
where Reviewer.rID=T.rID and Movie.mID=T.mID ;

#7. For each movie that has at least one rating, find the highest number of stars that movie
#received. Return the movie title and number of stars. Sort by movie title.

select Title, MAX(stars) from Rating
join Movie on Movie.mID=Rating.mID
group by Movie.mID
order by title ASC;

#8 For each movie, return the title and the 'rating spread', that is, the difference between
#highest and lowest ratings given to that movie. Sort by rating spread from highest to
#lowest, then by movie title.

select movie.title, max(stars)-min(stars) as rating_spread
from rating join movie on rating.mid=movie.mid
group by rating.mid
order by rating_spread desc, title;

#9 Find the difference between the average rating of movies released before 1980 and the
#average rating of movies released after 1980. (Make sure to calculate the average rating
#for each movie, then the average of those averages for movies before 1980 and movies
#after. Don't just calculate the overall average rating before and after 1980.)

select max(A)-min(A) from
(select avg(av1) as a1 from
(select avg(stars) as av1 
from rating r join movie m on r.mid=m.mid where m.year < 1980
group by r.mid) as A
union
select avg(av2) as a1 from
(select avg(stars) as av2 from rating r join movie m on r.mid=m.mid where m.year > 1980
group by r.mid)) as B;

#10. For all movies that have an average rating of 4 stars or higher, add 25 to the release
#year. (Update the existing tuples; don't insert new tuples.)

update movie as mv
set year = year + 25
where mID in (
  select mID from (
  select AVG(stars) as astar, mID from Rating
  where mID=rating.mID
  group by mID
  having astar >=4)
)