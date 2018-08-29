drop database if exists lahacks;
create database lahacks;
use lahacks;

create table users (
	username varchar(20) not null,
	-- bcrypt unique salt for each user
	password varchar(60) not null,
	primary key (username)
);

create table categories (
	name varchar(30) not null,
	primary key (name)
);

create table posts (
	postID int auto_increment,
	title varchar(150) not null,
	description varchar(140),
	username varchar(20) not null,
	category varchar(30) not null,
	imgAddress varchar(200) not null,
	at datetime not null default CURRENT_TIMESTAMP,

	primary key (postID),
	foreign key (username) references users(username),
	foreign key (category) references categories(name)
);

create table postLikes (
	username varchar(20) not null,
	postID int not null,
	likeState bit not null,
	at datetime not null default CURRENT_TIMESTAMP,
	primary key (username, postID),
	foreign key (username) references users(username),
	foreign key (postID) references posts(postID)
);

-- comments also going to handle replies with depth and parentID
-- now going with max depth of 2 to avoid overdesigning
create table comments (
	commentID int auto_increment,

-- need trigger to prevent insert if commentID = parentID
	parentID int default null,

-- need to create trigger, on add, check if item has parent, if it does +=1 to depth

	username varchar(20) not null,
	postID int,
	content varchar(10000) not null,
	at datetime not null default CURRENT_TIMESTAMP,
	primary key (commentID),
	foreign key (parentID) references comments(commentID),
	foreign key (username) references users(username),
	foreign key (postID) references posts(postID)
);
