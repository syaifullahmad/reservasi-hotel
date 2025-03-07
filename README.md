<<<<<<< HEAD

# Hotel Seadanya

This comprehensive hotel web application, developed using the Laravel V8 framework, offers a seamless journey from reservation to payment completion. With its intuitive interface and robust features, users can effortlessly browse available rooms, make reservations for their desired dates, manage bookings, and complete secure payments, all within a single platform. Built with a focus on user experience and efficiency, this application streamlines the entire hotel booking process for both guests and administrators, enhancing the overall experience for all stakeholders involved



## Features

- **Room Availability Search**: Users can search for room availability based on check-in dates, number of guests, and other preferences such as room type or amenities.
- **Room Descriptions**: Detailed information about each available room type, including photos, amenities, bed sizes, and pricing.
- **Room Reservation**: The ability to book rooms directly through the website by selecting check-in dates, number of rooms, and entering contact information.
- **Reservation Confirmation**: Users receive an email or confirmation message after successfully booking a room with details of their reservation.
- **Cancellation and Reservation Changes**: Feature allowing users to cancel or modify their reservations, with appropriate cancellation policies.
- **Payment Options**: Providing various convenient payment methods, such as credit cards, bank transfers, or cash payment upon arrival.
- **Calendar Integration**: Users can add their reservation details to their digital calendars to keep track of their stay dates.

## Screenshoots

![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/1.png)
![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/2.png)
![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/3.png)
![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/4.png)
![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/5.png)
![image](https://raw.githubusercontent.com/syaifullahmad/reservasi-hotel/e88a6cdfaa2423ff13c3c9151ee6ea49505eadf6/public/images/6.png)


## Tech Stack

**Framework:** Laravel, Bootstrap

**Database:** MySQL or sqlite


## Run Locally


[Download .zip file](https://github.com/syaifullahmad/reservasi-hotel/archive/refs/heads/main.zip) and extract to your folder

OR

Clone the project


```bash
  cd your-folder
  git clone https://github.com/syaifullahmad/reservasi-hotel.git
```

Go to the project directory

```bash
  cd hotel-reservasi
```

Install Packages

```bash
  composer install
```
Copy .env.example to .env

```bash
  cp .env.example .env
```
Generate AppKey

```bash
  php artisan key:generate
```

Create a new database your-database-name
Open .env on your code editor and set the .env database config

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your-database-name
DB_USERNAME=root
DB_PASSWORD=
```

Migrate project to generate table

```bash
  php artisan migrate
```
After creating a table, we'll seeding database, run seed command

```bash
  php artisan db:seed
```
Run project

```bash
  php artisan serve
```

open your project locally : http://localhost/8000 (port and host adjust)


## Authors

- [@syaifullahmad](https://www.github.com/syaifullahmad)


>>>>>>> 933c22a (perubahan pertama)
