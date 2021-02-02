//
//  iTunesURLSupport.swift
//  AppSearcher
//
//  Created by Daniel Steinberg on 1/31/21.
//

import Foundation

var iTunesURLBase: URLComponents {
  var urlComponents = URLComponents()
  urlComponents.scheme = "https"
  urlComponents.host = "itunes.apple.com"
  urlComponents.path = "/search"
  urlComponents.queryItems
    = [URLQueryItem(name: "entity", value: "software"),
       URLQueryItem(name: "limit", value: "10")]
  return urlComponents
}

