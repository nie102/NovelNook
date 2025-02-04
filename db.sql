# 此表是数据库的地基,只是一个可能的版本,如果写着写着发现数据库设计不合理,和组长联系修改

CREATE DATABASE IF NOT EXISTS novelnook;
USE novelnook;

DROP TABLE IF EXISTS borrow;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS patron;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS superuser;


CREATE  TABLE IF NOT EXISTS staff(
  userid int PRIMARY KEY AUTO_INCREMENT,
  password varchar(255),
  firstname varchar(255),
  lastname varchar(255),
  email varchar(255),
  telephone varchar(255),
  avatar varchar(255)
);


CREATE  TABLE IF NOT EXISTS patron(
    userid int PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(255),
    firstname varchar(255),
    lastname varchar(255),
    email VARCHAR(255),
    telephone varchar(255),
    avatar varchar(255)
);


CREATE  TABLE IF NOT EXISTS superuser(
    userid int PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(255),
    firstname varchar(255),
    lastname varchar(255),
    email VARCHAR(255),
    telephone varchar(255),
    avatar varchar(255)
);


CREATE  TABLE IF NOT EXISTS admin(
    userid int PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(255),
    firstname varchar(255),
    lastname varchar(255),
    email VARCHAR(255),
    telephone varchar(255),
    avatar varchar(255)
);


CREATE TABLE IF NOT EXISTS book(
                                   bookid int PRIMARY KEY AUTO_INCREMENT,
                                   bookname VARCHAR(255),
                                   press VARCHAR(255),
                                   author VARCHAR(255),
                                   publishtime VARCHAR(255),
                                   catagory VARCHAR(255),
                                   remain int,
                                   introduction TEXT,
                                   location varchar(255) #格式 房间号-书架号-第几层-编号（2位）
);
CREATE TABLE IF NOT EXISTS borrow(
                                     borrowid VARCHAR(255),
                                     userid int,
                                     bookid int,
                                     borrowtime DATE,
                                     deadline DATE,
                                     status ENUM('returned','borrowing'),
                                     FOREIGN KEY(userid) REFERENCES patron(userid) ON UPDATE CASCADE ON DELETE CASCADE ,
                                     FOREIGN KEY(bookid) REFERENCES book(bookid) ON UPDATE CASCADE ON DELETE CASCADE ,
                                     PRIMARY KEY (borrowid)
);

CREATE TABLE IF NOT EXISTS reservation(
                                          reservationid VARCHAR(255),
                                          userid int,
                                          bookid int,
                                          reservationtime DATE,
                                          status ENUM('canceled','waiting','satisfied'),
                                          FOREIGN KEY(userid) REFERENCES patron(userid) ON UPDATE CASCADE ON DELETE CASCADE ,
                                          FOREIGN KEY(bookid) REFERENCES book(bookid) ON UPDATE CASCADE ON DELETE CASCADE ,
                                          PRIMARY KEY (reservationid)
);

