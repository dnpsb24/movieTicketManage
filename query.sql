-- Query #1 = For telling which movies require parental guidance based on their genres

select m.name as requires_parental_guidance from movie m
where m.genre='Fantasy/Scifi' or m.genre='Drama/Comedy' or m.genre='Drama/Fantasy'
or m.genre='Horror' ;


-- Query #2 = For telling which movies based on their languages

select m.name as requires from movie m
where m.language='English';

select m.name as requires from movie m
where m.language='Hindi';

-- Query #3 = People who booked more than 5 ticktes


Select First_Name, Last_Name from Web_User
  where Web_User_ID IN
  (Select distinct User_ID from Booking where No_of_Tickets > 5);

-- Query #4 = Find Total no of gold seat where ID is uniqe.

SELECT sum(No_of_Seats_Gold) FROM Screen where Theatre_ID='T01';



-- Query #5 = Details of the user w.r.t. the card number used in the payment

Select First_name, Last_name, Email_ID, Phone_number, Card_number 
from Web_user Inner Join Booking
On (Web_user.Web_User_ID = Booking.User_ID);


-- Query #6 = Total earnings per movie and arrange them in a descending order
Select Name, Total_Revenue from (Select Movie_ID, sum(Total_cost) as Total_Revenue from Show Inner Join Booking On Show.Show_ID = Booking.Show_ID group by Movie_ID) Inner Join Movie On Movie.Movie_ID = Movie.Movie_ID Order By Total_Revenue DESC;



-- Query #7 = Details of the Theatre (name and location) based on the screen ID.
SELECT Name_of_Theatre, Area, Screen_ID
FROM Theatre
Left JOIN Screen
On Theatre.Theatre_ID = Screen.Theatre_ID;

-- Query #8 = The card details of the user w.r.t. his/her ticket ID

SELECT Name_On_Card, Card_Number, Total_Cost, Ticket_ID
FROM Booking
FULL OUTER JOIN Ticket
ON Booking.Booking_ID = Ticket.Booking_ID;


-- Query #9 = Count No of web user and movies Using Cursor.
Declare
client Web_user.Web_User_ID%type;
product Movie.Movie_ID%type;
count1 number;
count2 number;
Cursor count_client is select Web_User_ID from Web_user;
Cursor count_movie is select Movie_ID from Movie;
begin
count1:=0;
count2:=0;
open count_client;
loop
fetch count_client into client;
exit when count_client%NOTFOUND;
count1:=count1+1;
end loop;
close count_client;
dbms_output.put_line('No of clients: '|| count1);
open count_movie;
loop
fetch count_movie into product;
exit when count_movie%NOTFOUND;
count2:=count2+1;
end loop;
close count_movie;
dbms_output.put_line('No of movie: '|| count2);
end;/

-- Query #10 = Get details of movie with particular target audience Using Cursor.
Declare
cursor movie_details is select Movie_ID, Name, Language, Genre from movie where Target_Audience='U/A';
m_id movie.Movie_ID%type;
m_name movie.Name%type;
m_lang movie.Language%type;
m_genre movie.Genre%type;
begin
open movie_details;
loop
fetch movie_details into m_id,m_name,m_lang,m_genre;
exit when movie_details%NOTFOUND;
dbms_output.put_line(m_id ||' '||m_name||' '||m_lang||' '||m_genre||' ');
end loop;
close movie_details;
end;
/
-- Query #11 = Get Movie Name in descending order using cursor.
Declare
Cursor m_n is select Name from Movie order by Name desc;
mer_nam movie.Name%type;
begin
open m_n;
loop
fetch m_n into mer_nam;
exit when m_n%NOTFOUND;
dbms_output.put_line(mer_nam);
end loop;
close m_n;
end;
/


-- Query #12 = Trigger Statement wrt to age of web_user.

Create or replace trigger check_Age
before insert on Web_user
for each row
declare
ageN Web_user.Age%type;
begin
dbms_output.put_line('Checking triggered fired.');
if(ageN < 18) then
dbms_output.put_line('USER is not ELIGIBLE FOR A/R rated Movie. ');
else
dbms_output.put_line('USER is ELIGIBLE FOR A/R rated Movie. ');
end if;
if sql%rowcount=0 then
dbms_output.put_line('No rows affected. ');
end if;
end check_Age;
/