<?php

namespace App\Http\Controllers;

use App\Models\MajorStudent;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\MyUser;

class MajorStudentController extends Controller
{
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

        // Create the new student major
        $data = $request->json()->all();

        $major_student = new MajorStudent();

        if (array_key_exists('student_id', $data)) $major_student->student_id = $data['student_id'];
        if (array_key_exists('major_id', $data)) $major_student->major_id = $data['major_id'];

        $major_student->save();

        return $major_student->major_student_id;
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

        $id = $request->majorstudent;
        return MajorStudent::destroy($id);


    }
}