CREATE TABLE IF NOT EXISTS returned(
                                     borrowid VARCHAR(255) PRIMARY KEY ,
                                     returntime DATE, #还书的实际时间，还书的ddl在borrow表中
                                     fineamount numeric(10,2), #罚款金额
                                     ispay boolean, #是否交过罚款
                                     FOREIGN KEY(borrowid) REFERENCES borrow(borrowid) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS fine(
                                 id int PRIMARY KEY AUTO_INCREMENT,
                                 money numeric(10,2)
  );


#5.19
CREATE TABLE IF NOT EXISTS isbn_bookid(
                                 isbn VARCHAR(255) PRIMARY KEY,
                                 bookid int,
                                 FOREIGN KEY(bookid) REFERENCES book(bookid) ON UPDATE CASCADE ON DELETE CASCADE
  );

#5.25
CREATE TABLE IF NOT EXISTS booklimit(
                                 id int PRIMARY KEY AUTO_INCREMENT,
                                 limitnum int
  );
#5.25
CREATE TABLE IF NOT EXISTS book_realid(
                                 realid VARCHAR(255) PRIMARY KEY,
                                 bookid int,
                                 borrowid VARCHAR(255),
                                 FOREIGN KEY(bookid) REFERENCES book(bookid) ON UPDATE CASCADE ON DELETE CASCADE
  );


-- staff用测试数据

-- 生成20条随机数据 patron
INSERT INTO patron (password, firstname, lastname, email, telephone, avatar) VALUES
('s3cr3tp@ss', 'John', 'Doe', 'johndoe@example.com', '+1-234-567-8901', 'avatars/7.svg'),
('7yN7UBG@vk', 'Jane', 'Smith', 'janesmith@example.com', '+1-345-678-9012', 'avatars/3.svg'),
('p@ssw0rd123', 'Bob', 'Johnson', 'bobjohnson@example.com', '+1-456-789-0123', 'avatars/2.svg'),
('pa$sw0rd456', 'Sarah', 'Lee', 'sarahlee@example.com', '+1-567-890-1234', 'avatars/6.svg'),
('Qwerty123!', 'David', 'Chen', 'davidchen@example.com', '+1-678-901-2345', 'avatars/10.svg'),
('myp@ssw0rd', 'Linda', 'Wang', 'lindawang@example.com', '+1-789-012-3456', 'avatars/5.svg'),
('Passw0rd', 'Eric', 'Kim', 'erickim@example.com', '+1-890-123-4567', 'avatars/8.svg'),
('starbucks', 'Emily', 'Jones', 'emilyjones@example.com', '+1-901-234-5678', 'avatars/1.svg'),
('Hello123', 'Mark', 'Davis', 'markdavis@example.com', '+1-012-345-6789', 'avatars/9.svg'),
('P@ssword123', 'Melissa', 'Lopez', 'melissalopez@example.com', '+1-123-456-7890', 'avatars/4.svg'),
('sunshine', 'Chris', 'Brown', 'chrisbrown@example.com', '+1-234-567-8901', 'avatars/2.svg'),
('pa$$word', 'Ava', 'Taylor', 'avataylor@example.com', '+1-345-678-9012', 'avatars/3.svg'),
('qwertyuiop', 'Lucas', 'Wilson', 'lucaswilson@example.com', '+1-456-789-0123', 'avatars/6.svg'),
('myPassword', 'Sophia', 'Martin', 'sophiamartin@example.com', '+1-567-890-1234', 'avatars/7.svg'),
('baseball', 'Ethan', 'Flores', 'ethanflores@example.com', '+1-678-901-2345', 'avatars/10.svg'),
('password1', 'Isabella', 'Garcia', 'isabellagarcia@example.com', '+1-789-012-3456', 'avatars/1.svg'),
('qwerty123', 'Michael', 'Bailey', 'michaelbailey@example.com', '+1-890-123-4567', 'avatars/8.svg'),
('hunter2', 'Daniel', 'Nguyen', 'danielnguyen@example.com', '+1-901-234-5678', 'avatars/4.svg'),
('iloveme', 'Olivia', 'Hernandez', 'oliviahernandez@example.com', '+1-012-345-6789', 'avatars/9.svg'),
('1234567890', 'Matthew', 'Allen', 'matthewallen@example.com', '+1-123-456-7890', 'avatars/5.svg');

INSERT INTO staff (password, firstname, lastname, email, telephone, avatar) VALUES
('123456', 'staff', 'test01', '123@ex.com', '74184561', 'avatars/5.svg');

INSERT INTO fine(money) VALUES
(2);

INSERT INTO booklimit(limitnum) VALUES
(5);


#==============生成book信息============================
insert into novelnook.book (bookname, press, author, publishtime, catagory, remain, introduction, location)
values  ('Moby-Dick or, The Whale', '', 'Herman Melville', '2003-2-21', 'novel', 13, 'It is the horrible texture of a fabric that should be woven of ships&#39; cables and hawsers. A Polar wind blows through it, and birds of prey hover over it.&#34;    So Melville wrote of his masterpiece, one of the greatest works of imagination in literary history. In part, Moby-Dick is the story of an eerily compelling madman pursuing an unholy war against a creature as vast and dangero...', '102-2-2-11'),
        ('The Catcher in the rye', 'Little Brown and Company', 'Salinger', '2014-01-01', 'novel', 8, 'The hero-narrator of The Catcher in the Rye is an ancient child of sixteen, a native New Yorker named Holden Caulfield. Through circumstances that tend to preclude adult, secondhand description, he leaves his prep school in Pennsylvania and goes underground in New York City for three days. The boy himself is at once too simple and too complex for us to make any final comment about him or his story. Perhaps the safest thing we can say about Holden is that he was born in the world not just strongly attracted to beauty but, almost, hopelessly impaled on it. There are many voices in this novel: children''s voices, adult voices, underground voices-but Holden''s voice is the most eloquent of all. Transcending his own vernacular, yet remaining marvelously faithful to it, he issues a perfectly articulated cry of mixed pain and pleasure. However, like most lovers and clowns and poets of the higher orders, he keeps most of the pain to, and for, himself. The pleasure he gives away, or sets aside, with all his heart. It is there for the reader who can handle it to keep.
J.D. Salinger''s classic novel of teenage angst and rebellion was first published in 1951. The novel was included on Time''s 2005 list of the 100 best English-language novels written since 1923. It was named by Modern Library and its readers as one of the 100 best English-language novels of the 20th century. It has been frequently challenged in the court for its liberal use of profanity and portrayal of sexuality and in the 1950''s and 60''s it was the novel that every teenage boy wants to read.', '102-2-3-06'),
        ('To The Lighthouse', '', 'Virginia Woolf', '1989', 'novel', 6, '', '211-1-1-24'),
        ('The Lord of the Rings', '', 'J.R.R. Tolkien', '2005-10-12', 'novel', 6, 'One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, the Dark Lord, forged the One Ring, filling it with his own power so that he could rule all others. But the One Ring was taken from him, and though he sought it throughout Middle-earth, it re...', '303-2-1-01'),
        ('Brave New World', '', 'Aldous Huxley', '2006-10-17', 'novel', 7, 'Aldous Huxley&#39;s tour de force, &#34;Brave New World&#34; is a darkly satiric vision of a &#34;utopian&#34; future where humans are genetically bred and pharmaceutically anesthetized to passively serve a ruling order. A powerful work of speculative fiction that has enthralled and terrified readers for generations, it remains remarkably relevant to this day as both a warning to be heeded as we h...', '103-2-6-07'),
        ('Wuthering Heights', '', 'Emily Brontë', '2002-12', 'novel', 18, 'Published a year before her death at the age of thirty, Emily Brontë&#39;s only novel is set in the wild, bleak Yorkshire Moors. Depicting the relationship of Cathy and Heathcliff,  Wuthering Heights  creates a world of its own, conceived with an instinct for poetry and for the dark depths of human psychology.          Edited with an Introduction and Notes by Pauline Nestor     Ne...', '101-1-11-1'),
        ('Anna Karenina', 'Penguin Classics', 'Leo Tolstoy', '2004-5', 'novel', 5, 'Beautiful, vigorous, and eminently readable, this is the new English-language translation of one of the world''s literary masterpieces. Includes an illuminating Introduction and explanatory notes. BOMC Selection. 864 pp.', '204-2-6-07'),
        ('The Sun Also Rises', 'Scribner', 'HemingwayErnest', '', 'novel', 8, null, '106-9-2-11'),
        ('The Brothers Karamazov', '', 'Fyodor Dostoevsky', '2002-6-14', 'novel', 10, 'The award-winning translation of Dostoevsky&#39;s last and greatest novel.', '201-6-5-10'),
        ('Crime and Punishment', '', 'Fyodor Dostoyevsky', '2002-12-31', 'novel', 5, 'Raskolnikov, a destitute and desperate former student, commits a random murder without remorse or regret, imagining himself to be a great man far above moral law. But as he embarks on a dangerous cat-and-mouse game with a suspicious police investigator, his own conscience begins to torment him and he seeks sympathy and redemption from Sonya, a downtrodden prostitute. ...', '501-2-3-41'),
        ('The Picture of Dorian Gray', '', 'Oscar Wilde', '2003-2-4', 'novel', 6, 'Enthralled by a portrait of himself, young Dorian Gray makes a Faustian bargain to exchange his soul for eternal youth and beauty. Thus he is able to indulge in his desires, as only the portrait bears the traces of his decadence and becomes a nightmarish picture of his soul.          Edited with an Introduction by Robert Mighall     Preface by Peter Ackroyd', '404-4-6-7');


insert into novelnook.isbn_bookid (isbn, bookid)
values  ('9780142437247', 1),
        ('9780316769488', 2),
        ('9780156907392', 3),
        ('9780618640157', 4),
        ('9780060850524', 5),
        ('9780141439556', 6),
        ('9780143035008', 7),
        ('9780743297332', 8),
        ('9780374528379', 9),
        ('9780140449136', 10),
        ('9780141439570', 11);

insert into novelnook.book_realid (realid, bookid, borrowid)
values  ('1000001', 10, null),
        ('1000002', 10, null),
        ('1000003', 10, null),
        ('1000004', 10, null),
        ('1000005', 10, null),
        ('100001', 1, null),
        ('1000010', 1, null),
        ('1000011', 1, null),
        ('100002', 1, null),
        ('100003', 1, null),
        ('100004', 1, null),
        ('100005', 1, null),
        ('100006', 1, null),
        ('100007', 1, null),
        ('100008', 1, null),
        ('100009', 1, null),
        ('1100001', 11, 'de26af4c-d6e0-42ce-8c6d-143ac032e1ed'),
        ('1100002', 11, null),
        ('1100003', 11, null),
        ('1100004', 11, null),
        ('1100005', 11, null),
        ('1100006', 11, null),
        ('1100007', 11, null),
        ('200001', 2, '65745ace-c1ca-4e4b-ab3f-4ed863fbdd1a'),
        ('200002', 2, null),
        ('200003', 2, null),
        ('200004', 2, null),
        ('200005', 2, null),
        ('200006', 2, null),
        ('200007', 2, null),
        ('200008', 2, null),
        ('200009', 2, null),
        ('300001', 3, null),
        ('300002', 3, null),
        ('300003', 3, null),
        ('300004', 3, null),
        ('300005', 3, null),
        ('300006', 3, null),
        ('400001', 4, null),
        ('400002', 4, null),
        ('400003', 4, null),
        ('400004', 4, null),
        ('400005', 4, null),
        ('400006', 4, null),
        ('400007', 4, null),
        ('500001', 5, null),
        ('500002', 5, 'ef07353a-daaa-4a43-9269-db9c2fdd8b4c'),
        ('500003', 5, null),
        ('500004', 5, null),
        ('500005', 5, null),
        ('500006', 5, null),
        ('500007', 5, null),
        ('500008', 5, null),
        ('600001', 6, null),
        ('6000010', 6, null),
        ('600002', 6, null),
        ('600003', 6, null),
        ('600004', 6, null),
        ('600005', 6, null),
        ('600006', 6, null),
        ('600007', 6, null),
        ('600008', 6, null),
        ('600009', 6, null),
        ('700001', 7, null),
        ('700002', 7, null),
        ('700003', 7, null),
        ('700004', 7, null),
        ('700005', 7, null),
        ('800001', 8, null),
        ('800002', 8, null),
        ('800003', 8, null),
        ('800004', 8, null),
        ('800005', 8, null),
        ('800006', 8, null),
        ('800007', 8, null),
        ('800008', 8, null),
        ('900001', 9, null),
        ('9000010', 9, null),
        ('900002', 9, null),
        ('900003', 9, null),
        ('900004', 9, null),
        ('900005', 9, null),
        ('900006', 9, null),
        ('900007', 9, null),
        ('900008', 9, null),
        ('900009', 9, null);


insert into novelnook.borrow (borrowid, userid, bookid, borrowtime, deadline, status)
values  ('059a45f9-af7b-4fe5-a0a8-3381f8f567cd', 3, 5, '2022-06-06', '2022-07-06', 'returned'),
        ('65745ace-c1ca-4e4b-ab3f-4ed863fbdd1a', 3, 2, '2022-06-21', '2022-07-21', 'borrowing'),
        ('b2bf094f-917a-44f3-b87c-296e591bf842', 3, 9, '2023-05-25', '2023-06-25', 'returned'),
        ('de26af4c-d6e0-42ce-8c6d-143ac032e1ed', 11, 11, '2023-03-09', '2023-04-09', 'borrowing'),
        ('ef07353a-daaa-4a43-9269-db9c2fdd8b4c', 11, 5, '2023-06-01', '2023-07-01', 'borrowing'),
        ('64891361-9a6e-4040-9dc1-329058f73079', 14, 1, '2023-06-02', '2023-07-02', 'returned'),
        ('749831d1-69d2-4438-a3e6-dc5de5bc57cb', 14, 7, '2023-02-16', '2023-03-16', 'returned');


insert into novelnook.returned (borrowid, returntime, fineamount, ispay)
values  ('059a45f9-af7b-4fe5-a0a8-3381f8f567cd', '2023-06-04', 668.00, 0),
        ('64891361-9a6e-4040-9dc1-329058f73079', '2023-06-04', 0.00, 1),
        ('749831d1-69d2-4438-a3e6-dc5de5bc57cb', '2023-06-04', 162.00, 0),
        ('b2bf094f-917a-44f3-b87c-296e591bf842', '2023-06-04', 0.00, 1);