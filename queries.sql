-- Query 1
select
    b.booking_id,
    u.name as customer_name,
    v.vehicle_name,
    b.rent_start_date,
    b.rent_end_date,
    b.booking_status
from
    bookings as b
    inner join users as u on b.user_id = u.id
    inner join vehicles as v on b.vehicle_id = v.id;

-- Query 2
SELECT
    *
FROM
    Vehicles v
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            Bookings b
        WHERE
            b.vehicle_id = v.id
    );

-- Query 3
select
    *
from
    vehicles
where
    type = 'car'
    and availability_status = 'available';

-- Query 4
select
    v.vehicle_name,
    count(*) as total_bookings
from
    bookings as b
    join vehicles as v on b.vehicle_id = v.id
group by
    v.id,
    v.vehicle_name
having
    count(*) > 2;