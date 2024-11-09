-- Creación de la base de datos
-- CREATE DATABASE streaming_project;


-- Tabla: users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_of_registration DATE NOT NULL,
    country VARCHAR(100),
    preferences VARCHAR(255),
    user_type VARCHAR(50) CHECK (user_type IN ('consumer', 'content_creator', 'moderator', 'admin')),
    recommendation_system VARCHAR(50) CHECK (recommendation_system IN ('Recomendeitor', 'Recomendeitor_Plus'))
);

-- Tabla: content
CREATE TABLE content (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    duration INTEGER CHECK (duration > 0),
    content_type VARCHAR(50) CHECK (content_type IN ('movie', 'series', 'documentary', 'short', 'live')),
    rating DECIMAL(2,1) CHECK (rating BETWEEN 1 AND 5)
);

-- Tabla: genres
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Tabla: content_genres (relación entre contenido y géneros)
CREATE TABLE content_genres (
    content_id INTEGER REFERENCES content(id),
    genre_id INTEGER REFERENCES genres(id),
    PRIMARY KEY (content_id, genre_id)
);

-- Tabla: views
CREATE TABLE views (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    content_id INTEGER REFERENCES content(id),
    view_date DATE NOT NULL,
    duration_viewed INTEGER CHECK (duration_viewed > 0),
    recommendation_system VARCHAR(50) CHECK (recommendation_system IN ('Recomendeitor', 'Recomendeitor_Plus'))
);

-- Tabla: recommendations
CREATE TABLE recommendations (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    content_id INTEGER REFERENCES content(id),
    recommended_by VARCHAR(50) CHECK (recommended_by IN ('Recomendeitor', 'Recomendeitor_Plus')),
    recommendation_date DATE NOT NULL
);

-- Tabla: user_interactions
CREATE TABLE user_interactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    content_id INTEGER REFERENCES content(id),
    interaction_type VARCHAR(50) CHECK (interaction_type IN ('like', 'comment', 'share', 'favorite')),
    interaction_date DATE NOT NULL
);

-- Tabla: search_history
CREATE TABLE search_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    search_term VARCHAR(255) NOT NULL,
    search_date DATE NOT NULL
);

-- Tabla: favorites
CREATE TABLE favorites (
    user_id INTEGER REFERENCES users(id),
    content_id INTEGER REFERENCES content(id),
    PRIMARY KEY (user_id, content_id)
);

-- Tabla: comments
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    content_id INTEGER REFERENCES content(id),
    comment_text TEXT,
    comment_date DATE NOT NULL
);

-- Tabla: awards
CREATE TABLE awards (
    id SERIAL PRIMARY KEY,
    content_id INTEGER REFERENCES content(id),
    award_name VARCHAR(255) NOT NULL,
    award_date DATE NOT NULL
);

-- Tabla: tags
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Tabla: content_tags (relación entre contenido y etiquetas)
CREATE TABLE content_tags (
    content_id INTEGER REFERENCES content(id),
    tag_id INTEGER REFERENCES tags(id),
    PRIMARY KEY (content_id, tag_id)
);