 /*
   LPAD / RPAD
   - 문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
   - LPAD/RPAD(STRING, 최종적으로반환할문자의길이, [덧붙이고자하는문자])
   - 문자열에 덧붙이고자하는문자를 왼쪽 또는 오른쪽에 덧붙여서
     최종 N길이만큼의 문자열을 반환
 */
   SELECT LPAD('HELLO', 10, 'A')FROM DUAL; -- 덧붙이고자하는문자 생략시 공백으로 채운다.
   SELECT LPAD('HELLO', 10, 'A')FROM DUAL;
   SELECT RPAD('HELLO', 10) FROM DUAL;
   SELECT RPAD('HELLO', 10, '*') FROM DUAL;
   
   /*
   LTRIM / RTRIM
   - 문자열에서 특정 문자를 제거한 나머지를 반환
   - LTRIM/RTRIM(STRING, [제거하고자하는문자들])
   - 문자열의 왼쪽 또는 오른쪽에서 제거하고자하는문자들을 찾아서
     제거한 나머지 문자열을 반환
   */
   -- 제거하고자 하는 문자 생략 시 기본값으로 공백을 제거
   SELECT LTRIM('       K H       ') FROM DUAL;
   SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
   SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;
   
   /*
   
   TRIM
   - 문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반한
   - TRIM([LEADING|TRAILNG|BOTH]) 제거하고자하는문자들 FROM STRING)
   */
   SELECT TRIM('       K H      ') FROM DUAL;
   SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
   
   
   /*
   
   SUBSTR
   - 문자열에서 특정 문자열을 추출해서 반환
   - SUBSTR(STRING, POSITION, [LENGTH])
        STRING : 문자타입컬럼 또는 '문자열값'
        POSITION : 문자열을 추출할 시작위치값(음수값도 가능)
        LENGH : 추출할 문자 개수(생략시 끝까지)
   */ 
   SELECT SUBSTR('PROGRAMMING', 5, 2) FROM DUAL;
   SELECT SUBSTR('PROGRAMMING', -8, 3) FROM DUAL;
   
   -- 여자사원들의 이름만 조회
   SELECT EMP_NAME
   FROM EMPLOYEE
   WHERE SUBSTR(EMP_NO, 8, 1) IN(2, 4);
   
   -- 남자사원들의 이름만 조회
   SELECT EMP_NAME
   FROM EMPLOYEE
   WHERE SUBSTR(EMP_NO, 8, 1) IN(1, 3);

   
   -- 사원명과 주민등록번호(980708-*******) 조회
   
   SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
   FROM EMPLOYEE;
   
   -- 직원명, 이메일, 아이디(이메일에서 '@' 앞의 문자) 조회
  SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "아이디"
  FROM EMPLOYEE;
  
  
  /* 
      LOWER / UPPER / INITCAP
      - LOWER/UPPER/INITCAP(STRING)
      LOWER : 다 소문자로 변경한 문자열 반환
      UPPER : 다 대문자로 변경한 문자열 반환
      INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
  */
   
   SELECT LOWER('Welcome To My World!') FROM DUAL;
   SELECT UPPER('Welcome To My World!') FROM DUAL;
   SELECT INITCAP('Welcome To My World!') FROM DUAL;
   
   /*
    CONCAT
    - 문자열 두개 전달받아 하나로 합친 후 결과 반환
    - CONCAT(STRING, STRING)
   */
   SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
   SELECT '가나다라'||'ABCE' FROM DUAL; --연결연산자와 동일!
   
   SELECT '가나다라'||'ABCD'||'1234' FROM DUAL;
   SELECT CONCAT(CONCAT('가나다라', 'ABCD'), '1234') FROM DUAL;
   
   /*
     REPLACE
     - REPLACE(STRING, STR1, STR2)
       STRING : 컬럼 또는 문자열값
       STR1 : 변경시킬 문자열
       STR2 : STR1을 변경할 문자열
   */
   SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
   
   -- 사원명, 이메일,이메일의 kh.or.kr를 gmail.com으로 변경해서 조회
  SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gamil.com')
  FROM EMPLYOEE;
 
  /*
  숫자 처리 함수
  
  ABS(NUMBER) : 숫자의 절대값을 구해주는 함수
  
  */
  SELECT ABS(-10) FROM DUAL; 
  
  /*
    MOD(NUMBER, NUMBER) : 두 수를 나눈 나머지값을 반환해주는 함수
  */
  SELECT MOD(10, 3) FROM DUAL;
  
  /*
 ROUND(NUMBER, [위치]) : 반올림한 결과를 반환하는 함수
  */
  SELECT ROUND(123.456) FROM DUAL; -- 위치 생략시 0
  SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
  SELECT ROUND(123.456, -2) FROM DUAL; -- 100
  
  /*
    CEIL(NUMBER) : 올림처리해주는 함수
  */
  SELECT CEIL(123.152) FROM DUAL; -- 124
   
   /*
    FLOOR(NUMBER) : 소수점 아래 버림처리해주는 함수
   */
  SELECT FLOOR(123.952) FROM DUAL; -- 123
  
  /*
     TRUNC(NUMBER, [위치]) : 위치 지정 가능한 버림처리해주는 함수
  */
   SELECT TRUNC(123.952) FROM DUAL;
   SELECT TRUNC(123.952, 1)FROM DUAL;
   SELECT TRUNC(123.952, -1)FROM DUAL;
   
  /*
    날짜 처리 함수
    
    SYSDATE : 시스템의 날짜를 반환 (현재 날짜)
  */
   
   SELECT SYSDATE FROM DUAL;
   
   -- 날짜 포맷 변경
   ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
   ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; -- 원래 포맷으로 변경
   
   /*
    MONTHS_BETWEEN(DATE, DATE)
    - 입력받는 두 날짜 사이의 개월 수를 반환
   */
   SELECT MONTHS_BETWEEN(SYSDATE, '20230521') FROM DUAL;
   
 -- 직업명, 입사일, 근무 개월 수 조회
 SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
 FROM EMPLOYEE;
 
 /*
  ADD_MONTHS(DATE, NUMBER)
  - 특정 날짜에 입력받는 숫자만큼의 개월 수를 더한 날짜를 반환
 */
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- 직원명, 입사일, 입사 후 6개월이 된 날짜를 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;
   
   
   /*
     NEXT_DAY(DATE, 요일(문자|숫자))
     - 특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 리턴
     - 요일 : 1 - 일요일, 2 - 월요일, 7 - 토요일
   */
  SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일') FROM DUAL;
  SELECT SYSDATE, NEXT_DAY(SYSDATE, '금')FROM DUAL;
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 4) FROM DUAL;
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
  
  -- 현재 언어가 KOREAN이기 때문에 : 에러!
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
  -- 언어 변경
  ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
  ALTER SESSION SET NLS_LANGUAGE = KOREAN;
  
  /*
     LAST_DAT(DATE)
     - 해당 월의 마지막 날짜를 반환
  */
  SELECT LAST_DAY(SYSDATE) FROM DUAL;
  SELECT LAST_DAY('20230515') FROM DUAL;
  SELECT LAST_DAY('23/11/01') FROM DUAL;
  
 -- 직업명, 입사일, 입사월의 마지막 날짜, 입사한 월에 근무한 일수 조회
 SELECT 
 EMP_NAME, 
 HIRE_DATE, 
 LAST_DAY(HIRE_DATE), 
 LAST_DATE(HIRE_DATE) - HIRE_DATE + 1
 FROM EMPLOYEE;
 
 /*
   EXTRACT(YEAR|MONTH|DAY FROM DATE)
   - 특정 날짜에서 연도, 월, 일 정보를 추출해서 반환
     YEAR : 연도만 추출
     MONTH : 월만 추출
     DAY : 일만 추출
 */
