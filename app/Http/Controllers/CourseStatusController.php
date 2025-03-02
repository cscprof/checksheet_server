<?php

namespace App\Http\Controllers;

use App\Models\CourseStatus;
use Illuminate\Http\Request;

class CourseStatusController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return CourseStatus::all();
    }


}
