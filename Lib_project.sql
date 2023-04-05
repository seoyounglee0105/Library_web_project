CREATE DATABASE librarydb;
USE librarydb;

-- 회원
CREATE TABLE user (
	id VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    name VARCHAR(20) NOT NULL,
	phone_number CHAR(13) UNIQUE NOT NULL,
	address VARCHAR(200) NOT NULL,
    email VARCHAR(50) -- NULL 허용 
);

-- 서적 카테고리
CREATE TABLE category (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

INSERT INTO category (name) 
VALUES ('IT'), ('소설'), ('취미'), ('경제'), ('자기계발'), ('요리'), ('어린이');

-- 서적
CREATE TABLE book (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    writer VARCHAR(50) NOT NULL, -- 저자
    publisher VARCHAR(50) NOT NULL, -- 출판사
    image VARCHAR(50) NOT NULL, -- 표지 이미지
    description TEXT, -- 설명
	checkout_count INT, -- 총 대출량 (기본값 : 0)
    is_available boolean DEFAULT true, -- 대출 가능 여부 (기본값 : true)
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id)
);

-- 대여
CREATE TABLE checkout (
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50) NOT NULL,
    book_id INT NOT NULL,
    checkout_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_return boolean DEFAULT false,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

-- 리뷰
CREATE TABLE review (
	id int PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(50) NOT NULL,
    book_id int NOT NULL,
    star int NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    write_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE
);

