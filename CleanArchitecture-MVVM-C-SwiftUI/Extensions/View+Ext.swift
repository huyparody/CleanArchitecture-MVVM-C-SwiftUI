//
//  View+Ext.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import SwiftUI
import Combine
import ProgressHUD

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func roundedBorder(cornerRadius: CGFloat, lineWidth: CGFloat, borderColor: Color) -> some View {
        overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: lineWidth)
        )
    }
    
    func hideListRowSeperator() -> some View {
        if #available(iOS 15, *) {
            return AnyView(self.listRowSeparator(.hidden))
        } else {
            return AnyView(self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets(top: -1, leading: -1, bottom: -1, trailing: -1))
                .background(Color(.systemBackground)))
        }
    }
    
    
    /// Reads the view frame and bind it to the reader.
    /// - Parameters:
    ///   - coordinateSpace: a coordinate space for the geometry reader.
    ///   - reader: a reader of the view frame.
    func readFrame(in coordinateSpace: CoordinateSpace = .global,
                   for reader: Binding<CGRect>) -> some View {
        readFrame(in: coordinateSpace) { value in
            reader.wrappedValue = value
        }
    }
    
    /// Reads the view frame and send it to the reader.
    /// - Parameters:
    ///   - coordinateSpace: a coordinate space for the geometry reader.
    ///   - reader: a reader of the view frame.
    func readFrame(in coordinateSpace: CoordinateSpace = .global,
                   for reader: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: geometryProxy.frame(in: coordinateSpace)
                    )
                    .onPreferenceChange(FramePreferenceKey.self, perform: reader)
            }
        )
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func hideNavBar() -> some View {
        if #available(iOS 16.0, *) {
            return AnyView(self.toolbar(.hidden, for: .navigationBar))
        } else {
            return AnyView(self.navigationBarHidden(true))
        }
    }
    
    func hideViewWhenDataNotAvailable(dataSource: Any?) -> some View {
        opacity(dataSource == nil ? 0 : 1)
    }
    
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
    
    func onReceiveError(_ publisher: AnyPublisher<Error, Never>) -> some View {
        onReceive(publisher) { error in
            Common.showError(error)
        }
    }
    
    func onReceiveLoading(_ publisher: AnyPublisher<Bool, Never>) -> some View {
        onReceive(publisher) { isLoading in
            ProgressHUD.commonLoading(isLoading)
        }
    }
    
    func changeToBlackWhenNotNil(_ data: String?, colorHint: Color) -> some View {
        if data == nil || data?.isEmpty ?? false {
            return self.foregroundColor(colorHint)
        }
        else {
            return self.foregroundColor(.black)
        }
    }
    
}

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !viewDidLoad {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension UINavigationController {
    
    ///Re-enable swipe to go back when hide nav bar
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

public extension Binding where Value: Equatable {
    init(_ source: Binding<Value>, deselectTo value: Value) {
        self.init(get: { source.wrappedValue },
                  set: { source.wrappedValue = $0 == source.wrappedValue ? value : $0 }
        )
    }
}
