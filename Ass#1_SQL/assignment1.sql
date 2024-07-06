#1
select name
from Pokemon
where type = 'Grass'
order by name;
#2
select name
from Trainer
where hometown in ('Brown City', 'Rainbow City')
order by name;
#3
select distinct type
from Pokemon
order by type;
#4
select name
from City
where name like 'B%'
order by name;
#5
select hometown
from Trainer
where name not like 'M%'
order by hometown;
#6
with max_level(ml) as
	(select max(level) 
    from CatchedPokemon) 
select nickname
from CatchedPokemon, max_level
where level = max_level.ml
order by nickname;
#7
select name
from Pokemon
where name like 'A%'
	or name like 'E%'
    or name like 'I%'
    or name like 'O%'
    or name like 'U%'
order by name;
#8
select avg(level)
from CatchedPokemon;
#9
select max(level)
from Trainer, CatchedPokemon
where Trainer.name = 'Yellow' and Trainer.id = CatchedPokemon.owner_id;
#10
select distinct hometown
from Trainer
order by hometown;
#11
select name, nickname
from Trainer, CatchedPokemon
where CatchedPokemon.nickname like 'A%' 
	and Trainer.id = CatchedPokemon.owner_id
order by name;
#12
select Trainer.name
from Trainer, Gym, City
where description = 'Amazon'
	and city = City.name
    and id = leader_id;
#13 
with cnt(id, countFire) as
	(select owner_id, count(CatchedPokemon.id)
	 from Pokemon, CatchedPokemon
	 where pid = Pokemon.id and type = 'Fire'
	 group by owner_id)
select cnt.id, cnt.countFire
from cnt
where cnt.countFire = (select max(countFire)
					   from cnt);
#14
select distinct type
from(select type, id
     from Pokemon
	 where id < 10
     order by id desc)tyid;
#15
select count(*)
from Pokemon
where type not in ('Fire');
#16
select name
from Pokemon, Evolution
where before_id = id and after_id < before_id
order by name;
#17
select avg(level)
from CatchedPokemon, Pokemon
where Pokemon.id = pid and type = 'Water';
#18
with leaderPokemon(nn,lv) as(
	select nickname, level
	from Gym, CatchedPokemon
	where leader_id = owner_id)
select leaderPokemon.nn as nickname
from leaderPokemon
where leaderPokemon.lv = (select max(lv)
						  from leaderPokemon);
#19
with blueLv(id,lv) as(
select owner_id, avg(level)
from CatchedPokemon join Trainer on CatchedPokemon.owner_id = Trainer.id
where hometown = 'Blue City'
group by owner_id)
select name
from Trainer join blueLv on Trainer.id = blueLv.id
where blueLv.lv = (select max(blueLv.lv) from blueLv)
order by name;
#20
with c(id) as(select id
			  from Trainer
			  where Trainer.id not in (select a.id
									   from Trainer as a, Trainer as b
									   where a.hometown = b.hometown and a.id !=b.id))
select name
from CatchedPokemon join c on CatchedPokemon.owner_id = c.id join Pokemon on pid=Pokemon.id
where type = 'Electric' and pid in (select before_id
									from Evolution);
#21
select name as leader, sum(level) as sumLevel
from CatchedPokemon join Gym on owner_id = leader_id join Trainer on leader_id = Trainer.id
group by name
order by sumLevel desc;
#22
with homeCount(hm,cnt) as 
(select hometown, count(id)
from Trainer
group by hometown)
select hm as hometown
from homeCount
where cnt = (select max(cnt) from homeCount);
#23
select distinct Pokemon.name
from Trainer join CatchedPokemon on owner_id = Trainer.id join Pokemon on pid = Pokemon.id
where hometown in ('Sangnok City') and pid in 
(select pid 
from Trainer join CatchedPokemon on owner_id = Trainer.id
where hometown in ('Brown City'))
order by Pokemon.name;
#24
select Trainer.name
from CatchedPokemon join Pokemon on pid=Pokemon.id join Trainer on owner_id=Trainer.id
where Pokemon.name like 'P%' and hometown = 'Sangnok City'
order by Trainer.name;
#25
select Trainer.name, s.name as PokemonName
from (select owner_id, name
from Pokemon join CatchedPokemon on pid=Pokemon.id)s join Trainer on owner_id = Trainer.id
order by Trainer.name, PokemonName;
#26
select name
from (select before_id
from Evolution
where after_id not in (select before_id from Evolution)
and before_id not in (select after_id from Evolution))s join Pokemon on s.before_id = id
order by name;
#27
select nickname
from CatchedPokemon join Pokemon on pid = Pokemon.id join Gym on owner_id = leader_id
where city = 'Sangnok City' and type = 'Water'
order by nickname;
#28
select Trainer.name
from CatchedPokemon join Trainer on owner_id = Trainer.id
where pid in (select after_id from Evolution)
group by Trainer.name
having count(*)>2
order by Trainer.name;
#29
select name
from Pokemon
where Pokemon.id not in (select pid from CatchedPokemon)
order by name;
#30
select max(level) as maxLevel
from CatchedPokemon join Trainer on owner_id = Trainer.id
group by hometown
order by maxlevel desc;
#31
select d.firstid as id, e.name as firstName, f.name as secondName, g.name as thirdName
from (select b.before_id as firstid, a.before_id as secondid, a.after_id as thirdid
from Evolution as a, Evolution as b
where a.before_id = b.after_id)d join Pokemon as e on d.firstid = e.id join
Pokemon as f on d.secondid = f.id join Pokemon as g on d.thirdid = g.id
order by id;