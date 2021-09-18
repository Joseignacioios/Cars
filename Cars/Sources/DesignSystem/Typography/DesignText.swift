//
//  DesignText.swift
//  Cars
//
//  Created by Joce on 16.09.2021.
//

public enum DesignText {
    case header(style: Header)
    case paragraph(style: Paragraph)
}

// MARK: - Header

public extension DesignText {
    enum Header {
        case h1, h2, h3
    }
}

// MARK: - Paragraph

public extension DesignText {
    enum Paragraph {
        case p1, p2
    }
}
