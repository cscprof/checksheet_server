<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\MajorController;
use App\Http\Controllers\MinorController;

Route::resource('courses', CourseController::class);
Route::resource('majors', MajorController::class);
Route::resource('majors', MinorController::class);



Route::get('/', function () {
    return view('welcome');
});
