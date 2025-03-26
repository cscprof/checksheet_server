<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\MajorController;
use App\Http\Controllers\MinorController;
use App\Http\Controllers\MyUserController;
use App\Http\Controllers\StudentController;
use App\Http\Controllers\CoreThemeController;
use App\Http\Controllers\SemesterController;
use App\Http\Controllers\CourseStatusController;
use App\Http\Controllers\CourseStudentController;

/**
 * Authentication Related
 */
Route::post('/auth/login', [MyUserController::class, 'login']);
Route::post('/auth/logout', [MyUserController::class, 'logout']);
Route::resource('users', MyUserController::class);

/**
 * Course Related Routes
 */
Route::get('/courses/major/{id}', [MajorController::class, 'majorCourses']);
Route::get('/courses/minor/{id}', [MinorController::class, 'minorCourses']);
Route::get('/courses/core', [CourseController::class, 'coreCourses']);
Route::resource('courses', CourseController::class);
Route::resource('corethemes', CoreThemeController::class);


/**
 * Student Related Routes
 */
Route::put('students', [StudentController::class, 'myUpdate']);
Route::resource('students', StudentController::class);

/**
 * Student to Course mappings
 */
Route::put('studentcourses', [CourseStudentController::class, 'myUpdate']);
Route::resource('studentcourses', CourseStudentController::class);

/**
 * Dropdown Routes
 */
Route::resource('majors', MajorController::class);
Route::resource('minors', MinorController::class);
Route::resource('semesters', SemesterController::class);
Route::resource('coursestatuses', CourseStatusController::class);


/**
 * Default Route
 */
Route::get('/', function () {
    return view('welcome');
});
