<?php

namespace App\Http\Controllers;

use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\MyUser;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $token = $request->header('x-token');

        return Student::with('majors')
            ->with('minors')
            ->with('credits')
            ->where('account_guid',$token)
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
            $id = MyUser::where('user_guid', $token)->firstOrFail();
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        // Create the new student
        $data = $request->json()->all();

        $student = new Student();
        $student->account_guid = $token;
        if (array_key_exists('account_guid', $data)) $student->account_guid = $data['account_guid'];
        if (array_key_exists('firstname', $data)) $student->firstname = $data['firstname'];
        if (array_key_exists('lastname', $data)) $student->lastname = $data['lastname'];
        if (array_key_exists('preferred_name', $data)) $student->preferred_name = $data['preferred_name'];
        if (array_key_exists('email', $data)) $student->email = $data['email'];
        if (array_key_exists('math_proficient', $data)) $student->math_proficient = $data['math_proficient'];
        if (array_key_exists('reading_proficient', $data)) $student->reading_proficient = $data['reading_proficient'];
        if (array_key_exists('foreign_language', $data)) $student->foreign_language = $data['foreign_language'];
        if (array_key_exists('matriculation_year', $data)) $student->matriculation_year = $data['matriculation_year'];
        if (array_key_exists('is_active', $data)) $student->is_active = $data['is_active'];

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

        return Student::with('majors')
            ->with('minors')
            ->with('credits')
            ->where('account_guid',$token)
            ->where('student_id', $id)
            ->first();
    }

     /**
     * Update the specified resource in storage.
     */
    public function myUpdate(Request $request)
    {
        $token = $request->header('x-token');

        // Verify GUID is valid
        try {
            $id = MyUser::where('user_guid', $token)->firstOrFail();
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        $data = $request->all();

        $student = Student::find($data['student_id'], 'student_id');
        if (array_key_exists('firstname', $data)) $student->firstname = $data['firstname'];
        if (array_key_exists('lastname', $data)) $student->lastname = $data['lastname'];
        if (array_key_exists('preferred_name', $data)) $student->preferred_name = $data['preferred_name'];
        if (array_key_exists('email', $data)) $student->email = $data['email'];
        if (array_key_exists('math_proficient', $data)) $student->math_proficient = $data['math_proficient'];
        if (array_key_exists('reading_proficient', $data)) $student->reading_proficient = $data['reading_proficient'];
        if (array_key_exists('foreign_language', $data)) $student->foreign_language = $data['foreign_language'];
        if (array_key_exists('matriculation_year', $data)) $student->matriculation_year = $data['matriculation_year'];
        if (array_key_exists('is_active', $data)) $student->is_active = $data['is_active'];

        $student->save();

        return;

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $token = $request->header('x-token');

        // Verify GUID is valid
        try {
            $id = MyUser::where('user_guid', $token)->firstOrFail();
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        $id = $request->student;
        Student::destroy($id);

        return;
    }
}
