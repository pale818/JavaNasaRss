

CREATE LOGIN sa1 WITH PASSWORD = 'SQL';
GO

CREATE USER sa1 FOR LOGIN sa1;
GO

EXEC sp_addrolemember 'db_owner', 'sa1';
GO

USE ARTICLES;
GO

-- 1. Drop the existing table if it exists
IF OBJECT_ID('Article', 'U') IS NOT NULL
    DROP TABLE Article;
GO

-- 2. Create the 'Article' table to match the Java code (NO guid)
CREATE TABLE Article (
    IDArticle INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255),
    Link NVARCHAR(512),
    Description NVARCHAR(MAX),
    PicturePath NVARCHAR(512),
    PublishedDate NVARCHAR(100)
);
GO


--------------------------------------------------------------------------------
-- 3. Create the 'createArticle' procedure to match the Java code (6 parameters)
--------------------------------------------------------------------------------
IF OBJECT_ID('createArticle', 'P') IS NOT NULL
    DROP PROCEDURE createArticle;
GO

CREATE PROCEDURE createArticle
    @Title          NVARCHAR(255),
    @Link           NVARCHAR(512),
    @Description    NVARCHAR(MAX),
    @PicturePath    NVARCHAR(512),
    @PublishedDate  NVARCHAR(100),
    @IDArticle      INT OUTPUT
AS
BEGIN
    INSERT INTO Article (Title, Link, Description, PicturePath, PublishedDate)
    VALUES (@Title, @Link, @Description, @PicturePath, @PublishedDate);
    
    SET @IDArticle = SCOPE_IDENTITY();
END
GO


-- NOTE: Your other procedures for update, delete, and select already match this structure
-- and do not need to be changed.
--------------------------------------------------------------------------------
-- 4. Procedure to UPDATE an article by its ID
-- Updated to use the 'Article' table.
--------------------------------------------------------------------------------
IF OBJECT_ID('updateArticle', 'P') IS NOT NULL
    DROP PROCEDURE updateArticle;
GO

CREATE PROCEDURE updateArticle
    @IDArticle      INT,
    @Title          NVARCHAR(255),
    @Link           NVARCHAR(512),
    @Description    NVARCHAR(MAX),
    @PicturePath    NVARCHAR(512),
    @PublishedDate  NVARCHAR(100)
AS
BEGIN
    UPDATE Article SET
        Title = @Title,
        Link = @Link,
        Description = @Description,
        PicturePath = @PicturePath,
        PublishedDate = @PublishedDate
    WHERE
        IDArticle = @IDArticle;
END
GO

--------------------------------------------------------------------------------
-- 5. Procedure to DELETE an article by its ID
-- Updated to use the 'Article' table.
--------------------------------------------------------------------------------
IF OBJECT_ID('deleteArticle', 'P') IS NOT NULL
    DROP PROCEDURE deleteArticle;
GO

CREATE PROCEDURE deleteArticle
    @IDArticle INT
AS
BEGIN
    DELETE FROM Article
    WHERE IDArticle = @IDArticle;
END
GO

IF OBJECT_ID('deleteArticles', 'P') IS NOT NULL
    DROP PROCEDURE deleteArticles;
GO

CREATE PROCEDURE deleteArticles
AS
BEGIN
    DELETE FROM Article
END
GO




--------------------------------------------------------------------------------
-- 6. Procedure to SELECT a single article by its ID
-- Updated to use the 'Article' table.
--------------------------------------------------------------------------------
IF OBJECT_ID('selectArticle', 'P') IS NOT NULL
    DROP PROCEDURE selectArticle;
GO

CREATE PROCEDURE selectArticle
    @IDArticle INT
AS
BEGIN
    SELECT
        IDArticle,
        Title,
        Link,
        Description,
        PicturePath,
        PublishedDate
    FROM
        Article
    WHERE
        IDArticle = @IDArticle;
END
GO

--------------------------------------------------------------------------------
-- 7. Procedure to SELECT all articles
-- Updated to use the 'Article' table.
--------------------------------------------------------------------------------
IF OBJECT_ID('selectArticles', 'P') IS NOT NULL
    DROP PROCEDURE selectArticles;
GO

CREATE PROCEDURE selectArticles
AS
BEGIN
    SELECT
        IDArticle,
        Title,
        Link,
        Description,
        PicturePath,
        PublishedDate
    FROM
        Article;
END
GO




CREATE TABLE NewsFeedUser (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    IsAdmin BIT DEFAULT 1
);

INSERT INTO NewsFeedUser (username, PasswordHash, isAdmin)
VALUES ('admin', '$2a$10$I29jep6QDJpHiesPJCfegeytVB/Q9xcC1qRSriJKcq68LlUuQndvK', 1);

INSERT INTO NewsFeedUser (username, PasswordHash, isAdmin)
VALUES ('user', '$2a$10$c7Y9T1O0j0wQCGL8BwZpeuUH2FB8jnr06dkVTMOTx2uLrsZEJBS3G', 0);


-- Hashed admin password: $2a$10$I29jep6QDJpHiesPJCfegeytVB/Q9xcC1qRSriJKcq68LlUuQndvK   / admin123
-- Hashed user password: $2a$10$c7Y9T1O0j0wQCGL8BwZpeuUH2FB8jnr06dkVTMOTx2uLrsZEJBS3G    / user123
--------------------------------------------------------------------------------
-- 6. Procedure to SELECT user
--------------------------------------------------------------------------------
IF OBJECT_ID('selectUser', 'P') IS NOT NULL
    DROP PROCEDURE selectUser;
GO

CREATE PROCEDURE selectUser
    @UserName NVARCHAR(255)
AS
BEGIN
    SELECT
        UserId,
		UserName,
        PasswordHash,
        IsAdmin
    FROM
        NewsFeedUser
    WHERE
        UserName = @UserName;
END
GO

EXEC selectUser @UserName = 'user';





select * from Article

select * from NewsFeedUser

delete  Article