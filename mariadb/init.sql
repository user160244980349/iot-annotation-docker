CREATE USER iot_annotation IDENTIFIED BY 'secret';
CREATE DATABASE iot_annotation;
GRANT ALL PRIVILEGES ON iot_annotation.* TO iot_annotation;
USE iot_annotation;

-- Migrations --
CREATE TABLE `users` (
    `id`    INT PRIMARY KEY AUTO_INCREMENT,
    `name`  VARCHAR(255) UNIQUE NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `passwords` (
    `id`    INT PRIMARY KEY DEFAULT 0,
    `value` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`id`) REFERENCES `users`(`id`)
);

CREATE TABLE `groups` (
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `permissions` (
    `id`  INT PRIMARY KEY AUTO_INCREMENT,
    `for` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `group_user` (
    `id`       INT PRIMARY KEY AUTO_INCREMENT,
    `group_id` INT NOT NULL,
    `user_id`  INT NOT NULL,
    FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
    FOREIGN KEY (`user_id`)  REFERENCES `users`(`id`),
    UNIQUE (`group_id`, `user_id`)
);

CREATE TABLE `group_permission` (
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `group_id`      INT NOT NULL,
    `permission_id` INT NOT NULL,
    FOREIGN KEY (`group_id`)      REFERENCES `groups`(`id`),
    FOREIGN KEY (`permission_id`) REFERENCES `permissions`(`id`),
    UNIQUE (`group_id`, `permission_id`)
);

CREATE TABLE `policies` (
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `hash`      VARCHAR(255) UNIQUE NOT NULL,
    `requested` INT DEFAULT 0,
    `content`   MEDIUMTEXT
);

CREATE TABLE `products` (
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `manufacturer` VARCHAR(255),
    `keyword`      VARCHAR(255),
    `product_url`  MEDIUMTEXT,
    `website_url`  MEDIUMTEXT,
    `policy_url`   VARCHAR(255),
    `policy_hash`  VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (`policy_hash`) REFERENCES `policies`(`hash`)
);

CREATE TABLE `selections` (
    `id`                INT PRIMARY KEY AUTO_INCREMENT,
    `starts_on`         INT,
    `ends_on`           INT,
    `selection_class`   VARCHAR(255) NOT NULL,
    `selection_content` MEDIUMTEXT,
    `user_id`           INT,
    `policy_hash`       VARCHAR(255) DEFAULT NULL,
    `created_at`        DATETIME DEFAULT NOW(),
    FOREIGN KEY (`user_id`)     REFERENCES `users`(`id`),
    FOREIGN KEY (`policy_hash`) REFERENCES `policies`(`hash`)
);

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

INSERT INTO `group_permission` (
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