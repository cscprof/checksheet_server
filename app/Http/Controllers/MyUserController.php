<?php

namespace App\Http\Controllers;

use App\Models\MyUser;
use Illuminate\Http\Request;

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

}
