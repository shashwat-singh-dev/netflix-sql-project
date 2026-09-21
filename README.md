# 🎬 Netflix Movies & TV Shows Data Analysis Using SQL

![Netflix](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## 📌 Overview

This project focuses on analyzing the **Netflix Movies and TV Shows dataset using SQL and PostgreSQL**.

The objective of this project is to practice SQL concepts through real-world business questions and extract meaningful insights from Netflix's content catalog.

The analysis covers:

- Content distribution between Movies and TV Shows
- Ratings and genres
- Countries producing Netflix content
- Release years and content trends
- Movie and TV Show durations
- Directors and actors
- Indian content analysis
- Keyword-based content categorization

---

## 🎯 Objectives

The main objectives of this project are:

- Analyze the distribution of Movies and TV Shows on Netflix.
- Identify the most common ratings for different content types.
- Find content based on release years.
- Identify countries with the highest amount of Netflix content.
- Analyze movie durations and TV Show seasons.
- Explore genres and content categories.
- Analyze Indian content and actors.
- Find content based on directors and actors.
- Categorize content using keywords from descriptions.
- Practice SQL functions such as `GROUP BY`, `ORDER BY`, `COUNT`, `UNNEST`, `STRING_TO_ARRAY`, `CASE`, `EXTRACT`, and date functions.

---

## 📊 Dataset

The dataset used in this project is the **Netflix Movies and TV Shows dataset** available on Kaggle.

**Source:**  
https://www.kaggle.com/datasets/shivamb/netflix-shows

The dataset contains information about Netflix movies and TV shows, including:

- Show ID
- Type
- Title
- Director
- Cast
- Country
- Date Added
- Release Year
- Rating
- Duration
- Genre
- Description

---

## 🗃️ Database Schema

The dataset was imported into PostgreSQL using the following table structure:

```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

## 💡 Business Problems & Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
    type,
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;
