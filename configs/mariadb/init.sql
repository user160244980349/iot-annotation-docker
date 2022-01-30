CREATE USER iot_annotation IDENTIFIED BY 'secret';
CREATE DATABASE iot_annotation;
GRANT ALL PRIVILEGES ON iot_annotation.* TO iot_annotation;
USE iot_annotation;

CREATE TABLE `users` (
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `name`      VARCHAR(255) UNIQUE,
    `email`     VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `passwords` (
    `id`     INT PRIMARY KEY DEFAULT 0,
    `value`  VARCHAR(255) NOT NULL,
    FOREIGN KEY (id) REFERENCES `users`(id)
);

CREATE TABLE `groups` (
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `name`      VARCHAR(255)
);

CREATE TABLE `permissions` (
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `for`       VARCHAR(255)
);

CREATE TABLE `group_user` (
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `group_id`  INT,
    `user_id`   INT,
    FOREIGN KEY (group_id)    REFERENCES `groups`(id),
    FOREIGN KEY (user_id)     REFERENCES `users`(id)
);

CREATE TABLE `group_permission` (
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `group_id`      INT,
    `permission_id` INT,
    FOREIGN KEY (group_id)        REFERENCES `groups`(id),
    FOREIGN KEY (permission_id)   REFERENCES `permissions`(id)
);

CREATE TABLE `texts` (
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `url`           MEDIUMTEXT,
    `manufacturer`  VARCHAR(256),
    `keyword`       VARCHAR(256),
    `website`       MEDIUMTEXT,
    `policy`        VARCHAR(256),
    `policy_hash`   VARCHAR(256),
    `content`       MEDIUMTEXT
);

-- CREATE TABLE `selections` (
--     `id`                    INT PRIMARY KEY AUTO_INCREMENT,
--     `starts_on`             INT,
--     `ends_on`               INT,
--     `text_id`               INT,
--     `parent_id`             INT DEFAULT 0,
--     `selection_class`       VARCHAR(255) NOT NULL,
--     FOREIGN KEY (text_id)             REFERENCES `texts`(id),
--     FOREIGN KEY (parent_id)           REFERENCES `selections`(id)
-- );

-- CREATE TABLE `user_selection` (
--     `id` INT PRIMARY KEY AUTO_INCREMENT,
--     `user_id`                       INT,
--     `selection_id`                  INT,
--     FOREIGN KEY (user_id)         REFERENCES `users`(id),
--     FOREIGN KEY (selection_id)    REFERENCES `selections`(id)
-- );

-- Seeds --
INSERT INTO `users` (
    `name`,
    `email` 
) VALUES
('Admin', 'admin@iot_annotation.box');

INSERT INTO `passwords` (
    `id`, 
    `value`
) VALUES
(1, MD5(MD5('secret')));

INSERT INTO `groups` (
    `name`
) VALUES
('Authenticated'),
('Administrator');

INSERT INTO `permissions` (
    `for`
) VALUES
('visit-home'),
('manage-users'),
('manage-groups'),
('manage-data');

INSERT INTO group_permission (
    `group_id`,
    `permission_id`
) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4);

INSERT INTO `group_user` (
    `group_id`,
    `user_id`
) VALUES
(1, 1),
(2, 1);