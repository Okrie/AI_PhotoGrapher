### AI PhotoGrapher 
---

Flutter, Python을 사용하여 모바일 어플리케이션 제작    
사용자가 올린 이미지를 사용하여 AI Filter 이미지 생성하여 필터 구매시 다운로드 기능을 제공한다.  
     
<a href="https://drive.google.com/file/d/1gAJQ-JmT6rB2BUJxUjo75Ac0bKrQC9xO/view?usp=sharing">![cover](aiphotographer.png)</a>

##### 시연 영상

<a href="https://drive.google.com/file/d/1uizayUb2Cioa9eimNOFGpAt-EUSic6nc/view?usp=sharing"><img src="aiphotographer_preview.png" width="150" height="300"></a>


---

### 기능 설명
- 메인 뷰에서 앱에서 제휴한 사진 작가들이 노출되며 상단 배너에서는 랜덤하게 노출
- 사진작가가 보정한 결과물로 강화학습한 모델로 사용자가 올린 이미지를 토대로 생성
- 다운로드 받기 위해서는 사용자 로그인 필요
- 회원가입 구현 및 필터 구매 기능 구현
- AI 이미지는 3개 생성되며, 선택하여 필터 사용시 구매한 필터 사용횟수 차감 되며 사용자 모바일로 사진이 다운됨


---
---
#### Database      
    : MySQL    
   
    
    
#### 기술 스택
<p align="left">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=git,github,vscode,mysql,python,dart,fastapi,tensorflow,flutter" /></a>
    <img src="https://cdn.icon-icons.com/icons2/2107/PNG/512/file_type_swagger_icon_130134.png" height="53" title="Swagger">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/SQLAlchemy.svg/160px-SQLAlchemy.svg.png" height="53" title="SqlAlchemy">
    <img src="https://cdn.icon-icons.com/icons2/70/PNG/512/ubuntu_14143.png" height="53" title="Ubuntu">
    <img src="https://cdn.icon-icons.com/icons2/836/PNG/512/Windows_Phone_icon-icons.com_66782.png" height="53" title="Windows10">
    <img src="https://cdn.icon-icons.com/icons2/836/PNG/512/Android_icon-icons.com_66772.png" height="53" title="Android">
    <img src="https://cdn.icon-icons.com/icons2/3221/PNG/512/docs_editor_suite_docs_google_icon_196688.png" height="53" title="Google Docs"> 
 
</p>


---
## Flutter, Python 기능 상세 설명
- 상단 PDF 파일 참고

## Server 기능 상세 설명
<img src="https://skillicons.dev/icons?i=fastapi" />

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/3203034a-0452-43b0-8020-816d753141ec)

**Author**

---
- Author 검색 (Get)

```python
/getauthors
```

#### Param & Return

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/7d1b524f-b912-4151-8487-4e735456dc28)


**User**
---

- user 로그인 (Post)

```python
/auth/user
```

#### Param

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/f0164fd1-6fd7-45df-ba32-6fa42dc6274c)


#### Return

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/1cc2c1c0-010b-42a1-a0a1-d289a82fd34a)


- user 회원가입 (Post)

```python
/auth/user/register
```

#### Param

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/c3ec8551-69a5-4c4f-abef-aae02db0b62d)


#### Return

![image](https://github.com/Okrie/Swift_ML_FlaskServer/assets/24921229/15b69055-d816-4f96-b2ac-afb1642693fa)


- user 구매내역 (Get)

```python
/userinfo?userid={USERID : STRING}
```

#### Param

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/dfc3cc67-7833-4375-890f-273ed62aef23)


#### Return

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/ed407e1d-911e-467d-85eb-07dc2c540f47)




**Purchase**

---

- AI Filter 구매 (Post)

```python
/purchase
```

#### Param

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/78159dda-94ae-46f8-81ff-d0c8a093e123)

#### Return

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/abc49385-c59b-4167-858e-3beeda40b652)


- AI Filter 사용 (Get)

```python
/usefilter?userid={USERID : STRING}&pseq={AUTHOR_NUM : INT}
```

#### Param

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/98177cd6-0347-48eb-ab73-12fa12dff9cf)


#### Return

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/0377b96b-6421-4106-934c-48bba8d672f2)




**AI Filter**

---
    
- AI Filter 생성 (Post)
  Base64Encode 사용

```python
/pred
```

#### Param

![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/3f0c5dc4-0916-4686-86b7-68cf8790bfc3)


#### Return


![image](https://github.com/Okrie/Flutter_Python_FastAPI/assets/24921229/a144f016-02ad-41d0-8bd8-6baf6650d9ea)

