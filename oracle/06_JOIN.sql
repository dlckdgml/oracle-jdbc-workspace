/*
    JOIN
    - 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    - 조회 결과는 하나의 결과물(RESULT SET)으로 나옴

    - 관계형 데이터베이스는 최소한의 데이터로 가각의 테이블에 담고 있음
      (중복을 최소화하기 위해 최대한 쪼개서 관리)
      부서 데이터는 부서테이블, 사원에 대한 데이터는 사원 테이블, 직급 테이블...
      
      
      만약 어떤 사원이 어떤 부서에 속해있는지 부서명과 같이 조회하고 싶다면?
      만약 어떤 사원이 어떤 직급인지 직급명과 같이 조회하고 싶다면?
      
      => 즉, 관계형 데이터베이스에서 SQL 문을 이용한 테이블 간에
         "관계"를 맺어 원하는 데이터를 조회하는 방법
         
         - 크게 "오라클 구문"과 "ANSI 구문"
         - ANSI(미국국립표준협회 == 산업표준을 제정하는 단계) : 다른 DBMS에서도 사용 가능
*/
/*
    1. 오라클 - 등가 조인(EQAL JOIN) / ANSI - 내부 조인(INNER JOIN / NATUAL JOIN)
     - 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회
       (일치하는 값이 없는 행은 조회 X)
       
       
       1) 오라클 전용 구문
        SELECT 컬럼, 컬럼, ..., 컬럼
        FROM 테이블1, 테이블2
        WHERE 테이블1.컬럼명 = 테이블2.컬럼명;
        
        - FROM 절에 조회하고자 하는 테이블들을 콤마로(,) 구분하여 나열
        - WHERE 절에 매칭 시킬 컬럼명에 대한 조건 제시
        
        2) ANSI 표준 구문
           SELECT 컬럼, 컬럼, ..., 컬럼
           FROM 테이블1
           JOIN 테이블2 ON(테이블1.컬럼명 = 테이블2.컬럼명);
           
           - FROM 절에서 기준이 되는 테이블 기술
           - JOIN 절에서 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬
             컬럼에 대한 조건을 기술 (USING 구문과 ON 구문 사용)
           - 연결에 사용하려는 컬럼명이 같은 경우 ON 구문 대신에
             USING(컬럼명) 구문 사용
*/
-- 1) 연결할 두 컬럼명이 다른 경우
-- 사번, 사원명, 부서코드, 부서명 같이 조회
-- >> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    
-- 2) 연결할 두 컬럼명이 같은 경우
-- 사번, 사원명, 직급코드, 직급명

-- 해결방법 1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB 
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

    
-- 해결방법 2) 테이블에 별칭을 부여해서 이용하는 방법
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI 구문
-- 해결방법1) 테이블명 또는 별칭을 이용해서 하는 방법
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 해결방법2) JOIN USING 구문 사용하는 방법
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
   
-- 자연조인(NATURAL JOIN) : 각 테이블마다 동일한 컬럼이 한 개만 존재할 경우
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 직급이 대리인 사원의 사번, 이름, 직급명, 급여를 조회
-- >> 자연조인 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
NATURAL JOIN JOB
WHERE JOB_NAME = '대리';

-- >> 오라클 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '대리';

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-- 실습문제 --
-- 1. 부서가 인사관리부인 사원들의 사번, 이름 ,보너스 조회
-- 오라클 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '인사관리부';
-- ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- 2. DEPARTMENT와 LOCATION을 참고해서 전체 부서의 부서코드, 부서명,
--    지역코드, 지역명 조회
-- 오라클 구문
SELECT DEPT_CODE, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

-- ANSI 구문
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- 오라클 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
-- 오라클 구문
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '총무부';

-- ANSI 구문
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';


-- 1.직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 직원명,
--   직급명, 부서명, 근무지역, 급여를 조회
-- ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE JOB_NAME = '대리'
AND LOCAL_NAME LIKE 'ASIA%';

-- 오라클 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARYMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE


-- 2.70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호,
--   부서명, 직그명을 조회
-- ANSI 구문
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NO LIKE '7%'
AND SUBSTR(EMP_NO, 8, 1)  = 2
AND EMP_NAME LIKE '전%';

-- 오라클 구문

-- 3. 보너스를 받는 직원들의 직원명, 보너스, 연봉, 부서명, 근무지역을 조회
-- 단, 부서 코드가 없는 사원도 출력될 수 있게
-- ANSI 구문
SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 오라클 구문
SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
AND D.LOCATION_ID = L.LOCAL_CODE(+)
AND BONUS IS NOT NULL;

-- 4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역,
--    근무국가 조회

-- ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL = N.NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국', '일본');

-- 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID)
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND NATIONAL_NAME
   
-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회
--    단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔
-- ANSI 구문
SELECT DEPT_TITLE, AVG(NVL(SALARY,0))
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;

-- 오라클 구문
SELECT DEPT_TITLE, AVG(NVL(SALARY,0))
FROM EMPLOYEE E DEPARTMENT D 
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;

-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회
-- ANSI 구문
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 오라클 구문
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E,  DEPARTMENT D
WHERE (E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 7. 사번, 직원명, 직급명, 급여 등급, 구분을 조회
--    이때 구분에 해당하는 값은 아래와 같이 조회 되도록
--    급여 등급이 s1, s2인 경우 '고급'
--    급여 등급이 S3, S4인 경우 '중급'
--    급여 등급이 S5, S6인 경우 '초급'

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL,
CASE WHEN SAL_LEVEL IN('S1', 'S2') THEN '고급'
     WHEN SAL_LEVEL IN('S3', 'S4') THEN '중급'
     WHEN SAL_LEVEL IN('S5', 'S6') THEN '초급'
   END "구분"
FORM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AD S.MAX_SAL);


-- 8. 보너스를 받지 않는 직원들 중 직급 코드가 J4 또는 J7인 직원들의 
--    직원명, 직급명, 급여를 조회
-- ANSI 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL 
 AND J.JOB_CODE IN ('J4', 'J7');

-- 오라클 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE(E.JOB_CODE = J.JOB_CODE)
 AND BONUS IS NULL 
 AND J.JOB_CODE IN ('J4', 'J7');
 
-- 9. 부서가 있는 직원들의 직원명, 직급명, 부서명, 근무 지역을 조회
-- ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOACTION_ID = L.LOCAL_CODE):

-- 오라클 구문
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
 AND E.DEPT_CODE = D.DEPT_ID
 AND D.LOACTION_ID = L.LOCAL_CODE:
 
-- 10. 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서코드, 부서명 조회
-- ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE LIKE = '해외영업%';

-- 오라클 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE
AND E.DEPT_CODE = D.DEPT_ID
AND DEPT_TITLE LIKE = '해외영업%';

-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회
-- ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 오라클 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND EMP_NAME LIKE '%형%';


 















