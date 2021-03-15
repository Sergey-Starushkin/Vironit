//
//  StoryboardEnum.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import UIKit

enum Storyboard: String {
    
    case main   = "Main"
    case signIn = "SignIn"
    case gender = "Gender"
    case age = "Age"
    case userdata = "UserData"
    case height = "Height"
    case weight = "Weight"
    case userPhoto = "UserPhoto"
    case userProfile = "UserProfile"
    case trainingProcess = "TrainingProcess"
    case workoutDetails = "WorkoutDetails"
    case exerciseDetails = "ExerciseDetails"
    case privacy = "PrivacyPolicy"
    case termsOfUse = "TermsOfUse"
    
    var filename: String {
        return rawValue
    }
}
