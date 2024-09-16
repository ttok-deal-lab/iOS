//
//  Project.swift
//  MercuryAppManifests
//
//  Created by 송하민 on 8/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
  name: "Network",
  platform: .iOS,
  frameworkDependencies: [
    .appFoundation,
    .moya,
    .combineMoya,
    .composableArchitecture,
    .swiftyJSON,
    .domain
  ],
  frameworkTestDependencies: [
    
  ]
)