-- 직원명, 입사년도, 입사월, 입사일 조회
   SELECT EMP_NAME, 
   EXTRACT(YEAR FROM HIRE_DATE)"입사년도", 
   EXTRACT(MONTH FROM HIRE_DATE)"입사월", 
   EXTRACT(DAY FROM HIRE_DATE)"입사일"
   FROM EMPLOYEE;

/*
  형 변환 함수

  TO_CHAR(날짜|숫자, [포맷])
  - 날짜 또는 숫자형 데이터를 문자 타입으로 변환해서 반환
*/
  SELECT TO_CHAR(1234,'L999999') FROM DUAL; -- 현재 설정된 나라의 화폐단위
  SELECT TO_CHAR(1234,'$999999') FROM DUAL;
  SELECT TO_CHAR(1234,'L99') FROM DUAL; -- 포맷 자리수가 안맞아서
  SELECT TO_CHAR(1234,'L999,999') FROM DUAL;
  
  -- 직원명, 급여, 연봉(위의 TO_CHAR를 이용해서)조회
  SELECT EMP_NAME, 
  TO_CHAR(SALARY, 'L99,999,999'),
  TO_CHAR(SALARY * 12, 'L99,999,999') AS "연봉"
  FROM EMPLOYEE;
  
  -- 날짜 -> 문자
  SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS') FROM DUAL;
  SELECT TO_CHAR(SYSDATE,'AM HH24:MI:SS') FROM DUAL;
  SELECT TO_CHAR(SYSDATE,'MON DD, DY, YYYY') FROM DUAL; -- DY, DAY : 요일 / DD : 요일
  
  -- 년도와 관련된 포맷
  SELECT 
      TO_CHAR(SYSDATE, 'YYYY'),
      TO_CHAR(SYSDATE, 'YY'),
      TO_CHAR(SYSDATE, 'RRRR'),
      TO_CHAR(SYSDATE, 'RR'),
      TO_CHAR(SYSDATE, 'YEAR')
      FROM DUAL;
      
 -- 월과 관련된 포맷
 SELECT
     TO_CHAR(SYSDATE, 'MM'),
     TO_CHAR(SYSDATE, 'MON'),
     TO_CHAR(SYSDATE, 'MONTH'),
     TO_CHAR(SYSDATE, 'RM') -- 로마기호
     FROM DUAL;
     
  -- 일과 관련된 포맷
 SELECT
     TO_CHAR(SYSDATE, 'D'), -- 주 기준
     TO_CHAR(SYSDATE, 'DD'), -- 월 기준
     TO_CHAR(SYSDATE, 'DDD') -- 년 기준
     FROM DUAL;
  
  -- 요일과 관련된 포맷
  SELECT
      TO_CHAR(SYSDATE, 'DAY'),
      TO_CHAR(SYSDATE, 'DY')
    FROM DUAL;
    
    
    -- 직원명, 입사일 조회
    -- 단, 입사일은 포맷을 지정해서 조회 2023년 06월 21일 (수)

    SELECT 
    EMP_NAME,
    TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')
    FROM EMPLOYEE;
  
  /*
     TO_DATE(숫자|문자, [포맷])
     - 숫자 또는 문자형 데이터를 날짜 타입으로 변환해서 반환
  */
  -- 날짜 포맷 변경
  ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
  
  -- 숫자 --> 날짜
  SELECT TO_DATE(20230621) FROM DUAL;
 -- SELECT TO_DATE(20230621153410) FROM DUAL; -- 에러
  SELECT TO_DATE(20230621153410, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
    
  -- 문자 --> 날짜
  SELECT TO_DATE('20230621', 'YYYYMMDD')FROM DUAL;
  SELECT TO_DATE('20230621 033823', 'YYYY-MM-DD HH24MISS') FROM DUAL;
 
    
    /*
    TO_NUMBER('문자값', [포맷])
    - 문자형 데이터를 숫자 타입으로 변환해서 반환
    */
   SELECT '1000000' + '550000' FROM DUAL;
   SELECT '1,000,000' + '550,000' FROM DUAL; -- 에러발생
   SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('550,000', '999,999')
   FROM DUAL;
   
   /*
      NULL 처리 함수
      
      NVL(값1, 값2)
      - 값1이 NULL이 아니면 값1을 반환하고 값1이 NULL이면 값2를 반환
   */
    -- 사원명, 보너스 조회
    SELECT
       EMP_NAME, 
       NVL(BONUS, 0)
       FROM EMPLOYEE;
       
 -- 사원명, 보너스포함연봉(월급 + 월급*보너스) * 12 조회
    SELECT EMP_NAME,(SALARY + SALARY * NVL(BONUS,0)) * 12
    FROM EMPLOYEE;
 
 -- 사원명, 부서코드 조회 (부서코드가 NULL이면 "부서없음")조회
     SELECT EMP_NAME, NVL(DEPT_CODE, '부서없음')
     FROM EMPLOYEE;
     
    /*
    NVL2(값1, 값2, 값3)
    - 값1이 NULL이 아니면 값2반환하고 값1이 NULL이면 값3를 반환
    */
   -- 사원명, 부서코드가 있는 경우 "부서있음, 없는 경우는 "부서없음"조회
   SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음','부서없음')
   FROM EMPLOYEE;


   /*
     NULLIF(값1, 값2)
     - 두 개의 값이 동일하면 NULL을 반환하고,
       두 개의 값이 동일하지 않으면 값1을 반환
   */
   
   SELECT NULLIF('123', '123') FROM DUAL;
   SELECT NULLIF('123', '456') FROM DUAL;
 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   