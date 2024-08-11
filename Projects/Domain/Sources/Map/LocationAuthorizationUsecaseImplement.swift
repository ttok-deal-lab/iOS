//
//  MapUsecaseImplement.swift
//  Domain
//
//  Created by 송하민 on 8/10/24.
//

import AppFoundation
import Foundation
import CoreLocation
import DomainInterface

@MainActor
public final class UserLocationUsecaseImplement: NSObject, @preconcurrency UserLocationUsecase {
  
  // MARK: - private property

  private var authStatusContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
  private var updatedLocationContinuation: CheckedContinuation<CLLocation, Error>?
  
  
  // MARK: - public property
  
  @MainActor
  public var locationManager: CLLocationManager {
    let manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    return manager
  }
  
  
  // MARK: - life cycle
  
  public override init() {
    super.init()
  }
   
  deinit {
    print("\(self) is deinited.")
  }
  
  // MARK: - public method

  public func userAuthorization() -> CLAuthorizationStatus {
    return self.locationManager.authorizationStatus
  }

  public func userCurrentLocation() -> CLLocation? {
    return self.locationManager.location
  }
  
  public func requestUserAuthorization() async -> CLAuthorizationStatus {
    let currentStatus = locationManager.authorizationStatus
    if currentStatus != .notDetermined {
      return currentStatus
    }
    return await withCheckedContinuation { continuation in
      self.authStatusContinuation = continuation
      locationManager.requestWhenInUseAuthorization()
    }
  }
}

extension UserLocationUsecaseImplement: @preconcurrency CLLocationManagerDelegate {
  
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    print("Authorization status changed to: \(status)")
    
    if let continuation = self.authStatusContinuation {
      continuation.resume(returning: status)
      self.authStatusContinuation = nil
    }
  }
  
  
  public func startUpdatingLocation() async throws -> CLLocation {
    self.locationManager.startUpdatingLocation()
    let location = try await withCheckedThrowingContinuation({ continuation in
      updatedLocationContinuation = continuation
    })
    return location
  }
  
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      updatedLocationContinuation?.resume(returning: location)
      updatedLocationContinuation = nil
    }
  }
  
  @nonobjc public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    updatedLocationContinuation?.resume(throwing: MercuryError(from: .ownModule(.map), .unknown))
    updatedLocationContinuation = nil
  }
}
