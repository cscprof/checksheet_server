<?php

namespace App\Http\Controllers;

use App\Models\Minor;
use Illuminate\Http\Request;

class MinorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $minors = Minor::all();
        return $minors;
    }

    public function minorCourses($id)
    {
        return Minor::with('courses')
            ->where("minor_id", $id)
            ->get();
    }
}
