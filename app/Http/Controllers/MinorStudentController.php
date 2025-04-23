<?php

namespace App\Http\Controllers;

use App\Models\MinorStudent;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\MyUser;

class MinorStudentController extends Controller
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

        // Create the new student minor
        $data = $request->json()->all();

        $minor_student = new MinorStudent();

        if (array_key_exists('student_id', $data)) $minor_student->student_id = $data['student_id'];
        if (array_key_exists('minor_id', $data)) $minor_student->minor_id = $data['minor_id'];

        $minor_student->save();

        return $minor_student->minor_student_id;
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

        $id = $request->minorstudent;
        return MinorStudent::destroy($id);


    }
}
