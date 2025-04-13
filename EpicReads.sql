-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Aug 11, 2024 at 07:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `epic_reads`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `book_name` varchar(255) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` text DEFAULT NULL,
  `rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `book_name`, `author_name`, `quantity`, `category`, `price`, `img_url`, `added_at`, `description`, `rating`) VALUES
(2, 'Rich Dad Poor Dad', 'Robert T. Kiyosaki', 18, 'Finance', 1800.00, 'https://makeenbooks.com/upload/ga/9781612681139.jpg', '2024-08-10 05:36:26', 'An insightful guide on financial literacy and wealth building.', 4.7),
(3, 'Clean Code', 'Robert C. Martin', 22, 'Programming', 3600.00, 'https://m.media-amazon.com/images/I/413za4fzZLL.jpg', '2024-08-10 05:36:26', 'A handbook of agile software craftsmanship with practical advice.', 4.8),
(4, 'The Hobbit', 'J.R.R. Tolkien', 25, 'Fantasy', 2200.00, 'https://m.media-amazon.com/images/I/712cDO7d73L._AC_UF1000,1000_QL80_.jpg', '2024-08-10 05:36:26', 'A fantasy novel that follows the adventures of Bilbo Baggins.', 4.9),
(5, 'Intelligent Investor', 'Benjamin Graham', 16, 'Finance', 2900.00, 'https://store.goodreads.lk/wp-content/uploads/2021/10/9782156988579.jpg', '2024-08-10 05:36:26', 'A classic book on value investing and financial wisdom.', 4.8),
(6, 'JavaScript: The Good Parts', 'Douglas Crockford', 30, 'Programming', 2900.00, 'https://m.media-amazon.com/images/I/7185IMvz88L._AC_UF1000,1000_QL80_.jpg', '2024-08-10 05:36:26', 'A concise guide to the best features of JavaScript.', 4.7),
(7, 'A Song of Ice and Fire', 'George R.R. Martin', 14, 'Fantasy', 3400.00, 'https://upload.wikimedia.org/wikipedia/en/thumb/d/dc/A_Song_of_Ice_and_Fire_book_collection_box_set_cover.jpg/220px-A_Song_of_Ice_and_Fire_book_collection_box_set_cover.jpg', '2024-08-10 05:36:26', 'A series of epic fantasy novels with complex characters and plots.', 4.8),
(8, 'Your Money or Your Life', 'Vicki Robin', 12, 'Finance', 2100.00, 'https://images.blinkist.io/images/books/618d11f06cee070007adc7e9/1_1/470.jpg', '2024-08-10 05:36:26', 'A practical guide to transforming your relationship with money.', 4.6),
(9, 'The Pragmatic Programmer', 'Andrew Hunt and David Thomas', 25, 'Programming', 4200.00, 'https://pragprog.com/titles/tpp20/tpp20-large.jpg', '2024-08-10 05:36:26', 'A guide to best practices and techniques in programming.', 4.9),
(10, 'To Kill a Mockingbird', 'Christan Lee', 20, 'Fiction', 2500.00, 'https://media.glamour.com/photos/56e1f3c562b398fa64cbd310/master/w_1600%2Cc_limit/entertainment-2016-02-07-main.jpg', '2024-08-10 05:36:26', 'A novel about the serious issues of rape and racial inequality.', 4.9),
(18, 'Harry Potter', 'Joyson', 3, 'Fantasy', 1999.00, 'https://i.pinimg.com/736x/2f/44/ef/2f44effc1b43a4a24cf5188c92ab9944.jpg', '2024-08-10 21:53:21', 'sdfasfewf efefewrge gewrgewrgwergwe gw ergwerw', 0),
(19, 'CSS Mastery', 'Mishaf', 3, 'Programming', 1200.00, 'https://media.springernature.com/full/springer-static/cover-hires/book/978-1-4302-5864-3?as=webp', '2024-08-11 08:56:10', 'Fully updated to the latest CSS modules, make the journey to CSS mastery as simple and painless as possible. This book dives into advanced aspects of CSS-based design, such as responsive design, modular CSS, and CSS typography. Through a series of easy-to-follow tutorials, you will learn practical CSS techniques you can immediately start using in your daily work.', 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Completed') DEFAULT 'Pending',
  `shipping_address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`, `shipping_address`) VALUES
