<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ข้อสอบวิชาวัฒนธรรมจีน (中国文化课期末考试)</title>
    <style>
        :root {
            --primary: #c0392b;
            --primary-hover: #a93226;
            --bg: #f9f9f9;
            --card-bg: #ffffff;
            --text: #2c3e50;
            --border: #bdc3c7;
            --correct: #27ae60;
            --wrong: #e74c3c;
        }

        body {
            font-family: 'Sarabun', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 20px 10px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 800px;
            background: var(--card-bg);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 10px;
            font-size: 1.6rem;
        }

        .subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 25px;
            font-size: 0.95rem;
        }

        .section-header {
            background-color: var(--primary);
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            margin: 30px 0 15px 0;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .question-card {
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff;
        }

        .question-title {
            font-size: 1.05rem;
            font-weight: bold;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .options {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .option-label {
            display: flex;
            align-items: center;
            padding: 8px 12px;
            border: 1px solid #ecf0f1;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .option-label:hover {
            background-color: #f2f4f4;
        }

        .option-label input {
            margin-right: 10px;
        }

        .text-input {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border);
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1rem;
            margin-top: 5px;
        }

        .btn-submit {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.2rem;
            font-weight: bold;
            cursor: pointer;
            margin-top: 30px;
            transition: background 0.2s;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
        }

        .result-box {
            display: none;
            background-color: #eaf2f8;
            border: 2px solid #2980b9;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            margin-bottom: 25px;
        }

        .result-score {
            font-size: 2rem;
            font-weight: bold;
            color: #2980b9;
        }

        .feedback {
            margin-top: 10px;
            font-weight: bold;
            display: none;
        }

        .correct {
            color: var(--correct);
        }

        .wrong {
            color: var(--wrong);
        }

        .answer-key {
            font-size: 0.9rem;
            color: #555;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>中国文化课期末考试</h1>
    <div class="subtitle">แบบทดสอบวิชาวัฒนธรรมจีน (40 ข้อ)</div>

    <div id="resultBox" class="result-box">
        <h2>ผลการสอบของคุณ</h2>
        <div id="scoreDisplay" class="result-score">0 / 40</div>
        <button onclick="resetQuiz()" class="btn-submit" style="margin-top: 15px; background-color: #2980b9;">ทำซ้ำอีกครั้ง (Reset)</button>
    </div>

    <form id="quizForm">
        <div class="section-header">Part 1: 选择题 (ข้อสอบแบบเลือกตอบ 24 ข้อ)</div>
        <div id="part1"></div>

        <div class="section-header">Part 2: 填空题 (ข้อสอบแบบเขียนตอบ 16 ข้อ)</div>
        <div id="part2"></div>

        <button type="button" class="btn-submit" onclick="checkAnswers()">ส่งคำตอบ / ตรวจคะแนน</button>
    </form>
</div>

<script>
const quizData = [
    // Part 1
    { id: 1, type: 'mc', q: '中国古代的官员有几级？<br><small>(ข้าราชการในจีนโบราณมีกี่ขั้น?)</small>', options: ['A. 六品', 'B. 七品', 'C. 八品', 'D. 九品'], ans: 'D' },
    { id: 2, type: 'mc', q: '“秋后问斩”中的“秋后”指的是什么？<br><small>("秋后" ในคำว่า "秋后问斩" หมายถึงช่วงเวลาใด?)</small>', options: ['A. 立秋以后', 'B. 处暑以后', 'C. 秋分以后', 'D. 霜降以后'], ans: 'C' },
    { id: 3, type: 'mc', q: '中国古代的官员用什么颜色来区分官级？<br><small>(ข้าราชการจีนโบราณใช้สีอะไรในการแบ่งชั้นยศ?)</small>', options: ['A. 紫、红、绿、青', 'B. 黄、红、蓝、白', 'C. 紫、黄、红、绿', 'D. 红、绿、青、黑'], ans: 'A' },
    { id: 4, type: 'mc', q: '“五花八门”中的“五花”是指哪五种花？<br><small>("五花" ในสำนวน "五花八门" หมายถึงดอกไม้อะไรบ้าง?)</small>', options: ['A. 桃花、菊花、水仙花、火棘花、土牛花', 'B. 金菊花、木棉花、水仙花、火棘花、土牛花', 'C. 金菊花、木棉花、牡丹花、火棘花、土牛花', 'D. 金菊花、木棉花、水仙花、桂花、土牛花'], ans: 'B' },
    { id: 5, type: 'mc', q: '中国古代负责押送货物的职业是什么？<br><small>(อาชีพที่คุ้มกัน/คุ้มครองส่งสินค้าในจีนโบราณคืออะไร?)</small>', options: ['A. 镖师', 'B. 捕快', 'C. 更夫', 'D. 轿夫'], ans: 'A' },
    { id: 6, type: 'mc', q: '中国古代“跳槽”指的是什么？<br><small>(คำว่า "跳槽" ในจีนโบราณหมายถึงอะไร?)</small>', options: ['A. 换工作', 'B. 搬家', 'C. 多指男女变心', 'D. 离开家乡'], ans: 'C' },
    { id: 7, type: 'mc', q: '谁被称为“巾帼女宰相”？<br><small>(ใครได้รับการยกย่องว่าเป็น "นายกรัฐมนตรีหญิง"?)</small>', options: ['A. 武则天', 'B. 上官婉儿', 'C. 花木兰', 'D. 秦良玉'], ans: 'B' },
    { id: 8, type: 'mc', q: '中国古代的四大美男是谁？<br><small>(4 สุภาพบุรุษรูปงามในประวัติศาสตร์จีนคือใครบ้าง?)</small>', options: ['A. 宋玉、潘安、卫玠、兰陵王', 'B. 宋玉、潘安、贾宝玉、兰陵王', 'C. 屈原、潘安、卫玠、兰陵王', 'D. 宋玉、周瑜、卫玠、兰陵王'], ans: 'A' },
    { id: 9, type: 'mc', q: '女扮男装，替父从军的人是谁？<br><small>(ใครปลอมตัวเป็นชายเพื่อออกรบแทนพ่อ?)</small>', options: ['A. 上官婉儿', 'B. 祝英台', 'C. 秦良玉', 'D. 花木兰'], ans: 'D' },
    { id: 10, type: 'mc', q: '中国历史上第一位被列传的女将军是谁？<br><small>(นายพลหญิงคนแรกในประวัติศาสตร์จีนที่มีชื่อบันทึกในพงศาวดารคือใคร?)</small>', options: ['A. 花木兰', 'B. 穆桂英', 'C. 秦良玉', 'D. 梁红玉'], ans: 'C' },
    { id: 11, type: 'mc', q: '人比黄花瘦中的“黄花”指的是什么花？<br><small>("黄花" ในบทกวี "人比黄花瘦" หมายถึงดอกไม้อะไร?)</small>', options: ['A. 牡丹花', 'B. 菊花', 'C. 桂花', 'D. 兰花'], ans: 'B' },
    { id: 12, type: 'mc', q: '“愚公移山”中，愚公移的是哪两座山？<br><small>(ในนิทาน "ผู้เฒ่าย้ายภูเขา" ภูเขาสองลูกที่ย้ายคือภูเขาใด?)</small>', options: ['A. 泰山和华山', 'B. 太行山和王屋山', 'C. 峨眉山和黄山', 'D. 嵩山和衡山'], ans: 'B' },
    { id: 13, type: 'mc', q: '孟母三迁分别迁到了哪三个地方？<br><small>(แม่ของเมิ่งจื่อย้ายบ้าน 3 ครั้ง ไปที่สถานที่ใดบ้าง?)</small>', options: ['A. 墓地、市集、学校', 'B. 皇宫、市集、学校', 'C. 墓地、农田、学校', 'D. 寺庙、市集、学校'], ans: 'A' },
    { id: 14, type: 'mc', q: '“一问三不知”指的是哪“三不知”？<br><small>("三不知" ในสำนวน "一问三不知" หมายถึง 3 สิ่งใด?)</small>', options: ['A. 前因、后果、中间', 'B. 事情的起因、经过和结果', 'C. 时间、地点、人物', 'D. 天时、地利、人和'], ans: 'B' },
    { id: 15, type: 'mc', q: '“寿比南山”中的“南山”指哪座山？<br><small>("南山" ในคำอวยพร "寿比南山" หมายถึงภูเขาลูกใด?)</small>', options: ['A. 终南山', 'B. 华山', 'C. 泰山', 'D. 庐山'], ans: 'A' },
    { id: 16, type: 'mc', q: '“沧海桑田”中的“沧海”指什么海？<br><small>("沧海" ในสำนวน "沧海桑田" หมายถึงทะเลใด?)</small>', options: ['A. 南边的海', 'B. 西边的海', 'C. 北边的海', 'D. 东边的海'], ans: 'D' },
    { id: 17, type: 'mc', q: '“东山再起”中的“东山”指哪座山？<br><small>("东山" ในสำนวน "东山再起" หมายถึงภูเขาใด?)</small>', options: ['A. 井冈山', 'B. 会稽东山', 'C. 泰山东山', 'D. 黄山'], ans: 'B' },
    { id: 18, type: 'mc', q: '“五大三粗”是哪“五大”哪“三粗”？<br><small>("五大" และ "三粗" ในสำนวน "五大三粗" หมายถึงอะไร?)</small>', options: ['A. 五大：双手大、双脚大、头大；三粗：腰粗、腿粗、膀粗', 'B. 五大：耳朵大、眼睛大、头大；三粗：脖子粗、腰粗、腿粗', 'C. 五大：双手大、双脚大、耳朵大；三粗：腰粗、腿粗、手臂粗', 'D. 五大：头大、脸大、肚子大；三粗：腰粗、腿粗、脖子粗'], ans: 'A' },
    { id: 19, type: 'mc', q: '“三更”指的是现在的几点？<br><small>(เวลา "三更" ในโบราณ ตรงกับเวลากี่โมงในปัจจุบัน?)</small>', options: ['A. 19:00 - 21:00', 'B. 21:00 - 23:00', 'C. 23:00 - 01:00', 'D. 01:00 - 03:00'], ans: 'C' },
    { id: 20, type: 'mc', q: '消防队在古代叫什么？<br><small>(สถานีดับเพลิง/ทีมดับเพลิงในสมัยโบราณเรียกว่าอะไร?)</small>', options: ['A. 水机队', 'B. 潜火队', 'C. 灭火队', 'D. 防火队'], ans: 'B' },
    { id: 21, type: 'mc', q: '为什么说“买东西”而不是“买南北”？<br><small>(ทำไมถึงพูดว่า "买东西" (ซื้อของ) ไม่พูดว่า "买南北"?)</small>', options: ['A. 古代的市场在东西两边', 'B. 东西比南北好听', 'C. 南北代表方向不是物品', 'D. 皇帝规定的'], ans: 'A' },
    { id: 22, type: 'mc', q: '“落汤鸡”指的是什么人？<br><small>("落汤鸡" (ไก่ตกน้ำซุป) ใช้เปรียบเทียบถึงคนแบบใด?)</small>', options: ['A. 喜欢游泳的人', 'B. 浑身湿透，十分狼狈的人', 'C. 爱喝汤的人', 'D. 遇到好运的人'], ans: 'B' },
    { id: 23, type: 'mc', q: '“青梅竹马”指的是什么？<br><small>(สำนวน "青梅竹马" หมายถึงอะไร?)</small>', options: ['A. 喜欢吃青梅的人', 'B. 从小就相好的男女', 'C. 骑竹马的小孩', 'D. 好朋友'], ans: 'B' },
    { id: 24, type: 'mc', q: '“泰国”在中国古代叫什么？<br><small>(ประเทศ "ไทย" ในสมัยโบราณของจีนเรียกว่าอะไร?)</small>', options: ['A. 天竺', 'B. 新罗', 'C. 暹罗', 'D. 高丽'], ans: 'C' },

    // Part 2
    { id: 25, type: 'text', q: '中国古代海军又叫做什么？<br><small>(กองทัพเรือในจีนโบราณเรียกว่าอะไร?)</small>', ans: ['水军', '水师', '水军/水师', '水军,水师'] },
    { id: 26, type: 'text', q: '中国古代的“员外”指的是什么？<br><small>(คำว่า "员外" ในจีนโบราณหมายถึงใคร?)</small>', ans: ['有钱人'] },
    { id: 27, type: 'text', q: '“三百六十行”的说法出现在哪个时代？<br><small>(คำพูดที่ว่า "360 อาชีพ" เริ่มมีขึ้นในสมัยใด?)</small>', ans: ['明朝'] },
    { id: 28, type: 'text', q: '中国古代负责“打更”的职业叫什么？<br><small>(อาชีพที่ทำหน้าที่เดินตีเกราะบอกเวลาในจีนโบราณคืออะไร?)</small>', ans: ['更夫'] },
    { id: 29, type: 'text', q: '“绿肥红瘦”描写的是什么季节的景色？<br><small>(บทกวี "绿肥红瘦" บรรยายถึงบรรยากาศของฤดูใด?)</small>', ans: ['春天'] },
    { id: 30, type: 'text', q: '“精卫填海”中的“精卫”是什么动物？<br><small>(คำว่า "精卫" ในนิทาน "จิงเว่ยถมทะเล" คือสัตว์ชนิดใด?)</small>', ans: ['鸟'] },
    { id: 31, type: 'text', q: '“一日不见如隔三秋”中的“三秋”是指多久？<br><small>("三秋" ในสำนวน "ไม่เจอกันวันเดียวเหมือนห่างหายไป 3 ฤดูใบไม้ร่วง" หมายถึงระยะเวลานานเท่าใด?)</small>', ans: ['90天', '九十天'] },
    { id: 32, type: 'text', q: '“退避三舍”中的“三舍”指的多远？<br><small>("三舍" ในสำนวน "ถอยทัพให้สามเส่อ" คิดเป็นระยะทางไกลเท่าใด?)</small>', ans: ['九十里', '90里', '4.5公里', '九十里=4.5公里'] },
    { id: 33, type: 'text', q: '中国古代孩子一岁时要做什么？<br><small>(เด็กในจีนโบราณเมื่ออายุครบ 1 ขวบ ต้องทำพิธีอะไร?)</small>', ans: ['抓周'] },
    { id: 34, type: 'text', q: '“吹牛皮”是古代人过河的工具，现在是什么意思？<br><small>("吹牛皮" เดิมคืออุปกรณ์ข้ามแม่น้ำ ปัจจุบันมีความหมายว่าอย่างไร?)</small>', ans: ['说大话'] },
    { id: 35, type: 'text', q: '“铁公鸡”指的是什么人？<br><small>("铁公鸡" (ไก่ตัวผู้เหล็ก) หมายถึงคนที่มีลักษณะอย่างไร?)</small>', ans: ['非常小气、吝啬的人', '非常小气', '吝啬的人', '小气'] },
    { id: 36, type: 'text', q: '“千里姻缘一线牵”中的线是什么线？<br><small>("เส้นด้าย" ในสำนวน "พรหมลิขิตผูกพันด้ายเส้นเดียว" คือเส้นด้ายสีอะไร?)</small>', ans: ['红线'] },
    { id: 37, type: 'text', q: '“一甲子”指的是多少年？<br><small>(คำว่า "一甲子" (หนึ่งรอบเจี๋ยจื่อ) หมายถึงระยะเวลากี่ปี?)</small>', ans: ['60年', '六十年'] },
    { id: 38, type: 'text', q: '“豆蔻年华”指的是几岁的女子？<br><small>(คำว่า "豆蔻年华" ใช้เรียกหญิงสาวที่มีอายุช่วงกี่ปี?)</small>', ans: ['十三四岁的女子', '十三四岁', '13-14岁'] },
    { id: 39, type: 'text', q: '“医生”在古代叫什么？<br><small>(คำว่า "หมอ/แพทย์" ในสมัยโบราณเรียกว่าอะไร?)</small>', ans: ['郎中', '大夫', '郎中、大夫', '郎中/大夫'] },
    { id: 40, type: 'text', q: '为什么“福”字要倒着贴？<br><small>(ทำไมอักษร "福" (โชคลาภ) ถึงต้องติดกลับหัว?)</small>', ans: ['福到了'] }
];

function renderQuiz() {
    const part1Container = document.getElementById('part1');
    const part2Container = document.getElementById('part2');

    quizData.forEach((item, index) => {
        const card = document.createElement('div');
        card.className = 'question-card';
        card.id = `q-card-${item.id}`;

        let html = `<div class="question-title">${index + 1}. ${item.q}</div>`;

        if (item.type === 'mc') {
            html += `<div class="options">`;
            item.options.forEach(opt => {
                const val = opt.charAt(0);
                html += `
                    <label class="option-label">
                        <input type="radio" name="q${item.id}" value="${val}">
                        ${opt}
                    </label>
                `;
            });
            html += `</div>`;
        } else {
            html += `
                <input type="text" class="text-input" name="q${item.id}" placeholder="พิมพ์คำตอบภาษาจีนที่นี่...">
            `;
        }

        html += `<div id="fb-${item.id}" class="feedback"></div>`;
        html += `<div id="key-${item.id}" class="answer-key"></div>`;

        card.innerHTML = html;

        if (index < 24) {
            part1Container.appendChild(card);
        } else {
            part2Container.appendChild(card);
        }
    });
}

function checkAnswers() {
    let score = 0;

    quizData.forEach(item => {
        const fb = document.getElementById(`fb-${item.id}`);
        const key = document.getElementById(`key-${item.id}`);
        fb.style.display = 'block';

        if (item.type === 'mc') {
            const selected = document.querySelector(`input[name="q${item.id}"]:checked`);
            if (selected && selected.value === item.ans) {
                score++;
                fb.className = 'feedback correct';
                fb.innerText = '✓ ถูกต้อง';
                key.innerText = '';
            } else {
                fb.className = 'feedback wrong';
                fb.innerText = '✗ ผิด';
                key.innerText = `เฉลย: ข้อ ${item.ans}`;
            }
        } else {
            const userAns = document.querySelector(`input[name="q${item.id}"]`).value.trim();
            const isCorrect = item.ans.some(correct => userAns === correct || userAns.includes(correct));

            if (userAns !== '' && isCorrect) {
                score++;
                fb.className = 'feedback correct';
                fb.innerText = '✓ ถูกต้อง';
                key.innerText = '';
            } else {
                fb.className = 'feedback wrong';
                fb.innerText = '✗ ผิด';
                key.innerText = `เฉลย: ${item.ans[0]}`;
            }
        }
    });

    const resultBox = document.getElementById('resultBox');
    const scoreDisplay = document.getElementById('scoreDisplay');
    scoreDisplay.innerText = `${score} / 40`;
    resultBox.style.display = 'block';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function resetQuiz() {
    document.getElementById('quizForm').reset();
    document.getElementById('resultBox').style.display = 'none';
    quizData.forEach(item => {
        const fb = document.getElementById(`fb-${item.id}`);
        const key = document.getElementById(`key-${item.id}`);
        fb.style.display = 'none';
        key.innerText = '';
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

window.onload = renderQuiz;
</script>

</body>
</html>