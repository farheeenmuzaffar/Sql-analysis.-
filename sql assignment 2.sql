-- 1. List the names of all pet owners along with the names of their pets.
select * from pets;
select * from petowners;
select p.Name, p.Kind,po.Name
from pets p join petowners po
on p.OWNERID = po.OWNERID;


-- 2. List all pets and their owner names, including pets that don't have recorded owners.
select p.Name, po.Name, p.Kind,
case
	when po.Name is null then "No owner"
    else po.Name
end as Owner_Name
from pets p left join petowners po 
on p.ownerid = po.ownerid;


-- 3. Combine the information of pets and their owners, including those pets without
-- owners and owners without pets.
-- Hint: We cannot use Full join in mysql. We will use Left Join + union + Right Join.
select * from pets;
select * from petowners;
select * from pets where petid is null;
select * from petowners where ownerid is null;
select p.petid, p.name, po.name, po.ownerid
from pets p left join petowners po
on p.OwnerID = po.OwnerID
UNION
select p.petid, p.name, po.name, po.ownerid
from pets p left join petowners po
on p.OwnerID = po.OwnerID 
where po.ownerid is null
union
select p.petid, p.name, po.name, po.ownerid
from pets p left join petowners po
on p.ownerid = po.ownerid
where p.petid is null;

-- 4. List all pet owners and the number of dogs they own.
select * from pets;
select * from petowners;
select po.ownerid, p.Name, count(p.petid) AS number_of_dogs
from petowners po left join pets p on p.ownerid = po.ownerid 
where p.kind ='Dog'
group by po.ownerid, p.Name;


-- 5. Identify pets that have not had any procedures.
select * from procedureshistory;
select p.Name, p.kind,  p.Age, ph.ProcedureType
from pets p left join procedureshistory ph on p.PETID = ph.PETID
WHERE p.PetID IS NULL;

-- 6. Find the name of the oldest pet
Select Name, Age from pets where Age = (select max(Age) from pets);

-- 7. Find the details of procedures performed on 'Cuddles'.
select * from procedureshistory;
select * from pets;
select * from proceduresdetails;
select p.Name, p.kind,  p.Age, ph.ProcedureType,ph.Date
from procedureshistory ph left join pets p on p.PETID = ph.PETID
where p.Name = 'Cuddles';

-- 8. List the pets who have undergone a procedure called 'VACCINATIONS'.
-- select * from proceduresdetails;
select * from procedureshistory;
select * from pets;
select ph.procedureType, p.PetID, p.kind
from procedureshistory ph inner join pets p
on p.petid = ph.petid where ProcedureType = 'VACCINATIONS';


-- 9. Count the number of pets of each kind.
select kind,count(Kind) as pet_kind
from pets GROUP BY kind;

-- 10.Group pets by their kind and gender and count the number of pets in each group.
select kind, gender, count(*) as number_of_pets
from pets group by kind, gender;


-- 11.Show the average age of pets for each kind, but only for kinds that have more than 5
-- pets.
select kind, avg(age) as age_of_pets
from pets group by kind having count(5) > 5;

-- 12.Find the types of procedures that have an average cost greater than $50.
select * from proceduresdetails;
select * from procedureshistory;
select ph.procedureType, pd.price from
procedureshistory ph RIGHT JOIN proceduresdetails pd
on pd.proceduretype = ph.proceduretype 
group by ph.procedureType, pd.price having avg(Price) > 50;


-- 13.Classify pets as 'Young', 'Adult', or 'Senior' based on their age. Age less then 3
-- Young, Age between 3and 8 Adult, else Senior.
select * from pets;
select petid, age,
case
	when age < 3 then "Young"
    when age >= 3 and age <= 8 then "Adult"
    else "Senior"
End as Age_Status
from pets;
-- 14.Show the gender of pets with a custom label ('Boy' for male, 'Girl' for female).
select gender, kind,
case
	when gender = "male" then "boy"
    else "girl"
end as Gender_label
from pets;
-- Adding custom label permanently into table.
set sql_safe_updates = 0;
alter table pets add column Gender_label varchar(8);
update pets set Gender_label = 
case
	when gender = "male" then "boy"
    else "girl"
end;
select * from pets;

-- 15.For each pet, display the pet's name, the number of procedures they've had, and a
-- status label: 'Regular' for pets with 1 to 3 procedures, 'Frequent' for 4 to 7
-- procedures, and 'Super User' for more than 7 procedures.
select * from procedureshistory;
-- select * from proceduresdetails;
-- proceduretype common in history and details.
-- petid common in pet and history.
select * from pets;
select p.kind, p.name, count(ph.proceduretype) as number_of_procedures, ph.proceduresubcode,
case
	when ProcedureSubCode is null then " "
	when proceduresubcode = 1 and proceduresubcode <= 3 then "Regular"
    when proceduresubcode >= 4 and proceduresubcode <= 7 then "Frequent"
    else "Super User"
end as status_label
from pets p left join procedureshistory ph
on p.petid = ph.petid
group by p.kind, p.name,ph.proceduresubcode;

