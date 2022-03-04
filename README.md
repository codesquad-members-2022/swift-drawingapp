# swift-drawingapp
3번째 미션 - iOS 터치 드로잉 앱

## step-1 주요  작업 내용
- [x] Device - iPad, Device Orientation - Landscape Left, Landscape Right)
- [x] Factory 클래스에서 랜덤하게 Rectangle 클래스 생성

## 구현 화면(2022.03.04)

```
struct BackgroundColor {
        let R: UInt8
        let G: UInt8
        let B: UInt8
        
        static func random() -> Self {
            let randomR: UInt8 = UInt8.random(in: 0...255)
            let randomG: UInt8 = UInt8.random(in: 0...255)
            let randomB: UInt8 = UInt8.random(in: 0...255)
            return RectangleView.BackgroundColor(R: randomR, G: randomG, B: randomB)
        }
    }
    struct Size {
        let width: Double = 150.0
        let height: Double = 120.0
    }
    struct Point {
        let x: Double
        let y: Double
        
        static func random() -> Self {
            let randomX: Double = Double.random(in: 20...1010)
            let randomY: Double = Double.random(in: 24...680)
            return RectangleView.Point(x: randomX, y: randomY)
        }
    }
```

![os_log](https://user-images.githubusercontent.com/50472122/156562405-f07d43dc-e2a6-4b82-81de-cb4ac1381613.png)