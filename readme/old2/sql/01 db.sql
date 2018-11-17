서버 : localhost  3306  


---------- DB 생성 -------------

CREATE DATABASE qlearning;

create user 'qlearning'@'localhost' identified by 'elql7805';

grant select, insert, update, delete, create, drop, alter on qlearning.* to 'qlearning'@'localhost';

show grants for 'qlearning'@'localhost';

FLUSH PRIVILEGES;