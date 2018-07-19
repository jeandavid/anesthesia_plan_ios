# Anesthesia Plans

![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)

This app showcases some of the `MVVM` architecture principles.

## Features

This app contains three screens: a main screen that lists all the plans, a plan detail screen and a screen to add or edit a plan.
The data is persisted on the device using CoreData.

### Presentation Layer

The presentation layer uses a `MVVM` architecture.

Each screen consists of:
* a ViewController that handles the navigation and displays the data.
* a View Model that exposes data to the ViewController using optional callback closures.

In addition, each screen view delegates some of its responsibilities to child container views. For example, the EditPlan view
includes a child PageViewController that pages through the list of questions.

### Data Layer

The database is created using CoreData and has five entities:
* a `Plan` entity that has a one-to-many relationship to questions.
* a `Question` entity that can either be a multi-choice or free-text.
* a `MultiChoice` entity that has a one-to-many relationship to choices.
* a `FreeText` entity.
* a `Choice` entity.

To keep data synchronization across screens as easy as possible, created or updated plans + questions + choices are immediately saved on context.
Deleted objects might need to wait for the application to enter background before the changes being persisted into the store.

## Live Version

[On Apple Store](https://itunes.apple.com/il/app/eli7/id1380037770?mt=8)
