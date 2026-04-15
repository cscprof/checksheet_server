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

    public function store(Request $request)
    {
        $token = $request->header('x-token');

        // Verify GUID is valid
//        try {
//            $id = MyUser::where('user_guid', $token)->firstOrFail();
//        } catch (ModelNotFoundException $exception) {
//            return response()->json([
//                'error' => 'Unauthorized'
//            ], 401);
//        }

        // Create the new student major
        $data = $request->json()->all();

        $major = new Major();

        if (array_key_exists('major_name', $data)) $major->major_name = $data['major_name'];
        if (array_key_exists('major_abbreviation', $data)) $major->major_abbreviation = $data['major_abbreviation'];

        $major->save();

        return $major->major_id;
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
