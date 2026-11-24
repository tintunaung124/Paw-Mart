<?php

$host = getenv("DB_HOST");
$user = getenv("DB_USER");
$password = getenv("DB_PASSWORD");
$database = getenv("DB_NAME");

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    exit("Database connection failed.");
}