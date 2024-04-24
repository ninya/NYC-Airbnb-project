
--Most Popular Neighborhoods for Short-Term Rentals
SELECT neighbourhood, COUNT(*) AS total_listings
FROM prices
GROUP BY neighbourhood
ORDER BY total_listings DESC;
--Average Rental Price by Neighborhood and Property Type
SELECT p.neighbourhood, r.room_type, AVG(p.price) AS average_price
FROM prices p
JOIN room_types r ON p.listing_id = r.listing_id
GROUP BY p.neighbourhood, r.room_type
ORDER BY p.neighbourhood, average_price DESC;


--Most Commonly Rented Property Types
SELECT room_type, COUNT(*) AS count
FROM room_types
GROUP BY room_type
ORDER BY count DESC;

SELECT neighbourhood, room_type, COUNT(*) AS count
FROM room_types rt
JOIN prices p ON rt.listing_id = p.listing_id
GROUP BY neighbourhood, room_type
ORDER BY neighbourhood, count DESC;

-- Average Length of Stay
SELECT p.neighbourhood, AVG(r.minimum_nights) AS average_minimum_nights
FROM reviews r
JOIN prices p ON r.listing_id = p.listing_id
GROUP BY p.neighbourhood;

SELECT p.neighbourhood, rt.room_type, AVG(r.minimum_nights) AS average_minimum_nights
FROM reviews r
JOIN prices p ON r.listing_id = p.listing_id
JOIN room_types rt ON r.listing_id = rt.listing_id
GROUP BY p.neighbourhood, rt.room_type;

--Seasonal Trends in Demand
SELECT 
    EXTRACT(YEAR FROM TO_DATE(last_review, 'DD/MM/YYYY')) AS year, 
    EXTRACT(MONTH FROM TO_DATE(last_review, 'DD/MM/YYYY')) AS month, 
    COUNT(*) AS number_of_reviews
FROM reviews
GROUP BY year, month
ORDER BY year, month;
