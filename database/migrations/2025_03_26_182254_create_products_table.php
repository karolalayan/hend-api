<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('category_id');
            $table->string('name');
            $table->string('description');
            $table->decimal('latitude', 10, 8);
            $table->decimal('longitude', 11, 8);
            $table->tinyInteger('type')->comment('0 - lost, 1 - found');
            $table->tinyInteger('status')->comment('0 - created, 1 - approved, 2 - rejected, 3 - completed');
            $table->timestamps();
        });

        Schema::table('products', function (Blueprint $table) {
            $table->foreign('created_by')
                ->references('id')
                ->on('users')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->foreign('category_id')
                ->references('id')
                ->on('categories')
                ->onDelete('cascade')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
