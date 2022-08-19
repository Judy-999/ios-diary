# 📔 일기장

## 🪧 목차
- [🙋🏻‍♂️ 프로젝트 소개](#EF%B8%8F-프로젝트-소개)
- [📱 실행 화면](#-실행-화면)
- [💡 핵심경험](#-핵심경험)
- [🧑‍💻 코드 설명](#-코드-설명)
- [⚡️ 트러블 슈팅](#%EF%B8%8F-트러블-슈팅)
- [🔗 참고 링크](#-참고-링크)

<br>

## 🙋🏻‍♂️ 프로젝트 소개
일기장 어플 입니다 

> 프로젝트 기간: 2022-08-16 ~ 2022-09-02</br>
> 팀원:  [주디](https://github.com/Judy-999), [백곰](https://github.com/Baek-Gom-95) </br>
리뷰어: [찰리](https://github.com/kcharliek)</br>

<br>

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[주디](https://github.com/Judy-999)|[백곰](https://github.com/Baek-Gom-95)|
|:---:|:---:|
|<img src = "https://i.imgur.com/SdlGVLc.jpg" width="250" height="250"> | <img src = "https://i.imgur.com/c17eEk8.jpg" width="250" height="250"> |
	
<br>
	
## 📱 실행 화면
| 일기장 목록 화면 |+ 버튼 터치 시 추가화면으로 이동 | 글자 입력 및 키보드에 따른 텍스트뷰 변화 |
| :--------: | :--------: | :--------: |
| ![](https://i.imgur.com/yTb46gz.gif) |![](https://i.imgur.com/pQ2J1J0.gif)| ![](https://i.imgur.com/PcdFBvV.gif)|

<br>

## 💡 핵심경험
- [x] Date Formatter의 지역 및 길이별 표현의 활용
- [x] Text View의 활용
- [x] 코어데이터 모델 생성
- [x] 코어데이터 모델 및 DB 마이그레이션
- [x] 테이블뷰에서 스와이프를 통한 삭제기능 구현
- [x] Text View Delegate의 활용
- [x] Open API의 활용
- [x] Core Location의 활용
- [x] Date Formatter의 지역 및 길이별 표현의 활용
- [x] Text View의 활용
<br>
	
## 🧑‍💻 코드 설명
- `JSONParser`: JSON 타입의 데이터를 Parsing 합니다.
- `JSONError`: Parsing 도중에 일어날수있는 에러타입을 정리했습니다.
- `Diary`: Decode할 데이터의 모델 입니다.
- `ReuseIdentifying`: Cell의 이름을 Identifier로 가지게 합니다.
- `DateManager`: 날짜를 나타내는 데이터를 원하는 날짜포맷으로 변경합니다.
- `DiaryListCell`: 일기장 리스트 화면의 Cell을 구현합니다.
- `DiaryDetailView`: 일기를 선택하면 해당 일기의 상세내용을 표시합니다
- `AddDiaryView`: 일기장 생성 뷰를 구현합니다
- `DiaryTableViewController`: 일기장 리스트 뷰를 관리하는 컨트롤러 입니다.
- `DiaryDetailViewController`: 일기 상세보기 뷰를 관리하는 컨트롤러 입니다.
- `AddDiaryViewController`: 일기장 생성 뷰를 관리하는 컨트롤러 입니다.
<br>

## ⚡️ 트러블 슈팅
### 1. UITextField에 padding 구현
새로운 일기장을 생성하는 화면에서 제목을 `UITextField`로 두고, 본문을 `UITextView`로 구현했습니다. 하지만 `UITextField`와 `UITextView`의 글 시작지점이 차이가 있어 맞춰주고자 했습니다.

처음에 `UITextView`의 `contentInset`을 변경하는 방식을 해봤는데 별다른 변화가 없어 `UITextField` extension하여 padding을 추가하는 `addLeftPadding`메서드를 구현했습니다.
<br>

| **padding을 넣지 않았을 때** |  **padding을 넣은 후** | 
| :--------: | :--------: |  
| <img src="https://i.imgur.com/Sh6UCwN.png" width="400" height="200" />    |<img src="https://i.imgur.com/i6nwlVu.png" width="400" height="200" /> |

<br>

```swift
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
}
```
<br>

하지만 리뷰어이신 찰리가 `leftView`는 padding을 넣기 위한 공간이 아니고, 만일 나중에 악세서리를 추가하게 되면 문제가 될 수 있어 다른 방법을 추천해주셨습니다.
<br>

```swift
class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
```
<br>
`UITextField`을 상속하는 커스텀 텍스트필드를 만들어 padding을 넣는 방식으로 변경했습니다. 

하지만 이후에 텍스트필드 자체가 필요하지 않다고 판단되어 삭제했습니다. 🥲
<br>

### 2. SwiftLint 라이브러리
**SwiftLint** 라이브러리를 활용하여 코드 스타일을 일관성있게 유지했습니다. 
<br>

```swift
excluded:
    - Pods
    - Diary/Application/AppDelegate.swift
    - Diary/Application/SceneDelegate.swift
disabled_rules:
    - trailing_whitespace
    - line_length
```
<br>

`Pods`, `AppDelegate`, `SceneDelegate` 파일은 검사 대상에서 제외하고 **trailing_whitespace**와 **line_length** 규칙만 제외하도록 했습니다.

라이브러리를 CocoaPods로 받았는데 서로 Push-Pull 할 때마다 `pod install` 해야한다는 에러가 발생했습니다.  
<br>

![](https://i.imgur.com/omAPjwj.png)
<br>

각자 `pod install`을 하면 문제는 해결되었지만 매번 해주기 번거로워 살펴보니 팀원간의 CocoaPods 버전이 달라 발생한 문제였습니다.
서로 CocoaPods 버전을 확인하여 더 낮은 팀원의 버전을 업데이트 해서 해결했습니다!
<br>

### 3. 화면전환 방식 
ViewController를 스토리보드에 구현해서 `storyboard?.instantiateViewController` 방식으로 화면을 전환했지만 찰리가 Storyboard를 사용한다면 Segue로 하는 것이 VC간 관계를 표현하기 좋다고 하셔서 팀회의를 한 결과 Segue로 하는것이 VC간의 데이터 전달 및 여러가지 방면에서 유용하다고 판단해 변경하였습니다.
<br>

## 🔗 참고 링크
[Adaptivity and Layout](https://developer.apple.com/documentation/coredata)<br>
[UIKit: Apps for Every Size and Shape](https://developer.apple.com/videos/play/wwdc2018/235/)<br>
[Making Apps Adaptive, Part 1 / Script](https://asciiwwdc.com/2016/sessions/222)<br>
[Making Apps Adaptive, Part 2 / Script](https://www.youtube.com/watch?v=s3utpBiRbB0)<br>
[DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)<br>
[UITextView](https://developer.apple.com/documentation/uikit/uitextview)<br>
[키보드에 동적인 스크롤뷰](https://seizze.github.io/2019/11/17/iOS에서-키보드에-동적인-스크롤뷰-만들기.html)<br>
[UITextField Left padding 넣어주기 ](https://developer-fury.tistory.com/46)<br>
[키보드야 텍스트 가리지마](https://velog.io/@cherrish_red/iOS-%ED%82%A4%EB%B3%B4%EB%93%9C%EC%95%BC-%ED%85%8D%EC%8A%A4%ED%8A%B8-%EA%B0%80%EB%A6%AC%EC%A7%80%EB%A7%88)<br>
[timeIntervalSince1970](https://developer.apple.com/documentation/foundation/date/1779963-timeintervalsince1970)<br>
[UITextView](https://developer.apple.com/documentation/uikit/uitextview)<br>
[DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)<br>
[Create space at the beginning of a UITextField](https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield/27066764#27066764)<br>
[cell 이름으로 register하기](https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/UIKit/UICollectionViewExtensions.swift#L118)<br>
