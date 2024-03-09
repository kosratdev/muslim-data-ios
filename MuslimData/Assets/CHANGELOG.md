# Muslim Data DB Change Log
All notable changes to the MuslimData database will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.0.0] - 2024-03-09

Refactor database tables to improve table nomalization and handle city mapper in the database level.

### Added
- `country_id` as a foriegn key added to the `location` (or `city`) table to make a relation with `country` table.
- `prayer_dependent_id` field added to the `location` table to handle city mapper in the database level. 
- `location_id` as a foriegn key added to the `prayer_time` table to make a relation with `location` table.
 
### Changed
- `city` table name has been renamed to `location`. 
- `country_code` has been removed in the `location` table and the `country_id` field is used for the relationship between `location` and `country` tables.
- The `city` field in the `location` table has been renamed to `name` as it holds different types of locations like governorate, city, sub-city, village, etc. 
- `country` table fields have been refactored by removing the country suffix before the fields.
- `country_code` and `city` fields have been removed in the `prayer_time` table and used `location_id` to make the relationship between `prayer_time` and `location` tables.
- Database indices have been refactored as shown blow: 
    - `country` table has `code` and `name` indices. 
    - `location` table has `name`, `country_id`, `prayer_dependent_id`, `latitude`, `longitude`, `has_fixed_prayer_time` indices
    - `prayer_time` table has `date`, `location_id` indices.


## [1.5.0] - 2024-03-04

Update Chamchamal prayer times. 

### Changed
- Chamchamal, IQ prayer times have been updated.

## [1.4.2] - 2024-03-01

Bug fixes.

### Fixed
- Fix Sanandaj, IR prayer time at 29 Feb which was added as 02-01. 

## [1.4.1] - 2024-02-28

Bug fixes.

### Fixed
- Fix Chamchamal, IQ prayer time at 29 Feb which was added as 02-01. 

## [1.4.0] - 2024-02-18

Update Sulaymaniyah governorate prayer times. 

### Added
- Kalar, IQ prayer times have been added as a separate list with old Suli data. 
- Hero, IQ added to the city table. 
- Bngrd, IQ added to the city table.
- Dokan, IQ prayer times have been added to the prayer time table.
- Khanaqin, IQ prayer times have been added to the prayer time table.
- Penjwen, IQ prayer times have been added to the prayer time table.
- Gokhlan, IQ prayer times have been added to the prayer time table.

### Changed
- Sulaymaniyah, IQ prayer times have been updated.
- Qaladiza, IQ prayer times have been updated. 
- Qadir Karam removed from fixed prayer times.
- Ranya, IQ prayer times have been updated.
- Darbandikhan, IQ prayer times have been udpated.
 
## [1.3.3] - 2024-02-17
 
Add Qasre location to the MuslimData library. 
 
### Added
- Add Qasre location to the city table. 
- Add Qasre prayer times to the prayer time table.
 
## [Sample Data] - yyyy-mm-dd
 
Here we write upgrading notes for brands. It's a team effort to make them as
straightforward as possible.
 
### Added
-
- 
 
### Changed
-
-
 
### Fixed
-
-