INSERT INTO book (name, writer, publisher, image, category_id, check_out_count, description)
VALUES 
	('어린 왕자', '앙투안 드 생텍쥐페리', '더스토리', 'images/0.jpg', 2, 576, '생텍쥐페리는 프랑스의 유명한 소설가로, 그의 작품 <어린 왕자>는 전 세계적으로 <성경>, <자본론> 다음으로 많이 읽히는 책이다. 이 책은 1943년 뉴욕에서 출판된 프랑스어판 초판본 표지디자인을 그대로 되살렸다. 어둡지도 너무 빛바래지도 않은 노란색 표지와 어린 왕자의 연둣빛 옷의 색감을 최대한 살려냈고, 본문에는 생텍쥐페리의 친필 사인이 들어 있다. 또한 작가가 직접 그린 일러스트들이 시적이고 아름다운 어린 왕자의 이야기를 더욱 풍성하게 만들어준다.'),
    
	('챗GPT : 마침내 찾아온 특이점', '반병현', '생능북스', 'images/1.jpg', 1, 563, '출시된 지 얼마 되지도 않아 세상을 뒤흔든 챗GPT는 지금까지 나온 모든 인공지능 기술보다 훨씬 더 전 세계에 충격을 주었다. 챗GPT가 무엇이고, 어떻게 활용하며, 우리 사회에 어떤 영향을 줄지 인공지능 개발자인 저자의 시선을 통해 분석하였다.'),
    ('진짜 쓰는 실무 엑셀', '오빠두(전진권)', '제이펍', 'images/2.jpg', 1, 301, '대기업 직장 생활 10년의 실무 노하우와 엑셀 유튜브 채널을 운영하면서 들은 수많은 직장인의 고민을 해결할 수 있는 다양한 엑셀 비법을 담았다. 한 권이면 빠른 일 처리로 워라밸을 실현하고, 일잘러로 거듭날 수 있다!'),
    ('코딩 자율학습 나도코딩의 파이썬 입문', '나도코딩', '길벗', 'images/3.jpg', 1, 175, '유튜브와 인프런 최고의 인기 강의를 한 권에 담았다. 일상 속 재미있는 예제로 파이썬 기본 개념을 배우고 1분 퀴즈, 실습 문제, 셀프체크로 이어지는 단계별 학습으로 파이썬을 완공할 수 있다. 코딩을 처음 배우는 사람도 단계적 용어 설명과 친절한 지시선으로 막힘없이 따라 할 수 있다. 기본 설명 외에 팁, 노트 등을 적재적소에 배치해 혼자 공부할 때 생길 수 있는 의문점을 쉽게 해결할 수 있게 도와준다.'),
    ('혼자 공부하는 컴퓨터 구조 + 운영체제', '강민철', '한빛미디어', 'images/4.jpg', 1, 98, '1:1 과외하듯 배우는 IT 지식 입문서. 독학으로 컴퓨터 구조와 운영체제를 배우는 입문자가 ‘꼭 필요한 내용을 제대로 학습’할 수 있도록 구성했다. 뭘 모르는지조차 모르는 입문자의 막연한 마음에 십분 공감하여 과외 선생님이 알려주듯 친절하게, 핵심 내용만 콕콕 집어 준다.'),
    ('개발자에게 물어보세요', '제프 로슨', '박설영', 'images/5.jpg', 1, 232, '기회는 사라지지 않는다. 이동할 뿐이다. 배달의민족, 무신사, 오늘의집··· 디지털 네이티브 기업이 없던 시장을 만들고 기존 시장 점유율을 장악하고 있다. 이 책은 잘 만든 소프트웨어로 무엇을 이룰 수 있는지 설명하는 데서 시작한다. 우연찮게 은행이 된 기술기업 벙크, 고객센터를 사지 않고 구축한 ING의 생생한 사례를 통해 왜 그 어느 때보다 지금 개발자가 중요한지 알려 준다.'),

    ('스즈메의 문단속', '신카이 마코토', '대원씨아이', 'images/6.jpg', 2, 554, '규슈의 오랜 항구 마을, 햇살에 반짝이는 파란 바다가 정면으로 보이는 언덕은 스즈메의 등교길이다. 여느 때처럼 자전거를 타고 기분 좋은 바람을 맞으며 언덕을 내려가던 스즈메는 한 이방인과 마주친다. 근방에 폐허가 있냐는 그의 물음에 스즈메는 의아해하면서도 산속을 가리킨다. 거품 경제 시절에는 이름난 온천 명소로 커다란 리조트가 있었지만 지금은 쇠락하여 아무도 살지 않는 곳이다. 고맙다며 성큼성큼 산 쪽으로 걸어가던 뒷모습과 그가 한 말이 잊히지 않는 스즈메. "문을 찾고 있어." 그렇게 산을 향하며 스즈메의 첫 번째 문단속이 시작된다.'),
    ('환상서점', '소서림', '해피북스투유', 'images/7.jpg', 2, 510, '출간과 동시에 <하얼빈>, <불편한 편의점> 등 서점 베스트셀러 강자들을 제치고 단번에 밀리의 서재 종합 베스트셀러 1위에 오르며 화제의 중심에 선 오디오북 <환상서점>. 오디오북 출간 당시에도 내로라하는 유명 성우들로 구성되어 전에 없던 독자들의 뜨거운 반응으로 장시간 베스트셀러 1위를 기록했다. 오디오북 <환상서점>을 원작으로 하여, 서점주인이 들려주던 기묘한 이야기에서 세계관을 넓고 깊게 확장시켜, 서점주인과 손님 사이에서 피어나는 감정들을 촘촘하게 엮어 독자에게 새로운 경험을 선사한다.'),
    ('아버지의 해방일지', '정지아', '창비', 'images/8.jpg', 2, 485, '정지아의 이 장편소설은 추석연휴와 함께 독자에게 닿기 시작했다. 유시민 작가가 아나키스트인 아버지와 아들이 벌이는 코미디물인 오쿠다 히데오의 <남쪽으로 튀어!>의 예를 들며 이 소설을 추천하면서부터다. "올해 읽은 책 중 제일 재밌고 강력하다!"는 평을 얻은 이 소설. <빨치산의 딸> 출간 시 판매금지, 기소 등의 사건을 겪은 정지아 작가가 32년만에 소설의 첫 문장을 다시 쓴다.'),
    ('불편한 편의점', '김호연', '나무옆의자', 'images/9.jpg', 2, 453, '70만 독자의 지친 하루를 위로한 얼웨이즈 편의점은 오늘도 문을 연다. 서울역 노숙인이던 독고가 편의점의 야간 아르바이트 직원으로 일하면서 시작되는 1편의 이야기 이후 1년 반이 흘렀다. ALWAYS 편의점의 여름, 독고의 후임으로 밤 시간을 책임지던 곽 씨가 그만두고 새 야간 알바를 구하면서 편의점은 다시 한 번 변화를 맞이한다. 커다란 덩치와 느린 행동이 독고를 연상시키는 이 남자, 어수룩한 수다쟁이가 황근배라는 이름 대신 홍금보라는 별명이 적힌 명찰을 가슴에 달고 마냥 느긋하게 손님들을 맞는다.'),
    ('견딜 수 없는 사랑', '이언 매큐언', '복복서가', 'images/10.jpg', 2, 324, '인생의 방향을 완전히 바꿔놓을 순간이 오기 직전, 우리는 아무것도 알지 못한다. 그것은 햇빛 가득한 봄날의 풀밭에서 연인과 피크닉을 즐기고 있던 조 로즈에게도 마찬가지였다. 갑작스런 고함소리와 울음소리가 그의 소풍과 평온한 삶에 작별을 예고했지만 조는 알지 못했다. 이윽고 헬륨이 가득 든 거대한 열기구가 하늘로 떠오르고 있으며 그 안에 소년이 혼자 타고 있다는 것을 본 조는 열기구를 향해 미친 듯이 달려가고 있는 자신을 발견한다.'),
    
    ('제주탐묘생활', '이신아', '야옹서가', 'images/11.jpg', 3, 342, '길고양이에서 인스타그램 20만 팔로워를 보유한 스타 고양이로 거듭난 히끄와 반려인 히끄 아부지가, 첫 책 <히끄네 집> 출간 5년 만에 후속작 <제주탐묘생활>로 돌아왔다. 161장의 사진을 빼곡하게 담아, 더 애틋해지고 각별해진 가족 이야기를 들려준다.'),
    ('식물을 배우는 시간', '독일카씨 김강호', '길벗', 'images/12.jpg', 3, 321, '동물과 마찬가지로 말 못 하는 식물이 시름시름 앓을 때는 정말 마음이 답답하곤 하다. 한 번에 명쾌하게 병의 이유를 알 수 있으면 좋으련만, 말처럼 쉬운 일이 아나다. 그럴 때는 ‘빛이 문제일까, 통풍이 문제일까, 분갈이를 해볼까, 비료를 줘볼까’ 여러 가지 궁리를 하게 된다. 하지만 그조차 섣불리 했다가 식물을 더 아프게 만드는 건 아닐까 한참을 망설이곤 한다. 여러 식물과 함께 살고 있는 식물집사라면 한 번쯤은 해봤을 고민일 것이다. 그 고민에 도움이 될 베테랑 식물집사 독일카씨의 식물 케어법을 한 권의 책으로 엮었다. 식물의 생장에 영향을 주는 7가지 요소 흙, 화분, 빛, 물, 바람, 해충, 비료에 대한 상세하게 알아보고, 경험을 바탕에 둔 그린 솔루션으로 반려식물을 더 건강하게 관리할 수 있는 비법을 알려준다.'),
    ('8주간의 기적 근육의 부활', '조명기', '청림Life', 'images/13.jpg', 3, 145, '여러 연예인들의 몸을 명품근육으로 바꾸어 화제를 모은 저자의 ‘8주간의 기적’ 운동법을 담았다. 직업상 바쁘고 불규칙한 생활 때문에 뚱뚱한 몸, 마른 몸, 허약한 몸을 가지게 된 개그맨들은 그의 지도에 따라 하루에 최소 30분, 딱 8주 동안 운동을 실시했고, 놀랍게도 8주 후 건강하고 탄력 있는 근육질의 몸으로 180도 탈바꿈했다.'),
    ('단밍이네 어린 정원', '고현경, 이재호', '티나', 'images/14.jpg', 3, 95, '가드닝에 관심을 갖기 시작한 사람들에게 가드닝이 무엇인지를 알려주는, 매우 따뜻한 온기를 담은 가드닝 안내서다. 꽃과 식물에 대한 애정으로 무작정 시작한 가드닝, 이로부터 비롯되는 시행착오를 모두 거친 후 가드닝이 가야 할 길을 조목조목 정성스럽게 안내하는 것은 저자 부부의 깊은 성정에서 샘솟는 아름다운 일이 아닐 수 없다.'),
    ('히구치 유미코의 즐거운 울 자수', '히구치 유미코', '한즈미디어', 'images/15.jpg', 3, 70, '아름답고 단정한 자수로 일본, 한국뿐 아니라 전 세계에서 사랑받는 베스트셀러 작가 히구치 유미코의 신작으로, 이번 책에서는 울실을 사용해 포근한 입체감을 살리고 거기에 가장 많이 쓰는 25번 자수실을 조합해 다채로움까지 더했다.'),

    ('세이노의 가르침', '세이노', '데이원', 'images/16.jpg', 4, 432, '2000년부터 발표된 그의 주옥같은 글들. 독자들이 자발적으로 만든 제본서는 물론, 전자책과 앱까지 나왔던 《세이노의 가르침》이 드디어 전국 서점에서 독자들을 마주한다. 여러 판본을 모으고 저자의 확인을 거쳐 최근 생각을 추가로 수록하였다. 정식 출간본에만 추가로 수록된 글들은 목차와 본문에 별도 표시하였다.'),
    ('장하준의 경제학 레시피', '장하준', '부키', 'images/17.jpg', 4, 275, '세계적인 석학이자 베스트셀러 《장하준의 경제학 강의》 《그들이 말하지 않는 23가지》 《나쁜 사마리아인들》의 저자 장하준 교수가 다양한 음식으로 요리한 경제 이야기로 다시 우리 곁을 찾아왔다. 이 책에서 저자는 마늘에서 초콜릿까지 우리에게 친숙한 18가지 재료와 음식으로 가난과 부, 성장과 몰락, 자유와 보호, 공정과 불평등, 제조업과 서비스업, 민영화와 국영화, 규제 철폐와 제한, 금융 자유화와 금융 감독, 복지 확대와 복지 축소 등 우리에게 밀접한 경제 현안들을 흥미로우면서도 영양가 만점인 지식과 통찰로 풀어낸다.'),
    ('브라질에 비가 내리면 스타벅스 주식을 사라', '피터 나바로', '에프엔미디어', 'images/18.jpg', 4, 164, '미국 중앙은행이 갑자기 기준금리를 올리면 왜 유럽과 아시아의 주식시장이 충격을 받을까? 석유수출국기구가 대규모 감산을 결정하면 중국과 한국의 물가와 에너지 섹터 주가에 어떤 영향을 미칠까? 이 책은 이 같은 거시경제 변수가 주식시장과 어떻게 연계되는지 설명하고, 이를 활용해 투자 성과를 높이고 리스크도 관리하는 구체적인 방법을 알려준다. 핵심 경제 지표와 활용법을 명쾌하게 정리한 ‘매크로(macro) 투자의 고전’으로 널리 알려진 책이다.'),
    ('살 때, 팔 때, 벌 때', '강영현', '21세기북스', 'images/19.jpg', 4, 214, '시장의 심리를 읽는 매도·매수 타이밍, 상승-하락-횡보 시장에서 반드시 참고해야 할 실물-금융 시장의 지표들과 분석법, 펀더멘털을 통해 경제의 거대한 흐름을 읽고 ‘되는 시장’과 ‘되는 주식’을 고르는 인사이트를 담았다. 이 책으로 여의도 1타 브로커의 투자 비법을 자연스럽게 체화하여 상승의 시그널을 파악하는 안목을 갖고, 반드시 성공하는 자신만의 투자 전략을 세울 수 있을 것이다.'),
    ('챗GPT에게 묻는 인류의 미래', '김대식, 챗GPT', '동아시아', 'images/20.jpg', 4, 175, '2022년 말 출시되어 전 세계를 충격에 빠뜨린 챗GPT에 대한 관심이 뜨겁다. 구글 CEO가 ‘적색경보’를 언급하고, 마이크로소프트가 챗GPT를 개발한 ‘오픈AI’에 100억 달러 규모의 투자를 했다는 뉴스도 들려온다. 기존의 검색엔진을 대화형 AI가 대체할 것이며, 반복적인 작업이 필요한 대부분의 인간 업무를 AI가 대신할 수 있으리라는 등 혁신적인 인공지능 기술이 야기할 미래의 다양한 변화에 대한 논의가 뜨겁다. 이러한 가운데 KAIST 교수이자 뇌과학자인 김대식 교수가 기계와의 ‘진지한 대화’를 시도했다.'),
    
    ('사장학개론', '김승호', '스노우폭스북스', 'images/21.jpg', 5, 275, '한국과 미국, 전 세계를 오가며 ‘사장을 가르치는 사장’으로 알려진 『돈의 속성』의 저자 김승호 회장의 신간이다. 평생 사장으로 살아온 그의 경영철학 모두를 10여 년에 걸쳐 정리해 온 그는, 이번 『사장학개론』 책을 통해 120가지 주제로 그 내용을 모두 담아 완성했다.'),
    ('거인의 노트', '김익한', '다산북스', 'images/22.jpg', 5, 224, '우리는 인생을 살면서 다양한 한계에 부딪힌다. 공부라는 외롭고 힘든 길에서 앞으로 나아가지 못하고 있다면, 아직 자신이 원하는 일을 찾지 못했다면, 10년 가까이 회사를 다녔지만 더 이상 어떻게 성과를 내야 할지 모르겠다면, 또는 아이를 키우며 반복되는 일상에 지쳐버렸거나 노년에 접어들어 은퇴를 하고 더 이상의 성장을 포기하게 되었다면, 당신은 이 한계를 넘어서길 포기한 채 그저 살던 대로 살아갈 것인가, 다시 한번 인생의 변화를 꾀할 것인가?'),
    ('사이토 히토리의 1퍼센트 부자의 법칙', '사이토 히토리', '나비스쿨', 'images/23.jpg', 5, 185, '사이토 히토리는 매우 독특한 인물이다. 누적 납세액 1위라는 전대미문의 기록으로 일본 최고 부자의 자리에 올랐지만, 자신의 얼굴을 단 한 번도 공개한 적이 없다. 주식이나 부동산에 손대지 않고, 오직 스스로의 아이디어로 그 많은 돈을 벌어들인 그는 행복한 부자로 더욱 이름이 높다. 그 비법을 오롯이 담고도 그동안 절판되어 많은 애독자를 안타깝게 했던 책, “사이토 히토리의 1퍼센트 부자의 법칙”이 드디어 재출간되었다.'),
    ('타이탄의 도구들 (블랙 에디션)', '팀 페리스', '토네이도', 'images/24.jpg', 5, 123, '2017년 출간 즉시 아마존과 <뉴욕 타임스> 베스트셀러 차트 1위를 동시에 석권하며, 국내 독자들에게도 큰 사랑을 받은 《타이탄의 도구들》이 6년 연속 최고의 베스트셀러를 기념한 리커버 블랙 에디션으로 다시 우리를 찾아왔다. 출간 전부터 전 세계 독자들의 뜨거운 지지와 관심을 받았던 이 책에는 알랭 드 보통, 세스 고딘, 말콤 글래드웰, 파울로 코엘료, 피터 틸, 에드 캣멀 등등 이 시대 가장 성공한 인물들의 생생한 목소리가 담겨 있다. 세계적인 석학과 작가부터 최고의 혁신기업을 세운 창업가와 CEO, 크리에이티브 디렉터, 협상가, 슈퍼리치, 아티스트, 전문직 종사자까지 자기 분야에서 정상에 오른 사람들의 독창적인 성공 노하우가 낱낱이 담겨 있다.'),
    ('만일 내가 인생을 다시 산다면', '김혜남', '메이븐', 'images/25.jpg', 5, 67, '30년 동안 정신분석 전문의로 일해 온 김혜남이 벌써 마흔이 된 당신에게 해 주고 싶은 말들을 담은 책이다. 그녀는 지금껏 살면서 한 가지 후회하는 게 있다면 스스로를 너무 닦달하며 인생을 숙제처럼 산 것이라고 말한다. 의사로, 엄마로, 아내로, 며느리로, 딸로 살면서 늘 의무와 책임감에 치여 어떻게든 그 모든 역할을 잘해 내려 애썼고 그러다 보니 정작 누려야 할 삶의 즐거움들을 놓쳐 버렸다는 것이다. 그러다 22년 전 마흔세 살에 파킨슨병 진단을 받으며 비로소 알게 되었다. 자신이 없으면 집안도 병원도 제대로 안 굴러갈 것 같았는데 세상은 너무나 멀쩡히 잘 굴러갔다. 그제야 그녀는 자신의 곁을 지켜 주는 사람들을 다시 보게 되었고, 놓쳐서는 안 될 인생의 소중한 것들이 무엇인지를 돌아보게 되었다. 그래서 벌써 마흔이 되어 버린, 후회 없는 인생을 살고 싶은 사람들에게 말해 주고 싶은 것도 딱 한가지다. “하나의 문이 닫히면 또 하나의 문이 열린다. 그러니 더 이상 고민하지 말고 그냥 재미있게 살아라!”'),
    
    ('기적의 집밥책', '김해진', '청림Life', 'images/26.jpg', 6, 35, '월급 빼고 다 올랐다는 고물가 시대, 밥상 물가 역시 꾸준히 오르며 주부들의 한숨은 깊어졌다. 배달 음식, 외식을 줄이고 좋아하는 카페로 향하던 발걸음을 돌려보지만, 한 달은커녕 일주일도 버티기 힘든 것이 현실이다. 하지만 아무리 계산기를 두드려도 줄일 수 있는 것은 식비뿐. 식비 절약 좀 즐겁게 하는 방법은 없을까?'),
    ('사실은 집밥을 좋아하지만 지쳐버린 이들에게', '고켄테쓰', '윌북', 'images/27.jpg', 6, 23, '한약사가 알려주는 채소·과일식 해독법. 다이어트 보좌관이자 피토테라피스트 한약사 조승우가 《건강과 다이어트를 동시에 잡는 채소·과일식》을 세상에 내놓는다. 다이어트의 핵심은 독소 청소인데, 이를 위해 단순하면서 자연스러운 가장 효과적인 식단인 채소·과일식을 소개한다. 이 책은 가공식품과 화학첨가제의 진실을 알려준다. 또한 채소·과일식을 손쉽게 할 수 있는 방법부터 3주 프로그램을 통해 식단관리하는 방법까지 담겨 있다. 저자는 채소·과일식을 70%, 가공식품을 30%로 식단관리를 하도록 권한다. 여러분의 건강하고 행복한 삶을 기원한다.'),
    ('오늘 이 계절을 사랑해!', '진민섭', '세미콜론', 'images/28.jpg', 6, 45, '최소한의 양념과 조리법으로 재료 본연의 맛은 살리고, 조리 시간은 줄이는 ‘후암동삼층집’만의 노하우가 가득하다. 자취 1인 가구부터 대가구까지 두루 적용하기에 무리가 없으며, 요리 초보라도 누구나 두려움 없이 부엌에 설 수 있도록 돕는다. 이 책은 주방 곁에 늘 두고 싶은 계절 안내서로서의 역할을 톡톡히 할 것이다. 지금이 아니면 느끼지 못할 자연의 생명력과 건강한 음식으로 일상을 채워간다는 즐거움과 뿌듯함을 지금 바로 느껴보자.'),
    ('안밥모 베스트 유아식', '이샘', '래디시', 'images/29.jpg', 6, 23, '아이가 유아식을 먹기 시작하면 한동안 먹지 않아 애간장을 녹이는 일명 ‘밥태기’의 시기가 꼭 찾아온다. ‘먹이기 전쟁’으로 지친 수많은 부모들, 심지어 육아 중인 유명 연예인들도 가입한다는 국내 최대 유아식 커뮤니티가 있다. 9만 회원의 열렬한 지지를 받으며 밥태기 극복의 아이콘으로 자리매김한 네이버 대표카페 ‘안밥모’의 인기 레시피가 책으로 출간되었다.'),
    ('맛있게, 저염식', '윤세경', '아퍼블리싱', 'images/30.jpg', 6, 24, '집에 있는 재료만으로 휘리릭 만드는 초간단 주먹밥부터 소문난 맛집 메뉴를 변형한 별미 김밥, 트렌디한 맛과 비주얼의 토핑 유부초밥까지 한 권에 싹 모아 소개한 소장가치가 남다른 한입밥책이다.'),
    
    ('156층 나무 집', '앤디 그리피스', '시공주니어', 'images/31.jpg', 7, 153, '나무 집에는 바위 볼링장, 소원을 비는 우물, 수수께끼 엔진, 속마음을 읽어 내는 샌드위치 기계 들이 새로 생겨 156층이 된다. 크리스마스 앞두고 설레는 앤디와 테리에게 남극에서 눈이 배달된다. 한여름의 크리스마스를 보내온 둘에게 눈 선물은 그 무엇보다 특별하다. 하지만 눈의 정체는 나무 집을 노리는 남극의 눈사람. 앤디, 테리와 눈사람 사이에 나무 집을 가지기 위한 한판 승부가 벌어지는데….'),
    ('흔한남매 과학 탐험대 7 : 생물 1', '김언정', '주니어김영사', 'images/32.jpg', 7, 31, '과학을 처음 접하는 아이들이 과학의 주요 내용을 미리 맛볼 수 있는 초등 과학 입문서이다. 흔한남매가 최고의 과학 전문가들과 함께 우주, 지구와 달, 우리 몸, 정글 등을 여행하며 쉽고 재미있게 과학 지식을 배운다. 초등학교 과학 교과서의 내용을 모두 담았고, 생활 과학 정보, 과학 관련 최근 이슈, 우리나라 관련 정보들을 더했다.'),
    ('고양이 해결사 깜냥 5', '홍민정', '창비', 'images/33.jpg', 7, 25, '어린이 독자들의 뜨거운 사랑을 받아 온 화제의 베스트셀러 『고양이 해결사 깜냥』이 다섯 번째 이야기로 돌아왔다. 이번에는 깜냥이 편의점 직원으로 변신해 다양한 손님들을 맞이하며 벌어지는 일들을 그렸다. 저마다 다른 이유로 찾아왔지만, 편의점에서 깜냥을 만난 손님들의 얼굴에는 밝은 웃음이 가득하다. 새롭게 등장한 캐릭터 ‘하품이’의 매력을 발견하는 것도 5권을 읽는 큰 즐거움이다. 4권 이후 1년을 기다려 온 독자들의 부푼 기대에 부응할 신나는 이야기가 펼쳐진다.
');
    

