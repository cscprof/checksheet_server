<?php

namespace App\Http\Controllers;

use App\Models\Student;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $token = $request->header('x-token');

        return Student::where('account_guid',$token)
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

        $student = new Student();
        $student->account_guid = $token;
        $student->firstname = $data['firstname'];
        $student->lastname = $data['lastname'];
        $student->preferred_name = $data['preferred_name'];
        $student->email = $data['email'];
        $student->math_proficient = $data['math_proficient'];
        $student->reading_proficient = $data['reading_proficient'];
        $student->foreign_language = $data['foreign_language'];
        $student->is_active = $data['is_active'];

        $student->save();

        return $student->student_id;
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request)
    {
        $token = $request->header('x-token');
        $id = $request->student;

        return Student::where('account_guid',$token)
            ->where('student_id', $id)
            ->first();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Student $student)
    {
        //
    }
}
