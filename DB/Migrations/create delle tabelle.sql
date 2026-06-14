DROP TABLE IF EXISTS `product_category`;
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;


CREATE TABLE `products`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `availability` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
		ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(150) NOT NULl UNIQUE
);
CREATE TABLE `reviews`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `valutation` DECIMAL(2, 1) NOT NULL,
    `text` TEXT NOT NULL,
    `id_product` BIGINT UNSIGNED,
    `author` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL
);
CREATE TABLE `product_category`(
    `id_product` BIGINT UNSIGNED NOT NULL,
    `id_category` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(`id_product`, `id_category`)
);
ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_id_product_foreign` FOREIGN KEY(`id_product`) REFERENCES `products`(`id`)
    ON DELETE CASCADE;
ALTER TABLE
    `reviews` ADD CONSTRAINT `reviews_id_product_foreign` FOREIGN KEY(`id_product`) REFERENCES `products`(`id`)
    ON DELETE SET NULL;
ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_id_category_foreign` FOREIGN KEY(`id_category`) REFERENCES `categories`(`id`)
    ON DELETE CASCADE;
    
    
