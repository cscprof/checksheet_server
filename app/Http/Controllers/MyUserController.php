<?php

namespace App\Http\Controllers;

use App\Models\MyUser;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\User;

class MyUserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = MyUser::all();
        return $users;
    }

    /**
     * Simulate login functions
     */
    public function login(Request $request)
    {
        $username = $request->input('username');
        $password = $request->input('password');

        $guid = MyUser::where('username',$username)
            ->where('password', $password)
            ->get(['user_guid', 'firstname', 'lastname', 'username']);

        if ( ! $guid->isEmpty() ) {
            return $guid;
        }

        // Invalid - return
        return response('Unauthorized', 401)->header('Content-Type', 'text/plain');
    }

    /**
     * Simulate login functions
     */
    public function logout(Request $request)
    {
       return response('Logged out', 200)->header('Content-Type', 'text/plain');
    }

    /**
     * Update the specified resource in storage.
     */
    public function resetPassword(Request $request)
    {
        $token = $request->header('x-token');

        // Verify GUID is valid
        try {
            $user = User::where('user_guid', $token)->firstOrFail();
        } catch (ModelNotFoundException $exception) {
            return response()->json([
                'error' => 'Unauthorized'
            ], 401);
        }

        $data = $request->all();

        if (array_key_exists('password', $data)) $user->password = $data['password'];

        return $user->save();

    }

}
