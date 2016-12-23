--File displays Game Of Thrones Analytics based of data provided by Kaggle.com

/*prections - name, culture, mother, father, heir, house, spouse, age 
battle - year, aking, dking, attacker, defender, acommand, dcommande
deaths - name,allegiances, death year,*/

--Get first 10 names in alphabetical order that are present in both predictions and death files
SELECT gotp.name AS prediction_character_name, gotd.name AS death_character_name, CASE WHEN gotp.isalive = 1 THEN 'nope' WHEN gotp.isalive = 0 THEN 'yip' END AS is_dead FROM public.gotp INNER JOIN public.gotd ON (public.gotp.name = public.gotd.name) ORDER BY gotp.name asc LIMIT 10;
/* prediction_character_name | death_character_name | is_dead 
---------------------------+----------------------+---------
 Addam Marbrand            | Addam Marbrand       | nope
 Aemon Costayne            | Aemon Costayne       | nope
 Aemon Estermont           | Aemon Estermont      | nope
 Aenys Frey                | Aenys Frey           | yip
 Aeron Greyjoy             | Aeron Greyjoy        | nope
 Aethan                    | Aethan               | nope
 Aggar                     | Aggar                | yip
 Aggo                      | Aggo                 | nope
 Alayaya                   | Alayaya              | nope
 Albar Royce               | Albar Royce          | nope*/

 --Same as query above but with left join, so all values from prediction values are matched with death values if no death vale then death name set to null
 SELECT gotp.name AS prediction_character_name, gotd.name AS death_character_name, CASE WHEN gotp.isalive = 1 THEN 'nope' WHEN gotp.isalive = 0 THEN 'yip' END AS is_dead FROM public.gotp LEFT JOIN public.gotd ON (public.gotp.name = public.gotd.name) ORDER BY gotp.name asc LIMIT 10;
 /*  prediction_character_name  | death_character_name | is_dead 
-----------------------------+----------------------+---------
 Abelar Hightower            |                      | nope
 Addam                       |                      | nope
 Addam Frey                  |                      | nope
 Addam Marbrand              | Addam Marbrand       | nope
 Addam Osgrey                |                      | yip
 Addam Velaryon              |                      | yip
 Addison Hill                |                      | nope
 Aegon Blackfyre             |                      | yip
 Aegon Frey (son of Aenys)   |                      | nope
 Aegon Frey (son of Stevron) |                      | yip*/

--Shows name of king, army size, and allegiance. When using the right join it death name is joined with attacking king. Can seem which values come from which table.
SELECT gotd.name AS death_character_name, gotb.aking AS attacking_king, gotd.allegiance, gotb.asize AS army_size, CASE WHEN gotb.asize >= gotb.dsize THEN 'Larger Army' ELSE 'Smaller Amry' END AS army_strength FROM public.gotd RIGHT JOIN public.gotb ON (public.gotd.name = public.gotb.aking);
/*death_character_name |      attacking_king      | allegiance  | army_size | army_strength 
----------------------+--------------------------+-------------+-----------+---------------
 Robb Stark           | Robb Stark               | House Stark |           | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |      3000 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |           | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |      6000 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |       100 | Larger Army
 Robb Stark           | Robb Stark               | House Stark |      6000 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |       244 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |      6000 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |      1875 | Smaller Amry
 Robb Stark           | Robb Stark               | House Stark |     18000 | Smaller Amry
                      |                          |             |           | Smaller Amry
                      |                          |             |           | Smaller Amry
                      | Balon/Euron Greyjoy      |             |           | Smaller Amry
                      | Balon/Euron Greyjoy      |             |           | Smaller Amry
                      | Balon/Euron Greyjoy      |             |           | Smaller Amry
                      | Balon/Euron Greyjoy      |             |        20 | Smaller Amry
                      | Balon/Euron Greyjoy      |             |       264 | Smaller Amry
                      | Balon/Euron Greyjoy      |             |      1000 | Smaller Amry
                      | Balon/Euron Greyjoy      |             |           | Smaller Amry
                      | Stannis Baratheon        |             |      5000 | Smaller Amry
                      | Stannis Baratheon        |             |      4500 | Larger Army
                      | Stannis Baratheon        |             |    100000 | Larger Army
                      | Stannis Baratheon        |             |     21000 | Larger Army
                      | Stannis Baratheon        |             |      5000 | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |      1500 | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |      3000 | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |      2000 | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |      3500 | Larger Army
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |     20000 | Larger Army
                      | Joffrey/Tommen Baratheon |             |       618 | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |     15000 | Larger Army
                      | Joffrey/Tommen Baratheon |             |           | Smaller Amry
                      | Joffrey/Tommen Baratheon |             |     15000 | Larger Army*/

