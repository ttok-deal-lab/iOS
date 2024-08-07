//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 7/21/24.
//

import ProjectDescription  

extension Project {
  
  public static func dynamicFramework(
    name: String,
    destinations: Destinations = .iOS,
    bundleId: String = bundleId,
    product: Product = .framework,
    platform: Platform,
    scripts: [TargetScript] = [],
    frameworkDependencies: [TargetDependency],
    frameworkTestDependencies: [TargetDependency]
  ) -> Project {
    return framework(
      name: name,
      destinations: destinations,
      bundleId: bundleId,
      product: product,
      platform: platform,
      scripts: scripts,
      frameworkDependencies: frameworkDependencies,
      frameworkTestDependencies: frameworkTestDependencies
    )
  }
}
