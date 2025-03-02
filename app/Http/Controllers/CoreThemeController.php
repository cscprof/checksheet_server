<?php

namespace App\Http\Controllers;

use App\Models\CoreTheme;
use Illuminate\Http\Request;

class CoreThemeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $themes = CoreTheme::all();
        return $themes;
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(CoreTheme $coreTheme)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, CoreTheme $coreTheme)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(CoreTheme $coreTheme)
    {
        //
    }
}
