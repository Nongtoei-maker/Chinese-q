<!DOCTYPE html>
<html lang="th" class="h-full bg-slate-50">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>แบบทดสอบวิชาวัฒนธรรมจีน (ทำซ้ำได้หลายรอบ)</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Kanit', sans-serif; }
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="h-full flex flex-col justify-between text-slate-800">

    <!-- Header -->
    <header class="bg-red-700 text-white shadow-lg sticky top-0 z-50">
        <div class="max-w-4xl mx-auto px-4 py-4 flex justify-between items-center">
            <div class="flex items-center space-x-3">
                <i class="fa-solid font-bold text-2xl text-yellow-400 fa-book-open"></i>
                <div>
                    <h1 class="font-bold text-lg md:text-xl leading-tight">แบบทดสอบวัฒนธรรมจีน 40 ข้อ</h1>
                    <p class="text-xs text-red-200">ระบบฝึกฝนและทำข้อสอบซ้ำ (Practice & Quiz Mode)</p>
                </div>
            </div>
            <div id="stats-badge" class="hidden md:flex items-center bg-red-800 px-3 py-1.5 rounded-full text-xs text-yellow-300 font-medium">
                <i class="fa-solid fa-rotate-right mr-1.5"></i> ทำซ้ำแล้ว: <span id="attempt-count" class="font-bold ml-1 text-white">0</span> ครั้ง
            </div>
        </div>
    </header>

    <!-- Main Content Container -->
    <main class="max-w-4xl mx-auto w-full px-4 py-6 flex-grow">

        <!-- Start Screen -->
        <div id="start-screen" class="bg-white rounded-2xl shadow-xl p-6 md:p-10 text-center border border-red-100">
            <div class="w-20 h-20 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-6 text-3xl shadow-inner">
                <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <h2 class="text-2xl md:text-3xl font-bold text-slate-900 mb-3">คลังข้อสอบวัฒนธรรมจีน 40 ข้อ</h2>
            <p class="text-slate-600 mb-8 max-w-lg mx-auto leading-relaxed">
                ระบบนี้ออกแบบมาให้คุณสามารถ **ทำข้อสอบซ้ำได้หลายๆ รอบ** เพื่อทบทวนความรู้ มีทั้งข้อสอบแบบปรนัย (ตัวเลือก) และข้อเขียน พร้อมระบบเฉลยทันทีหลังทำเสร็จ
            </p>

            <!-- Mode Selector -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-xl mx-auto mb-8 text-left">
                <label class="relative flex flex-col p-4 bg-red-50/50 border-2 border-red-500 rounded-xl cursor-pointer hover:bg-red-50 transition">
                    <input type="radio" name="quiz-mode" value="all" checked class="sr-only peer">
                    <span class="font-bold text-red-900 mb-1 flex items-center justify-between">
                        <span>ชุดข้อสอบเต็ม (40 ข้อ)</span>
                        <i class="fa-solid fa-check-circle text-red-600 peer-checked:inline"></i>
                    </span>
                    <span class="text-xs text-slate-600">ข้อสอบปรนัย + ข้อเขียน ครบทั้ง 40 ข้อ</span>
                </label>
                <label class="relative flex flex-col p-4 bg-slate-50 border-2 border-slate-200 rounded-xl cursor-pointer hover:bg-red-50 hover:border-red-300 transition">
                    <input type="radio" name="quiz-mode" value="random10" class="sr-only peer">
                    <span class="font-bold text-slate-800 mb-1 flex items-center justify-between">
                        <span>สุ่มข้อสอบ 10 ข้อ (ฉบับไว)</span>
                        <i class="fa-solid fa-dice text-slate-400"></i>
                    </span>
                    <span class="text-xs text-slate-500">เหมาะสำหรับการทดสอบความเร็วและทบทวนสั้นๆ</span>
                </label>
            </div>

            <!-- Start Button -->
            <button onclick="startQuiz()" class="w-full sm:w-auto px-8 py-4 bg-red-600 hover:bg-red-700 text-white font-bold text-lg rounded-xl shadow-lg hover:shadow-red-500/30 transition transform hover:-translate-y-0.5 active:translate-y-0 flex items-center justify-center mx-auto space-x-2">
                <i class="fa-solid fa-play"></i>
                <span>เริ่มทำแบบทดสอบ</span>
            </button>
        </div>

        <!-- Quiz Main Screen (Hidden by default) -->
        <div id="quiz-screen" class="hidden space-y-6">

            <!-- Progress Bar & Status -->
            <div class="bg-white p-4 rounded-xl shadow-sm border border-slate-100 flex flex-col md:flex-row justify-between items-center gap-3">
                <div class="w-full md:w-2/3">
                    <div class="flex justify-between text-xs font-semibold text-slate-500 mb-1">
                        <span>ความคืบหน้า</span>
                        <span id="progress-text">ข้อที่ 1 จาก 40</span>
                    </div>
                    <div class="w-full bg-slate-100 h-3 rounded-full overflow-hidden">
                        <div id="progress-bar" class="bg-red-600 h-full w-0 transition-all duration-300"></div>
                    </div>
                </div>
                <div class="flex items-center space-x-2 w-full md:w-auto justify-end">
                    <span id="type-tag" class="px-3 py-1 bg-red-100 text-red-700 font-medium text-xs rounded-full">ปรนัย</span>
                    <button onclick="resetQuiz()" class="px-3 py-1 bg-slate-100 hover:bg-slate-200 text-slate-600 text-xs font-medium rounded-lg transition flex items-center space-x-1">
                        <i class="fa-solid fa-rotate-right"></i>
                        <span>เริ่มใหม่</span>
                    </button>
                </div>
            </div>

            <!-- Question Card -->
            <div class="bg-white rounded-2xl shadow-md border border-slate-200/80 overflow-hidden">
                <div class="bg-gradient-to-r from-red-50 to-orange-50 p-6 border-b border-red-100">
                    <span class="text-xs font-bold text-red-600 tracking-wider uppercase mb-1 block">คำถาม</span>
                    <h3 id="question-text" class="text-lg md:text-xl font-bold text-slate-900 leading-snug">
                        <!-- Question text inserted by JS -->
                    </h3>
                </div>

                <!-- Options / Answer Input Area -->
                <div class="p-6">
                    <!-- Multiple Choice Area -->
                    <div id="options-container" class="grid grid-cols-1 gap-3">
                        <!-- Options generated dynamically -->
                    </div>

                    <!-- Written Answer Area -->
                    <div id="written-container" class="hidden space-y-4">
                        <label class="block text-sm font-medium text-slate-700">พิมพ์คำตอบของคุณลงในช่องว่างด้านล่าง:</label>
                        <input type="text" id="written-input" placeholder="พิมพ์คำตอบภาษาจีนหรือไทย..." class="w-full p-3.5 border border-slate-300 rounded-xl focus:ring-2 focus:ring-red-500 focus:border-red-500 outline-none transition text-lg">
                        <p class="text-xs text-slate-400">*หมายเหตุ: ระบบจะตรวจคำตอบภาษาจีนเป็นหลัก หรือคำตอบที่ความหมายตรงกัน</p>
                    </div>
                </div>
            </div>

            <!-- Navigation Buttons -->
            <div class="flex justify-between items-center">
                <button id="prev-btn" onclick="prevQuestion()" class="px-5 py-2.5 bg-slate-200 hover:bg-slate-300 text-slate-700 font-semibold rounded-xl text-sm transition disabled:opacity-40 disabled:cursor-not-allowed flex items-center space-x-2">
                    <i class="fa-solid fa-chevron-left"></i>
                    <span>ข้อก่อนหน้า</span>
                </button>
                <button id="next-btn" onclick="nextQuestion()" class="px-6 py-2.5 bg-red-600 hover:bg-red-700 text-white font-semibold rounded-xl text-sm transition shadow-md flex items-center space-x-2">
                    <span id="next-btn-text">ข้อถัดไป</span>
                    <i class="fa-solid fa-chevron-right" id="next-btn-icon"></i>
                </button>
            </div>
        </div>

        <!-- Result Screen (Hidden by default) -->
        <div id="result-screen" class="hidden space-y-6">
            <div class="bg-white rounded-2xl shadow-xl p-6 md:p-8 text-center border border-slate-100">
                <div id="result-icon" class="w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-4 text-4xl shadow-inner">
                    <!-- Dynamic Icon -->
                </div>
                <h2 class="text-2xl font-bold text-slate-800 mb-1">ผลการทำแบบทดสอบ</h2>
                <p id="result-feedback" class="text-slate-500 text-sm mb-6">สรุปคะแนนของคุณในรอบนี้</p>

                <div class="flex justify-center items-center space-x-4 mb-8">
                    <div class="bg-red-50 border border-red-100 p-4 rounded-xl min-w-[140px]">
                        <span class="block text-xs text-red-600 font-semibold uppercase">คะแนนที่ได้</span>
                        <span id="score-text" class="text-3xl font-extrabold text-red-700">0 / 40</span>
                    </div>
                    <div class="bg-slate-50 border border-slate-100 p-4 rounded-xl min-w-[140px]">
                        <span class="block text-xs text-slate-500 font-semibold uppercase">คิดเป็น</span>
                        <span id="percentage-text" class="text-3xl font-extrabold text-slate-800">0%</span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row justify-center gap-3">
                    <button onclick="startQuiz()" class="px-6 py-3.5 bg-red-600 hover:bg-red-700 text-white font-bold