--Top 15 popular charceters in book 1 sorted by popularity, displays if they are noble, gender, and if still alive
SELECT gotd.name AS death_character_name, gotp.name AS prediction_character_name, gotp.book1 AS prediction_book1, gotd.got AS death_book1, gotp.popularity, CASE WHEN gotd.nobolilty = 1 THEN 'noble' ELSE 'common' END AS is_noble, CASE WHEN gotp.isalive = 1 THEN 'alive' ELSE 'dead' END AS living_status, CASE WHEN gotd.gender = 1 THEN 'male' ELSE 'female' END AS gender FROM public.gotd INNER JOIN public.gotp ON (gotd.name = gotp.name AND gotp.book1 = gotd.got) ORDER BY gotp.popularity desc LIMIT 15;
    /* death_character_name | prediction_character_name | prediction_book1 | death_book1 |    popularity     | is_noble | living_status | gender 
----------------------+---------------------------+------------------+-------------+-------------------+----------+---------------+--------
 Tywin Lannister      | Tywin Lannister           |                1 |           1 |                 1 | noble    | dead          | male
 Petyr Baelish        | Petyr Baelish             |                1 |           1 |                 1 | common   | alive         | male
 Jon Snow             | Jon Snow                  |                1 |           1 |                 1 | noble    | alive         | male
 Sansa Stark          | Sansa Stark               |                1 |           1 |                 1 | noble    | alive         | female
 Renly Baratheon      | Renly Baratheon           |                1 |           1 |                 1 | noble    | dead          | male
 Theon Greyjoy        | Theon Greyjoy             |                1 |           1 |                 1 | noble    | alive         | male
 Bran Stark           | Bran Stark                |                1 |           1 |                 1 | noble    | alive         | male
 Arya Stark           | Arya Stark                |                1 |           1 |                 1 | noble    | alive         | female
 Daenerys Targaryen   | Daenerys Targaryen        |                1 |           1 |                 1 | noble    | alive         | female
 Jaime Lannister      | Jaime Lannister           |                1 |           1 |                 1 | noble    | alive         | male
 Barristan Selmy      | Barristan Selmy           |                1 |           1 |                 1 | noble    | alive         | male
 Eddard Stark         | Eddard Stark              |                1 |           1 |                 1 | noble    | dead          | male
 Cersei Lannister     | Cersei Lannister          |                1 |           1 |                 1 | noble    | alive         | female
 Tyrion Lannister     | Tyrion Lannister          |                1 |           1 |                 1 | noble    | alive         | male
 Roose Bolton         | Roose Bolton              |                1 |           1 | 0.979933110367893 | noble    | alive         | male*/

 --Same query as aboce, but with last book instead of first book. Can see how charceter importance has shifted.
SELECT gotd.name, gotp.name, gotp.book5 AS prediction_book5, gotd.dwd AS death_book5, gotp.popularity,  CASE WHEN gotd.nobolilty = 1 THEN 'noble' ELSE 'common' END AS is_noble, CASE WHEN gotp.isalive = 1 THEN 'alive' ELSE 'dead' END AS living_status, CASE WHEN gotd.gender = 1 THEN 'male' ELSE 'female' END AS gender FROM public.gotd INNER JOIN public.gotp ON (gotd.name = gotp.name AND gotp.book5 = gotd.dwd) WHERE gotp.book5 =1  ORDER BY gotp.popularity desc LIMIT 15;
/*        name        |        name        | prediction_book5 | death_book5 |    popularity     | is_noble | living_status | gender 
--------------------+--------------------+------------------+-------------+-------------------+----------+---------------+--------
 Daenerys Targaryen | Daenerys Targaryen |                1 |           1 |                 1 | noble    | alive         | female
 Arya Stark         | Arya Stark         |                1 |           1 |                 1 | noble    | alive         | female
 Theon Greyjoy      | Theon Greyjoy      |                1 |           1 |                 1 | noble    | alive         | male
 Jaime Lannister    | Jaime Lannister    |                1 |           1 |                 1 | noble    | alive         | male
 Bran Stark         | Bran Stark         |                1 |           1 |                 1 | noble    | alive         | male
 Tyrion Lannister   | Tyrion Lannister   |                1 |           1 |                 1 | noble    | alive         | male
 Barristan Selmy    | Barristan Selmy    |                1 |           1 |                 1 | noble    | alive         | male
 Cersei Lannister   | Cersei Lannister   |                1 |           1 |                 1 | noble    | alive         | female
 Jon Snow           | Jon Snow           |                1 |           1 |                 1 | noble    | alive         | male
 Roose Bolton       | Roose Bolton       |                1 |           1 | 0.979933110367893 | noble    | alive         | male
 Samwell Tarly      | Samwell Tarly      |                1 |           1 | 0.969899665551839 | noble    | alive         | male
 Davos Seaworth     | Davos Seaworth     |                1 |           1 | 0.969899665551839 | noble    | alive         | male
 Varys              | Varys              |                1 |           1 | 0.899665551839464 | common   | alive         | male
 Kevan Lannister    | Kevan Lannister    |                1 |           1 | 0.869565217391304 | noble    | dead          | male
 Mace Tyrell        | Mace Tyrell        |                1 |           1 | 0.856187290969899 | noble    | alive         | male*/

 --Connecting major charcters with potential battles in which they mhad a good chance of dieing in
