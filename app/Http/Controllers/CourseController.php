<?php

namespace App\Http\Controllers;

use App\Models\Course;
use App\Models\CoreCourse;
use Illuminate\Http\Request;

class CourseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Course::
            with('prereqs')
            ->with('prereqsOf')
            ->get();
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request)
    {

        $id = $request->course;
        $course = Course::
        where('course_id', '=', $id)
            ->with('prereqs')
            ->with('prereqsOf')
            ->get();

        return $course;
    }

    /**
     * Display core Courses
     *
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function coreCourses()
    {
        $courses = CoreCourse::with('theme')
            ->with('course')
            ->get();

        // dd($courses);

        return $courses;
    }



}