(16, 2, '2024-08-10 11:52:53', 29.97, 'Pending', '123 Elm Street, Springfield'),
(18, 3, '2024-08-10 11:52:53', 19.98, 'Pending', '789 Pine Road, Capital City'),
(19, 4, '2024-08-10 11:52:53', 12.98, 'Pending', '321 Maple Street, Springfield'),
(20, 5, '2024-08-10 11:52:53', 22.98, 'Pending', '654 Cedar Avenue, Shelbyville'),
(21, 6, '2024-08-10 11:52:53', 15.99, 'Pending', '987 Birch Lane, Capital City'),
(22, 2, '2024-08-10 11:52:53', 39.98, 'Completed', '135 Walnut Street, Springfield'),
(23, 8, '2024-08-10 11:52:53', 31.98, 'Pending', '246 Spruce Avenue, Shelbyville'),
(24, 9, '2024-08-10 11:52:53', 20.49, 'Completed', '369 Elm Street, Capital City'),
(25, 2, '2024-08-10 11:52:53', 28.49, 'Pending', '741 Oak Avenue, Springfield'),
(26, 1, '2024-08-10 11:52:53', 11.99, 'Pending', '852 Pine Road, Shelbyville'),
(28, 3, '2024-08-10 11:52:53', 8.99, 'Pending', '741 Cedar Avenue, Springfield'),
(31, 2, '2024-08-11 17:15:57', 3600.00, 'Pending', 'Puttalam'),
(32, 2, '2024-08-11 17:16:55', 3600.00, 'Pending', 'Puttalam'),
(33, 26, '2024-08-11 17:22:17', 3600.00, 'Pending', 'Mannar');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `firstName`, `lastName`, `username`, `password`) VALUES
(1, 'Joyson', 'Joy', 'joyson@gmail.com', 'e10adc3949ba59abbe56e057f20f883e'),
(2, 'Renoson', 'Reno', 'reno@gmail.com', 'e10adc3949ba59abbe56e057f20f883e'),
(3, 'Saru', 'saru', 'saru@gamil.com', 'e10adc3949ba59abbe56e057f20f883e'),
(4, 'Mishaf', 'Hasan', 'mishaf1106@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password`, `role`) VALUES
(1, 'EpicReads', 'Admin', 'admin@admin.com', '81dc9bdb52d04dc20036dbd8313ed055', 'admin'),
(2, 'Mishaf', 'Hasan', 'mishaf1106@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'customer'),
(3, 'Alice', 'Johnson', 'alicejohnson', 'password123', 'customer'),
(4, 'Bob', 'Brown', 'bobbrown', 'password123', 'customer'),
(5, 'Charlie', 'Davis', 'charliedavis', 'password123', 'customer'),
(6, 'Diana', 'Wilson', 'dianawilson', 'password123', ''),
(7, 'Eve', 'Taylor', 'evetaylor', 'password123', ''),
(8, 'Frank', 'Moore', 'frankmoore', 'password123', ''),
(9, 'Grace', 'Lee', 'gracelee', 'password123', ''),
(10, 'Henry', 'Anderson', 'henryanderson', 'password123', ''),
(12, 'R', 'Hasan', 'rvomva@hi2.in', 'c4ca4238a0b923820dcc509a6f75849b', ''),
(19, 'Chris', 'Cone', 'cone@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', ''),
(24, 'Saru', 'Punda', 'saru@gmail.com', '7813d1590d28a7dd372ad54b5d29d033', 'customer'),
(26, 'Christan', 'Sunni', 'rvo@hi2.in', 'b59c67bf196a4758191e42f76670ceba', 'customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_users` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_items_orders` (`order_id`),
  ADD KEY `fk_order_items_books` (`book_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
