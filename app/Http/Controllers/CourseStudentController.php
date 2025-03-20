<?php

namespace App\Http\Controllers;

use App\Models\CourseStudent;
use App\Models\User;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class CourseStudentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $token = $request->header('x-token');

        return CourseStudent::with('student')
            ->with('course')
            ->with('courseStatus')
            ->with('semester')
            ->whereHas('student', function($q) use($token){
                $q->where('account_guid','=',$token);
            })
            ->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $token = $request->header('x-token');

        // Verify GUID is valid
        try {
            $id = User::where('user_guid', $token)->firstOrFail();
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        // Create the new student
        $data = $request->json()->all();

        $courseStudent = new CourseStudent();
        if (array_key_exists('student_id', $data)) $courseStudent->student_id = $data['student_id'];
        if (array_key_exists('course_id', $data)) $courseStudent->course_id = $data['course_id'];
        if (array_key_exists('grade', $data)) $courseStudent->grade = $data['grade'];
        if (array_key_exists('course_status_id', $data)) $courseStudent->course_status_id = $data['course_status_id'];
        if (array_key_exists('semester_id', $data)) $courseStudent->semester_id = $data['semester_id'];
        if (array_key_exists('year', $data)) $courseStudent->year = $data['year'];
        $courseStudent->save();

        return $courseStudent->course_student_id;
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request)
    {
        $token = $request->header('x-token');

        $id = $request->studentcourse;
        return CourseStudent::with('student')
            ->with('course')
            ->with('courseStatus')
            ->with('semester')
            ->whereHas('student', function($q) use($token){
                $q->where('account_guid','=',$token);
            })
            ->where('student_id', $id)
            ->get();
    }

    /**
     * Update the specified resource in storage.
     */
    public function myUpdate(Request $request)
    {
        $data = $request->all();

        $courseStudent = CourseStudent::find($data['course_student_id'], 'course_student_id');
        if (array_key_exists('student_id', $data)) $courseStudent->student_id = $data['student_id'];
        if (array_key_exists('course_id', $data)) $courseStudent->course_id = $data['course_id'];
        if (array_key_exists('grade', $data)) $courseStudent->grade = $data['grade'];
        if (array_key_exists('course_status_id', $data)) $courseStudent->course_status_id = $data['course_status_id'];
        if (array_key_exists('semester_id', $data)) $courseStudent->semester_id = $data['semester_id'];
        if (array_key_exists('year', $data)) $courseStudent->year = $data['year'];
        $courseStudent->save();

        return;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {

    }
}
