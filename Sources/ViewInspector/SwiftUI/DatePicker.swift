import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension ViewType {
    
    struct DatePicker: KnownViewType {
        public static let typePrefix: String = "DatePicker"
    }
}

// MARK: - Extraction from SingleViewContent parent

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View: SingleViewContent {
    
    func datePicker() throws -> InspectableView<ViewType.DatePicker> {
        return try .init(try child(), parent: self, index: nil)
    }
}

// MARK: - Extraction from MultipleViewContent parent

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View: MultipleViewContent {
    
    func datePicker(_ index: Int) throws -> InspectableView<ViewType.DatePicker> {
        return try .init(try child(at: index), parent: self, index: index)
    }
}

// MARK: - Custom Attributes

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View == ViewType.DatePicker {
    
    func labelView() throws -> InspectableView<ViewType.ClassifiedView> {
        let view = try Inspector.attribute(label: "label", value: content.view)
        return try .init(try Inspector.unwrap(content: Content(view)), parent: self, index: nil)
    }
    
    @available(*, deprecated, message: "Please use .labelView().text() instead")
    func text() throws -> InspectableView<ViewType.Text> {
        return try labelView().text()
    }
}

// MARK: - Global View Modifiers

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView {

    func datePickerStyle() throws -> Any {
        let modifier = try self.modifier({ modifier -> Bool in
            return modifier.modifierType.hasPrefix("DatePickerStyleModifier")
        }, call: "datePickerStyle")
        return try Inspector.attribute(path: "modifier|style", value: modifier)
    }
}