SELECT gotb.name AS battle_name, gotd.name AS death_character_name, gotb.aking AS attacking_king, gotb.year AS battle_year, gotd.year AS death_year, CASE WHEN gotb.death = 1 THEN 'yes' ELSE 'no' END major_death FROM public.gotd LEFT JOIN public.gotb ON (gotb.year =gotd.year AND gotd.name = gotb.aking) WHERE gotb.death =1;
/*     battle_name      | death_character_name | attacking_king | battle_year | death_year | major_death 
----------------------+----------------------+----------------+-------------+------------+-------------
 Battle of Duskendale | Robb Stark           | Robb Stark     |         299 |        299 | yes
 Sack of Harrenhal    | Robb Stark           | Robb Stark     |         299 |        299 | yes
 Battle of Oxcross    | Robb Stark           | Robb Stark     |         299 |        299 | yes*/

 --Characters showing up in all the books, display their nickname and culture 
 SELECT gotd.name AS death_character_name, gotp.name AS prediction_character_name, gotp.title AS charcter_title, gotp.culture, gotd.got AS book1, gotd.cok AS book2, gotd.sos AS book3, gotd.ffc AS book4, gotd.dwd AS book5 FROM public.gotd INNER JOIN public.gotp ON (gotd.name = gotp.name) WHERE (gotd.got = 1 AND gotd.cok = 1 AND gotd.sos = 1 AND gotd.ffc = 1 AND gotd.ffc =1 AND gotd.dwd = 1);
 /* death_character_name | prediction_character_name |           charcter_title            |   culture   | book1 | book2 | book3 | book4 | book5 
----------------------+---------------------------+-------------------------------------+-------------+-------+-------+-------+-------+-------
 Samwell Tarly        | Samwell Tarly             |                                     | Westeros    |     1 |     1 |     1 |     1 |     1
 Arya Stark           | Arya Stark                | Princess                            | Northmen    |     1 |     1 |     1 |     1 |     1
 Boros Blount         | Boros Blount              | Ser                                 |             |     1 |     1 |     1 |     1 |     1
 Cersei Lannister     | Cersei Lannister          | Light of the West                   | Westerlands |     1 |     1 |     1 |     1 |     1
 Lancel Lannister     | Lancel Lannister          | Ser                                 |             |     1 |     1 |     1 |     1 |     1
 Meryn Trant          | Meryn Trant               | Ser                                 |             |     1 |     1 |     1 |     1 |     1
 Pycelle              | Pycelle                   | Grand Maester                       |             |     1 |     1 |     1 |     1 |     1
 Balon Swann          | Balon Swann               | Ser                                 | Stormlander |     1 |     1 |     1 |     1 |     1
 Grenn                | Grenn                     |                                     | Westeros    |     1 |     1 |     1 |     1 |     1
 Harys Swyft          | Harys Swyft               | Knight                              |             |     1 |     1 |     1 |     1 |     1
 Jaime Lannister      | Jaime Lannister           | Ser                                 | Westerlands |     1 |     1 |     1 |     1 |     1
 Jon Snow             | Jon Snow                  | Lord Commander of the Night's Watch | Northmen    |     1 |     1 |     1 |     1 |     1
 Kevan Lannister      | Kevan Lannister           | Ser                                 |             |     1 |     1 |     1 |     1 |     1*/

 --Find popularity based off what allegiance/house characters support
 SELECT gotp.house, gotd.allegiance, gotp.popularity, gotd.name FROM public.gotp INNER JOIN public.gotd ON(gotp.house=gotd.allegiance) ORDER BY gotp.popularity desc;
 /*      house      |   allegiance    | popularity |      name       
-----------------+-----------------+------------+-----------------
 House Greyjoy   | House Greyjoy   |          1 | Aeron Greyjoy
 House Greyjoy   | House Greyjoy   |          1 | Adrack Humble
 House Targaryen | House Targaryen |          1 | Aegon Targaryen
 House Targaryen | House Targaryen |          1 | Aggo
 House Greyjoy   | House Greyjoy   |          1 | Aggar*/


