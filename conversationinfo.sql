create table conversations (
	id INT, 
	email VARCHAR(30),
	created_at DATETIME
)

create table conversation_tag (
	conversation_id INT,
	tag text
)

insert into conversations (id, email, created_at)
values
('1','dixi@example.com','2018-08-14 14:02:10'),
('2','eli@example.com','2018-08-14 14:06:30'),
('3', 'matt@example.com','2018-08-14 14:07:33'),
('4','katia@example.com','2018-08-14 14:11:30'),
('5','jen@example.com', '2018-08-13 14:11:30')


insert into conversation_tag (conversation_id, tag)
values
 ('1','new-trial'),              
('1','bug-report'),
('2', 'property_chat_interest'),
('4', 'property_chat_interest')


select c.`email`, c.`created_at`
From conversation_tag as ct, conversations as c
where ct.`conversation_id` = c.`id`
 and ct.tag = 'property_chat_interest'