create database kullanici;
use kullanici;
create table kullanicilar(
id INT AUTO_INCREMENT, 
username varchar(20) not null, 
pass varchar(20) not null, 
level varchar(20) not null, 
PRIMARY KEY (ID));
-- select * from kullanicilar
INSERT INTO `kullanici`.`kullanicilar` (`username`, `pass`, `level`) VALUES ('admin', '123', '1');
INSERT INTO `kullanici`.`kullanicilar` (`username`, `pass`, `level`) VALUES ('admin2', '123', '1');
UPDATE `kullanici`.`kullanicilar` SET `username` = 'member', `level` = 'member' WHERE (`id` = '2');
UPDATE `kullanici`.`kullanicilar` SET `level` = 'admin' WHERE (`id` = '1');
select * from kullanicilar
