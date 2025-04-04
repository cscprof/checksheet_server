<?php

namespace App\Http\Controllers;

use App\Models\Major;

use Illuminate\Http\Request;

class MajorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Major::all();
    }

    public function majorCourses($id)
    {
        return Major::with('courses')
            ->where("major_id", $id)
            ->get();
    }

    public function majorCoursesWithPrereqs($id)
    {
        return Major::with('courses')
            ->with('courses.prereqs')
            ->with('courses.prereqsOf')
            ->where("major_id", $id)
            ->get();
    }


}
